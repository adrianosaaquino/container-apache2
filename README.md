# Apache 2 GitHub Page

Apache 2.4 image.

## How to use this image

This image makes it easy to run Apache Web Server 2.

```
$ docker run -it --rm "80:80" aaquino/apache2
```

### Expose
80
443

### Volumes
/usr/local/apache2/conf.d
/usr/local/apache2/www
/usr/local/apache2/logs
/usr/local/apache2/certs

## Simplee example with docker-compose


```
version: '2'

services:
 apache2:
  container_name: apache2-proxy
  image: aaquino/apache2:1.00
  restart: unless-stopped
  volumes:
   - ./conf.d:/usr/local/apache2/conf.d
   - ./www:/usr/local/apache2/www
   - ./logs:/usr/local/apache2/logs
   - ./certs:/usr/local/apache2/certs
  ports:
   - 80:80
   - 443:443
```

- ./conf.d: additional sites
- ./www: static content
- ./logs: apache logs
- ./certs: SSL certificates

### Example SSL usage:

Site Example.com

File: /conf.d/example.com.conf

```
<VirtualHost *:80>

    ServerName example.com

    RedirectPermanent / https://example.com

</VirtualHost>

<IfModule mod_ssl.c>
    <VirtualHost *:443>
       
        ServerName example.com

        SSLEngine on

        SSLCertificateFile      ${APACHE_DIR}/certs/example.com/server.crt
        SSLCertificateKeyFile   ${APACHE_DIR}/certs/example.com/server.key
        SSLCertificateChainFile ${APACHE_DIR}/certs/example.com/gd_bundle.crt
        SSLCipherSuite          EECDH+AESGCM:EDH+AESGCM:AES256+EECDH:AES256+EDH
        SSLProtocol             -all +TLSv1.2
        SSLHonorCipherOrder     On

        Header always set Strict-Transport-Security "max-age=63072000; includeSubdomains; preload"
        Header always set X-Frame-Options DENY
        Header always set X-Content-Type-Options nosniff

        ErrorLog ${APACHE_LOG_DIR}/example.com-error.log
        CustomLog ${APACHE_LOG_DIR}/example.com-access.log combined

        ProxyPass / http://127.0.0.1:8080/ retry=0
        ProxyPassReverse / http://127.0.0.1:8080/
        ProxyPreserveHost on

    </VirtualHost>
</IfModule>
```

Folder: /certs/
- /example.com/server.crt
- /example.com/server.key
- /example.com/gd_bundle.crt
