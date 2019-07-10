FROM alunde/opensuse:42.3
MAINTAINER andrew.lunde@sap.com

#Install more stuff if needed
RUN zypper ar http://download.opensuse.org/tumbleweed/repo/oss/ tumbleweed \
	&& zypper -n --gpg-auto-import-keys install --no-recommends --auto-agree-with-licenses --force-resolution git-core lsof netcat hostname curl tar wget java python-pip python3-pip unzip jq nodejs8 npm8 libxml2-tools
RUN curl -L "https://packages.cloudfoundry.org/stable?release=linux64-binary&source=github" | tar -zx \
	&& npm install -g npm \ 
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
	&& wget -c http://thedrop.sap-a-team.com./files/hanaclient-2.3.144-linux-x64.tar.gz \
	&& tar xzvf hanaclient-2.3.144-linux-x64.tar.gz \
	&& client/hdbinst -b \
	&& echo "export PATH=\$PATH:/usr/sap/hdbclient" >> /etc/bash.bashrc \
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
	&& echo "xs api https://api.p2sb.psg.tax.us.deloitte.com:443/ --skip-ssl-validation" >> /etc/motd \
	&& echo "xs login -u APPAEOI -p Nirvana####1" >> /etc/motd \
	&& echo "git clone https://github.com/alundesap/mta_dt_poc.git" >> /etc/motd \
	&& echo "git config --global user.email "'"'"andrew.lunde@sap.com"'"' >> /etc/motd \
	&& echo "git config --global user.name "'"'"Andrew Lunde"'"' >> /etc/motd \
	&& echo "cd mta_dt_poc" >> /etc/motd \
	&& echo "" >> /etc/motd \
	&& echo "ssh-keygen ; cat /root/.ssh/id_rsa.pub" >> /etc/motd \
	&& echo "" >> /etc/motd
#
COPY entrypoint.sh /usr/local/bin/
EXPOSE 22
#
ENTRYPOINT ["entrypoint.sh"]
