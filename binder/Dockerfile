# Use Alpine Linux as the base image
FROM jupyter/docker-stacks-foundation:latest

# Create user with a home directory
ARG NB_USER=jovyan
ARG NB_UID=1000
ENV USER ${NB_USER}
ENV HOME /home/${NB_USER}

RUN adduser -u ${NB_UID} ${NB_USER}

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
