var Socket = Class.extend({
    init: function() {
        this.socket = new WebSocket("ws://localhost:8989");
        this.socketOpen = false;
        _this = this;
    
        this.socket.onopen = function() {
            console.log("Socket opened");
        }
        
        this.socket.onmessage = function(msg) {
            console.log("Received: ");
            console.log(msg);
        }
        
        this.socket.onclose = function() {
            console.log("Socket closed");
        }

        console.log("Waiting for socket to open...");
    },
    
    send: function(msg) {
        console.log("Sending: " + msg);
        if(this.socket.readyState != 1) {
            console.log("Socket not open. State is: " + this.socket.readyState);
        } else {
            this.socket.send(msg);
        }
    }
});