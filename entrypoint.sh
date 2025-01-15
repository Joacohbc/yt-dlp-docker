#!/bin/bash

set -e

COMMAND=$1
URL=$2

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
if [[ "$1" == "pre-upgrade-audio"  ]]; then
  pip install --upgrade --force-reinstall yt-dlp
  COMMAND="audio"
fi

if [[ "$1" == "pre-upgrade-video"  ]]; then
  pip install --upgrade --force-reinstall yt-dlp
  COMMAND="video"
fi

# Check if -h or --help is passed
if [[ "$1" == "-h" || "$1" == "--help"|| "$1" == "help"   ]]; then
  help
fi

if [ -z "$COMMAND" ]; then
  echo "Error: Missing mode argument."
  help
fi

if [ "$COMMAND" == "audio" ]; then
  if [ -z "$URL" ]; then
    echo "Error: Missing URL argument for audio mode."
    help
  fi
  yt-dlp -f bestaudio --extract-audio --audio-format mp3 -o "/out/%(title)s.%(ext)s" "$URL"

elif [ "$COMMAND" == "video" ]; then
  if [ -z "$URL" ]; then
    echo "Error: Missing URL argument for video mode."
    help
  fi
  yt-dlp -f "bestvideo+bestaudio" --merge-output-format mp4 -o "/out/%(title)s.%(ext)s" "$URL"

else
  echo "Error: Invalid mode: $COMMAND. Use 'audio' or 'video'."
  help
fi