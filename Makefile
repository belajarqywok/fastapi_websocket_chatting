shell:
	poetry shell

dev:
	uvicorn --host 0.0.0.0 --port 8000 --reload main:app

prod:
	uvicorn --host 0.0.0.0 --port 8000 --workers 10 main:app

requirements:
	poetry export --without-hashes --format=requirements.txt > requirements.txt
	