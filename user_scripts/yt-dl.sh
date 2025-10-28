#!/usr/bin/env bash


if [[ $1 = '-h' ]]; then 
    echo "Download youtube videos from the DL playlist"
    exit 0
fi

~/yt-dlp --yes-playlist  \
         --download-archive ~/Videos/yt-downloads/playlist \
         -P '~/Videos/yt-downloads' \
         -o '%(uploader)s/%(uploader)s: %(title)s' \
         'https://www.youtube.com/watch?v=PEA0JzhpzPU&list=PLzE-f10BKWwDS_C7lyUM881Ed2-2n29jc'


# ~/yt-dlp --yes-playlist  \
#          --download-archive ~/Videos/yt-downloads/playlist \
#          -P '~/Videos/yt-downloads' \
#          -o '%(uploader)s/%(uploader)s: %(title)s' \
#          --cookies-from-browser brave+kwallet5 \
#          'https://www.youtube.com/watch?v=PEA0JzhpzPU&list=PLzE-f10BKWwDS_C7lyUM881Ed2-2n29jc'
