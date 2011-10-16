var dashboard = null;
var socket = null;

$(function(){
    socket = new Socket();
    
    dashboard = new Dashboard();
    dashboard.fetchWidgetTemplate('stats');
    
    $('#widgets-panel').animate({
        height: '15px'
    });
    
    $('#widgets-panel .show a').click(function() {
        if($('#widgets-panel').height() < 150)  
            height = '150px'; 
        else 
            height = '15px';
                
        $('#widgets-panel').animate({
            height: height
        });
    });    
});