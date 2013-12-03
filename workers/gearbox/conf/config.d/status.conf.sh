#!/bin/sh

[ -n "$status_db_type" ] && db_type=$status_db_type
[ -n "$status_db_name" ] && db_name=$status_db_name
[ -n "$status_db_user" ] && db_user=$status_db_user
[ -n "$status_db_pass" ] && db_pass=$status_db_pass
[ -n "$status_db_admin_pass" ] && db_admin_pass=$status_db_admin_pass
[ -n "$status_db_host" ] && db_host=$status_db_host
[ -n "$status_db_port" ] && db_port=$status_db_port
[ -n "$status_db_sock" ] && db_sock=$status_db_sock

[ -n "$db_type" ] || db_type="sqlite3"
if [ -z "$db_name" ]; then
    [ "$db_type" = "mysql" ] && db_name="status" || db_name="$ROOT/var/gearbox/db/status.db"
fi
if [ -z "$db_user" ]; then
    if [ "$db_type" = "mysql" ]; then
        db_user="gearbox"
    else
        db_user="nobody"
    fi
fi
if [ -z "$db_port" ]; then
    [ "$db_type" = "mysql" ] && db_port=3306 || db_port=0
fi
if [ "$db_type" = "mysql" ]; then
    [ -n "$db_host" ] || db_host="localhost"
    [ "$db_host" = "localhost" ] && [[ -z "${db_sock-undefined}" || ${db_sock:=/tmp/mysql.sock} ]]
fi
cat <<EOM
{
    "db_type" : "$db_type",
    "db_name" : "$db_name",
    "db_user" : "$db_user",
    "db_pass" : "$db_pass",
    "db_admin_pass": "$db_admin_pass",
    "db_host" : "$db_host",
    "db_port" : $db_port,
    "db_sock" : "$db_sock"
}
EOM
