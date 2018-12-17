FROM alunde/opensuse:42.3
MAINTAINER andrew.lunde@sap.com

#Install more stuff if needed
RUN zypper -n --gpg-auto-import-keys install --no-recommends --auto-agree-with-licenses --force-resolution git-core lsof netcat hostname curl tar wget java python-pip python3-pip
RUN curl -L "https://packages.cloudfoundry.org/stable?release=linux64-binary&source=github" | tar -zx \
	&& mv cf /usr/local/bin/ \ 
	&& wget http://thedrop.sap-a-team.com/files/mta_plugin_linux_amd64 \
	&& cf install-plugin mta_plugin_linux_amd64 -f \
	&& wget http://thedrop.sap-a-team.com/files/xs \
	&& chmod 755 xs \
	&& mv xs /usr/local/bin/ \
	&& wget http://thedrop.sap-a-team.com/files/mta_archive_builder-1.1.7.jar
#
# Need to set JAVA_HOME to get xs working properly...
#
COPY entrypoint.sh /usr/local/bin/
EXPOSE 22
#
ENTRYPOINT ["entrypoint.sh"]
