#BASE IMAGE: Centos7
FROM centos:7
ENV container docker
RUN (cd /lib/systemd/system/sysinit.target.wants/; for i in *; do [ $i == \
systemd-tmpfiles-setup.service ] || rm -f $i; done); \
rm -f /lib/systemd/system/multi-user.target.wants/*;\
rm -f /etc/systemd/system/*.wants/*;\
rm -f /lib/systemd/system/local-fs.target.wants/*; \
rm -f /lib/systemd/system/sockets.target.wants/*udev*; \
rm -f /lib/systemd/system/sockets.target.wants/*initctl*; \
rm -f /lib/systemd/system/basic.target.wants/*;\
rm -f /lib/systemd/system/anaconda.target.wants/*;
VOLUME [ "/sys/fs/cgroup" ]
#Usally Used Utils Install
RUN  yum clean all; yum makecache; \ 
yum install -y epel-release && \
yum install -y wget htop openssl vim unzip zip \
openssh-server openssh-clients git \
ncdu tree cronie ;yum update -y; yum clean all
CMD ["/usr/sbin/init"]
