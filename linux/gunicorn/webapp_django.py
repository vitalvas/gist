bind = "unix:/srv/socks/webapp.sock"
workers = 2 # 2 * nums cpu
user = "www-data"
group = "www-data"
logfile = "/srv/logs/webapp/gunicorn.log"
loglevel = "info"
proc_name = "webapp"
