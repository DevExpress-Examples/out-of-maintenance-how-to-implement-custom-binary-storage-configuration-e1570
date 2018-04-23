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
using System.Configuration;
using System.Collections;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using System.Web.UI.HtmlControls;
using DevExpress.Web.Internal;

public partial class CacheSample : System.Web.UI.Page {
    protected void Page_Load(object sender, EventArgs e) {
    }

    public void ASPxGridView1_HtmlDataCellPrepared(object sender, DevExpress.Web.ASPxGridViewTableDataCellEventArgs e) {
        if (e.DataColumn.FieldName == "Picture")
            (e.Cell.Controls[0] as BinaryImageDisplayControl).Attributes.Add("data-key", e.KeyValue.ToString());
    }

    protected void ASPxButton1_Click(object sender, EventArgs e) {
        Random rnd = new Random();
        gaugeControl1.Value = rnd.Next(100).ToString();
    }

}
