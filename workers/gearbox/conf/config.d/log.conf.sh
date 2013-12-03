#!/bin/sh
cronbindir=/usr/sbin
cat <<EOM
{
    "config_file" : "/etc/gearbox/logger/gearbox-logger.conf",
    "cmd" : "%{log.logger} --hardlink %{log.dir}/%{logname}.log %{log.dir}/archive/%{logname}.%Y%m%d.log",
    "logger" : "$cronbindir/cronolog",
    "dir" : "$ROOT/var/log/gearbox"
}
EOM
