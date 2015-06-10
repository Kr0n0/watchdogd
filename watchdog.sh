#!/bin/sh
#/etc/init.d/watchdog: start watchdog daemon.

### BEGIN INIT INFO
# Provides:          watchdog
# Short-Description: Start software watchdog daemon
# Required-Start:    $all
# Required-Stop:     $all
# Should-Start:
# Should-Stop:
# Default-Start:     2 3 4 5
# Default-Stop:      0 1 6
### END INIT INFO

PATH=/bin:/usr/bin:/sbin:/usr/sbin

test -x /usr/local/sbin/watchdogd || exit 0

# Get lsb functions
. /lib/lsb/init-functions

case "$1" in
  start)
        log_begin_msg "Starting watchdog daemon..."
        /usr/local/sbin/watchdogd
        PID=`cat /run/watchdogd.pid` && echo -1000 > /proc/${PID}/oom_score_adj
    ;;

  stop)
        log_begin_msg "Stopping watchdog daemon..."
        PID=`cat /run/watchdogd.pid` && pkill -9 ${PID}
    ;;

  status)
        cat /run/watchdogd.status
    ;;

  *)
    echo "Usage: /etc/init.d/watchdog {start|stop|status}"
    exit 1

esac

exit 0
