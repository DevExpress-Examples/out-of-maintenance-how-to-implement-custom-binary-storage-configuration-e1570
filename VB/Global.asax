<%@ Application Language="vb" %>

<script runat="server">

    Sub Application_Start(ByVal sender As Object, ByVal e As EventArgs)
        DevExpress.Web.BinaryStorageConfigurator.Mode = DevExpress.Web.BinaryStorageMode.Custom
        DevExpress.Web.BinaryStorageConfigurator.RegisterCustomStorageStrategy(New StaticImageStrategy())

        DevExpress.Web.BinaryStorageConfigurator.RegisterStorageStrategy(New FileCacheStrategy(), AddressOf SupportsStrategy)
    End Sub
    Private Function SupportsStrategy(ByVal control As DevExpress.Web.ASPxWebControlBase) As Boolean
        Return control.GetType() Is GetType(DevExpress.Web.ASPxGauges.ASPxGaugeControl)
    End Function

    Sub Application_End(ByVal sender As Object, ByVal e As EventArgs)
        '  Code that runs on application shutdown

    End Sub

    Sub Application_Error(ByVal sender As Object, ByVal e As EventArgs)
        ' Code that runs when an unhandled error occurs

    End Sub

    Sub Session_Start(ByVal sender As Object, ByVal e As EventArgs)
        ' Code that runs when a new session is started

    End Sub

    Sub Session_End(ByVal sender As Object, ByVal e As EventArgs)
        ' Code that runs when a session ends. 
        ' Note: The Session_End event is raised only when the sessionstate mode
        ' is set to InProc in the Web.config file. If session mode is set to StateServer 
        ' or SQLServer, the event is not raised.

    End Sub

</script>