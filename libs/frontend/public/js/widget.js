var Widget = Class.extend({
    init: function(s) {
        this.settings = s;
    },
    
    receiveData: function(data) {
        console.log("Received: " + data);
    },
    
    sendData: function(data) {
        console.log("Sending: " + data);
    }
});
