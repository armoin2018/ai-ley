# Adaptive bitrate encoding for HLS
ffmpeg -i input.mp4 \
  -c:v libx264 -preset medium -crf 23 -maxrate 4M -bufsize 8M -s 1920x1080 \
  -c:a aac -b:a 128k -ac 2 -ar 48000 \
  -f hls -hls_time 6 -hls_playlist_type vod \
  -hls_segment_filename 'segment_%03d.ts' \
  -master_pl_name master.m3u8 \
  output.m3u8