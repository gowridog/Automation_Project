#!/bin/bash

sudo apt update -y

# To check if apache2 server is installed or not

s3_bucket="upgrad-srinivas"
name="srinivas"
timestamp=$(date '+%d%m%Y-%H%M%S')

if dpkg -l | grep -i apache2
then
        echo "Apache2 server is installed"
else
        echo "Apache2 server is not installed"
        sudo apt install apache2
fi

#To check for the word inactive status in the result of status

STARTAPACHE="systemctl start apache2"

if systemctl status apache2 | grep -q inactive
then
        echo "Starting the Apache2 server at $(date)"
        $STARTAPACHE
else
        echo "Apache2 server is running at $(date)"
fi

sudo systemctl status apache2.service
sudo systemctl enable apache2

#To create tar files from the logs

sudo tar -cvf /tmp/"${name}-httpd-logs-${timestamp}.tar" /var/log/apache2/*.log
# To upload tar files to S3 bucket
aws s3 cp /tmp/${name}-httpd-logs-${timestamp}.tar s3://${s3_bucket}/${name}-httpd-logs-${timestamp}.tar


#Script for generating the HTML file for Bookkeeping

if [[ ! -f var/www/html/inventory.html ]];
then
        echo -e Log Type\ \Date Created\ \Type\ \Size > /var/www/html/inventory.html
fi

if [[ -f /var/www/html/inventory.html ]];

then
        size=$(du -h /tmp/"${name}-httpd-logs-${timestamp}.tar" | awk '{print $1}')

        echo -e "httpd-logs\t- \t$(date '+%d%m%Y-%H%M%S')\t- \ttar\t -\t${size}" >> /var/www/html/inventory.html

fi

#Cron job for automation

if [[ ! -f /etc/cron.d/automation ]];
then
        echo "* * * * * root /root/Automation_Project/automation.sh" >> /etc/cron.d/automation
fi
