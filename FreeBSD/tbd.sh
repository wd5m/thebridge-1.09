# Start thebridge
# $Id: tbd.sh,v 1.1.1.1 2002/08/10 20:33:40 wb6ymh Exp $

pidfiledir=/var/run
tbd=/usr/local/libexec/tbd

# start
if [ "x$1" = "x" -o "x$1" = "xstart" ]; then
        if [ -f $tbd ]; then
                echo -n ' thebridge'
                $tbd -s
        fi

# stop
elif [ "x$1" = "xstop" ]; then
        kill `cat $pidfiledir/tbd.pid`
fi

