FROM jenkins/jenkins:latest as jenkins
USER root
RUN apt-get update -y
RUN apt-get install wget curl sudo vim openssh-server openssh-client -y
RUN mkdir /var/run/sshd
RUN echo 'root:vagrant' | chpasswd
RUN sed -i 's/PermitRootLogin prohibit-password/PermitRootLogin yes/' /etc/ssh/sshd_config
# SSH login fix. Otherwise user is kicked off after login
RUN sed 's@session\s*required\s*pam_loginuid.so@session optional pam_loginuid.so@g' -i /etc/pam.d/sshd

ENV NOTVISIBLE "in users profile"
RUN echo "export VISIBLE=now" >> /etc/profile
EXPOSE 22
RUN  apt-get update  -y
RUN mkdir -p /root/.ssh
RUN touch /root/.ssh/id_rsa
#COPY ~/home/vagrant/.ssh/id_rsa /root/.ssh/id_rsa

CMD ["/usr/sbin/sshd", "-D"]
