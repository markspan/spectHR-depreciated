# Start from a minimal Jupyter base image
FROM jupyter/base-notebook:lab-4.0.0

# Install system dependencies
USER root
RUN apt-get update && apt-get install -y \
    git \
    wget \
    fuse \
    rclone \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

# Set up FUSE permissions
RUN chmod +x /usr/bin/fusermount && mkdir -p /home/jovyan/.config/rclone

# Copy necessary files into the image, excluding sensitive ones
COPY binder/start.sh /usr/local/bin/start.sh
COPY binder/rclone.conf /home/jovyan/.config/rclone/rclone.conf

# Make start script executable
RUN chmod +x /usr/local/bin/start.sh

# Install Python packages
RUN pip install jupyterhub \
    git+https://github.com/markspan/spectHR.git

# Set permissions and switch back to jovyan
RUN chown -R jovyan:users /home/jovyan
USER jovyan

# Set working directory
WORKDIR /home/jovyan

# Run the custom entrypoint script which mounts rclone and launches JupyterLab
CMD ["/usr/local/bin/start.sh"]
