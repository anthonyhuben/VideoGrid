# 🎬 Video Grid 0.3

<div align="center">

![Privacy First](https://img.shields.io/badge/Privacy-100%25_Client--Side-brightgreen)
![No Dependencies](https://img.shields.io/badge/Dependencies-Zero-blue)
![Tech Stack](https://img.shields.io/badge/Stack-Vanilla_JS_|_HTML5_|_CSS3-orange)
![License](https://img.shields.io/badge/License-MIT-purple)

**A powerful, privacy-first video thumbnail generator that runs entirely in your browser**

[Features](#-features) • [Quick Start](#-quick-start) • [User Guide](#-user-guide) • [Customization](#-customization) • [Technical Details](#-technical-details)

</div>

---

## 📖 Overview

**Video Grid 0.3** is a professional-grade, client-side web application designed to generate beautiful thumbnail contact sheets (video grids) directly in your browser. Unlike traditional tools that upload your files to remote servers, Video Grid processes everything locally using modern HTML5 APIs, ensuring your media files never leave your computer.

### Why Video Grid?

- **🔒 Complete Privacy**: Zero server uploads - all processing happens in your browser's memory
- **⚡ Lightning Fast**: No installation, no npm packages, just open and run
- **🎨 Highly Customizable**: 50+ color presets, custom fonts, and intelligent auto-styling
- **💎 Professional Quality**: Hardware-accelerated rendering with support for resolutions up to 8K
- **🆓 Free & Open Source**: Released under MIT license for personal and commercial use

---

## ✨ Features

### 🎯 Core Capabilities

#### Intelligent Frame Extraction
- **Smart Sampling**: Automatically extracts evenly-spaced frames across the entire video duration
- **Custom Grid Layouts**: Flexible configurations from 2×2 to 20×20 grids (and beyond)
- **Precision Editing**: Click any thumbnail to fine-tune its exact timestamp using a slider or manual input
- **Custom Overlays**: Add descriptive text labels to individual frames (e.g., "Opening Scene", "Credits")

#### Advanced Metadata Detection
Video Grid automatically analyzes your video file and displays comprehensive technical information:

- **Resolution & Aspect Ratio**: From SD (480p) to 8K (7680×4320) and beyond
- **Frame Rate Precision**: Uses `requestVideoFrameCallback` API for accurate FPS detection
- **Bitrate Analysis**: Calculates video bitrate in both MB/s and kbps
- **Codec Detection**: Identifies H.264, H.265 (HEVC), VP9, VP8, AV1, and other codecs
- **File Statistics**: Total frames, runtime, file size, and more

#### Professional Styling System

##### 🎨 Auto-Style Detection
The application analyzes the color distribution of your video to recommend complementary color palettes:
- **Automated Analysis**: Samples multiple frames to determine dominant colors
- **Smart Recommendations**: Suggests 3-5 optimal presets based on video content
- **One-Click Apply**: Instantly apply suggested styles with a single click

##### 🌈 50+ Handcrafted Color Presets
Organized into intuitive categories:

**Dark Themes** (High contrast, cinematic)
- Midnight, Noir, Obsidian, Abyss, Graphite, Charcoal, Void, Carbon

**Light Themes** (Clean, professional)
- Paper, Snow, Minimal, Arctic, Cream, Vanilla, Pearl, Frost

**Warm Themes** (Earthy, inviting)
- Sepia, Sunset, Ember, Coffee, Copper, Caramel, Rust, Autumn

**Cool Themes** (Tech, modern)
- Ocean, Slate, Twilight, Steel, Ice, Denim, Storm, Pewter

**Vibrant Themes** (Bold, creative)
- Cyberpunk, Synthwave, Neon, Vapor, Electric, Toxic, Miami, Retro

**Natural Themes** (Organic, balanced)
- Forest, Moss, Sage, Earth, Clay, Sand, Stone, Olive

##### 🔤 Advanced Typography
- **System Fonts**: Pre-loaded collection of professional fonts
- **Web-Safe Fonts**: Classic typography options (Arial, Times New Roman, Georgia, etc.)
- **Custom Font Upload**: Support for `.ttf` and `.otf` files to match your brand
- **Separate Frame Fonts**: Use different fonts for timestamp badges and custom text overlays

### 🎛️ Advanced Controls

#### Output Quality Management
- **Smart Resolution Scaling**: Intelligent suggestions based on source video quality
  - 4K/8K videos → 25% scale recommended
  - 1080p videos → 12.5% scale recommended
  - 720p and below → 6.25% scale recommended
- **Custom Scale Options**: Precise control from 6.25% to 100% in multiple increments
- **Format Selection**: PNG (lossless), JPEG (best compatibility), or WebP (best quality/size ratio)
- **Quality Slider**: Fine-tune compression for JPEG and WebP formats

#### Visual Enhancements
- **Rounded Corners**: Optional corner radius for a modern, polished look
- **Timestamp Badges**: Overlay frame timestamps with customizable colors
- **Custom Gap Spacing**: Adjust spacing between thumbnails (0-100px)
- **Header Customization**: Editable video title with bold/normal weight options

### 🖥️ User Interface Features

#### Theme System
Choose from 6 beautifully crafted UI themes to match your workspace:
- **Dark** (Default): Professional dark mode with purple accents
- **Light**: Clean, minimal light mode with blue accents
- **Ocean**: Deep blue theme with cyan highlights
- **Cyberpunk**: Futuristic dark theme with magenta accents
- **Retro Terminal**: Classic green-on-black terminal aesthetic
- **Slate**: Sophisticated gray-blue professional theme

#### Interactive Grid Preview
- **Real-time Updates**: See thumbnails as they're generated
- **Hover Controls**: Quick access to timestamp adjustment and custom text
- **Frame-Level Editing**: 
  - Time slider for precise timestamp control
  - Manual time input for exact positioning
  - Custom text overlay for frame annotations
- **Visual Feedback**: Progress indicators and status updates throughout

---

## 🚀 Quick Start

### Installation

**Method 1: Direct Download**
1. Download `VideoGrid.html` 
2. Open the file in any modern web browser (Chrome or Edge recommended)
3. That's it! No installation required.

**Method 2: Clone Repository**
```bash
git clone https://github.com/harp37/VideoGrid.git
cd VideoGrid
# Simply open VideoGrid.html in your browser
```

### Basic Usage (3 Simple Steps)
#### Step 1: Load Your Video
1. Click **"Choose Video File"** button
2. Select any video file from your computer
3. Wait for automatic metadata detection (usually 1-2 seconds)

#### Step 2: Configure Your Grid
1. **Select Layout**: Choose grid dimensions (e.g., 5 columns × 6 rows = 30 thumbnails)
2. **Choose Scale**: Click **"Auto-select scale"** for optimal quality, or pick a custom percentage
3. **Click Generate**: The grid will populate with evenly-spaced frames

#### Step 3: Customize & Download
1. **Optional**: Adjust individual frame timestamps or add custom text
2. **Optional**: Choose a color preset from the **🎨 Output Image Style** section
3. **Select format**: WebP (recommended), PNG, or JPEG
4. **Click Download Image**: Your contact sheet will be saved to your downloads folder

## 🖥️ Native macOS App

A lightweight Swift/WebKit wrapper loads `VideoGrid.html` inside a native window and keeps the same privacy-first behavior while giving you a downloadable macOS experience.

### Requirements
- macOS 11.0 or newer with Xcode command line tools installed (`swiftc`, `hdiutil`).
- Keep `VideoGrid.html` at the project root; the build script copies it directly into the app bundle.
- Install Python 3 + Pillow (`pip install pillow`) so you can run `scripts/generate-icon.py` to refresh `packaging/VideoGrid.icns` (the icon is copied into the bundle automatically).

### Build & Packaging
1. Run `./scripts/build-app.sh` to compile `src/main.swift`, bundle `VideoGrid.html`, and generate `build/VideoGrid.app`.
2. Run `./scripts/create-dmg.sh` to package that app bundle into `dist/VideoGrid-Installer.dmg`. The script also adds an `Applications` shortcut so end users can drag & drop.
3. Open the DMG (`open dist/VideoGrid-Installer.dmg`) or copy `build/VideoGrid.app` into `/Applications` for internal testing.

After you edit the HTML or styles, rerun `./scripts/build-app.sh` before rebuilding the DMG so the latest assets are included.

If you want to update the Finder icon, run `python3 scripts/generate-icon.py` (requires `iconutil`). The generated `packaging/VideoGrid.icns` will be bundled automatically on the next build.

## 📚 User Guide

---

## 📚 User Guide

### Understanding Grid Layout

The grid dimensions determine how many thumbnails will be extracted from your video:
- **Columns × Rows = Total Frames**
- Example: 5 columns × 6 rows = 30 thumbnails
- Frames are extracted at evenly-spaced intervals across the entire video duration

**Recommended Layouts:**
- **Quick Preview**: 4×3 (12 frames) or 5×4 (20 frames)
- **Standard Contact Sheet**: 5×6 (30 frames) or 6×6 (36 frames)
- **Detailed Analysis**: 8×8 (64 frames) or 10×10 (100 frames)
- **Ultra-Detailed**: 15×10 (150 frames) or higher for long-form content

### Resolution Scaling Explained

Scaling determines the size of each thumbnail in the final output:

| Source Resolution | Recommended Scale | Thumbnail Size (5 col) | Final Image Width |
|------------------|-------------------|----------------------|------------------|
| 720p (1280×720) | 6.25% - 12.5% | 80×45 to 160×90 | ~480-960px |
| 1080p (1920×1080) | 12.5% - 25% | 240×135 to 480×270 | ~1440-2880px |
| 4K (3840×2160) | 25% - 50% | 960×540 to 1920×1080 | ~5760-11520px |
| 8K (7680×4320) | 25% - 50% | 1920×1080 to 3840×2160 | ~11520-23040px |

**Note**: The "Auto-select scale" button analyzes your video and chooses the optimal balance between quality and file size.

### Using Auto-Style Detection

The auto-style feature analyzes your video's color palette to suggest matching presets:

1. **Load your video** and click **"Generate Grid"**
2. Scroll to **🎨 Output Image Style** section
3. Click **"🔍 Auto-Detect Best Style"**
4. Wait 2-3 seconds while the algorithm:
   - Samples frames from different parts of the video
   - Analyzes brightness, saturation, and color distribution
   - Compares against all 50+ presets
5. Review the **top 3-5 recommended presets** with match scores
6. Click **"Apply"** on your favorite suggestion

**Auto-Style Categories:**
- **Dark videos** (low brightness) → Dark theme presets
- **Light videos** (high brightness) → Light theme presets
- **Warm videos** (orange/red tones) → Warm theme presets
- **Cool videos** (blue/green tones) → Cool theme presets
- **Vibrant videos** (high saturation) → Vibrant theme presets
- **Muted videos** (low saturation) → Natural/minimal presets

### Custom Font Upload

Add your own typography for a branded look:

1. Navigate to the **🎨 Output Image Style** section
2. Find **"Custom Font Upload"** under the font selection
3. Click **"Choose Font File (.ttf, .otf)"**
4. Select your font file from your computer
5. The font will be loaded and automatically selected
6. Your custom font will appear as "Custom Font" in the dropdown

**Supported Formats:**
- `.ttf` (TrueType Font)
- `.otf` (OpenType Font)

**Use Cases:**
- Corporate branding with company fonts
- Matching video production style guides
- Creative projects with unique typography
- Consistency with existing media libraries

### Fine-Tuning Individual Frames

Each thumbnail can be individually customized:

1. **Hover over any thumbnail** in the grid preview
2. **Edit controls will appear** with two options:

**Adjust Timestamp:**
- Use the **slider** to scrub through nearby video content
- Or click **"⌨️ Manual"** to enter an exact time in MM:SS format
- The thumbnail updates in real-time as you adjust

**Add Custom Text:**
- Enter descriptive text (e.g., "Intro", "Act 2", "Credits")
- Text appears as a badge in the top-left corner of that frame
- Great for annotating specific scenes or moments

### Export Formats Comparison

| Format | Quality | File Size | Transparency | Best For |
|--------|---------|-----------|--------------|----------|
| **PNG** | Lossless | Large (10-30MB) | ✅ Yes | Archival, editing, maximum quality |
| **JPEG** | Lossy | Small (2-8MB) | ❌ No | Sharing, web use, email attachments |
| **WebP** | Lossy/Lossless | Medium (3-12MB) | ✅ Yes | Best balance of quality and size |

**Recommendations:**
- **WebP** at 90-95% quality: Best overall choice for most use cases
- **PNG**: When you need perfect quality or plan to edit the image later
- **JPEG** at 85-90% quality: Maximum compatibility for sharing

---

## 🎨 Customization

### Color Preset Reference

Here's a detailed look at some popular presets in each category:

#### Dark Presets

**Midnight** (`#000814`, `#ffd60a`, `#9d9d9d`)
- Deep navy background with bright yellow title
- Perfect for: Night scenes, space footage, dramatic content

**Noir** (`#0a0a0a`, `#e5e5e5`, `#7d7d7d`)
- Classic black and white scheme
- Perfect for: Film noir, black & white videos, minimalist content

**Abyss** (`#000000`, `#00d9ff`, `#00a8cc`)
- Pure black with cyan accents
- Perfect for: Underwater footage, tech demos, sci-fi content

#### Light Presets

**Paper** (`#f5f5f5`, `#1a1a1a`, `#4a4a4a`)
- Off-white background with dark text
- Perfect for: Documentation, tutorials, professional presentations

**Snow** (`#ffffff`, `#000000`, `#666666`)
- Pure white with black text
- Perfect for: Clean product shots, minimalist videos, high-key content

**Arctic** (`#e8f4f8`, `#003d5c`, `#006494`)
- Light blue-gray with deep blue accents
- Perfect for: Winter scenes, tech content, corporate videos

#### Warm Presets

**Sepia** (`#f4e8d8`, `#5d4e37`, `#8b7355`)
- Classic sepia tone
- Perfect for: Vintage content, nostalgia, period pieces

**Sunset** (`#ffe5b4`, `#cc5500`, `#ff7f00`)
- Warm orange glow
- Perfect for: Golden hour footage, warm landscapes, sunset timelapses

**Coffee** (`#d7c9aa`, `#3e2723`, `#5d4037`)
- Rich brown tones
- Perfect for: Food content, cozy scenes, autumn footage

#### Cool Presets

**Ocean** (`#e0f2f7`, `#004d61`, `#007a99`)
- Aquatic blue theme
- Perfect for: Ocean footage, water sports, marine documentaries

**Slate** (`#e8eaed`, `#37474f`, `#546e7a`)
- Professional gray-blue
- Perfect for: Business content, tech reviews, corporate videos

**Twilight** (`#d4e0ed`, `#1a237e`, `#283593`)
- Deep blue evening tones
- Perfect for: Twilight scenes, city nights, moody content

#### Vibrant Presets

**Cyberpunk** (`#0a0014`, `#ff00ff`, `#00ffff`)
- High-contrast neon colors
- Perfect for: Gaming content, sci-fi, futuristic themes

**Synthwave** (`#1a0033`, `#ff007f`, `#00ffff`)
- 80s-inspired neon palette
- Perfect for: Retro content, music videos, creative projects

**Neon** (`#0d0221`, `#ff006e`, `#8338ec`)
- Electric magenta and purple
- Perfect for: Night club footage, concert videos, energetic content

### Creating Manual Color Schemes

For complete control, manually adjust all color parameters:

1. **Background Color**: The canvas background (space between thumbnails)
2. **Title Color**: Color of the video title text
3. **Title Weight**: Normal (300) or Bold (700) font weight
4. **Metadata Color**: Color of technical information text
5. **Timestamp Background**: Badge background for frame times
6. **Timestamp Text**: Text color for timestamps

**Design Tips:**
- **High Contrast**: Ensure text is readable against backgrounds (use light text on dark backgrounds and vice versa)
- **Color Harmony**: Choose colors from the same family or use complementary colors
- **Consistency**: Match colors to your video's mood or your brand guidelines
- **Accessibility**: Maintain sufficient contrast ratios (4.5:1 for normal text, 3:1 for large text)

### Advanced Font Configuration

**Header Font vs Frame Font:**
- **Header Font**: Used for video title and metadata in the top section
- **Frame Font**: Used for timestamp badges and custom text overlays
- These can be different for visual hierarchy (e.g., elegant header font, monospaced frame font)

**Font Selection Strategy:**
- **Serif Fonts** (Times New Roman, Georgia): Traditional, formal, documentary-style
- **Sans-Serif Fonts** (Arial, Roboto, Segoe UI): Modern, clean, professional
- **Monospace Fonts** (Courier New, Consolas): Technical, code-like, precise
- **Display Fonts** (Custom uploads): Branding, creative, unique

---

## 🔧 Technical Details

### Architecture

Video Grid 0.3 is built with a "zero-dependency" philosophy using pure web standards:

- **HTML5**: Semantic markup and structure
- **CSS3**: Modern styling with CSS custom properties (variables) for theming
- **Vanilla JavaScript**: No frameworks, libraries, or build tools

### How It Works

#### 1. Video Loading & Analysis
```javascript
// When a video file is selected:
1. Create a hidden <video> element
2. Load video metadata (duration, dimensions, codec)
3. Use requestVideoFrameCallback API for precise FPS measurement
4. Calculate bitrate: (fileSize × 8) / duration
5. Estimate total frames: duration × fps
```

#### 2. Frame Extraction
```javascript
// For each thumbnail:
1. Calculate timestamp: (i / totalFrames) × duration
2. Seek video to exact timestamp
3. Wait for 'seeked' event
4. Draw current frame to a temporary <canvas>
5. Store canvas reference for later rendering
```

#### 3. Grid Composition
```javascript
// Final image generation:
1. Create output canvas with calculated dimensions
2. Draw header section with video metadata
3. Loop through stored frame canvases
4. Draw each thumbnail to grid position
5. Add rounded corners (if enabled)
6. Overlay timestamp badges and custom text
7. Convert to Blob and trigger download
```

### Mathematical Calculations

**Grid Dimensions:**
```
Final Width  = (thumbnail_width × columns) + (gap × (columns - 1))
Final Height = header_height + (thumbnail_height × rows) + (gap × (rows - 1))
```

**Header Sizing:**
```
Header Height = thumbnail_height × 0.8
```

**Font Sizing (Auto-fit):**
```
Test Size = 100px
Measured Width = measureText(text)
Size Based on Width = (maxWidth / measuredWidth) × testSize
Final Size = min(sizeBasedOnWidth, maxHeight)
```

**Timestamp Positioning:**
```
Badge X = thumbnail_x + thumbnail_width - text_width - (thumbnail_width × 0.02)
Badge Y = thumbnail_y + thumbnail_height - text_height - (thumbnail_height × 0.02)
```

### Browser Compatibility

| Browser | Minimum Version | Video Codecs | Notes |
|---------|----------------|--------------|-------|
| **Chrome** | 90+ | H.264, VP8, VP9, AV1 | Best overall support |
| **Edge** | 90+ | H.264, VP8, VP9, AV1, HEVC* | *HEVC requires system extension |
| **Firefox** | 88+ | H.264, VP8, VP9, AV1 | Good support, slower FPS detection |
| **Safari** | 14+ | H.264, HEVC | Limited WebP export support |
| **Opera** | 76+ | H.264, VP8, VP9, AV1 | Based on Chromium |

**Codec Notes:**
- **HEVC/H.265**: Requires "HEVC Video Extensions" on Windows 10/11 (available in Microsoft Store)
- **AV1**: Newer codec with excellent compression but limited device playback
- **VP9**: YouTube's primary codec, widely supported

### Performance Characteristics

**Processing Speed** (approximate, varies by system):
- **720p Video**: 1-2 seconds to extract 30 frames
- **1080p Video**: 2-4 seconds to extract 30 frames
- **4K Video**: 5-10 seconds to extract 30 frames
- **8K Video**: 10-20 seconds to extract 30 frames

**Memory Usage:**
- Base application: ~5-10 MB
- Per frame stored: ~0.5-2 MB (depends on resolution and scale)
- Example: 5×6 grid at 1080p/25% scale ≈ 30-60 MB total

**Disk Space (Output Files):**
- 1080p grid (5×6) at 25% scale:
  - PNG: 10-20 MB
  - JPEG (90% quality): 3-6 MB
  - WebP (90% quality): 4-8 MB
- 4K grid (5×6) at 25% scale:
  - PNG: 20-40 MB
  - JPEG (90% quality): 6-12 MB
  - WebP (90% quality): 8-15 MB

### Security & Privacy

**Complete Client-Side Processing:**
- No data ever leaves your browser
- No analytics or tracking
- No external dependencies or CDN requests
- All font files loaded from your local filesystem

**Safe to Use With:**
- Confidential footage
- Unreleased content
- Personal videos
- Sensitive media files

---

## 💡 Tips & Best Practices

### Optimizing for Different Video Types

**Short Videos (< 5 minutes):**
- Use 4×4 or 5×4 grids for good coverage
- Higher scale percentages (25-50%) for detail
- Consider PNG for archival quality

**Medium Videos (5-30 minutes):**
- Use 5×6 or 6×6 grids for balanced overview
- Medium scale (12.5-25%) for file size
- WebP recommended for quality/size balance

**Long Videos (30+ minutes):**
- Use 8×8 or 10×10 grids for comprehensive coverage
- Lower scale (6.25-12.5%) to keep file size manageable
- JPEG may be necessary for very large grids

**High-Motion Videos (Sports, Action):**
- Increase grid size for more samples
- Add custom text to mark key moments
- Use vibrant color presets to match energy

**Cinematic Videos (Films, Documentaries):**
- Use wider grids (e.g., 6×4) for cinematic aspect ratios
- Choose elegant presets (Noir, Sepia, Minimal)
- Enable rounded corners for polished look

### Workflow Recommendations

**For Archival/Documentation:**
1. Use highest quality scale (50-100%)
2. Export as PNG
3. Include all metadata
4. Use descriptive video titles

**For Web Sharing/Portfolio:**
1. Use recommended scale (12.5-25%)
2. Export as WebP at 90% quality
3. Enable rounded corners
4. Use branded fonts and colors

**For Quick Reference/Notes:**
1. Use 4×3 or 5×4 grid
2. Lower scale (6.25%)
3. Export as JPEG
4. Add custom text annotations

### Troubleshooting Common Issues

**Problem: Video won't load**
- Ensure the codec is supported by your browser
- Try opening the video in the browser directly to test
- Install required codec extensions (HEVC Video Extensions for Windows)

**Problem: Slow generation**
- Reduce grid size (fewer total frames)
- Lower the scale percentage
- Close other browser tabs to free up memory
- Use hardware acceleration in browser settings

**Problem: Blurry thumbnails**
- Increase the scale percentage
- Check source video quality
- Ensure you're not scaling UP (>100%)

**Problem: File size too large**
- Lower the scale percentage
- Use JPEG instead of PNG
- Reduce quality slider for JPEG/WebP
- Reduce grid dimensions

**Problem: Text cut off in header**
- Shorten video title
- The font size auto-adjusts, but extremely long titles may wrap
- Consider abbreviating technical details

---

## 🛠️ System Requirements

### Minimum Requirements
- **Browser**: Chrome 88+, Edge 88+, Firefox 85+, Safari 14+
- **RAM**: 4 GB (for 1080p videos)
- **Display**: 1280×720 minimum resolution
- **OS**: Windows 10, macOS 10.15, Linux (any modern distro)

### Recommended Requirements
- **Browser**: Chrome 100+ or Edge 100+ (best codec support)
- **RAM**: 8 GB (for 4K videos)
- **Display**: 1920×1080 or higher
- **OS**: Windows 11, macOS 12+, Linux
- **GPU**: Dedicated graphics card for hardware acceleration

### For 8K Videos
- **RAM**: 16 GB or more
- **GPU**: Modern dedicated GPU with hardware decode support
- **Storage**: SSD for fast video file reading
- **Browser**: Latest version with AV1 support

---

## 📝 Version History

### Version 0.3 (Current)
- ✨ Added 50+ color presets organized by category
- 🎨 Implemented auto-style detection based on video analysis
- 🔤 Added custom font upload support (.ttf, .otf)
- 🖼️ Added rounded corners option
- 🎭 Implemented 6 UI themes
- 📝 Added custom text overlays for individual frames
- 🔧 Improved metadata detection accuracy
- 🚀 Performance optimizations for 4K/8K videos
- 🎯 Enhanced timestamp editing with manual input
- 📊 Better bitrate calculation and codec detection

---

## 📜 License

**MIT License**

Copyright (c) 2025 Video Grid Contributors

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

---

## 🤝 Contributing

Contributions are welcome! Here are some ways you can help:

- 🐛 Report bugs and issues
- 💡 Suggest new features or presets
- 🎨 Submit new color schemes
- 📚 Improve documentation
- 🔧 Submit pull requests

---

## 💬 Support

- **Issues**: Report bugs or request features at [github.com/harp37/VideoGrid/issues](https://github.com/harp37/VideoGrid/issues)
- **Discussions**: Share tips and ask questions in GitHub Discussions
- **Repository**: [github.com/harp37/VideoGrid](https://github.com/harp37/VideoGrid)

---

## 🙏 Acknowledgments

- Built with modern web APIs (Canvas, Video, FileReader, FontFace)
- Inspired by traditional video editing contact sheets
- Thanks to the open-source community for continuous feedback

---

## 🔗 Links

- **Repository**: [github.com/harp37/VideoGrid](https://github.com/harp37/VideoGrid)
- **Issues**: [Report a Bug](https://github.com/harp37/VideoGrid/issues)
- **Releases**: [Download Latest Version](https://github.com/harp37/VideoGrid/releases)

---

<div align="center">

**Made with ❤️ by developers who value privacy**

⭐ Star this repo if you find it useful!

[Report Bug](https://github.com/harp37/VideoGrid/issues) • [Request Feature](https://github.com/harp37/VideoGrid/issues) • [View Repository](https://github.com/harp37/VideoGrid)

</div>
