# Docker YouTube Downloader

A Docker container that allows you to easily download audio or video from YouTube and other supported platforms using yt-dlp.

## Features

- Download audio (MP3 format)
- Download video (MP4 format)
- Uses latest yt-dlp version
- Includes ffmpeg for media processing

## Building

Build the Docker image:

```bash
docker build -t yt-downloader .
```

## Usage

The container supports two modes: audio and video.

### Audio Download

To download audio in MP3 format:

```bash
docker run --rm -v /path/to/output:/out yt-downloader audio <URL>
```

### Video Download

To download video in MP4 format:

```bash
docker run --rm -v /path/to/output:/out yt-downloader video <URL>
```

### Help

To display help information:

```bash
docker run --rm yt-downloader --help
```

## Output

Downloaded files will be saved to the mounted `/out` directory with the video's original title as the filename.

## Notes

- You need to mount a volume to `/out` to save the downloaded files.
- The container automatically selects the best quality available.
- Requires Docker to be installed on your system.