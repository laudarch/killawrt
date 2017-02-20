#!/bin/sh

cat <<__HEADERS__
Content-Type: text/plain

__HEADERS__

ACTION=$(echo "$QUERY_STRING" | sed -e 's,[^a-zA-Z0-9],_,g')

h_config() {
	cat /etc/killawrt.conf
}

h_log() {
	cat /var/log/killawrt.log
}

h_version() {
	killawrt --version
}

case "$ACTION" in
  config)
  	h_config
  	;;
  log)
  	h_log
  	;;
  version)
	h_version
	;;
  *)
	echo "501 - Action '$ACTION' not implemented (yet)"
	;;
esac

