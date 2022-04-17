cd /data/wwwroot/CSC4001_Project/Code
sudo killall -9 uwsgi
nohup uwsgi --ini CUHKSZ_STACK_OVERFLOW.ini &
cd /data/wwwroot/CSC4001_Project/Code/backend
python3 manage.py collectstatic