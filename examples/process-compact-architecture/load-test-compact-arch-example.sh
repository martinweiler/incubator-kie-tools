PROTOCOL=http
HOST=localhost
PORT=8080
CONTEXT=hiring
CONCURRENT_REQUESTS=10
TOTAL_REQUESTS=100

if [ -n "$1" ]; then
   CONTEXT="$1"
fi

APPURL=${PROTOCOL}://${HOST}:${PORT}/${CONTEXT}

# create process instance
echo "{\"candidateData\": { \"name\": \"Jon\", \"lastName\": \"Snow\", \"email\": \"jon@snow.org\", \"experience\": 0, \"skills\": [\"Java\", \"Kogito\", \"Fencing\"]}}" > payload.json
echo Load testing  ${APPURL} with payload `cat payload.json`
echo Concurrency ${CONCURRENT_REQUESTS}
echo Total number of requests ${TOTAL_REQUESTS}

# load test
ab -c ${CONCURRENT_REQUESTS} -n ${TOTAL_REQUESTS} -H 'Content-Type: application/json' -T 'application/json' -p payload.json ${APPURL}
rm payload.json

# wait for 2 seconds
sleep 2

ACTIVE_PROCESS_INSTANCES=`curl -s -X POST http://localhost:8080/graphql -H 'accept: application/json' -H 'Content-Type: application/json' -d "{\"query\": \"{ ProcessInstances(where:{state:{equal:ACTIVE}}) { id, state, start, end } }\"}"|jq '.data.ProcessInstances | length'`

echo "-------------------------------------------------------"
echo "RESULT: ${ACTIVE_PROCESS_INSTANCES} of ${TOTAL_REQUESTS} process instances open"
echo "-------------------------------------------------------"
