#docker stop $(docker ps -a -q)

#for VANITY_COIN_TRADER_CONFIG in $(ls trader_configs | head -n 2)
for VANITY_COIN_TRADER_CONFIG in $(ls trader_configs)
do
	echo "Starting $VANITY_COIN_TRADER_CONFIG..."
	docker run --name $VANITY_COIN_TRADER_CONFIG wealthcoin_vanitycoin_engine /bin/kelp trade --botConf /bin/$VANITY_COIN_TRADER_CONFIG --strategy buysell --stratConf /bin/vanitycoin_buysell_strategy.cfg &
	echo "Started $VANITY_COIN_TRADER_CONFIG"
done
