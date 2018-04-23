' Developer Express Code Central Example:
' How to implement custom binary storage configuration
' 
' This example demonstrates how to implement different storage strategies for the
' DevExpress control's binary images.
' 
' The FileCacheStrategy scenario implies
' the use of a specific folder on the server for storing the ASPxGauge's binary
' images. Changing the control's value causes generating its new image, which is
' stored into a specified folder. Cache is cleared every 10 minutes. Each image
' can be obtained by using its recourse key. The StaticImageStrategy scenario
' implements storing the ASPxGridView binary data (a specific column with binary
' images) into a public folder within an application. Each image within the folder
' has its own static URL. In this scenario, cache is cleared every 60
' minutes.
' 
' See Also:
' Binary Storage Configuration
' (ms-help://DevExpress.AspNet/CustomDocument6874.htm)
' 
' You can find sample updates and versions for different programming languages here:
' http://www.devexpress.com/example=E1570


Imports Microsoft.VisualBasic
Imports System
Imports System.Data
Imports System.Configuration
Imports System.Collections
Imports System.Web
Imports System.Web.Security
Imports System.Web.UI
Imports System.Web.UI.WebControls
Imports System.Web.UI.WebControls.WebParts
Imports System.Web.UI.HtmlControls

Partial Public Class CacheSample
	Inherits System.Web.UI.Page
	Protected Sub Page_Load(ByVal sender As Object, ByVal e As EventArgs)
	End Sub
	Protected Sub ASPxButton1_Click(ByVal sender As Object, ByVal e As EventArgs)
		Dim rnd As New Random()
		gaugeControl1.Value = rnd.Next(100).ToString()
	End Sub
End Class
