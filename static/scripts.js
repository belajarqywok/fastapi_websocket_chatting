const userId = prompt("enter your user ID (e.g., user1, user2):");

const ws = new WebSocket(`ws://localhost:8000/ws/${userId}`);
const outputDiv = document.getElementById("output");

ws.onmessage = function (event) {
    const data = JSON.parse(event.data);
    outputDiv.innerHTML += `<p>${data.userId}: ${data.message}</p>`;
};

function sendMessage() {
    const messageInput = document.getElementById("messageInput");
    const content = {
        message: messageInput.value,
        userId
    }

    ws.send(JSON.stringify(content));
    messageInput.value = "";
    outputDiv.innerHTML += `<p>You: ${content.message}</p>`;
}
