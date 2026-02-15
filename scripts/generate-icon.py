from pathlib import Path
import subprocess
import sys

from PIL import Image, ImageDraw, ImageFilter

ROOT = Path(__file__).resolve().parent.parent
ICONSET_DIR = ROOT / "packaging" / "VideoGrid.iconset"
ICNS_FILE = ROOT / "packaging" / "VideoGrid.icns"

ICON_SPECS = [
    ("icon_16x16.png", 16),
    ("icon_16x16@2x.png", 32),
    ("icon_32x32.png", 32),
    ("icon_32x32@2x.png", 64),
    ("icon_128x128.png", 128),
    ("icon_128x128@2x.png", 256),
    ("icon_256x256.png", 256),
    ("icon_256x256@2x.png", 512),
    ("icon_512x512.png", 512),
    ("icon_512x512@2x.png", 1024),
]


def lerp(a, b, t):
    return int(a + (b - a) * t)


def blend(color_a, color_b, t):
    return tuple(lerp(a, b, t) for a, b in zip(color_a, color_b))


def rounded_rect_mask(size, rect, radius):
    mask = Image.new("L", (size, size), 0)
    draw = ImageDraw.Draw(mask)
    draw.rounded_rectangle(rect, radius=radius, fill=255)
    return mask


def vertical_gradient(size, top, mid, bottom):
    img = Image.new("RGBA", (size, size), (0, 0, 0, 0))
    draw = ImageDraw.Draw(img)
    for y in range(size):
        t = y / max(1, size - 1)
        if t <= 0.55:
            c = blend(top, mid, t / 0.55)
        else:
            c = blend(mid, bottom, (t - 0.55) / 0.45)
        draw.line((0, y, size, y), fill=(*c, 255))
    return img


def draw_base_tile(size):
    # Leave a small transparent edge for anti-aliasing and shadow falloff.
    inset = size * 0.06
    rect = (inset, inset, size - inset, size - inset)
    radius = size * 0.225

    canvas = Image.new("RGBA", (size, size), (0, 0, 0, 0))

    # Soft drop shadow behind the tile like native macOS icons.
    shadow = Image.new("RGBA", (size, size), (0, 0, 0, 0))
    shadow_draw = ImageDraw.Draw(shadow)
    y_shift = size * 0.016
    shadow_rect = (rect[0], rect[1] + y_shift, rect[2], rect[3] + y_shift)
    shadow_draw.rounded_rectangle(shadow_rect, radius=radius, fill=(5, 14, 36, 105))
    shadow = shadow.filter(ImageFilter.GaussianBlur(size * 0.03))
    canvas = Image.alpha_composite(canvas, shadow)

    mask = rounded_rect_mask(size, rect, radius)
    bg = vertical_gradient(size, (109, 189, 255), (56, 134, 233), (32, 78, 184))
    base = Image.new("RGBA", (size, size), (0, 0, 0, 0))
    base.paste(bg, (0, 0), mask)

    # Subtle top sheen for depth, avoiding heavy glossy effects.
    sheen = Image.new("RGBA", (size, size), (0, 0, 0, 0))
    sheen_draw = ImageDraw.Draw(sheen)
    sheen_h = int(size * 0.36)
    for y in range(sheen_h):
        t = 1.0 - (y / max(1, sheen_h - 1))
        alpha = int(50 * t)
        sheen_draw.line((rect[0], y + rect[1], rect[2], y + rect[1]), fill=(255, 255, 255, alpha))
    sheen = sheen.filter(ImageFilter.GaussianBlur(size * 0.01))
    base = Image.alpha_composite(base, sheen)

    # Gentle edge stroke, common in current macOS app icon language.
    stroke = Image.new("RGBA", (size, size), (0, 0, 0, 0))
    stroke_draw = ImageDraw.Draw(stroke)
    stroke_draw.rounded_rectangle(rect, radius=radius, outline=(255, 255, 255, 72), width=max(1, int(size * 0.004)))
    base = Image.alpha_composite(base, stroke)

    canvas = Image.alpha_composite(canvas, base)
    return canvas, rect


