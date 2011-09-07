var dashboard = null;

$(function(){
    dashboard = new Dashboard();
    dashboard.fetchWidgetTemplate('test-1');
    dashboard.convertWidgetNameToClassName('test-beans-1-dogs');
});

var Dashboard = function(){
    var availableWidgets = [],
        loadedWidgets = [];
    
    // Register a new widget
    this.loadWidget = function(widget) {  
        this.fetchWidgetTemplate(widget);
    },
    
    // Fetch the widget template      
    this.fetchWidgetTemplate = function(widget) {
        // Load in the style and compile it
        var link = $('<link rel="stylesheet/less" type="text/css" href="/widgets/' + widget + '/public/css/style.less" />');
        $('head').append(link);
        less.sheets.push(link[0]);
        less.refresh();

        // Load in any JS for the widget
        var link = $('<script type="text/javascript" src="/widgets/' + widget + '/public/js/script.js"></script>');
        $('head').append(link);

        // Load in the template
        $.ajax({
           url: '/widgets/' + widget + '/public/template.ejs',
           success: function(data) {
               dashboard.addTemplateToBody(widget, data);
           },
           error: function(data) {
               console.log("Error");
               console.log(data);
           }
        });
    },
    
    /*
     * Add the template to the body, and init the widget
     * Also set up the data structures for the widget, 
     * and compile the template from ejs
     */
    this.addTemplateToBody = function(widget, template) {
        $('#widget-container').append('<div class="' + widget + '">' + template + '</div>');
        var className = this.convertWidgetNameToClassName(widget);
        eval('var object = new ' + className + '()');
        object.init();
    },
    
    /*
     * The JS class names are camel-cased versions of the widget names, 
     * minus any punctuation and spaces
     */
    this.convertWidgetNameToClassName = function(widget) {
        var bits = widget.split(/\W/g);
        var name = bits[0];
        
        for(i = 1; i < bits.length; i++) {
            name += bits[i].charAt(0).toUpperCase() + bits[i].substr(1).toLowerCase();
        }
        
        return name;        
    }
};