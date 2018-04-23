Imports Microsoft.VisualBasic
Imports System
Imports System.Data
Imports System.Web
Imports System.Web.Security
Imports System.Web.UI
Imports System.Web.UI.WebControls
Imports System.Web.UI.WebControls.WebParts
Imports System.Web.UI.HtmlControls
Imports DevExpress.Web.ASPxClasses
Imports System.IO

Public Class FileCacheStrategy
	Inherits RuntimeStorageStrategy
	Public FileCacheFolderPath As String = "~/FileCacheFolder/"
	Public Const CacheClearingInterval As Integer = 1 ' minutes
	Public Const CacheExpirationTime As Integer = 10 ' minutes

	Public Shared LastCacheClearing As DateTime = DateTime.MinValue

'     GetResourceKey
'        1) the mime type is saved as a file's extension for further 
'           use within the GetResourceData method.
'        2) received key is used to generate the image url for further 
'           use within the StoreResourceData, GetResourceData
'    
	Public Overrides Function GetResourceKey(ByVal control As ASPxWebControlBase, ByVal content() As Byte, ByVal mimeType As String) As String
		Dim fileExtension As String = ""
		If mimeType.StartsWith("image/") Then
			fileExtension = "." & mimeType.Substring("image/".Length)
		End If
		Return Guid.NewGuid().ToString() & fileExtension
	End Function
	Public Overrides Sub StoreResourceData(ByVal control As ASPxWebControlBase, ByVal key As String, ByVal data As BinaryStorageData)
		ClearFileCacheIfNeeded(GetFolderPath())
		Using stream As New FileStream(GetFilePath(key), FileMode.OpenOrCreate)
			stream.Write(data.Content, 0, data.Content.Length)
		End Using
	End Sub
	Public Overrides Function GetResourceData(ByVal key As String) As BinaryStorageData
		Using stream As New FileStream(GetFilePath(key), FileMode.Open)
			Dim content(stream.Length - 1) As Byte
			stream.Read(content, 0, content.Length)
			Dim mimeType As String = "image/" & key.Split("."c)(1)
			Return New BinaryStorageData(content, mimeType)
		End Using
		Return Nothing
	End Function

	Private Shared Sub ClearFileCacheIfNeeded(ByVal physicalPath As String)
		Dim now As DateTime = DateTime.Now
		' cache clearing is launched after the specified time interval
		If now.Subtract(LastCacheClearing) < TimeSpan.FromMinutes(CacheClearingInterval) Then
			Return
		End If

		Dim fileNames() As String = Directory.GetFiles(physicalPath)
		For Each fileName As String In fileNames
			If now - File.GetCreationTime(fileName) > TimeSpan.FromMinutes(CacheExpirationTime) Then
				Try
					File.Delete(fileName)
				Catch
				End Try
			End If
		Next fileName
		LastCacheClearing = now
	End Sub
	Private Function GetFilePath(ByVal key As String) As String
		Return GetFolderPath() & key
	End Function
	Private Function GetFolderPath() As String
		Return HttpContext.Current.Server.MapPath(FileCacheFolderPath)
	End Function
End Class

' images are cached within the predefined public folder. The method returns an image url.
Public Class StaticImageStrategy
	Inherits RuntimeStorageStrategy
	Public StaticCacheFolderName As String = "StaticCacheFolder" ' public folder
	Public Const FileExpirationTime As Integer = 60 ' minutes

	Public Overrides Function GetResourceUrl(ByVal control As ASPxWebControlBase, ByVal content() As Byte, ByVal mimeType As String) As String
		Dim fileExtension As String = ""
		If mimeType.StartsWith("image/") Then
			fileExtension = "." & mimeType.Substring("image/".Length)
		End If

		Dim fileName As String = GetControlUniqueName(control) & fileExtension
		Dim physicalPath As String = HttpContext.Current.Server.MapPath(String.Format("~/{0}/", StaticCacheFolderName)) & fileName

		If File.Exists(physicalPath) AndAlso DateTime.Now - File.GetCreationTime(physicalPath) > TimeSpan.FromMinutes(FileExpirationTime) Then
			File.Delete(physicalPath) ' an image is refreshed every hour
		End If
		If (Not File.Exists(physicalPath)) Then
			Using stream As New FileStream(physicalPath, FileMode.OpenOrCreate)
				stream.Write(content, 0, content.Length)
			End Using
		End If

		Return String.Format("{0}/{1}", StaticCacheFolderName, fileName)
	End Function
End Class