# Exit immediately if a pipeline returns a non-zero status
set -e

position () {
    curl -s http://api.open-notify.org/iss-now.json |
        jq -r '[.iss_position.longitude, .iss_position.latitude] | @tsv';
}

wkt_position () {
    echo "POINT ($(position | expand -t 1))";
}

while true; do
    crash --hosts 192.168.40.81:4200 \
        --command "INSERT INTO iss (position) VALUES ('$(wkt_position)')"
    echo 'Sleeping for 1 seconds...'
    sleep 10
done


