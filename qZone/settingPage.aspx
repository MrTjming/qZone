<%@ Page Title="" Language="C#" MasterPageFile="~/qZoneTop.master" AutoEventWireup="true" CodeFile="settingPage.aspx.cs" Inherits="_Default" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    <br />----------------空间设置---------------<br />
    <asp:LinkButton ID="btnSetZone" runat="server" Text="修改空间信息" OnClick="btnSetZone_Click"></asp:LinkButton>
    <div id="zoneSet" runat="server" visible="false">
    空间名称:<asp:TextBox ID="zoneName" runat="server"></asp:TextBox> <br />
    空间说明:<asp:TextBox ID="zoneintroduce" runat="server" TextMode="MultiLine"></asp:TextBox><br />
    <asp:Button ID="btnSave" runat="server" Text="保存" OnClick="btnSave_Click" />
    <br />
        </div>
    <br />
     <asp:LinkButton ID="btnSetPower" runat="server" Text="设置空间权限" OnClick="btnSetPower_Click"></asp:LinkButton>
     <div id="setPower" runat="server" visible="false" >
        <asp:ScriptManager ID="ScriptManager1" runat="server"></asp:ScriptManager>
        <asp:UpdatePanel ID="UpdatePanel1" runat="server">
            <ContentTemplate>
                
               <br />
                权限管理<br />
                <asp:RadioButton ID="RadioButton1" runat="server" GroupName="power" Text="所有人可见" AutoPostBack="True" OnCheckedChanged="RadioButton1_CheckedChanged" /><br />
                <asp:RadioButton ID="RadioButton4" runat="server" GroupName="power" Text="仅好友可见" AutoPostBack="True" OnCheckedChanged="RadioButton1_CheckedChanged"  /><br />
                <asp:RadioButton ID="RadioButton2" runat="server" GroupName="power" Text="仅自己可见" AutoPostBack="True" OnCheckedChanged="RadioButton2_CheckedChanged" /><br />
                <asp:RadioButton ID="RadioButton3" runat="server" GroupName="power" Text="指定好友可见" OnCheckedChanged="RadioButton3_CheckedChanged" AutoPostBack="True" /><br />
                <div id="chosePower" runat="server" visible="false">

                    <asp:Label ID="powertext" runat="server" Visible="false"></asp:Label><br />
                    好友列表
        <asp:BulletedList ID="friendsList" runat="server" DisplayMode="LinkButton" Height="16px" OnClick="friendsList_Click" Width="267px"></asp:BulletedList>
                    <br />
                    可见列表
        <asp:BulletedList ID="addUsers" runat="server" DisplayMode="LinkButton" Height="16px" OnClick="addUsers_Click" Width="240px"></asp:BulletedList>
                    <br />
                    
                </div>
                
            </ContentTemplate>
        </asp:UpdatePanel>
         <asp:Button ID="btnSavePower" runat="server" Text="保存" OnClick="btnSavePower_Click" />
    </div>
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="ContentPlaceHolder2" Runat="Server">
</asp:Content>

