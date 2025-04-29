# Use a base image with a compatible Python version
FROM alpine

# Install necessary system packages, including git
RUN apt-get update && apt-get install -y \
    git \
    && rm -rf /var/lib/apt/lists/*

# Set environment variables
ENV PIP_TIMEOUT=60

# Install the notebook package
RUN pip install --no-cache --upgrade pip setuptools && \
    pip install --no-cache notebook jupyterlab

# Create user with a home directory
ARG NB_USER
ARG NB_UID
ENV USER ${NB_USER}
ENV HOME /home/${NB_USER}

RUN adduser --disabled-password \
    --gecos "Default user" \
    --uid ${NB_UID} \
    ${NB_USER}

WORKDIR ${HOME}
USER ${USER}

# Install spectHR from a specific source if needed
RUN pip install git+https://github.com/markspan/spectHR.git

# Install spectHR from PyPI
# RUN pip install spectHR
