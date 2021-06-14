# Helium Blockchain ETL Tools

Just a set of tools to assist with ETL upkeep.

## etl-status.sh

Will show the local ETL's current block height, Helium's current block height and last 15 lines of the console log. Created to be ran under `tmux` and `watch` as follows:

```
git clone https://github.com/hotspotrf/helium-blockchain-etl-tools.git
cd helium-blockchain-etl-tools
sudo apt install jq tmux wget
chmod +x etl-status.sh
tmux new-session -s etl_watch 'watch -n8 ./etl-status.sh'
```

To exit out of tmux you press CTRL+B and just hit the "d" key on your keyboard. To reattach yourself to that session:

`tmux attach -t etl_watch`

This script is just meant to be ran while the ETL is running, out-of-the-box - no configuration necessary and will even make a configuration file that contains your ETL's working directory - if one isn't present for you - so you're able to run the other scripts. You will get an error obviously if the ETL isn't running.

## etl-live.sh

Sometimes the ETL will unexpectedly crash, this keeps it alive and well. You'll want to crontab this; every 5 mins depending on your needs.

```
chmod +x etl-status.sh
crontab -e
*/5 * * * * $HOME/helium-blockchain-etl-tools/etl-live.sh
```
