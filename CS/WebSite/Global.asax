<%@ Application Language="C#" %>

<script runat="server">

    void Application_Start(object sender, EventArgs e) {
        DevExpress.Web.ASPxClasses.BinaryStorageConfigurator.Mode = DevExpress.Web.ASPxClasses.BinaryStorageMode.Custom;
        DevExpress.Web.ASPxClasses.BinaryStorageConfigurator.RegisterCustomStorageStrategy(new StaticImageStrategy());

        DevExpress.Web.ASPxClasses.BinaryStorageConfigurator.RegisterStorageStrategy(new FileCacheStrategy(),
            SupportsStrategy);
    }
    private bool SupportsStrategy(DevExpress.Web.ASPxClasses.ASPxWebControlBase control) {
        return control.GetType() == typeof(DevExpress.Web.ASPxGauges.ASPxGaugeControl);
    }

    void Application_End(object sender, EventArgs e) 
    {
        //  Code that runs on application shutdown

    }
        
    void Application_Error(object sender, EventArgs e) 
    { 
        // Code that runs when an unhandled error occurs

    }

    void Session_Start(object sender, EventArgs e) 
    {
        // Code that runs when a new session is started

    }

    void Session_End(object sender, EventArgs e) 
    {
        // Code that runs when a session ends. 
        // Note: The Session_End event is raised only when the sessionstate mode
        // is set to InProc in the Web.config file. If session mode is set to StateServer 
        // or SQLServer, the event is not raised.

    }
       
</script>
