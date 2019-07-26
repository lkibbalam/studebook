set -e
rm -f /studybook-api/tmp/pids/server.pid
exec "$@"