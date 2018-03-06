FROM java:8-jdk-alpine

RUN echo -e "https://mirrors.ustc.edu.cn/alpine/v3.4/main\nhttps://mirrors.ustc.edu.cn/alpine/v3.4/community\n" > /etc/apk/repositories \
&& apk add --no-cache openssh bash vim openrc tzdata


COPY id_rsa /root/.ssh/id_rsa
COPY id_rsa.pub /root/.ssh/id_rsa.pub
COPY ssh_* /etc/ssh/
COPY authorized_keys /root/.ssh/authorized_keys

RUN cp /usr/share/zoneinfo/Asia/Shanghai /etc/localtime \
&& chmod 600 /root/.ssh/id_rsa \
&& chmod 600 /etc/ssh/ssh_host_rsa_key \
&& chmod 600 /etc/ssh/ssh_host_dsa_key \
&& chmod 600 /etc/ssh/ssh_host_ecdsa_key \
&& chmod 600 /etc/ssh/ssh_host_ed25519_key \
&& echo "StrictHostKeyChecking no" >> /etc/ssh/ssh_config \
&& rc-update add sshd
