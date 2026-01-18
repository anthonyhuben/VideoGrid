# Video Grid

**Video Grid** is a lightweight, single-file HTML5 application that generates professional video thumbnail grids in your web browser! It requires no server uploads, no installation, and runs completely offline.

## 🚀 Features

* **Zero Installation:** Runs entirely in the browser using a single HTML file.
* **Privacy First:** All processing is done client-side. Your video files never leave your computer.
* **Customizable Layout:** Choose grid dimensions ranging from 2x2 up to 8x8.
* **Smart Metadata Display:** Automatically extracts and displays:
* Video Title (Editable)
* File Size
* Resolution (Width × Height)
* Bitrate (in MB/s)
* Runtime and Total Frame Count


* **Frame Editor:** Click any thumbnail to fine-tune the specific timestamp using a slider or manual input.
* **Title Cleaner:** One-click utility to remove dots, file extensions, and resolution tags (e.g., “1080p”, “4k”) from the title.
* **High-Quality Export:** Download the final contact sheet as a PNG image with customizable scaling options.

## 📋 Requirements

* A modern web browser (Google Chrome, Microsoft Edge, Firefox, or Safari).
* Video files in **.MP4** format.

## 🛠️ How to Run

1. Download the `VideoGrid.html` file.
2. Double-click the file to open it in your default web browser.
3. That’s it!

## 📖 Usage Guide

1. **Select Video:** Click “Select Video” and choose an MP4 file from your computer.
2. **Configure Grid:** Select your desired number of Columns and Rows (e.g., 5x6).
3. **Generate:** Click the **Generate** button. The app will scan the video and create evenly spaced thumbnails.
4. **Refine:**
* **Edit Title:** Type in the text box to change the header title. Use the **✨ Clean Title** button to auto-format it.
* **Edit Frames:** Click on any specific image in the grid to open the **Frame Editor**. You can seek to a better moment and update just that thumbnail.


5. **Export:** Select your desired output scale (default is optimized for 1080p videos) and click **Download PNG**.

## ⚙️ Technical Details

* **Version:** 0.1
* **Tech Stack:** HTML5, CSS3, Vanilla JavaScript.
* **Rendering:** Uses the HTML5 Canvas API to capture video frames and render the composite image.
* **Bitrate Calculation:** Calculated as `(File Size in MB) / (Duration in Seconds)`.

## 📄 License

This project is open-source. Feel free to modify and distribute it as needed.
