FROM eboraas/apache-php

MAINTAINER Daniel Alexander Parkes
LABEL version="0.2"

RUN  echo 'export DBNAME=${DBNAME}\n\
export DBUSER=${DBUSER}\n\
export DBPASS=${DBPASS}\n\
export DBHOST=${DBHOST}\n' >> /etc/apache2/envvars

RUN sed -i -e 's/DirectoryIndex.*$/DirectoryIndex index.php/g' /etc/apache2/mods-available/dir.conf && rm /etc/apache2/sites-enabled/default-ssl.conf


EXPOSE 80 
#VOLUME /var/www/html/
COPY src/index.php /var/www/html/

CMD ["/usr/sbin/apache2ctl", "-D", "FOREGROUND" ]
