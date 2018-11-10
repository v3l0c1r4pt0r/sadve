#!/bin/sh
# Vectors for system tests
set -e
RETURN=0
COUNT=0

# array of vectors
declare -A VECTORS
VECTORS['sadve -d AF_INET sys/socket.h']='2'
VECTORS['sadve --define AF_INET sys/socket.h']='2'
VECTORS['sadve -s sockaddr sys/socket.h']='16'
VECTORS['sadve --struct sockaddr sys/socket.h']='16'
VECTORS['sadve -t uint32_t stdint.h']='4'
VECTORS['sadve --type uint32_t stdint.h']='4'
VECTORS['sadve -u i2c_smbus_data linux/i2c.h']='34'
VECTORS['sadve --union i2c_smbus_data linux/i2c.h']='34'
VECTORS['sadve -e net_device_flags linux/if.h']='4'
VECTORS['sadve --enum net_device_flags linux/if.h']='4'
VECTORS['sadve int stdint.h']=''
VECTORS['sadve int']=''
VECTORS['sadve --hex -d WDIOC_GETSTATUS linux/watchdog.h']='80045701'
VECTORS['sadve --dec -d WDIOC_GETSTATUS linux/watchdog.h']='-2147199231'
VECTORS['sadve --format=o -d WDIOC_GETSTATUS linux/watchdog.h']='20001053401'

# evaluate
for COMMAND in "${!VECTORS[@]}"; do
  let COUNT+=1
  EXPECTED="${VECTORS[$COMMAND]}"
  echo -n "'$COMMAND': "
  if [ "z$EXPECTED" == "z" ]; then
    EXPECTED_RETURN=1
  else
    EXPECTED_RETURN=0;
  fi
  set +e
  ACTUAL="$($COMMAND)"
  RESULT=$?
  set -e
  if [ $EXPECTED_RETURN -ne 0 -a $RESULT -ne 0 ]; then
    echo ' OK '
  elif [ $RESULT -eq $EXPECTED_RETURN -a "$ACTUAL" == "$EXPECTED" ]; then
    echo ' OK '
  else
    echo 'FAIL'
    let RETURN+=1
  fi
done

# return number of failed tests
echo "Failed $RETURN out of $COUNT tests."
exit $RETURN;
