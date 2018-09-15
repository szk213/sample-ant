FROM centos:7
RUN yum install -y curl tar

## Install JDK
ENV JAVA_HOME /opt/jdk
ENV PATH ${PATH}:${JAVA_HOME}/bin
ARG JDK_TAR_URL=http://download.oracle.com/otn-pub/java/jdk/8u181-b13/96a7b8442fe848ef90c96a2fad6ed6d1/jdk-8u181-linux-x64.tar.gz
ARG JDK_TAR_HASH=1845567095bfbfebd42ed0d09397939796d05456290fb20a83c476ba09f991d3
ENV ORACLE_DOWNLOAD_COOKIE "gpw_e24=http%3A%2F%2Fwww.oracle.com%2F; oraclelicense=accept-securebackup-cookie"
RUN echo "${JDK_TAR_HASH} -" > sum.txt && \
    curl -fLs --header "Cookie: ${ORACLE_DOWNLOAD_COOKIE}" ${JDK_TAR_URL} | tee jdk.tar.gz | sha256sum -c sum.txt && \
    mkdir ${JAVA_HOME} && \
    tar xvfz jdk.tar.gz -C ${JAVA_HOME} --strip-components 1 && \
    rm -f jdk.tar.gz sum.txt

## Install Ant
ENV ANT_HOME /opt/ant
ENV PATH ${PATH}:${ANT_HOME}/bin
ARG ANT_TAR_URL=http://ftp.jaist.ac.jp/pub/apache/ant/binaries/apache-ant-1.10.5-bin.tar.gz
ARG ANT_TAR_HASH=05d44122fd1e7c37a7c30653bbcce20866d6c7e7
RUN echo "${ANT_TAR_HASH} -" > sum.txt && \
    curl -fLs ${ANT_TAR_URL} | tee ant.tar.gz | sha1sum -c sum.txt && \
    mkdir ${ANT_HOME} && \
    tar xvfz ant.tar.gz -C ${ANT_HOME} --strip-components 1 && \
    rm -f ant.tar.gz sum.txt

