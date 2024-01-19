shell:
	poetry shell

dev:
	uvicorn --host 0.0.0.0 --port 8000 --reload main:app

prod:
	uvicorn --host 0.0.0.0 --port 8000 --workers 10 main:app

requirements:
	poetry export --without-hashes --format=requirements.txt > requirements.txt
	
cert_gen:
	openssl req -x509 -nodes -days 365 -newkey rsa:2048 -keyout F:\command\nginx\conf\private.key -out F:\command\nginx\conf\certs.crt
	openssl dhparam -out F:\command\nginx\conf\dhparam.pem 2048
	