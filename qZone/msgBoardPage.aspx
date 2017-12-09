<%@ Page Title="" Language="C#" MasterPageFile="~/qZoneTop.master" AutoEventWireup="true" CodeFile="msgBoardPage.aspx.cs" Inherits="Default2" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    <br />----------------留言板----------------<br />
    <div id="hosterSayDisplay" runat="server" visible="false">
        <asp:TextBox runat="server" ID="hostSayText" Height="49px" MaxLength="200" TextMode="MultiLine" Width="339px" ></asp:TextBox>
        <br /><asp:Button ID="btnSaveSay" runat="server" Text="保存" OnClick="btnSaveSay_Click" />
    </div>
    <asp:Label ID="hostSay" runat="server"></asp:Label><br />
    <asp:LinkButton ID="btnToSay" runat="server" Text="修改主人寄语" OnClick="btnToSay_Click"></asp:LinkButton>
    <br />----------------------------------------<br />

    <asp:LinkButton ID="btnToAddMsg" runat="server" Text="我要留言" OnClick="btnToAddMsg_Click"></asp:LinkButton>
    &nbsp 
    <div id="addMsgDisplay" runat="server" visible="false">
        <asp:TextBox ID="msgText" runat="server" TextMode="MultiLine" Height="77px" Width="564px" MaxLength="500"></asp:TextBox>
        <br /><asp:Button ID="btnPost" runat="server" Text="发表" OnClick="btnPost_Click" />




    </div>


    <div id="msgBoardDisplay" runat="server">
    <asp:Label ID="sql1" runat="server" Visible="false"></asp:Label>
    <asp:Repeater ID="myBoard" runat="server" OnItemCommand="myBoard_ItemCommand" OnItemDataBound="myBoard_ItemDataBound">
        <HeaderTemplate>

        </HeaderTemplate>
        <ItemTemplate>
             用户:<td align="center" valign="middle"><%# Eval("nickname") %></td>   <br />
            内容:<td align="center" valign="middle"><%# Eval("text") %></td> <br />
            时间:<asp:Label ID="timeDisplay" runat="server" Text=<%# Eval("time") %> Font-Size="Smaller"></asp:Label>
                <asp:LinkButton ID="btnReply" runat="server" CommandName="reply" CommandArgument='<%# Eval("id") %>' Text="回复"></asp:LinkButton></td> 
             <asp:LinkButton ID="btnDel" runat="server" CommandName="del" OnClientClick="return confirm('确认删除?'); " CommandArgument='<%# Eval("id") %>' Text="删除"></asp:LinkButton></td> <br />
            <asp:TextBox ID="replyText" runat="server" Visible="false" TextMode="MultiLine" MaxLength="200"></asp:TextBox>
                    <br /> <asp:Button ID="btnPost" runat="server" Text="回复" Visible="false" CommandName="btnreply" CommandArgument='<%# Eval("id") %>'/><br />
            <asp:Repeater ID="replyDisplay" runat="server" Visible="false" OnItemCommand="replyDisplay_ItemCommand" OnItemDataBound="replyDisplay_ItemDataBound">
                <ItemTemplate>
                    
                    用户:<td align="center" valign="middle"><%# Eval("nickname") %></td>   <br />
                    内容:<td align="center" valign="middle"><%# Eval("text") %></td> <br />
                    时间:<asp:Label ID="timeDisplay" runat="server" Text=<%# Eval("time") %> Font-Size="Smaller"></asp:Label>
                    <br />
                </ItemTemplate>
            </asp:Repeater>
            <br /><br />

        </ItemTemplate>
        <FooterTemplate>
            
        </FooterTemplate>
    </asp:Repeater>
    <div id="Page1" runat="server" >
                <asp:LinkButton ID="up" runat="server" Text="上一页" OnClick="up_Click"></asp:LinkButton>&nbsp
            <asp:LinkButton ID="down" runat="server" Text="下一页" OnClick="down_Click"></asp:LinkButton>&nbsp
            <asp:LinkButton ID="firstPage" runat="server" Text="首页" OnClick="firstPage_Click"></asp:LinkButton>&nbsp
            <asp:LinkButton ID="endPage" runat="server" Text="尾页" OnClick="endPage_Click"></asp:LinkButton>
            第<asp:TextBox ID="nowPage" runat="server" Text="1" TextMode="Number" Width="30px"></asp:TextBox>页/共<asp:Label ID="tolPage" runat="server"></asp:Label>页
                <asp:Button ID="btnTurn" runat="server" Text="跳转" Height="21px" Width="43px" OnClick="btnTurn_Click" />
                
            </div>
        </div>
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="ContentPlaceHolder2" Runat="Server">
</asp:Content>

