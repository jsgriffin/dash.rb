var dashboard = null;

$(function(){
    dashboard = new Dashboard();
    dashboard.fetchWidgetTemplate('test');
    dashboard.convertWidgetNameToClassName('test-beans-1-dogs');
    
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