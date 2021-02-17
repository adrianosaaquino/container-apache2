FROM httpd:2.4.46
LABEL maintainer="adrianosaaquino@gmail.com"
EXPOSE 80 443
RUN runDeps="nano curl less libaprutil1-ldap openssl ca-certificates" \
 && apt-get update \
 && apt-get install -y --no-install-recommends $runDeps \
 && apt-get clean \
 && rm -rf /var/lib/apt/lists/* \
 && sed -i 's|#LoadModule ssl_mod|LoadModule ssl_mod|' /usr/local/apache2/conf/httpd.conf \
 && sed -i 's|#LoadModule socache_shmcb_module|LoadModule socache_shmcb_module|' /usr/local/apache2/conf/httpd.conf \ 
 && sed -i 's|#LoadModule proxy_module|LoadModule proxy_module|' /usr/local/apache2/conf/httpd.conf \
 && sed -i 's|#LoadModule proxy_http_module|LoadModule proxy_http_module|' /usr/local/apache2/conf/httpd.conf \
 && sed -i 's|#LoadModule rewrite_module|LoadModule rewrite_module|' /usr/local/apache2/conf/httpd.conf \
 && sed -i 's|#LoadModule proxy_wstunnel_module|LoadModule proxy_wstunnel_module|' /usr/local/apache2/conf/httpd.conf \
 && sed -i 's|#LoadModule deflate_module|LoadModule deflate_module|' /usr/local/apache2/conf/httpd.conf \
 && sed -i 's|#LoadModule log_config_module|LoadModule log_config_module|' /usr/local/apache2/conf/httpd.conf \
 && sed -i 's|#LoadModule logio_module|LoadModule logio_module|' /usr/local/apache2/conf/httpd.conf \
 && sed -i 's|#LoadModule negotiation_module|LoadModule negotiation_module|' /usr/local/apache2/conf/httpd.conf \
 && sed -i 's|#LoadModule security2_module|LoadModule security2_module|' /usr/local/apache2/conf/httpd.conf \ 
 && sed -i 's|#LoadModule unique_id_module|LoadModule unique_id_module|' /usr/local/apache2/conf/httpd.conf \ 
 && sed -i 's|#LoadModule watchdog_module|LoadModule watchdog_module|' /usr/local/apache2/conf/httpd.conf \ 
 && sed -i 's|#LoadModule access_compat_module|LoadModule access_compat_module|' /usr/local/apache2/conf/httpd.conf \ 
 && sed -i 's|#LoadModule cgid_module|LoadModule cgid_module|' /usr/local/apache2/conf/httpd.conf \ 
 && echo '# Custom config' >> /usr/local/apache2/conf/httpd.conf \
 && echo 'Define APACHE_DIR /usr/local/apache2' >> /usr/local/apache2/conf/httpd.conf \
 && echo 'Define APACHE_LOG_DIR ${APACHE_DIR}/logs' >> /usr/local/apache2/conf/httpd.conf \
 && echo '# Include generic snippets of statements' >> /usr/local/apache2/conf/httpd.conf \
 && echo 'Include conf.d/' >> /usr/local/apache2/conf/httpd.conf \
 && echo 'Listen 443' >> /usr/local/apache2/conf/httpd.conf \
 && echo "----------------------------------------------------------------------------" \
 && cat -n /usr/local/apache2/conf/httpd.conf \
 && echo "----------------------------------------------------------------------------"
