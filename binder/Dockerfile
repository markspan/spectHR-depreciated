# Use Alpine Linux as the base image
FROM jupyter/docker-stacks-foundation:latest

# Create a user with a specific UID and home directory
ARG NB_USER=jovyan
ARG NB_UID=1000

# Switch to root user to create the user and set the home directory
USER root
RUN addgroup --gid $NB_UID $NB_USER \
    && adduser --disabled-password --gecos "" --ingroup $NB_USER --uid $NB_UID $NB_USER \
    && mkdir -p /home/$NB_USER \
    && chown $NB_USER:$NB_USER /home/$NB_USER

# Set environment variables for the user and home directory
ENV USER ${NB_USER}
ENV HOME /home/${NB_USER}

# Set the working directory to the user's home directory
WORKDIR ${HOME}

# Switch to the newly created user
USER ${USER}

# Expose the JupyterLab port
EXPOSE 8888

# Install spectHR from a specific source if needed
RUN pip install git+https://github.com/markspan/spectHR.git

# Install spectHR from PyPI (uncomment if needed)
# RUN pip install spectHR

# Start JupyterLab
CMD ["jupyter", "lab", "--ip=0.0.0.0", "--port=8888", "--no-browser", "--allow-root", "--NotebookApp.token=''"]
