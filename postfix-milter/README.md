Контейнер предназначен для интеграции с продуктами Drweb по протоколу MILTER.


Контейнер может принимать переменные окружения:

* DRWEB_MILTER_IP
* DRWEB_MILTER_PORT

Если переменные не объявлены, производится попытка разрешить имя хоста "drweb" и использовать полученный IP-адрес.

Контейнер состоит из:

1. supervisord - обеспечивает запуск: dovecot, exim, rsyslog
2. dovecot - обеспечивает доступ к почтовым ящиками по протоколам POP3/POP3S и IMAP/IMAPS
3. postfix - обеспечивает функцию MTA по протоколам SMTP/SMTPS
4. rsyslog - служит средством логирования

Настройки сервисов:

1. Почтовый домен по-умолчанию: testlab1.test
2. Пользователи (username:password): user1:user1, user2:user2, user3:user3, user4:user4, user5:user5, user6:user6
3. Postfix: smtpd_milters содержит IP-адрес и номер порта хоста, на котором установлен Drweb. 