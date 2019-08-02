#!/bin/sh
#service traccar server for universal version
#e.g. ./traccar.sh start
#e.g. ./traccar.sh stop
#e.g. ./traccar.sh restart


SERVICE_NAME=traccar
PATH_TO_JAR=${SYNOPKG_PKGDEST}/tracker-server.jar
PATH_TO_CONF=${SYNOPKG_PKGDEST}/conf/traccar.xml
PID_PATH_NAME=${SYNOPKG_PKGDEST}/tmp/traccar-pid
case $1 in
    start)
        echo "Starting $SERVICE_NAME ..."
        if [ ! -f $PID_PATH_NAME ]; then
            # nohup java -jar $PATH_TO_JAR $PATH_TO_CONF ./tmp 2>> /dev/null >> /dev/null &
			java -jar $PATH_TO_JAR $PATH_TO_CONF ${SYNOPKG_PKGDEST}/tmp 2>> /dev/null >> /dev/null &
			echo $! > $PID_PATH_NAME
            echo "$SERVICE_NAME started ..."
        else
            echo "$SERVICE_NAME is already running ..."
        fi
    ;;
    stop)
        if [ -f $PID_PATH_NAME ]; then
            PID=$(cat $PID_PATH_NAME);
            echo "$SERVICE_NAME stoping ..."
            kill $PID;
            echo "$SERVICE_NAME stopped ..."
            rm $PID_PATH_NAME
        else
            echo "$SERVICE_NAME is not running ..."
        fi
    ;;
    restart)
        if [ -f $PID_PATH_NAME ]; then
            PID=$(cat $PID_PATH_NAME);
            echo "$SERVICE_NAME stopping ...";
            kill $PID;
            echo "$SERVICE_NAME stopped ...";
            rm $PID_PATH_NAME
            echo "$SERVICE_NAME starting ..."
            nohup java -jar $PATH_TO_JAR $PATH_TO_CONF ${SYNOPKG_PKGDEST}/tmp 2>> /dev/null >> /dev/null &
                        echo $! > $PID_PATH_NAME
            echo "$SERVICE_NAME started ..."
        else
            echo "$SERVICE_NAME is not running ..."
        fi
    ;;
esac
