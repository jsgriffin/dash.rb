var Widget = Class.extend({
    init: function(s) {
        this.settings = s;
        this.data = {};
    },
    
    receive: function(data) {

    },
    
    send: function(data) {
        console.log("Sending from widget");
        socket.send(this.settings.id, data);
    },
    
    render: function() {
        var html = new EJS({text: this.settings.template}).render(this.data);
        $(this.settings.containerId).html(html);
        this.afterRender();
    },
    
    afterRender: function() {
        
    }
});
