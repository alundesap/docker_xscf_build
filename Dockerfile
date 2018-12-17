FROM alunde/opensuse:42.3
MAINTAINER andrew.lunde@sap.com

#Install more stuff if needed
RUN zypper -n --gpg-auto-import-keys install --no-recommends --auto-agree-with-licenses --force-resolution go git-core lsof netcat hostname 
#
#
COPY entrypoint.sh /usr/local/bin/
EXPOSE 8080
#
#run!
#Moved to entrypoint.sh
#ENTRYPOINT chisel server -v --port 8080 --authfile /usr/bin/auth.json
ENTRYPOINT ["entrypoint.sh"]
