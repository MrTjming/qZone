<%@ Page Title="" Language="C#" MasterPageFile="~/qZoneTop.master" AutoEventWireup="true" CodeFile="userInfoPage.aspx.cs" Inherits="_default" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <br />----------------个人档----------------<br />
    个人资料&nbsp
   <asp:LinkButton ID="btnChange" runat="server" Text="修改" OnClick="btnChange_Click"></asp:LinkButton>
    &nbsp <asp:LinkButton ID="toGood" runat="server" Text="点赞" OnClick="toGood_Click"></asp:LinkButton>
    <br />
    <asp:Label ID="goodNameDisplay" runat="server" ForeColor="#FFCC00"></asp:Label> 
    <br />
    <div id="infoDisplay" runat="server">
        性别：<asp:Label ID="sexInfo" runat="server"></asp:Label>
        <br />
        年龄：<asp:Label ID="ageInfo" runat="server"></asp:Label>
        <br />
        生日：<asp:Label ID="birthdayInfo" runat="server"></asp:Label>
        <br />
        星座：<asp:Label ID="constellationInfo" runat="server"></asp:Label>
        <br />
        现居地：<asp:Label ID="liveInfo" runat="server"></asp:Label>
        <br />
        婚姻状况：<asp:Label ID="marrageInfo" runat="server"></asp:Label>
        <br />
        血型：<asp:Label ID="bloodTypeInfo" runat="server"></asp:Label>
        <br />
        故乡：<asp:Label ID="hometownInfo" runat="server"></asp:Label>
        <br />
        职业：<asp:Label ID="workInfo" runat="server"></asp:Label>
        <br />
        公司名称：<asp:Label ID="companyName" runat="server"></asp:Label>
        <br />
        公司所在地：<asp:Label ID="companyPlace" runat="server"></asp:Label>
        <br />
        详细地址：<asp:Label ID="addressInfo" runat="server"></asp:Label>
        <br />
    </div>

    <div id="changePage" runat="server" visible="false">
        性别：<asp:DropDownList ID="sexChange" runat="server">
            <asp:ListItem>男</asp:ListItem>
            <asp:ListItem>女</asp:ListItem>
            <asp:ListItem>保密</asp:ListItem>
        </asp:DropDownList>
        <br />
        <asp:ScriptManager ID="ScriptManager1" runat="server"></asp:ScriptManager>
        <asp:UpdatePanel ID="UpdatePanel1" runat="server">
            <ContentTemplate>
                生日：<asp:Label ID="birthdayDate" runat="server"></asp:Label>
                <asp:LinkButton ID="btnBirthdayDate" runat="server" Text="选择" OnClick="btnBirthdayDate_Click"></asp:LinkButton>
                <asp:Label ID="checkAdd" runat="server" Text="no" Visible="false"></asp:Label>
                <br />

                <div id="changeDate" runat="server" visible="false">
                    <asp:DropDownList ID="yearSelect" runat="server" AutoPostBack="True" OnSelectedIndexChanged="yearSelect_SelectedIndexChanged"></asp:DropDownList>年
             <asp:DropDownList ID="monthSelect" runat="server" AutoPostBack="True" OnSelectedIndexChanged="monthSelect_SelectedIndexChanged"></asp:DropDownList>月
                <asp:Calendar ID="Calendar" runat="server" OnSelectionChanged="Calendar_SelectionChanged" BorderStyle="Dotted" FirstDayOfWeek="Sunday" NextPrevFormat="ShortMonth" />
                    <asp:Label ID="tip2" runat="server" Visible="False" ForeColor="#FF3300"></asp:Label>
                </div>
                年龄：<asp:Label ID="ageChange" runat="server"></asp:Label> <br />
                星座：<asp:Label ID="constellationChange" runat="server"></asp:Label>
                <br />

                血型：<asp:DropDownList ID="bloodTypeChange" runat="server">
                    <asp:ListItem>A</asp:ListItem>
                    <asp:ListItem>B</asp:ListItem>
                    <asp:ListItem>O</asp:ListItem>
                    <asp:ListItem>AB</asp:ListItem>
                    <asp:ListItem>保密</asp:ListItem>
                </asp:DropDownList>
                <br />
                婚姻状况：<asp:DropDownList ID="marrageInfoChange" runat="server">
                    <asp:ListItem>单身</asp:ListItem>
                    <asp:ListItem>恋爱中</asp:ListItem>
                    <asp:ListItem>已订婚</asp:ListItem>
                    <asp:ListItem>已婚</asp:ListItem>
                    <asp:ListItem>分居</asp:ListItem>
                    <asp:ListItem>离异</asp:ListItem>
                    <asp:ListItem>保密</asp:ListItem>
                </asp:DropDownList><br />
                现居地：<asp:DropDownList ID="Country" runat="server" AutoPostBack="True" OnSelectedIndexChanged="Country_SelectedIndexChanged">
                    <asp:ListItem>中国</asp:ListItem>
                    <asp:ListItem>外国</asp:ListItem>
                </asp:DropDownList>
                <asp:DropDownList ID="Province" runat="server" AutoPostBack="True"
                    OnSelectedIndexChanged="Province_SelectedIndexChanged">
                </asp:DropDownList>
                <asp:DropDownList ID="City" runat="server" AutoPostBack="True"></asp:DropDownList>
                <br />
                故乡：<asp:DropDownList ID="Country2" runat="server" AutoPostBack="True" OnSelectedIndexChanged="Country2_SelectedIndexChanged">
                    <asp:ListItem>中国</asp:ListItem>
                    <asp:ListItem>外国</asp:ListItem>
                </asp:DropDownList>
                <asp:DropDownList ID="Province2" runat="server" AutoPostBack="True"
                    OnSelectedIndexChanged="Province2_SelectedIndexChanged">
                </asp:DropDownList>
                <asp:DropDownList ID="City2" runat="server" AutoPostBack="True"></asp:DropDownList>
                <br />
            


        
        职业：<asp:TextBox ID="workChange" runat="server" MaxLength="20" ></asp:TextBox>
        <br />
        公司名称：<asp:TextBox ID="companyChange" runat="server" MaxLength="20" ></asp:TextBox>
        <br />
        公司所在地：<asp:DropDownList ID="Country3" runat="server" AutoPostBack="True" OnSelectedIndexChanged="Country3_SelectedIndexChanged">
                    <asp:ListItem>中国</asp:ListItem>
                    <asp:ListItem>外国</asp:ListItem>
                </asp:DropDownList>
                <asp:DropDownList ID="Province3" runat="server" AutoPostBack="True"
                    OnSelectedIndexChanged="Province3_SelectedIndexChanged">
                </asp:DropDownList>
                <asp:DropDownList ID="City3" runat="server" AutoPostBack="True"></asp:DropDownList>
                <br />
                </ContentTemplate>
        </asp:UpdatePanel>
        详细地址：<asp:TextBox ID="addressChange" runat="server" MaxLength="50"></asp:TextBox><br />
        <asp:Button ID="saveChange" runat="server" Text="保存" OnClick="saveChange_Click" /><asp:CheckBox ID="showOther" runat="server" Text="不通知我的好友（仅对本次设置有效）" Font-Size="Small"/>
    </div>
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="ContentPlaceHolder2" runat="Server">
</asp:Content>