def draw_grid_symbol(icon, tile_rect, size):
    draw = ImageDraw.Draw(icon)

    tx0, ty0, tx1, ty1 = tile_rect
    tile_w = tx1 - tx0
    tile_h = ty1 - ty0

    # Foreground panel represents a tiled video contact sheet.
    panel_margin_x = tile_w * 0.19
    panel_margin_y = tile_h * 0.20
    panel = (
        tx0 + panel_margin_x,
        ty0 + panel_margin_y,
        tx1 - panel_margin_x,
        ty1 - panel_margin_y,
    )

    panel_radius = tile_w * 0.09

    panel_shadow = Image.new("RGBA", icon.size, (0, 0, 0, 0))
    ps_draw = ImageDraw.Draw(panel_shadow)
    ps_draw.rounded_rectangle(
        (panel[0], panel[1] + size * 0.008, panel[2], panel[3] + size * 0.008),
        radius=panel_radius,
        fill=(3, 10, 24, 90),
    )
    panel_shadow = panel_shadow.filter(ImageFilter.GaussianBlur(size * 0.01))
    icon.alpha_composite(panel_shadow)

    panel_bg = Image.new("RGBA", icon.size, (0, 0, 0, 0))
    pb_draw = ImageDraw.Draw(panel_bg)
    pb_draw.rounded_rectangle(panel, radius=panel_radius, fill=(243, 248, 255, 225), outline=(255, 255, 255, 220), width=max(1, int(size * 0.0035)))
    icon.alpha_composite(panel_bg)

    cols = 3
    rows = 3
    grid_w = panel[2] - panel[0]
    grid_h = panel[3] - panel[1]

    gutter = grid_w * (0.055 if size >= 64 else 0.03)
    cell_w = (grid_w - gutter * (cols + 1)) / cols
    cell_h = (grid_h - gutter * (rows + 1)) / rows
    cell_r = min(cell_w, cell_h) * 0.19

    # Slight tone shifts mimic varied video thumbnails while staying clean.
    palette = [
        (84, 144, 228),
        (94, 164, 238),
        (72, 130, 216),
        (102, 176, 246),
        (83, 152, 235),
        (76, 139, 223),
        (96, 170, 242),
        (68, 122, 206),
        (88, 157, 236),
    ]

    for r in range(rows):
        for c in range(cols):
            idx = r * cols + c
            x0 = panel[0] + gutter + c * (cell_w + gutter)
            y0 = panel[1] + gutter + r * (cell_h + gutter)
            x1 = x0 + cell_w
            y1 = y0 + cell_h
            color = palette[idx % len(palette)]

            draw.rounded_rectangle((x0, y0, x1, y1), radius=cell_r, fill=(*color, 245), outline=(255, 255, 255, 110), width=max(1, int(size * 0.0018)))

            # Keep tiny sizes uncluttered.
            if size >= 128:
                cx = (x0 + x1) / 2
                cy = (y0 + y1) / 2
                tri_w = cell_w * 0.22
                tri_h = cell_h * 0.28
                triangle = [
                    (cx - tri_w * 0.45, cy - tri_h * 0.5),
                    (cx - tri_w * 0.45, cy + tri_h * 0.5),
                    (cx + tri_w * 0.55, cy),
                ]
                draw.polygon(triangle, fill=(255, 255, 255, 185))


def draw_icon(size):
    icon, tile_rect = draw_base_tile(size)

    if size < 64:
        # Simplified mark for tiny renditions to preserve legibility.
        draw = ImageDraw.Draw(icon)
        tx0, ty0, tx1, ty1 = tile_rect
        inner = size * 0.22
        panel = (tx0 + inner, ty0 + inner, tx1 - inner, ty1 - inner)
        r = size * 0.06
        draw.rounded_rectangle(panel, radius=r, fill=(236, 246, 255, 220), outline=(255, 255, 255, 190), width=1)
        q_w = (panel[2] - panel[0]) / 2
        q_h = (panel[3] - panel[1]) / 2
        g = size * 0.02
        for r_i in range(2):
            for c_i in range(2):
                x0 = panel[0] + c_i * q_w + g
                y0 = panel[1] + r_i * q_h + g
                x1 = x0 + q_w - g * 2
                y1 = y0 + q_h - g * 2
                draw.rounded_rectangle((x0, y0, x1, y1), radius=size * 0.03, fill=(72, 141, 227, 235))
    else:
        draw_grid_symbol(icon, tile_rect, size)

    return icon


def ensure_iconset():
    if ICONSET_DIR.exists():
        for child in ICONSET_DIR.iterdir():
            child.unlink()
    else:
        ICONSET_DIR.mkdir(parents=True, exist_ok=True)


def generate():
    ensure_iconset()
    for filename, size in ICON_SPECS:
        path = ICONSET_DIR / filename
        icon = draw_icon(size)
        icon.save(path)
        print(f"Generated {path.name} ({size}x{size})")

    if ICNS_FILE.exists():
        ICNS_FILE.unlink()

    subprocess.run(["iconutil", "-c", "icns", str(ICONSET_DIR), "-o", str(ICNS_FILE)], check=True)
    print(f"Created {ICNS_FILE}")


if __name__ == "__main__":
    try:
        generate()
    except Exception as exc:
        print("Icon generation failed:", exc, file=sys.stderr)
        sys.exit(1)
