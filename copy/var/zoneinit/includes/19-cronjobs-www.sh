# create cronjob for piwik

# remove cached trackers
echo "0,5,10,15,20,25,30,35,40,45,50,55 * * * * if [ -d /var/www/htdocs/piwik/current/tmp/cache/tracker ]; then /usr/bin/rm -rf /var/www/htdocs/piwik/current/tmp/cache/tracker/* 2>/dev/null; fi" >> /var/spool/cron/crontabs/www
# remove sessions older than two hours
echo "0,15,30,45 * * * * /usr/bin/find /var/tmp/ -name sess_* -cmin +120 -exec rm '{}' +" >> /var/spool/cron/crontabs/www
# archive-piwik-requests
echo "10 * * * * if [ -f /var/www/htdocs/piwik/current/console  ]; then /opt/local/bin/php /var/www/htdocs/piwik/current/console core:archive --url=https://matomo.example.com 1>> /var/www/htdocs/piwik/piwik-update.log 2>/dev/null; fi" >> /var/spool/cron/crontabs/www
# change server-name
if mdata-get server_name 1>/dev/null 2>&1; then
  SERVER_NAME=`mdata-get server_name`
  sed -i "s:matomo.example.com:${SERVER_NAME}:g" /var/spool/cron/crontabs/www
fi
# the end
echo "#" >> /var/spool/cron/crontabs/www
