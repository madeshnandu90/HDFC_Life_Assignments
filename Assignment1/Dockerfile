# Base image to build the current Docker image
FROM centos:centos6
MAINTAINER Madesh C <madeshnandu90@gmail.com>
LABEL version="1.0.0"



### Python 2.7

# Updating and installing prerequisites
RUN yum groupupdate -y "Development Tools" \
 && yum update -y zlib-devel \
                  bzip2-devel \
                  openssl-devel \
                  ncurses-devel \
                  sqlite-devel \
                  readline-devel \
                  tk-devel gdbm-devel \
                  db4-devel \
                  libpcap-devel \
                  xz-devel \
                  expat-devel \
 && yum groupinstall -y "Development Tools" \
 && yum install -y zlib-devel \
                   bzip2-devel \
                   openssl-devel \
                   ncurses-devel \
                   sqlite-devel \
                   readline-devel \
                   tk-devel gdbm-devel \
                   db4-devel \
                   libpcap-devel \
                   xz-devel \
                   expat-devel \
 && yum clean all

# Downloading Python 2.7
RUN curl -O https://www.python.org/ftp/python/2.7.13/Python-2.7.13.tgz \
 && tar xzf Python-2.7.13.tgz \
 && rm -rf Python-2.7.13.tgz

# Compiling Python 2.7 and installing setup tools for Python 2.7
WORKDIR Python-2.7.13
RUN ./configure --prefix=/usr/local \
                --enable-unicode=ucs4 \
                --enable-shared LDFLAGS="-Wl,-rpath /usr/local/lib" \
 && make \
 && make altinstall \
 && curl -O https://bootstrap.pypa.io/get-pip.py \
 && python2.7 get-pip.py \
 && rm -rf get-pip.py \
 && strip /usr/local/lib/libpython2.7.so.1.0



### MongoDB 3.4

# Installing MongoDB 3.4
COPY mongodb-org-3.4.repo /etc/yum.repos.d/
RUN yum install -y mongodb-org \
 && mkdir -p /data/db

# Expose port 27017 of the container
EXPOSE 27017



### Apache Tomcat 7.0.77

# Downloading and installing Oracle Java SE Development Kit 8u121 and Apache Tomcat 7.0.77
WORKDIR /usr/local/
RUN curl -O http://mirror.fibergrid.in/apache/tomcat/tomcat-7/v7.0.77/bin/apache-tomcat-7.0.77.tar.gz \
 && curl -L -C - -b "oraclelicense=accept-securebackup-cookie" -O http://download.oracle.com/otn-pub/java/jdk/8u121-b13/e9e7ea248e2c4826b92b3f075a80e441/jdk-8u121-linux-x64.rpm \
 && tar xzf apache-tomcat-7.0.77.tar.gz \
 && mv apache-tomcat-7.0.77 tomcat7 \
 && rpm -ivh jdk-8u121-linux-x64.rpm \
 && rm -rf jdk-8u121-linux-x64.rpm \
 && rm -rf apache-tomcat-7.0.77.tar.gz

# Expose port 8080 of the container
EXPOSE 8080



### Starting Apache Tomcat and MongoDB servers
WORKDIR /
COPY start.sh /
CMD ["/bin/sh", "start.sh"]
