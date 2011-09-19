var Test = Widget.extend({
    init: function(s) {
        this._super(s);
    },
    
    onLoad: function() {
        var div = this.settings.containerId;
        _this = this;
        
        $(div).find('a.test-send').click(function() {
            _this.send("Donkeys");
        });
        
        this.data.title = "Beans AND cheese";
    }
});
