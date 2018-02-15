if mdata-get server_name 1>/dev/null 2>&1; then
  SERVER_NAME=`mdata-get server_name`
  sed -i "s:SERVER_NAME:$SERVER_NAME:g" /opt/local/etc/httpd/vhosts/01-piwik.conf
fi

if mdata-get server_name 1>/dev/null 2>&1; then
  SERVER_ALIAS=`mdata-get server_alias`
  sed -i "s:SERVER_ALIAS:$SERVER_ALIAS:g" /opt/local/etc/httpd/vhosts/01-piwik.conf
else
  sed -i "s:ServerAlias SERVER_ALIAS::g" /opt/local/etc/httpd/vhosts/01-piwik.conf
fi

# Enable apache by default
/usr/sbin/svcadm enable svc:/pkgsrc/apache:default
