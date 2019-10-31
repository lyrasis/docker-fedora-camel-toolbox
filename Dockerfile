FROM openjdk:8

ENV KARAF_VERSION 4.0.5

RUN cd /tmp \
	&& wget -q -O "apache-karaf-${KARAF_VERSION}.tar.gz" "http://archive.apache.org/dist/karaf/${KARAF_VERSION}/apache-karaf-${KARAF_VERSION}.tar.gz" \
	&& tar -zxvf apache-karaf-$KARAF_VERSION.tar.gz \
	&& mv /tmp/apache-karaf-$KARAF_VERSION /opt \
	&& ln -s "/opt/apache-karaf-$KARAF_VERSION" /opt/karaf

COPY files/* /
RUN chmod u+x /*.sh && \
		sed -i "s|#org.ops4j.pax.url.mvn.localRepository=|org.ops4j.pax.url.mvn.localRepository=~/.m2/repository|" /opt/karaf/etc/org.ops4j.pax.url.mvn.cfg && \
		/opt/karaf/bin/start && \
		echo "Waiting for Karaf to install features" && \
		sleep 10 && \
		/opt/karaf/bin/client -u karaf -h localhost -a 8101 "feature:repo-add hawtio 2.5.0" && \
		/opt/karaf/bin/client -u karaf -h localhost -a 8101 "feature:install hawtio" && \
		/opt/karaf/bin/client -u karaf -h localhost -a 8101 -f "/fedora_camel_toolbox.script"

HEALTHCHECK --interval=1m --timeout=5s --start-period=1m --retries=2 \
  CMD wget -q --spider http://localhost:8181/hawtio || exit 1

CMD ["/start.sh"]
