FROM eboraas/apache-php

MAINTAINER Daniel Alexander Parkes
LABEL version="0.2"

RUN  echo 'export DBNAME=${DBNAME}\n\
export DBUSER=${DBUSER}\n\
export DBPASS=${DBPASS}\n\
export DBHOST=${DBHOST}\n' >> /etc/apache2/envvars

RUN sed -i -e 's/DirectoryIndex.*$/DirectoryIndex index.php/g' /etc/apache2/mods-available/dir.conf && rm /etc/apache2/sites-enabled/default-ssl.conf

COPY scripts/run-script.sh /usr/local/bin/run-script.sh
RUN chmod +x /usr/local/bin/run-script.sh

EXPOSE 80 

ENTRYPOINT ["run-script.sh"]
CMD ["start"]
