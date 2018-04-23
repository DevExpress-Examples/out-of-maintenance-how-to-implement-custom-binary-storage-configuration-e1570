// Developer Express Code Central Example:
// How to implement custom binary storage configuration
// 
// This example demonstrates how to implement different storage strategies for the
// DevExpress control's binary images.
// 
// The FileCacheStrategy scenario implies
// the use of a specific folder on the server for storing the ASPxGauge's binary
// images. Changing the control's value causes generating its new image, which is
// stored into a specified folder. Cache is cleared every 10 minutes. Each image
// can be obtained by using its recourse key. The StaticImageStrategy scenario
// implements storing the ASPxGridView binary data (a specific column with binary
// images) into a public folder within an application. Each image within the folder
// has its own static URL. In this scenario, cache is cleared every 60
// minutes.
// 
// See Also:
// Binary Storage Configuration
// (ms-help://DevExpress.AspNet/CustomDocument6874.htm)
// 
// You can find sample updates and versions for different programming languages here:
// http://www.devexpress.com/example=E1570

using System;
using System.Data;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using System.Web.UI.HtmlControls;
using DevExpress.Web;
using System.IO;

public class FileCacheStrategy : RuntimeStorageStrategy {
    public string FileCacheFolderPath = "~/FileCacheFolder/";
    public const int CacheClearingInterval = 1; // minutes
    public const int CacheExpirationTime = 10; // minutes

    public static DateTime LastCacheClearing = DateTime.MinValue;

    /* GetResourceKey
        1) the mime type is saved as a file's extension for further 
           use within the GetResourceData method.
        2) received key is used to generate the image url for further 
           use within the StoreResourceData, GetResourceData
    */
    public override string GetResourceKey(ASPxWebControlBase control, byte[] content, string mimeType) {
        
        string fileExtension = "";
        if(mimeType.StartsWith("image/"))
            fileExtension = "." + mimeType.Substring("image/".Length);
        return Guid.NewGuid().ToString() + fileExtension;
    }
    public override void StoreResourceData(ASPxWebControlBase control, string key, BinaryStorageData data) {
        ClearFileCacheIfNeeded(GetFolderPath());
        using(FileStream stream = new FileStream(GetFilePath(key), FileMode.OpenOrCreate))
            stream.Write(data.Content, 0, data.Content.Length);
    }
    public override BinaryStorageData GetResourceData(string key) {
        using(FileStream stream = new FileStream(GetFilePath(key), FileMode.Open)) {
            byte[] content = new byte[stream.Length];
            stream.Read(content, 0, content.Length);
            string mimeType = "image/" + key.Split('.')[1];
            return new BinaryStorageData(content, mimeType);
        }
        return null;
    }

    private static void ClearFileCacheIfNeeded(string physicalPath) {
        DateTime now = DateTime.Now;
        // cache clearing is launched after the specified time interval
        if(now - LastCacheClearing < TimeSpan.FromMinutes(CacheClearingInterval))
            return;

        string[] fileNames = Directory.GetFiles(physicalPath);
        foreach(string fileName in fileNames) {
            if(now - File.GetCreationTime(fileName) > TimeSpan.FromMinutes(CacheExpirationTime)) {
                try {
                    File.Delete(fileName);
                } catch { }
            }
        }
        LastCacheClearing = now;
    }
    private string GetFilePath(string key) {
        return GetFolderPath() + key;
    }
    private string GetFolderPath() {
        return HttpContext.Current.Server.MapPath(FileCacheFolderPath);
    }
}

// images are cached within the predefined public folder. The method returns an image url.
public class StaticImageStrategy : RuntimeStorageStrategy {
    public string StaticCacheFolderName = "StaticCacheFolder"; // public folder
    public const int FileExpirationTime = 60; // minutes

    public override string GetResourceUrl(ASPxWebControlBase control, byte[] content, string mimeType, string contentDisposition) {
        string fileExtension = "";
        var a = control.NamingContainer.BindingContainer;
        if (mimeType.StartsWith("image/"))
            fileExtension = "." + mimeType.Substring("image/".Length);


        string fileName = control.Attributes["data-key"] + fileExtension;
        string physicalPath = HttpContext.Current.Server.MapPath(string.Format("~/{0}/", StaticCacheFolderName)) + fileName;
        
        if(File.Exists(physicalPath) && DateTime.Now - File.GetCreationTime(physicalPath) > TimeSpan.FromMinutes(FileExpirationTime))
            File.Delete(physicalPath);// an image is refreshed every hour
        if(!File.Exists(physicalPath)) {
            using(FileStream stream = new FileStream(physicalPath, FileMode.OpenOrCreate))
                stream.Write(content, 0, content.Length);
        }

        return String.Format("{0}/{1}", StaticCacheFolderName, fileName);
    }
}