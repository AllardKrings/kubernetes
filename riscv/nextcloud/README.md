INSIDE THE NEXTCLOUD CONTAINER:
===============================

#controleren of WEBDAV is geinstalleerd:

su -s /bin/sh -c "php occ app:list www-data

=> 

Enabled:
  - activity: 2.20.0
  - circles: 28.0.0
  - cloud_federation_api: 1.11.0
  - comments: 1.18.0
  - contactsinteraction: 1.9.0
  - dashboard: 7.8.0
  - dav: 1.29.2
  - federatedfilesharing: 1.18.0
  - federation: 1.18.0
  - files: 2.0.0
  - files_pdfviewer: 2.9.0
  - files_reminders: 1.1.0
  - files_sharing: 1.20.0
  - files_trashbin: 1.18.0
  - files_versions: 1.21.0
  - firstrunwizard: 2.17.0
  - logreader: 2.13.0
  - lookup_server_connector: 1.16.0
  - nextcloud_announcements: 1.17.0
  - notifications: 2.16.0
  - oauth2: 1.16.4
  - password_policy: 1.18.0
  - photos: 2.4.0
  - privacy: 1.12.0
  - provisioning_api: 1.18.0
  - recommendations: 2.0.0
  - related_resources: 1.3.0
  - serverinfo: 1.18.0
  - settings: 1.10.1
  - sharebymail: 1.18.0
  - support: 1.11.1
  - survey_client: 1.16.0
  - systemtags: 1.18.0
  - text: 3.9.2
  - theming: 2.3.0
  - twofactor_backupcodes: 1.17.0
  - updatenotification: 1.18.0
  - user_status: 1.8.1
  - viewer: 2.2.0
  - weather_status: 1.8.0
  - workflowengine: 2.10.0
Disabled:
  - admin_audit: 1.18.0
  - bruteforcesettings: 2.8.0
  - encryption: 2.16.0
  - files_external: 1.20.0
  - suspicious_login: 6.0.0
  - twofactor_totp: 10.0.0-beta.2
  - user_ldap: 1.19.0

#zo niet dan:

su -s /bin/sh -c "php occ app:enable dav" www-data

=> dav already enabled

#controleren of nextcloud alle bestanden in var/www/data kan lezen:

su -s /bin/sh -c "php occ files:scan --all" www-data

=>

Starting scan for user 1 out of 1 (admin)
+---------+-------+-----+---------+---------+--------+--------------+
| Folders | Files | New | Updated | Removed | Errors | Elapsed time |
+---------+-------+-----+---------+---------+--------+--------------+
| 6       | 44    | 0   | 0       | 0       | 0      | 00:00:01     |
+---------+-------+-----+---------+---------+--------+--------------+

#controleren of de user "admin" een directory heeft:

ls -lah /var/www/html/data/admin/

=>
total 16K
drwxrwx---    4 www-data www-data    4.0K Feb  9 16:47 .
drwxrwx---    4 www-data www-data    4.0K Feb  9 16:46 ..
drwxrwx---    2 www-data www-data    4.0K Feb  9 16:47 cache
drwxrwx---    5 www-data www-data    4.0K Feb  9 16:17 files

su -s /bin/sh -c "php occ user:list" www-data

#controleren of gebruiker bestaat:

=>  - admin: admin

#enable gebruiker admin:

su -s /bin/sh -c "php occ user:enable admin" www-data

=> The specified user is enabled

su -s /bin/sh -c "php occ security:bruteforce:reset admin" www-data

=>
#controleren log of specifieke meldingen mbt admin:

cat /var/www/html/data/nextcloud.log | grep "admin"


=> 

{"reqId":"up3RdhwXxxGTV3nlIMH9","level":2,
 "time":"2025-02-09T20:15:15+00:00",
 "remoteAddr":"10.42.0.82",
 "user":"--",
 "app":"no app in context",
 "method":"POST",
 "url":"/index.php/login",
 "message":"Login failed: admin (Remote IP: 10.42.0.82)",
 "userAgent":"Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/18.3 Safari/605.1.15",
 "version":"28.0.14.1",
 "data":[]}

#controleren of .htaccess goed is geconfigureerd:

cat /var/www/html/.htaccess | grep dav

=>

  RewriteRule ^$ /remote.php/webdav/ [L,R=302]
  RewriteRule ^\.well-known/carddav /remote.php/dav/ [R=301,L]
  RewriteRule ^\.well-known/caldav /remote.php/dav/ [R=301,L]

#  - https://docs.nextcloud.com/server/latest/admin_manual/issues/general_troubleshooting.html#troubleshooting-webdav

#legen cache:

su -s /bin/sh -c "php occ maintenance:mode --on" www-data
=> Nextcloud is in maintenance mode, no apps are loaded.

su -s /bin/sh -c "php occ maintenance:data-fingerprint" www-data

=>
Commands provided by apps are unavailable.
Updated data-fingerprint to 60f73f9b70daee107c27b5a064670c28

su -s /bin/sh -c "php occ cache:clear" www-data

=>
Commands provided by apps are unavailable.
Updated data-fingerprint to 60f73f9b70daee107c27b5a064670c28
There are no commands defined in the "cache" namespace.

su -s /bin/sh -c "php occ maintenance:mode --off" www-data
=>
Maintenance mode disabled
su -s /bin/sh -c "php occ config:system:get overwrite.cli.url" www-data



#OUTSIDE NEXTCLOUD CONTAINER
============================
#herstarten:

kubectl rollout restart deployment nextcloud -n nextcloud

#testen webdav:

curl -v -u admin:Nextcloud01@ -X PROPFIND https://nextcloud-riscv.allarddcs.nl/remote.php/dav/files/admin/

