var Widget = Class.extend({
    init: function(s) {
        this.settings = s;
    },
    
    receive: function(data) {

    },
    
    send: function(data) {
        socket.send(data);
    }
});
