FROM ubuntu:bionic

ARG DONATE_LEVEL=0

#WORKDIR /app
USER root

RUN apt-get update && \
apt-get install -y gcc-7 g++-7 git build-essential cmake libuv1-dev libmicrohttpd-dev libssl-dev libhwloc-dev && \
cd /usr/src/ && \
git clone https://github.com/xmrig/xmrig.git && \
cd /usr/src/xmrig && \
#git checkout $GIT_TAG && \
sed -i -r "s/k([[:alpha:]]*)DonateLevel = [[:digit:]]/k\1DonateLevel = ${DONATE_LEVEL}/g" src/donate.h && \
mkdir build && \
cd build && \
cmake .. -DCMAKE_C_COMPILER=gcc-7 -DCMAKE_CXX_COMPILER=g++-7 && \
make

CMD ["/usr/src/xmrig/build/xmrig", "--algo=rx/loki", "--api-port=8080", "--max-cpu-usage=100", "--cpu-priority=5", "-o", "loki.herominers.com:10110", "-u", "LR4x4pnKTjihVJfiemGGY57u4uZAmiSm42saGnh65TJ8JBNepjNeiLHAB4FZZAYhoqUv4KJN63b951CxQn6NjZn9Qju4X6R" ]
