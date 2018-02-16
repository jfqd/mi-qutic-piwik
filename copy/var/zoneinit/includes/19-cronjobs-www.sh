# create cronjob for piwik

# remove cached trackers
echo "0,5,10,15,20,25,30,35,40,45,50,55 * * * * if [ -d /var/www/htdocs/piwik/current/tmp/cache/tracker ]; then /usr/bin/rm -rf /var/www/htdocs/piwik/current/tmp/cache/tracker/* 2>/dev/null; fi" >> /var/spool/cron/crontabs/www
# remove sessions older than two hours
echo "0,15,30,45 * * * * /usr/bin/find /var/tmp/ -name sess_* -cmin +120 -exec rm '{}' +" >> /var/spool/cron/crontabs/www
# archive-piwik-requests
echo "10 * * * * if [ -f /var/www/htdocs/piwik/current/console  ]; then /opt/local/bin/php /var/www/htdocs/piwik/current/console core:archive --url=https://piwik.qutic.com 1>> /var/www/htdocs/piwik/piwik-update.log 2>/dev/null; fi" >> /var/spool/cron/crontabs/www
# the end
echo "#" >> /var/spool/cron/crontabs/www
