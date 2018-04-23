<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Default.aspx.cs" Inherits="CacheSample" %>

<%@ Register Assembly="DevExpress.Web.ASPxGauges.v9.2" Namespace="DevExpress.Web.ASPxGauges.Gauges" TagPrefix="dxg" %>
<%@ Register assembly="DevExpress.Web.ASPxGauges.v9.2" namespace="DevExpress.Web.ASPxGauges" tagprefix="dxg" %>


<%@ Register Assembly="DevExpress.Web.ASPxGauges.v9.2" Namespace="DevExpress.Web.ASPxGauges.Gauges.Linear" TagPrefix="dxg" %>
<%@ Register Assembly="DevExpress.Web.ASPxGauges.v9.2" Namespace="DevExpress.Web.ASPxGauges.Gauges.Circular" TagPrefix="dxg" %>
<%@ Register Assembly="DevExpress.Web.ASPxGauges.v9.2" Namespace="DevExpress.Web.ASPxGauges.Gauges.State" TagPrefix="dxg" %>
<%@ Register Assembly="DevExpress.Web.ASPxGauges.v9.2" Namespace="DevExpress.Web.ASPxGauges.Gauges.Digital" TagPrefix="dxg" %>
<%@ Register Assembly="DevExpress.Web.ASPxGridView.v9.2" Namespace="DevExpress.Web.ASPxGridView" TagPrefix="dxwgv" %>
<%@ Register Assembly="DevExpress.Web.ASPxEditors.v9.2" Namespace="DevExpress.Web.ASPxEditors" TagPrefix="dxe" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Untitled Page</title>
</head>
<body>
    <form id="form1" runat="server">
        FileCacheStrategy demonstration:
        <br />
        <dxg:ASPxGaugeControl ID="gaugeControl1" runat="server" BackColor="White" Height="260px"
            Value="20" Width="260px">
            <Gauges>
                <dxg:CircularGauge Bounds="0, 0, 260, 260" Name="cGauge1">
                    <BackgroundLayers>
                        <dxg:ArcScaleBackgroundLayerComponent Name="bg1" ScaleCenterPos="0.5, 0.61" ScaleID="scale1"
                            Size="250, 205" ZOrder="1000" ShapeType="CircularThreeFourth_Style7"></dxg:ArcScaleBackgroundLayerComponent>
                    </BackgroundLayers>
                    <Needles>
                        <dxg:ArcScaleNeedleComponent EndOffset="-25" StartOffset="-21" ScaleID="scale1" Name="needle1"
                            ZOrder="-50" ShapeType="CircularFull_Style7"></dxg:ArcScaleNeedleComponent>
                    </Needles>
                    <EffectLayers>
                        <dxg:ArcScaleEffectLayerComponent Name="effect1" 
                            Shader="&lt;ShaderObject Type=&quot;Opacity&quot; Data=&quot;Opacity[0.75]&quot;/&gt;"
                            ScaleID="scale1" Size="230, 110" ZOrder="-1000" ShapeType="CircularThreeFourth_Style7">
                        </dxg:ArcScaleEffectLayerComponent>
                    </EffectLayers>
                    <Scales>
                        <dxg:ArcScaleComponent Name="scale1" MaxValue="100" Value="20" MinorTickmark-ShapeType="Circular_Style7_1"
                            Center="125, 140" EndAngle="30" MajorTickCount="9" MinorTickCount="4" MajorTickmark-TextOffset="22"
                            MajorTickmark-TextOrientation="LeftToRight" MajorTickmark-FormatString="{0:F0}"
                            MajorTickmark-ShapeType="Circular_Style7_2" StartAngle="-210" RadiusX="83" RadiusY="83">
                        </dxg:ArcScaleComponent>
                    </Scales>
                </dxg:CircularGauge>
            </Gauges>
        </dxg:ASPxGaugeControl>
        <br />
        <dxe:ASPxButton ID="ASPxButton1" runat="server" OnClick="ASPxButton1_Click" Text="Generate random value">
        </dxe:ASPxButton>
        <br />
        
        <br />
        StaticImageStrategy demonstration:
        <dxwgv:ASPxGridView ID="ASPxGridView1" runat="server" AutoGenerateColumns="False"
            DataSourceID="AccessDataSource1" KeyFieldName="CategoryID">
            <Columns>
                <dxwgv:GridViewDataTextColumn FieldName="CategoryID" ReadOnly="True" VisibleIndex="0">
                    <EditFormSettings Visible="False" />
                </dxwgv:GridViewDataTextColumn>
                <dxwgv:GridViewDataTextColumn FieldName="CategoryName" VisibleIndex="1">
                </dxwgv:GridViewDataTextColumn>
                <dxwgv:GridViewDataTextColumn FieldName="Description" VisibleIndex="2">
                </dxwgv:GridViewDataTextColumn>
                <dxwgv:GridViewDataBinaryImageColumn FieldName="Picture" Name="Picture" VisibleIndex="3">
                </dxwgv:GridViewDataBinaryImageColumn>
            </Columns>
        </dxwgv:ASPxGridView>
        <asp:AccessDataSource ID="AccessDataSource1" runat="server" DataFile="~/App_Data/nwind.mdb"
            SelectCommand="SELECT * FROM [Categories]"></asp:AccessDataSource>
    </form>
</body>
</html>
