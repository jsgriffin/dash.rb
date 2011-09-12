var dashboard = null;

$(function(){
    dashboard = new Dashboard();
    dashboard.fetchWidgetTemplate('test');
    dashboard.convertWidgetNameToClassName('test-beans-1-dogs');
});