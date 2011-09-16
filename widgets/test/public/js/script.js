var Test = Widget.extend({
    init: function(s) {
        this._super(s);
    },
    
    onLoad: function() {
        var div = this.settings.containerId;
        _this = this;
        
        console.log(this);
        $('#' + div).find('a.test-send').click(function() {
            console.log("Sending...");
            console.log(_this);
            _this.send("Donkeys");
        });
    }
});
