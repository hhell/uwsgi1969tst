#!/bin/sh

set -e
# set -x


ulimit -c unlimited

# # Maybe (because there are problems with setuid sometimes):
# sudo ./.env/bin/uwsgi --ini _uwsgi.ini --logto _uwsgi.log &

. ./.env/bin/activate
python setup.py build_ext --inplace

./.env/bin/uwsgi --ini uwsgi_aeo.ini &
uwsgi_pid=$!
echo " ===== run: uWSGI pid: $uwsgi_pid"

trap 'kill -TERM "$uwsgi_pid" 2>/dev/null; sleep 2; kill -KILL "$uwsgi_pid" 2>/dev/null' EXIT

sleep 3

# # Maybe: nginx
# # (but hopefully uwsgi's http will be enough)

query="$1"

curl \
    --fail \
    --show-error \
    --silent \
    --max-time 20 \
    "http://127.0.0.1:49053/test/?$query"

# echo " ===== run: Reload ..."
# echo w > ./.run/_uwsgi_master.fifo
# sleep 1

echo " ===== run: ..."

for num in $(seq 1 20); do
    echo ""
    curl \
        --write-out "\nHTTP %{http_code}\n" \
        --show-error \
        --silent \
        --max-time 20 \
        "http://127.0.0.1:49053/test/?$query" \
        || true
    if [ x"$num" = x"10" ]; then
        echo "Mid-pause..."
        sleep 10
    else
        sleep 0.01
    fi
done

echo " ===== run: Sleep && kill..."

sleep 2

kill -TERM $uwsgi_pid

sleep 2

kill -KILL $uwsgi_pid || true

echo " ===== run: Done."
