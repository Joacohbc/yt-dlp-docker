FROM python:3.11-slim

WORKDIR /app

RUN apt update && apt install ffmpeg -y
RUN apt clean autoclean && apt autoremove --yes
RUN rm -rf /var/lib/{apt,dpkg,cache,log}/

RUN pip install yt-dlp

COPY entrypoint.sh .
RUN chmod +x entrypoint.sh

ENTRYPOINT ["/app/entrypoint.sh"] 