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

# Install git and jupyterhub
RUN apt-get update && apt-get install -y git && \
    pip install jupyterhub 

# Update package list and install curl and wget
RUN apt-get update && apt-get install -y wget

# Set environment variables for the user and home directory
ENV USER ${NB_USER}
ENV HOME /home/${NB_USER}

# Set the working directory to the user's home directory
WORKDIR ${HOME}

# Install spectHR from a specific GitHub repository
RUN pip install git+https://github.com/markspan/spectHR.git
# Set config path
ENV JUPYTER_CONFIG_DIR=/etc/jupyter

# Copy config file to the right location
COPY binder/jupyter_server_config.py /etc/jupyter/


# Switch to the newly created user
USER ${USER}

# Expose the JupyterLab port
EXPOSE 8888
# Alternatively, install spectHR from PyPI (uncomment if needed)
# RUN pip install spectHR

# Start JupyterLab
CMD ["jupyter", "lab", "--ip=0.0.0.0", "--port=8888", "--no-browser", "--allow-root", "--NotebookApp.token=''"]
