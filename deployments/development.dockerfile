FROM python:3.9-bullseye

# Write Byte Code and Buffered
ENV PYTHONDONTWRITEBYTECODE 1
ENV PYTHONUNBUFFERED 1

# Set Working Directory
WORKDIR /etc/fastapi_websocket_chatting/

# Upgrade PIP
RUN python3 -m pip install --upgrade pip

# Install the Requirements
COPY requirements.txt \
    /etc/fastapi_websocket_chatting/

RUN pip3 install -r requirements.txt

COPY . /etc/fastapi_websocket_chatting/

EXPOSE 8000

CMD [ "/bin/bash", "-c", "uvicorn --host 0.0.0.0 --port 8000 main:app" ]
