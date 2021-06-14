(export workingDir=$(ps -ef | grep `pidof blockchain_etl | head -n 1` | awk '{print $8}' | head -n 1 | sed 's/_build/\n/g' | head -n 1) && export configFile=config.json && (export workDir=$(cat config.json | jq -r '.workDir') && (if [ -z $workDir ]; then echo $(rm -rf config.json && (echo 'Making config file.' && echo '{"workDir":"'${workingDir}'"}' > config.json)); fi) || echo 'Making config file.' && echo '{"workDir":"'${workingDir}'"}' > config.json) && export consoleLog="${workingDir}_build/dev/rel/blockchain_etl/log/console.log" && echo "[LOCAL BLOCKCHAIN-ETL BLOCK]" && echo $workingDir | awk '{print $1"_build/dev/rel/blockchain_etl/bin/blockchain_etl info height"}' | bash | awk '{ print $2 }' && echo; echo "[HELIUM API BLOCK]" && wget -qO- --no-check-certificate --no-cache --no-cookies https://api.helium.io/v1/stats | jq -r '.data .counts .blocks' && echo; echo "[LAST 15 OF CONSOLE LOGS]" && tail -f -n 15 "$consoleLog") || echo; echo 'Error running etl-status.'
