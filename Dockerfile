FROM a772bnsz/mayabase-centos:7 AS centos7

RUN wget https://trial2.autodesk.com/NetSWDLD/2020/MAYA/BB8314BA-8DE1-45E4-B827-79F63158212E/ESD/Autodesk_Maya_2020_ML_Linux_64bit.tgz -O maya.tgz && \
    mkdir /maya && tar -xvf maya.tgz -C /maya && \
    rm maya.tgz && \
    rpm -Uvh /maya/Packages/Maya*.rpm && \
    rm -r /maya

# Make mayapy the default Python
RUN echo alias hpython="\"/usr/autodesk/maya/bin/mayapy\"" >> ~/.bashrc && \
    echo alias hpip="\"mayapy -m pip\"" >> ~/.bashrc

# Setup environment
ENV MAYA_LOCATION=/usr/autodesk/maya
ENV PATH=$MAYA_LOCATION/bin:$PATH
ENV PYTHONPATH=lib/python2.7/site-packages
#ENV PYMEL_SKIP_MEL_INIT=1

# Workaround for "Segmentation fault (core dumped)"
# See https://forums.autodesk.com/t5/maya-general/render-crash-on-linux/m-p/5608552/highlight/true
ENV MAYA_DISABLE_CIP=1

# Cleanup
WORKDIR /root