FROM alunde/opensuse:42.3
MAINTAINER andrew.lunde@sap.com

#Install more stuff if needed
RUN zypper ar http://download.opensuse.org/tumbleweed/repo/oss/ tumbleweed \
	&& zypper -n --gpg-auto-import-keys install --no-recommends --auto-agree-with-licenses --force-resolution git-core lsof netcat hostname curl tar wget java python-pip python3-pip unzip jq nodejs8 npm libxml2-tools
RUN curl -L "https://packages.cloudfoundry.org/stable?release=linux64-binary&source=github" | tar -zx \
	&& mv cf /usr/local/bin/ \ 
	&& wget http://thedrop.sap-a-team.com/files/mta_plugin_linux_amd64 \
	&& cf install-plugin mta_plugin_linux_amd64 -f \
	&& wget http://thedrop.sap-a-team.com/files/xs.onpremise.runtime.client_linuxx86_64.zip \
	&& mkdir -p xs_cli \
	&& cd xs_cli \
	&& unzip ../xs.onpremise.runtime.client_linuxx86_64.zip \
	&& cd .. \
	&& mv xs_cli /usr/local/ \
	&& echo "export PATH=\$PATH:/usr/local/xs_cli/bin" >> /etc/bash.bashrc \
	&& wget http://thedrop.sap-a-team.com/files/mta_archive_builder-1.1.7.jar \
	&& mv /mta_archive_builder-1.1.7.jar /usr/local/xs_cli/jars \
	&& ln -s /usr/local/xs_cli/jars/mta_archive_builder-1.1.7.jar /usr/local/xs_cli/jars/mta.jar \
	&& wget http://thedrop.sap-a-team.com/files/mta_xs_cli_jars.sh \
	&& mv /mta_xs_cli_jars.sh /usr/local/xs_cli/bin/mta \
	&& chmod 755 /usr/local/xs_cli/bin/mta \
	&& rm -f /mta_plugin_linux_amd64 \
	&& rm -f /xs.onpremise.runtime.client_linuxx86_64.zip \
	&& echo "" > /etc/motd \
	&& echo "Welcome to Andrew's xscf-build" >> /etc/motd \
	&& echo "" >> /etc/motd \
	&& echo "cf api https://api.cf.us10.hana.ondemand.com" >> /etc/motd \
	&& echo "cf api https://api.cf.us30.hana.ondemand.com" >> /etc/motd \
	&& echo "cf api https://api.cf.eu10.hana.ondemand.com" >> /etc/motd \
	&& echo "cf api https://api.cf.eu20.hana.ondemand.com" >> /etc/motd \
	&& echo "cf api https://api.cf.ap10.hana.ondemand.com" >> /etc/motd \
	&& echo "cf api https://api.cf.ap11.hana.ondemand.com" >> /etc/motd \
	&& echo "cf api https://api.cf.ca10.hana.ondemand.com" >> /etc/motd \
	&& echo "cf api https://api.cf.jp10.hana.ondemand.com" >> /etc/motd \
	&& echo "" >> /etc/motd \
	&& echo "xs api https://api.<hostname> --skip-ssl-validation" >> /etc/motd \
	&& echo "xs api https://<hostname>:30030 --skip-ssl-validation" >> /etc/motd \
	&& echo "" >> /etc/motd \
	&& echo "git clone https://github.com/alundesap/mta_python_juypter.git" >> /etc/motd \
	&& echo "cd mta_python_juypter" >> /etc/motd \
	&& echo "" >> /etc/motd \
	&& echo "xs api https://hxehost:39030 --skip-ssl-validation" >> /etc/motd \
	&& echo "git clone https://github.com/alundesap/mta_dt_poc.git" >> /etc/motd \
	&& echo "git clone https://github.com/alundesap/mta_dt_poc_master.git" >> /etc/motd \
	&& echo "git clone https://github.com/alundesap/mta_dt_poc_client.git" >> /etc/motd \
	&& echo "cd mta_dt_poc" >> /etc/motd \
	&& echo "" >> /etc/motd
#
COPY entrypoint.sh /usr/local/bin/
EXPOSE 22
#
ENTRYPOINT ["entrypoint.sh"]
