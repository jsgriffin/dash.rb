$(function(){
    var dashboard = new Dashboard();
    dashboard.fetchWidgetTemplate('test-1');
});

var Dashboard = function(){
    this.fetchWidgetTemplate = function(widget) {        
        $.ajax({
           url: '/widgets/' + widget + '/template',
           success: function(data) {
               $('body').append(data);
           },
           error: function(data) {
               console.log("Error");
               console.log(data);
           }
        });
    }
};