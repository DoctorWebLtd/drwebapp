FROM            ubuntu:16.04
MAINTAINER      drweb.com

ENV             DEBIAN_FRONTEND=noninteractive

RUN             apt-get update && apt-get -y install dovecot-imapd dovecot-lmtpd dovecot-pop3d \
                mailutils exim4-daemon-heavy locales spamassassin rsyslog supervisor tzdata && \
                apt-get clean all

# From Russia with love
RUN             echo en_US.UTF-8 UTF-8 >> /etc/locale.gen && \
                echo ru_RU.UTF-8 UTF-8 >> /etc/locale.gen && \
                locale-gen && cp /usr/share/zoneinfo/Europe/Moscow /etc/localtime

# SSL certificates for encrypted connections
COPY            ssl/test2_server6.pem /etc/ssl/test2_server6.pem
COPY            ssl/test2.pem /etc/ssl/test2.pem

# Exim settings
COPY            exim/exim4.conf /etc/exim4/exim4.conf

# Dovecot settings
COPY            dovecot/10-auth.conf /etc/dovecot/conf.d/10-auth.conf
COPY            dovecot/10-logging.conf /etc/dovecot/conf.d/10-logging.conf
COPY            dovecot/10-mail.conf /etc/dovecot/conf.d/10-mail.conf
COPY            dovecot/10-master.conf /etc/dovecot/conf.d/10-master.conf
COPY            dovecot/10-ssl.conf /etc/dovecot/conf.d/10-ssl.conf
COPY            dovecot/15-lda.conf /etc/dovecot/conf.d/15-lda.conf
COPY            dovecot/20-lmtp.conf /etc/dovecot/conf.d/20-lmtp.conf
COPY            dovecot/auth-system.conf.ext /etc/dovecot/conf.d/auth-system.conf.ext

# System users and their mailboxes
COPY            dovecot/mail.passwd /etc/mail.passwd

# System users who will receive email
RUN             useradd -u 1001 -m user1 && echo user1:user1 | chpasswd && \
                useradd -u 1002 -m user2 && echo user2:user2 | chpasswd && \
                useradd -u 1003 -m user3 && echo user3:user3 | chpasswd && \
                useradd -u 1004 -m user4 && echo user4:user4 | chpasswd && \
                useradd -u 1005 -m user5 && echo user5:user5 | chpasswd && \
                useradd -u 1006 -m user6 && echo user6:user6 | chpasswd
RUN             chmod 777 /home

EXPOSE          25 110 143 465 993 995

# Default startup
COPY            supervisord.conf /etc/supervisord.conf
COPY            entrypoint.sh /entrypoint.sh

CMD             ["/entrypoint.sh"]
