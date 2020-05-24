FROM centos:centos7

COPY . /root

RUN chmod +x /root/maya_deps.sh && \
    root/maya_deps.sh

# Enable playblasts with Quicktime
ENV LIBQUICKTIME_PLUGIN_DIR=/usr/autodesk/maya/lib

# Start Xvfb
# Provide an in-memory X-session for parts of Maya that require a GUI
# such as cmds.playblast()
ENV DISPLAY=:99

# Run on user login, this has the limitation of being run
# each time a user logs into the Docker image. Suggestions
# are welcome to make this only run once at startup.
RUN echo "# Start Xvfb" >> ~/.bashrc && \
    echo "Xvfb :99 -screen 0 1024x768x16 2>/dev/null &" >> ~/.bashrc && \
    echo "while ! ps aux | \grep -q '[0]:00 Xvfb :99 -screen 0 1024x768x16';" >> ~/.bashrc && \
    echo "  do echo 'Waiting for Xvfb...'; sleep 1; done" >> ~/.bashrc