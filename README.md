# flask nginx mysql 
a container with  flask nginx mysql 

#nginx
nginx setting in app.conf 
port 80

#gunicorn
gunicorn setting in gunicorn.conf 
port 5000

#mysql 
MYSQL_USER=admin
MYSQL_PASS=**Random
you can set MYSQL_PASS  docker run -d --env MYSQL_USER=admin --env MYSQL_PASS=123 <images>

#flask
workdir -> app 
you can  put you application in app 
when you  use mysql you can use flask config set MYSQL_USER= os.environ.get('MYSQL_USER')
MYSQL_PASS= os.environ.get('MYSQL_PASS')
