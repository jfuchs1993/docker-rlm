FROM debian:jessie
MAINTAINER dsheyp

RUN buildDeps=' \
		curl \
	' \
	set -x \
	&& apt-get update \
	&& apt-get install -y $buildDeps \
	&& rm -r /var/lib/apt/lists/*

ENV RLM_PREFIX /opt
RUN mkdir -p "$RLM_PREFIX"
WORKDIR $RLM_PREFIX

RUN pwd

	
COPY rlm.tgz rlm.tgz

RUN ls -alh

RUN tar -xvf rlm.tgz
RUN mv x64_l1.admin rlm 
COPY rlm.sh rlm/rlm.sh

RUN chmod +x rlm/rlm.sh

VOLUME /opt/rlm/licenses
VOLUME /opt/rlm/logs

# rlm server
EXPOSE 5053
# admin gui
EXPOSE 5054
# isv server
EXPOSE 54500

CMD ["/opt/rlm/rlm.sh", "start"]

