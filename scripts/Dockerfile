FROM ubuntu:20.04

COPY kelp /bin/kelp
COPY trader_configs/* /bin/
COPY strategy_configs/vanitycoin_buysell_strategy.cfg /bin/vanitycoin_buysell_strategy.cfg 

# RUN apt update && apt install -y wget
RUN apt update && apt install -y ca-certificates
