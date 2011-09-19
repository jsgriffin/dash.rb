var Dashboard = Class.extend({
    init: function() {
        this.availableWidgets = {};
        this.loadedWidgets = {};
        this.numLoadedWidgets = 0;
    },
    
    getWidget: function(widgetId) {
        if(this.loadedWidgets[widgetId] != undefined) {
            return this.loadedWidgets[widgetId];
        } else {
            return null;
        }
    },
    
    // Register a new widget
    loadWidget: function(widget) {  
        this.fetchWidgetTemplate(widget);
    },
    
    // Fetch the widget template      
    fetchWidgetTemplate: function(widget) {
        // Load in the style and compile it
        var link = $('<link rel="stylesheet/less" type="text/css" href="/widgets/' + widget + '/public/css/style.less" />');
        $('head').append(link);
        less.sheets.push(link[0]);
        less.refresh();

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
    addTemplateToBody: function(widget, template) {
        this.numLoadedWidgets++;
        var widgetId = 'widget-' + (this.numLoadedWidgets);
        $('#widget-container').append('<div class="widget ' + widget + '" id="' + widgetId + '"></div>');
        $('.widget').draggable({containment: 'parent', zIndex: 2700});
        this.loadWidgetJs(widget, widgetId, template);
    },

    /*
     * Load the widget's JavaScript, and then load the 
     * widget's class 
     */
    loadWidgetJs: function(widget, id, template) {
        var _this = this;
        
        $.ajax({
            url: '/widgets/' + widget + '/public/js/script.js',
            dataType: "script",
            success: function() {
                var className = _this.convertWidgetNameToClassName(widget);
                var settings = {
                    title: className,
                    widget: widget,
                    id: id,
                    containerId: '#' + id,
                    template: template
                };
                eval('var widgetObj = new ' + className + '(settings)');
                widgetObj.onLoad();
                widgetObj.render();
                _this.loadedWidgets[id] = widgetObj;
                _this.registerWidget(id);
            },
            error: function(error) {
                console.log("Error loading widget JS");
                console.log(error);
            }
        });
    },
    
    /*
     * Register a widget with the backend
     */
    registerWidget: function(widgetId) {
        var postData = {
            widgetId: widgetId,
            type: this.loadedWidgets[widgetId].settings.widget
        };
        console.log(postData);
        
        $.ajax({
            url: '/register-widget',
            data: {widget: JSON.stringify(postData)},
            type: "POST",
            success: function(data) {
                
            },
            error: function(error) {
                console.log("Error registering widget");
            }
        });
    },
    
    /*
     * The JS class names are camel-cased versions of the widget names, 
     * minus any punctuation and spaces
     */
    convertWidgetNameToClassName: function(widget) {
        var bits = widget.split(/\W/g);
        var name = '';
        
        for(i = 0; i < bits.length; i++) {
            name += bits[i].charAt(0).toUpperCase() + bits[i].substr(1).toLowerCase();
        }
        
        return name;        
    }
});