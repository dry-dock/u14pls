# Begin service ENV variables
export SHIPPABLE_ES_CLUSTER_NAME=shippabletest;
export SHIPPABLE_ES_PORT=9200;
export SHIPPABLE_ES_BINARY="/usr/local/bin/elasticsearch";
export SHIPPABLE_ES_CMD="$SHIPPABLE_ES_BINARY --cluster.name=$SHIPPABLE_ES_CLUSTER_NAME";
# End service ENV variables

#
# Function to START
#
start_service() {
  start_generic_service "elasticsearch" "$SHIPPABLE_ES_BINARY" "$SHIPPABLE_ES_CMD" "$SHIPPABLE_ES_PORT";
}

# Function to stop
stop_service() {
  curl -s -X POST "http://localhost:9200/_shutdown" > /dev/null 2>&1;
}

start_generic_service() {
  name=$1
  binary=$2
  service_cmd=$3
  service_port=$4


  if [ -f $binary ]; then
    exec_cmd "sudo su -c \"$service_cmd > /dev/null 2>&1 &\"";
    sleep 5

    ## check if the service port is reachable
    while ! nc -vz localhost $service_port &>/dev/null; do

      ## check service process PID
      service_proc=$(pgrep -f "$binary" || echo "")

      if [ ! -z "$service_proc" ]; then
        ## service PID exists, service is starting. Hence wait...
        exec_cmd "echo \"Waiting for $name to start...\"";
      else
        ## service PID does not exist, service crashed. Reboot service...
        exec_cmd "echo 'Service $name boot error, restarting...'"
        exec_cmd "sudo su -c \"$service_cmd > /dev/null 2>&1 &\"";
      fi
      sleep 5;
    done
    exec_cmd "echo \"$name started successfully\"";
  else
    exec_cmd "echo \"$name will not be started because the binary was not found at $binary.\""
    if [ "$name" != "mysql" ] && [ "$name" != "postgres" ]; then
      exit 99;
    fi
  fi
}

exec_cmd() {
  cmd=$@
  cmd_uuid=$(python -c 'import uuid; print(str(uuid.uuid4()))')
  cmd_start_timestamp=`date +"%s"`
  echo "__SH__CMD__START__|{\"type\":\"cmd\",\"sequenceNumber\":\"$cmd_start_timestamp\",\"id\":\"$cmd_uuid\"}|$cmd"
  eval "$cmd"
  cmd_status=$?
  if [ "$2" ]; then
    echo $2;
  fi

  cmd_end_timestamp=`date +"%s"`
  echo "__SH__CMD__END__|{\"type\":\"cmd\",\"sequenceNumber\":\"$cmd_start_timestamp\",\"id\":\"$cmd_uuid\",\"exitcode\":\"$cmd_status\"}|$cmd"
  return $cmd_status
}

#
# Call to start service
#
echo "================= Starting elasticsearch ==================="
printf "\n"
start_service
printf "\n\n"
echo "================= Stopping elasticsearch ==================="
printf "\n"
stop_service
printf "\n\n"
