FROM ubuntu:trusty

RUN apt-get update
RUN apt-get install -y python python-pip python-virtualenv nginx gunicorn supervisor

# Setup flask application
RUN mkdir -p /www
COPY app /www
RUN pip install -r /www/requirements.txt

# Setup nginx
RUN rm /etc/nginx/sites-enabled/default
COPY app.conf /etc/nginx/sites-available/
RUN ln -s /etc/nginx/sites-available/app.conf /etc/nginx/sites-enabled/app.conf
RUN echo "daemon off;" >> /etc/nginx/nginx.conf

#Setup mysql
ADD start-mysqld.sh /start-mysqld.sh
ADD my.cnf /etc/mysql/conf.d/my.cnf
ADD create_mysql_admin_user.sh /create_mysql_admin_user.sh
ADD run.sh /run.sh
RUN chmod 755 /*.sh
RUN rm -rf /var/lib/mysql/*

# Setup supervisord
RUN mkdir -p /var/log/supervisor
COPY supervisord.conf /etc/supervisor/conf.d/supervisord.conf
COPY gunicorn.conf /etc/supervisor/conf.d/gunicorn.conf

# Add volumes for MySQL 
VOLUME  ["/etc/mysql", "/var/lib/mysql" ]

# Start processes
CMD ["/run.sh"]
EXPOSE 80 3306
