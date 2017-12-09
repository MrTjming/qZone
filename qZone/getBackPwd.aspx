<%@ Page Language="C#" AutoEventWireup="true" CodeFile="getBackPwd.aspx.cs" Inherits="getBackPwd" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <title></title>
</head>
<body>
    <form id="form1" runat="server">
       <div>
            --------------------------qZone---------------------------------<br />
            密码管理<br />
            帐号：<asp:TextBox ID="nameGetBack" runat="server" MaxLength="20"></asp:TextBox>
            <br />
        </div>
        <div id="page1" runat="server">
            验证码：<asp:TextBox ID="checkNum" runat="server" MaxLength="4"></asp:TextBox>
            <asp:Image ID="checkPhoto" runat="server" ImageUrl="~/ValidateCode.aspx" />
            <asp:LinkButton ID="fresh3" runat="server" Text="看不清？" OnClick="fresh3_Click"> </asp:LinkButton>
            <br />
            <br />
            <asp:Button ID="next" runat="server" Text="下一步" OnClick="next_Click" Style="width: 57px" />
        </div>
        <div id="ques" runat="server" visible="false">
            密保问题：<asp:Label ID="question" runat="server" Text=""></asp:Label>
            <br />
            答案：<asp:TextBox ID="answer" runat="server" MaxLength="50"></asp:TextBox>
            <br />
            验证码：<asp:TextBox ID="validate1" runat="server" MaxLength="4"></asp:TextBox>
            <asp:Image ID="validateImage1" runat="server" ImageUrl="~/ValidateCode.aspx" />
            <asp:LinkButton ID="fresh1" runat="server" Text="看不清？" OnClick="fresh1_Click"> </asp:LinkButton>
            <br />
            <asp:Button ID="next2" runat="server" Text="下一步" OnClick="next2_Click" Visible="false" />
        </div>


        <div id="pageGetBack" runat="server" visible="false">
            <asp:Label ID="text1" runat="server" Text="选择验证方式"></asp:Label> <br />
            <asp:Button ID="next1" runat="server" Text="密保验证" OnClick="next1_Click" />


        </div>
        <div id="nextChange" runat="server" visible="false">
            <asp:Label ID="text2" runat="server" Text=""></asp:Label>
            <asp:Button ID="changgeNext1" runat="server" Text="密码验证" OnClick="changgeNext1_Click" /><br />
        </div>
        <div id="pageChange1" runat="server" visible="false">
            原密码：<asp:TextBox ID="oldPwd" runat="server" TextMode="Password" MaxLength="20"></asp:TextBox>
            <br />
            </div>
        <div id="pageChange" runat="server" visible="false">

            新密码：<asp:TextBox ID="newPwd1" runat="server" TextMode="Password" MaxLength="20"></asp:TextBox>
            <br />
            确认密码：<asp:TextBox ID="newPwd2" runat="server" TextMode="Password" MaxLength="20"></asp:TextBox><br />
            验证码：<asp:TextBox ID="validate2" runat="server" MaxLength="4"></asp:TextBox>
            <asp:Image ID="validateImage2" runat="server" ImageUrl="~/ValidateCode.aspx" />
            <asp:LinkButton ID="fresh2" runat="server" Text="看不清？" OnClick="fresh2_Click"> </asp:LinkButton>
            <br />
            <asp:Button ID="btnChange" runat="server" Text="修改密码" OnClick="btnChange_Click" />
        </div>
        <div id="validatePage" runat="server" visible="false">
        </div>

    </form>
</body>
</html>
