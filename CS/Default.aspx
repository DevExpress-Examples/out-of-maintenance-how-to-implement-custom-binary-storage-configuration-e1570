<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Default.aspx.cs" Inherits="CacheSample" %>

<%@ Register Assembly="DevExpress.Web.ASPxGauges.v17.1" Namespace="DevExpress.Web.ASPxGauges.Gauges" TagPrefix="dx" %>
<%@ Register assembly="DevExpress.Web.ASPxGauges.v17.1" namespace="DevExpress.Web.ASPxGauges" tagprefix="dx" %>


<%@ Register Assembly="DevExpress.Web.ASPxGauges.v17.1" Namespace="DevExpress.Web.ASPxGauges.Gauges.Linear" TagPrefix="dx" %>
<%@ Register Assembly="DevExpress.Web.ASPxGauges.v17.1" Namespace="DevExpress.Web.ASPxGauges.Gauges.Circular" TagPrefix="dx" %>
<%@ Register Assembly="DevExpress.Web.ASPxGauges.v17.1" Namespace="DevExpress.Web.ASPxGauges.Gauges.State" TagPrefix="dx" %>
<%@ Register Assembly="DevExpress.Web.ASPxGauges.v17.1" Namespace="DevExpress.Web.ASPxGauges.Gauges.Digital" TagPrefix="dx" %>
<%@ Register Assembly="DevExpress.Web.v17.1" Namespace="DevExpress.Web" TagPrefix="dx" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Untitled Page</title>
</head>
<body>
    <form id="form1" runat="server">
        FileCacheStrategy demonstration:
        <br />
        <dx:ASPxGaugeControl ID="gaugeControl1" runat="server" BackColor="White" Height="260px"
            Value="20" Width="260px">
            <Gauges>
                <dx:CircularGauge Bounds="0, 0, 260, 260" Name="cGauge1">
                    <BackgroundLayers>
                        <dx:ArcScaleBackgroundLayerComponent Name="bg1" ScaleCenterPos="0.5, 0.61" ScaleID="scale1"
                            Size="250, 205" ZOrder="1000" ShapeType="CircularThreeFourth_Style7"></dx:ArcScaleBackgroundLayerComponent>
                    </BackgroundLayers>
                    <Needles>
                        <dx:ArcScaleNeedleComponent EndOffset="-25" StartOffset="-21" ScaleID="scale1" Name="needle1"
                            ZOrder="-50" ShapeType="CircularFull_Style7"></dx:ArcScaleNeedleComponent>
                    </Needles>
                    <EffectLayers>
                        <dx:ArcScaleEffectLayerComponent Name="effect1" 
                            Shader="&lt;ShaderObject Type=&quot;Opacity&quot; Data=&quot;Opacity[0.75]&quot;/&gt;"
                            ScaleID="scale1" Size="230, 110" ZOrder="-1000" ShapeType="CircularThreeFourth_Style7">
                        </dx:ArcScaleEffectLayerComponent>
                    </EffectLayers>
                    <Scales>
                        <dx:ArcScaleComponent Name="scale1" MaxValue="100" Value="20" MinorTickmark-ShapeType="Circular_Style7_1"
                            Center="125, 140" EndAngle="30" MajorTickCount="9" MinorTickCount="4" MajorTickmark-TextOffset="22"
                            MajorTickmark-TextOrientation="LeftToRight" MajorTickmark-FormatString="{0:F0}"
                            MajorTickmark-ShapeType="Circular_Style7_2" StartAngle="-210" RadiusX="83" RadiusY="83">
                        </dx:ArcScaleComponent>
                    </Scales>
                </dx:CircularGauge>
            </Gauges>
        </dx:ASPxGaugeControl>
        <br />
        <dx:ASPxButton ID="ASPxButton1" runat="server" OnClick="ASPxButton1_Click" Text="Generate random value">
        </dx:ASPxButton>
        <br />
        
        <br />
        StaticImageStrategy demonstration:
        <dx:ASPxGridView ID="ASPxGridView1" runat="server" AutoGenerateColumns="False" OnHtmlDataCellPrepared="ASPxGridView1_HtmlDataCellPrepared"
            DataSourceID="AccessDataSource1" KeyFieldName="CategoryID">
            <Columns>
                <dx:GridViewDataTextColumn FieldName="CategoryID" ReadOnly="True" VisibleIndex="0">
                    <EditFormSettings Visible="False" />
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn FieldName="CategoryName" VisibleIndex="1">
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn FieldName="Description" VisibleIndex="2">
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataBinaryImageColumn FieldName="Picture" Name="Picture" VisibleIndex="3">
                </dx:GridViewDataBinaryImageColumn>
            </Columns>
        </dx:ASPxGridView>
        <asp:AccessDataSource ID="AccessDataSource1" runat="server" DataFile="~/App_Data/nwind.mdb"
            SelectCommand="SELECT * FROM [Categories]"></asp:AccessDataSource>
    </form>
</body>
</html>
