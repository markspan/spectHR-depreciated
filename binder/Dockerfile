# Use the Jupyter Docker stack foundation as the base image
FROM jupyter/docker-stacks-foundation:latest

# Define arguments for the user and UID
ARG NB_USER=jovyan
ARG NB_UID=1000

# Switch to the root user to create the user and set the home directory if it doesn't exist
USER root
RUN if ! id -u $NB_USER >/dev/null 2>&1; then \
        addgroup --gid $NB_UID $NB_USER && \
        adduser --disabled-password --gecos "" --ingroup $NB_USER --uid $NB_UID $NB_USER && \
        mkdir -p /home/$NB_USER && \
        chown $NB_USER:$NB_USER /home/$NB_USER; \
    fi
# Base image and system setup
FROM python:3.11-slim

# Install system dependencies for rclone, Jupyter, and others
RUN apt-get update && apt-get install -y \
    git \
    curl \
    unzip \
    fuse3 \
    wget \
    && rm -rf /var/lib/apt/lists/*

# Install rclone
RUN curl -O https://downloads.rclone.org/rclone-current-linux-amd64.zip && \
    unzip rclone-current-linux-amd64.zip && \
    cp rclone-*-linux-amd64/rclone /usr/bin/ && \
    chmod 755 /usr/bin/rclone && \
    rm -rf rclone*

# Install JupyterHub and spectHR
RUN pip install jupyterhub jupyterlab && \
    pip install git+https://github.com/markspan/spectHR.git

# Set up environment variables
ENV NB_USER jovyan
ENV HOME /home/${NB_USER}
ENV RCLONE_CONFIG=${HOME}/.config/rclone/rclone.conf

# Create user and working directories
RUN useradd -m -s /bin/bash ${NB_USER} && \
    mkdir -p ${HOME}/gdrive && \
    chown -R ${NB_USER}:${NB_USER} ${HOME}

# Copy startup script
COPY start.sh /usr/local/bin/start.sh
RUN chmod +x /usr/local/bin/start.sh

# Set working directory
WORKDIR ${HOME}

# Switch to user
USER ${NB_USER}

# Expose JupyterLab
EXPOSE 8888

# Start script (mount + Jupyter)
CMD ["/usr/local/bin/start.sh"]
