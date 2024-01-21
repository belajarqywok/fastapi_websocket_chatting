NGINX_PATH = F:\command\nginx\conf
HAPROXY_PATH = F:\command\haproxy

shell:
	poetry shell

dev:
	uvicorn --host 0.0.0.0 --port 8000 --reload main:app

prod:
	uvicorn --host 0.0.0.0 --port 8000 --workers 10 main:app

requirements:
	poetry export --without-hashes --format=requirements.txt > requirements.txt
	
# openssl x509 -req -sha256 -days 365 -in $(NGINX_PATH)/certs.crt -signkey $(NGINX_PATH)/private.key -out $(NGINX_PATH)/certs.pem
cert_gen:
	openssl req -x509 -nodes -days 365 -newkey rsa:2048 -keyout $(NGINX_PATH)\private.key -out $(NGINX_PATH)\certs.crt
	openssl dhparam -out $(NGINX_PATH)\dhparam.pem 2048
	
	cat $(NGINX_PATH)\certs.crt $(NGINX_PATH)\private.key > $(HAPROXY_PATH)\certificates.pem

haproxy:
	haproxy -f ./haproxy/haproxy.cfg