FROM centos:centos7

COPY . /root

RUN chmod +x /root/maya_deps.sh && \
    root/maya_deps.sh

ENV LD_LIBRARY_PATH=/opt/Autodesk/Adlm/R14/lib64/
ENV PRODUCT_KEY=657L1
ENV SERIAL_NUMBER=901-54141408
ENV MAYA_LOCATION=/usr/autodesk/maya/
ENV PATH=$MAYA_LOCATION/bin:$PATH
#ENV PYMEL_SKIP_MEL_INIT=1
ENV MAYA_DISABLE_CIP=1
ENV MAYA_LICENSE=$PRODUCT_KEY
ENV MAYA_LICENSE_METHOD=Standalone
ENV PYTHONPATH=lib/python2.7/site-packages


RUN wget https://trial2.autodesk.com/NetSWDLD/2019/MAYA/EC2C6A7B-1F1B-4522-0054-4FF79B4B73B5/ESD/Autodesk_Maya_2019_Linux_64bit.tgz -O maya.tgz && \
    tar -xvf maya.tgz && \
    rm maya.tgz && \
    rpm -ivh adlmapps14-14.0.23-0.x86_64.rpm && \
    rpm -ivh adlmflexnetclient-14.0.23-0.x86_64.rpm && \
    rpm -ivh Maya2019_64-2019.0-7966.x86_64.rpm && \
    /usr/autodesk/maya2019/bin/adlmreg -i S $PRODUCT_KEY $PRODUCT_KEY 2019.0.0.F $SERIAL_NUMBER /var/opt/Autodesk/Adlm/Maya2019/MayaConfig.pit && \
    ./unix_installer.sh


# Make mayapy the default Python
RUN echo alias hpython="\"/usr/autodesk/maya/bin/mayapy\"" >> ~/.bashrc && \
    echo alias hpip="\"mayapy -m pip\"" >> ~/.bashrc

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
