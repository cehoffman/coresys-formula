class Nginx < Coresys::Formula
  stable do
    url 'http://nginx.org/download/nginx-1.2.7.tar.gz'
    sha1 '65309abde9d683ece737da7a354c8fae24e15ecb'
  end

  devel do
    url 'http://nginx.org/download/nginx-1.3.15.tar.gz'
    sha1 '16488c527078e26c32b0e467120501abf927fc8f'
  end

  def install
    system './configure', '--builddir=build', "--prefix=#{prefix}",
          '--user=nginx', '--group=nginx', "--conf-path=#{etc}/nginx/nginx.conf",
          "--error-log-path=#{var}/nginx/log/error.log",
          "--http-log-path=#{var}/nginx/log/access.log",
          "--pid-path=#{var}/nginx/nginx.pid",
          "--lock-path=#{var}/nginx/nginx.lock",
          "--http-client-body-temp-path=#{var}/nginx/tmp/client",
          "--http-proxy-temp-path=#{var}/nginx/tmp/proxy",
          "--http-fastcgi-temp-path=#{var}/nginx/tmp/fcgi",
          '--with-md5-asm', '--with-sha1-asm', '--with-pcre',
          '--without-http_geo_module',
          '--without-http_scgi_module',
          '--without-http_ssi_module',
          '--without-http_uwsgi_module',
          '--without-http_userid_module',
          '--with-http_gzip_static_module',
          '--with-http_ssl_module',
          "--with-http_stub_status_module",
          '--with-sha1=/usr/lib',
          '--with-ipv6'
    system 'make'
    system 'make', 'install'
    man8.install 'man/nginx.8'
  end
end
