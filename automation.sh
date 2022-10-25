timestamp=$(date -I)
sudo apt update -y
apt-get install apache2
cd /var/log/apache2/
tar -cvf srinivas-httpd-logs-$(date -I).tar *
mv srinivas-httpd-logs-$(date -I).tar /tmp
aws s3 cp /tmp/srinivas-httpd-logs-${timestamp}.tar s3://upgrad-srinivas/srinivas-httpd-logs-${timestamp}.tar
