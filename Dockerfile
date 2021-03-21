#########################################################################
#	Centos7-Base-Systemd Container Image				#
#	https://github.com/krsuhjunho/centos7-base-systemd		#
#	BASE IMAGE: Centos7:latest					#
#########################################################################

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

#########################################################################
#	Install && Update 						#
#########################################################################

RUN  	yum clean all; \
	yum makecache; \ 
	yum install -y -q \	
	epel-release && \
	yum install -y -q \
	wget \
	htop \	
	openssl \
	vim \	
	unzip \
	zip \
	openssh-server \
	openssh-clients \
	git \
	ncdu \ 
	tree \
	cronie ; \
	yum update -y -q;\
	yum clean all

#########################################################################
#       Systemd	&& Using SSH                                            #
#########################################################################

CMD ["/usr/sbin/init"]
