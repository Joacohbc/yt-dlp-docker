#!/bin/bash

set -e

# Create the /out directory if it doesn't exist
mkdir -p /out

# Function to display help message
help() {
  echo "Usage: docker run <image> <mode> <URL>"
  echo "Modes:"
  echo "  audio: Download audio from the given URL. (a playlist will download all audio files)"
  echo "  video: Download video from the given URL. (a playlist will download all audio files)"
  echo "Example:"
  echo "  docker run my-downloader audio https://www.youtube.com/watch?v=dQw4w9WgXcQ"
  exit 1
}

# Check if -h or --help is passed
if [[ "$1" == "-h" || "$1" == "--help"  ]]; then
  help
fi

if [ -z "$1" ]; then
  echo "Error: Missing mode argument."
  help
fi

if [ "$1" == "audio" ]; then
  if [ -z "$2" ]; then
    echo "Error: Missing URL argument for audio mode."
    help
  fi
  yt-dlp -f bestaudio --extract-audio --audio-format mp3 -o "/out/%(title)s.%(ext)s" "$2"
elif [ "$1" == "video" ]; then
  if [ -z "$2" ]; then
    echo "Error: Missing URL argument for video mode."
    help
  fi
  yt-dlp -f "bestvideo+bestaudio" --merge-output-format mp4 -o "/out/%(title)s.%(ext)s" "$2"
else
  echo "Error: Invalid mode: $1. Use 'audio' or 'video'."
  help
fi