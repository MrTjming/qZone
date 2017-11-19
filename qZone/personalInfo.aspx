<%@ Page Title="" Language="C#" MasterPageFile="~/qZoneTop.master" AutoEventWireup="true" CodeFile="personalInfo.aspx.cs" Inherits="_Default" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    <br />个人资料&nbsp <asp:LinkButton ID="btnChange" runat="server" Text="修改" OnClick="btnChange_Click"></asp:LinkButton>
    <br />
    <div id="infoDisplay" runat="server" >
    
    性别：<asp:Label ID="sexInfo" runat="server" ></asp:Label> <br />
    年龄：<asp:Label ID="ageInfo" runat="server" ></asp:Label> <br />
    生日：<asp:Label ID="birthdayInfo" runat="server" ></asp:Label> <br />
    星座：<asp:Label ID="constellationInfo" runat="server" ></asp:Label> <br />
    现居地：<asp:Label ID="liveInfo" runat="server" ></asp:Label> <br />
    婚姻状况：<asp:Label ID="marrageInfo" runat="server" ></asp:Label> <br />
    血型：<asp:Label ID="bloodTypeInfo" runat="server" ></asp:Label> <br />
    故乡：<asp:Label ID="hometownInfo" runat="server" ></asp:Label> <br />
    职业：<asp:Label ID="workInfo" runat="server" ></asp:Label> <br />
    公司名称：<asp:Label ID="companyName" runat="server" ></asp:Label> <br />
    公司所在地：<asp:Label ID="companyPlace" runat="server" ></asp:Label> <br />
    详细地址：<asp:Label ID="addressInfo" runat="server" ></asp:Label> <br />
        </div>

    <div id="changePage" runat="server"  visible="false">
        性别：<asp:DropDownList ID="DropDownList1" runat="server">
            <asp:ListItem>男</asp:ListItem>
            <asp:ListItem>女</asp:ListItem>
            <asp:ListItem>保密</asp:ListItem>
        </asp:DropDownList> <br />
       <asp:ScriptManager ID="ScriptManager1" runat="server"></asp:ScriptManager>
        <asp:UpdatePanel ID="UpdatePanel1" runat="server">
            <ContentTemplate>
    生日：<asp:Label ID="birthdayDate" runat="server" ></asp:Label>
        <asp:LinkButton ID="btnBirthdayDate" runat="server" Text="选择" OnClick="btnBirthdayDate_Click" ></asp:LinkButton>
                <asp:Label ID="checkAdd" runat="server" Text="no" Visible="false"></asp:Label>
                <br/>
                
         <div id="changeDate" runat="server" visible="false">
             <asp:DropDownList ID="yearSelect" runat="server" AutoPostBack="True" OnSelectedIndexChanged="yearSelect_SelectedIndexChanged"></asp:DropDownList>年
             <asp:DropDownList ID="monthSelect" runat="server" AutoPostBack="True" OnSelectedIndexChanged="monthSelect_SelectedIndexChanged"></asp:DropDownList>月
                <asp:Calendar ID="Calendar" runat="server" OnSelectionChanged="Calendar_SelectionChanged"  BorderStyle="Dotted" FirstDayOfWeek="Sunday" NextPrevFormat="ShortMonth"/> 
             <asp:Label ID="tip2" runat="server" Visible="False" ForeColor="#FF3300"></asp:Label> 
                </div>
            </ContentTemplate>
            </asp:UpdatePanel>  
    星座：<asp:Label ID="Label4" runat="server" ></asp:Label> <br />
    现居地：<asp:Label ID="Label5" runat="server" ></asp:Label> <br />
    婚姻状况：<asp:Label ID="Label6" runat="server" ></asp:Label> <br />
    血型：<asp:Label ID="Label7" runat="server" ></asp:Label> <br />
    故乡：<asp:Label ID="Label8" runat="server" ></asp:Label> <br />
    职业：<asp:Label ID="Label9" runat="server" ></asp:Label> <br />
    公司名称：<asp:Label ID="Label10" runat="server" ></asp:Label> <br />
    公司所在地：<asp:Label ID="Label11" runat="server" ></asp:Label> <br />
    详细地址：<asp:TextBox ID="addressChange" runat="server" ></asp:TextBox><br />
   
        </div>
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="ContentPlaceHolder2" Runat="Server">
</asp:Content>

