#redirect http to https
server {
	listen 80;
	server_name {{ ansible_hostname }}.local www.{{ ansible_hostname }}.local;
	return 301 https://{{ ansible_hostname }}.local$request_uri;
}

#redirect www to without www
server {
        listen 443 ssl;

        server_name www.{{ ansible_hostname }}.local;

        ssl_certificate {{ dest_ssl }}{{ ansible_hostname }}.crt;
        ssl_certificate_key {{ dest_ssl }}{{ ansible_hostname }}.key;

        return 301 https://{{ ansible_hostname }}.local$request_uri;
}


server {
	listen 443 ssl;

	server_name {{ ansible_hostname }}.local www.{{ ansible_hostname }}.local;
	ssl_certificate {{ dest_ssl }}{{ ansible_hostname }}.crt;
        ssl_certificate_key {{ dest_ssl }}{{ ansible_hostname }}.key;

	root /var/www/html;
	index index.html;

	location / {
		try_files $uri $uri/ =404;
       }
}
