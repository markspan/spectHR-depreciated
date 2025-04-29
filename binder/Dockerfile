# Use Alpine Linux as the base image
FROM alpine:3.16

# Install necessary system packages
RUN apk add --no-cache \
    python3 \
    py3-pip \
    git \
    bash \
    build-base \
    libffi-dev \
    openssl-dev \
    libxml2-dev \
    libxslt-dev \
    && rm -rf /var/cache/apk/*

# Set environment variables
ENV PYTHONUNBUFFERED=1 \
    PIP_DISABLE_PIP_VERSION_CHECK=1 \
    PIP_NO_CACHE_DIR=off

# Upgrade pip and install JupyterLab
RUN pip install --upgrade pip && \
    pip install jupyterlab

# Create user with a home directory
ARG NB_USER=jovyan
ARG NB_UID=1000
ENV USER ${NB_USER}
ENV HOME /home/${NB_USER}

RUN adduser -D -u ${NB_UID} ${NB_USER}

WORKDIR ${HOME}
USER ${USER}

# Expose the JupyterLab port
EXPOSE 8888

# Install spectHR from a specific source if needed
RUN pip install git+https://github.com/markspan/spectHR.git

# Install spectHR from PyPI
# RUN pip install spectHR

# Start JupyterLab
CMD ["jupyter", "lab", "--ip=0.0.0.0", "--port=8888", "--no-browser", "--allow-root", "--NotebookApp.token=''"]
