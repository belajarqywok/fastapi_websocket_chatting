from fastapi.responses import HTMLResponse
from fastapi.staticfiles import StaticFiles
from fastapi.templating import Jinja2Templates
from fastapi.middleware.cors import CORSMiddleware
from fastapi import FastAPI, Request, WebSocket, WebSocketDisconnect

app = FastAPI()

app.mount(
    "/static",
    StaticFiles(directory = "static"), 
    name = "static"
)

templates = Jinja2Templates(
    directory = "templates"
)

# dictionary to store connected WebSocket clients
connected_users = {}

app.add_middleware(
    CORSMiddleware,
    allow_origins = ["*"],
    allow_methods = ["*"],
    allow_headers = ["*"],
    allow_credentials = True,
)

@app.get("/", response_class = HTMLResponse)
async def main(request: Request):
    return templates.TemplateResponse(
        name = "chatting.jinja",
        context = {'request': request}
    )

@app.websocket("/ws/{user_id}")
async def websocket_endpoint(user_id: str, websocket: WebSocket):
    await websocket.accept()

    # store the WebSocket connection in the dictionary
    connected_users[user_id] = websocket

    try:
        while True:
            data = await websocket.receive_text()
            # send the received data to the other user
            for user, user_ws in connected_users.items():
                if user != user_id:
                    await user_ws.send_text(data)

    except WebSocketDisconnect:
        # if a user disconnects, remove them from the dictionary
        del connected_users[user_id]
