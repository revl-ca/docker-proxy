events {
  worker_connections 1024;
}

http {
  server {
    listen {{ SERVER_PORT }};

    access_log /dev/stdout combined;
    error_log /dev/stdout;

    location / {
      limit_except GET {
        deny all;
      }

      proxy_pass http://unix:/var/run/docker.sock;
    }
  }
}

