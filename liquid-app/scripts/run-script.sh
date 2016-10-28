#!/bin/bash
case  $1  in
start)
exec /usr/sbin/apache2ctl -D FOREGROUND
;;
test)
if [ $(/usr/bin/php /var/www/html/index.php | grep IP | wc -l ) -gt 0 ] ; then
   echo "PHP app Test Passed OK"
else
   echo "PHP app Test Failed" 
   exit 1
fi
;;
*)
echo "please use $@ start|test"
;;
esac
