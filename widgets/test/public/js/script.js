var Test = Widget.extend({
    init: function(s) {
        this._super(s);
    },
    
    onLoad: function() {        
        this.data.title = "Beans AND cheese";
    },
    
    afterRender: function() {
        var div = this.settings.containerId;
        _this = this;
        
        $(div).find('a.test-send').click(function() {
            _this.send({title: "Donkeys"});
        });
    },
    
    receive: function(data) {
        this.data.title = data.title;
        this.render();
    }
});
