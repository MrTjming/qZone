﻿<%@ Page Language="C#" AutoEventWireup="true" CodeFile="login.aspx.cs" Inherits="loginn" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <title></title>
</head>
<body>
    <form id="form1" runat="server">
    <div>
     <div id="Page1" runat="server">
            用户登录&nbsp 
            <br />
            帐号：<asp:TextBox ID="nameLogin" runat="server" MaxLength="20"></asp:TextBox>
            <asp:LinkButton ID="toRegister" runat="server" PostBackUrl="~/register.aspx" Text="注册帐号" > </asp:LinkButton>
            <br />
            密码：<asp:TextBox ID="pwdLogin" runat="server" TextMode="Password" MaxLength="20"></asp:TextBox>
            <asp:LinkButton ID="toGetBackPwd" runat="server" PostBackUrl="~/getBackPwd.aspx" Text="找回密码"></asp:LinkButton>
            <br />
            验证码：<asp:TextBox ID="validate" runat="server" MaxLength="4"></asp:TextBox>
            <%--<asp:Image ID="validateImage" runat="server" ImageUrl="~/ValidateCode.aspx" /> 
        <asp:linkbutton ID="fresh" runat="server" Text="看不清？" OnClick="fresh_Click" > </asp:linkbutton>--%>
            <img id="validateImage" src="ValidateCode.aspx" onclick="ttt()" />
            <script type="text/javascript">
                var images = document.getElementById("validateImage");
                function ttt() {
                    if (images != null)
                        images.src = images.src + "?";
                }
                if (self.frameElement && self.frameElement.tagName == "IFRAM")
                    images.src = "ValidateCode.aspx";
            </script>
            <br />
     <asp:CheckBox ID="rememberPwd" Text="记住密码" runat="server" Visible="false" /> &nbsp <asp:CheckBox ID="autologin" Text="自动登陆" runat="server" /> <br/>
            <asp:Button ID="btnLogin" runat="server" Text="登录" OnClick="btnLogin_Click" />
        </div>
    </div>
    </form>
</body>
</html>
