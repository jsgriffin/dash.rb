var Widget = Class.extend({
    init: function(s) {
        this.settings = s;
        this.data = {};
        
        if(this.settings.containerId.charAt(0) != '#') {
            this.settings.containerId = '#' + this.settings.containerId;
        }
    },
    
    receive: function(data) {

    },
    
    send: function(data) {
        socket.send(data);
    },
    
    render: function() {
        var html = new EJS({text: this.settings.template}).render(this.data);
        $(this.settings.containerId).html(html);
    }
});
