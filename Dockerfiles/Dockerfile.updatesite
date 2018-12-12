FROM eyedeekay/eephttpd
COPY . /opt/eephttpd/www
USER eephttpd
CMD eephttpd -f /usr/src/eephttpd/etc/eephttpd/eephttpd.conf \ -i -n i2pbrowser-updates -s /opt/eephttpd/ -sh=sam-host -sp=7656 -r
