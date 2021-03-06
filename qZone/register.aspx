﻿<%@ Page Language="C#" AutoEventWireup="true" CodeFile="register.aspx.cs" Inherits="registe" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <title></title>
</head>
<body>
    <form id="form1" runat="server">
    <div>
     <div>
            --------------------------qZone---------------------------------<br />
            用户注册 
            <asp:Button ID="toLogin" runat="server" Text="返回登陆" PostBackUrl="~/login.aspx" /><br />
            &nbsp&nbsp帐号：<asp:TextBox ID="nameRegister" runat="server" MaxLength="20"></asp:TextBox>
            <asp:Label ID="tip1" runat="server" ForeColor="Red"></asp:Label>
            <br />
         &nbsp&nbsp昵称：<asp:TextBox ID="nicknameRegister" runat="server" MaxLength="20" ></asp:TextBox>
            <asp:Label ID="tip6" runat="server" ForeColor="Red"></asp:Label>
            <br />
            &nbsp&nbsp密码：<asp:TextBox ID="pwdRegister" runat="server" TextMode="Password" MaxLength="20" ></asp:TextBox>
            <asp:Label ID="tip2" runat="server" ForeColor="Red"></asp:Label>
            <br />
            重复密码：<asp:TextBox ID="pwdAgain" runat="server" TextMode="Password"  CausesValidation="True" MaxLength="20"></asp:TextBox>
          
         <asp:Label ID="tip3" runat="server" ForeColor="Red" Visible="False"></asp:Label>
            <br />
            密保问题：<asp:DropDownList ID="quesIDlist" runat="server">
                <asp:ListItem Value="0">你的第一个宠物的名称？</asp:ListItem>
                <asp:ListItem Value="1">你最喜欢去的地方？</asp:ListItem>
                <asp:ListItem Value="2">你高中班主任的名字？</asp:ListItem>
                <asp:ListItem Value="3">你最喜欢的颜色？</asp:ListItem>
                <asp:ListItem Value="4">你父亲的名字？</asp:ListItem>
                <asp:ListItem Value="5">你母亲的名字？</asp:ListItem>
                <asp:ListItem Value="6">你第一个手机号是什么？</asp:ListItem>
            </asp:DropDownList><br />
            密保答案：<asp:TextBox ID="ansRegister" runat="server" MaxLength="50"></asp:TextBox>
            <asp:Label ID="tip5" runat="server" ForeColor="Red"></asp:Label>
            <br />
            &nbsp验证码：<asp:TextBox ID="validate" runat="server" MaxLength="4"></asp:TextBox>
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
            <asp:Label ID="tip4" runat="server" ForeColor="Red"></asp:Label>


        </div>
        <p>
            <asp:Button ID="btnRegister" runat="server" Text="注册" OnClick="btnRegister_Click" Style="height: 21px" />

        </p>
 
    </div>
    </form>
</body>
</html>
