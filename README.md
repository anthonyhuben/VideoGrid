# 🎞️ Video Grid 0.3

**Video Grid 0.3** is a high-performance, 100% client-side web application designed to generate professional thumbnail contact sheets (video grids) directly in your browser. By leveraging the power of modern HTML5 APIs and Vanilla JavaScript, it eliminates the need for server-side processing, ensuring your media remains private and secure on your local machine.

![Privacy First](https://img.shields.io/badge/Privacy-100%25_Local-brightgreen)
![Tech Stack](https://img.shields.io/badge/Stack-Vanilla_JS_|_HTML5_|_CSS3-blue)
![License](https://img.shields.io/badge/License-MIT-orange)

---

## ✨ Key Features

### 🚀 Performance & Privacy
*   **Zero Server Uploads**: Processing happens entirely in your browser's memory using the Canvas and Video APIs.
*   **Instant Start**: No installation, no `npm install`, and no dependencies. Just one HTML file.
*   **Hardware Accelerated**: Uses your local GPU for video decoding and frame rendering.

### 📊 Advanced Metadata Detection
Automatically extract and display technical data in the header:
*   **Resolution & Aspect Ratio**: Detects everything from SD to 8K.
*   **Smart FPS Detection**: Uses the `requestVideoFrameCallback` API for precise frame rate calculation.
*   **Bitrate & Codec**: Estimates video bitrate (MB/s and kbps) and identifies common codecs (H.264, H.265, VP9, etc.).

### 🎨 Intelligent Styling
*   **Auto-Style Detection**: Analyzes the color distribution of the video to recommend the perfect color palette.
*   **50+ Color Presets**: Categorized themes including *Midnight, Arctic, Sepia, Cyberpunk, Forest,* and *Vapor*.
*   **Custom Typography**: Use system fonts, web-safe fonts, or upload your own `.ttf` or `.otf` files to brand your contact sheets.
*   **UI Themes**: Match your workspace with *Ocean, Slate, Retro Terminal, Cyberpunk,* and more.

### 🛠️ Precision Editing
*   **Frame-Level Tuning**: Click any thumbnail to adjust its exact timestamp using a slider or manual input.
*   **Custom Overlays**: Add unique text labels to individual frames (e.g., "Intro," "Final Scene").
*   **Responsive Scaling**: Smart "Output Resolution Scale" suggestions based on source quality to balance file size and clarity.

---

## 🚀 Quick Start Guide

### 1. Launch
Simply open `index.html` in any modern web browser (Chrome or Edge recommended for best codec support).

### 2. Configure
1.  **Select Video**: Click the input button to load your local file.
2.  **Layout**: Choose your grid dimensions (e.g., 5 columns × 6 rows).
3.  **Scale**: Use the recommended "Auto-select scale" or pick a custom chip (e.g., 12.5% for 1080p).
4.  **Generate**: Hit the **Generate** button to populate the grid.

### 3. Customize & Export
1.  **Edit**: Hover over a frame to fine-tune the time or add text.
2.  **Style**: Expand the **🎨 Output Image Style** section. Choose a preset or manually set colors.
3.  **Download**: Select your format (WebP is best for quality/size) and click **Download Image**.

---

## 🎨 Styling Presets Reference

The application includes over 50 handcrafted color presets. Here are some of the popular categories:

| Category | Recommended For... | Key Presets |
| :--- | :--- | :--- |
| **Dark** | High-contrast cinematic shots | Noir, Obsidian, Abyss, Graphite |
| **Light** | Clean, professional documentation | Paper, Snow, Minimal, Arctic |
| **Warm** | Landscapes, sunsets, and autumn film | Sepia, Sunset, Ember, Coffee |
| **Cool** | Tech reviews, water scenes, and sci-fi | Ocean, Slate, Twilight, Steel |
| **Vibrant** | Creative projects and music videos | Cyberpunk, Synthwave, Neon, Toxic |

---

## 🛠️ Technical Details

Video Grid 0.3 is built using a "No-Framework" philosophy to maximize speed and compatibility.

### Core Logic
*   **Frame Capture**: Uses `HTMLVideoElement` seeking and `drawImage()` into a temporary `CanvasRenderingContext2D`.
*   **Font Handling**: Implements the `FontFace` API to allow real-time custom font injections.
*   **Memory Management**: Efficiently handles `Blob` objects and `URL.createObjectURL` for exporting high-resolution images.

### Math & Calculations
Grid dimensions and text scaling are calculated dynamically. For example, the header height is scaled based on the thumbnail height:
$$ \text{HeaderHeight} = \text{ThumbHeight} \times 0.8 $$
The font size is automatically calculated to fit the widest line of text within the grid width:
$$ \text{FontSize} = \min(\text{sizeTitle}, \text{sizeMeta1}, \text{sizeMeta2}) $$

---

## 💻 System Requirements

*   **Browser**: Modern Chromium-based browsers (Chrome, Edge, Opera) offer the best support for HEVC and high-res video.
*   **Memory**: While the app is lightweight, processing 4K/8K video requires at least 8GB of RAM for smooth performance.
*   **Codecs**: Support depends on your OS and browser. If a video won't play, ensure you have the necessary system-level extensions (like "HEVC Video Extensions" for Windows).

---

## 📄 License

Video Grid 0.3 is released under the **MIT License**. You are free to use, modify, and distribute the application for personal and commercial use.
