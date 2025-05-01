#!/bin/bash

# Ensure rclone config is copied from JuiceFS mount to the appropriate location
cp /opt/jovyan/binder/rclone.conf /home/jovyan/.config/rclone/rclone.conf

# Ensure the service account file is also copied from JuiceFS to the proper location for rclone
cp /opt/jovyan/binder/myserviceaccount.json /home/jovyan/binder/myserviceaccount.json

# Mount Google Drive using rclone (assuming "gdrive" is configured in rclone.conf)
# This will mount the Google Drive at /mnt/gdrive
rclone mount gdrive: /mnt/gdrive \
  --config=/home/jovyan/.config/rclone/rclone.conf \
  --allow-other \
  --vfs-cache-mode writes \
  --umask 002 \
  --attr-timeout 1s \
  --poll-interval 15s \
  --dir-cache-time 72h &

# Start JupyterLab
exec jupyter lab --ip=0.0.0.0 --port=8888 --no-browser --allow-root --NotebookApp.token=''
