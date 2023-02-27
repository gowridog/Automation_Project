Developed an "automation.sh" bash script file to perform the following list of subtasks:
1). Performed an update of the package details and the package list at the start of the script. 
2). Installed the apache2 server package if it is not already installed. 
3). Ensured that the apache2 service was running if not running. 
4). Ensured that the apache2 service is enabled if not enabled. 
5). Created a tar archive of apache2 access logs and error logs that are present in the /var/log/apache2/ directory and placed the tar into the /tmp/ directory. 
6). Installed AWS CLI. The script would run the AWS CLI command and copy the archive to the s3 bucket. Also ensures that the script checks for the presence of the inventory. html file in /var/www/html/; creates the file if not found.
7). This file will essentially serve as a web page to get the metadata of the archived logs. 
8). The script should create a cron job file in /etc/cron.d/ with the name 'automation' that runs the script /root//automation.sh every day via the root user.

