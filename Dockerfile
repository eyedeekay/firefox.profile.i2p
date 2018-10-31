FROM eyedeekay/eephttpd
COPY . /opt/eephttpd/www
USER eephttpd
CMD eephttpd -n i2pbrowser-updates -s /opt/eephttpd/ -sh=sam-host -sp=7656 -r
