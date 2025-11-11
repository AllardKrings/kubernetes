
#registratie admin:

kubectl exec -it matrix-644984f6b7-d7jcp -n matrix -- register_new_matrix_user http://localhost:8008  -u admin -p Matrix01@ \
        -a -k f0hE.OTU8UXQ44yIHPWtO+8CKhM-b:QZNngk_qhE8EvgmP-3h@

#registratie gewone gebruiker:

kubectl exec -it matrix-644984f6b7-d7jcp -n matrix -- register_new_matrix_user http://localhost:8008  -u diederick -p Matrix01@ \
        --no-admin -k f0hE.OTU8UXQ44yIHPWtO+8CKhM-b:QZNngk_qhE8EvgmP-3h@

#algemeen:

usage: register_new_matrix_user [-h] [-u USER] [--exists-ok] [-p PASSWORD | --password-file PASSWORD_FILE] [-t USER_TYPE]                                [-a | --no-admin] (-c CONFIG | -k SHARED_SECRET)
                                [server_url]

Used to register new users with a given homeserver when registration has been disabled. The homeserver must be configured with
the 'registration_shared_secret' option set.

positional arguments:
  server_url            URL to use to talk to the homeserver. By default, tries to find a suitable URL from the configuration
                        file. Otherwise, defaults to 'http://localhost:8008'.

options:
  -h, --help            show this help message and exit
  -u USER, --user USER  Local part of the new user. Will prompt if omitted.
  --exists-ok           Do not fail if user already exists.
  -p PASSWORD, --password PASSWORD
                        New password for user. Will prompt for a password if this flag and `--password-file` are both omitted.
  --password-file PASSWORD_FILE
                        File containing the new password for user. If set, will override `--password`.
  -t USER_TYPE, --user_type USER_TYPE
                        User type as specified in synapse.api.constants.UserTypes
  -a, --admin           Register new user as an admin. Will prompt if --no-admin is not set either.
  --no-admin            Register new user as a regular user. Will prompt if --admin is not set either.
  -c CONFIG, --config CONFIG
                        Path to server config file. Used to read in shared secret.
  -k SHARED_SECRET, --shared-secret SHARED_SECRET
                        Shared secret as defined in server config file.
#coturn:

check udp:

nc -zvu coturn-prod.allarddcs.nl 3478
nc -zv coturn-prod.allarddcs.nl 3478
nc -zv coturn-prod.allarddcs.nl 5349

