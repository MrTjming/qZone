<%@ Page Title="" Language="C#" MasterPageFile="~/qZoneTop.master" AutoEventWireup="true" CodeFile="twitterPage.aspx.cs" Inherits="Default2" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    <br />----------------说说----------------<br />
    <asp:LinkButton ID="btnAddTwitter" runat="server" Text="写说说" OnClick="btnAddTwitter_Click"></asp:LinkButton>
    <div id="addTwitter" runat="server" visible="false">
        <asp:TextBox ID="twiterText" runat="server" TextMode="MultiLine" Height="70px" Width="467px" MaxLength="140"></asp:TextBox>
        <asp:ScriptManager ID="ScriptManager1" runat="server"></asp:ScriptManager>
        <asp:UpdatePanel ID="UpdatePanel1" runat="server">
            <ContentTemplate>
        
        <asp:RadioButton ID="RadioButton1" runat="server" GroupName="power" Text="所有人可见" AutoPostBack="True" OnCheckedChanged="RadioButton1_CheckedChanged" Checked="True"/><br />
        <asp:RadioButton ID="RadioButton2" runat="server" GroupName="power" Text="仅自己可见" AutoPostBack="True" OnCheckedChanged="RadioButton2_CheckedChanged"/><br />
        <asp:RadioButton ID="RadioButton3" runat="server" GroupName="power" Text="指定好友可见" OnCheckedChanged="RadioButton3_CheckedChanged" AutoPostBack="True" /><br />
        <asp:Label ID="powertext" runat="server" Visible="false" ></asp:Label><br />
        <div id="SetPower" runat="server" visible="false">
        好友列表
        <asp:BulletedList ID="friendsList" runat ="server" DisplayMode="LinkButton" Height="16px" OnClick="friendsList_Click" Width="267px" ></asp:BulletedList> 
        <br />可见列表
        <asp:BulletedList ID="addUsers" runat="server" DisplayMode="LinkButton" Height="16px" OnClick="addUsers_Click" Width="240px"></asp:BulletedList>
        <br />
    </div>
                </ContentTemplate>
    </asp:UpdatePanel>
        <asp:Button ID="btnPost" runat="server" Text="发表" OnClick="btnPost_Click" />
    </div>

    <div id="myTwitterDisplay" runat="server" >
        我的说说<br />
        <asp:Repeater ID="twitter" runat="server" OnItemCommand="twitter_ItemCommand" OnItemDataBound="twitter_ItemDataBound">
                <ItemTemplate>
                    <br /><tr>
                       
             用户:<td align="center" valign="middle"><%# Eval("nickname") %></td>   <br />
            内容:<td align="center" valign="middle"><%# Eval("text") %></td> <br />
            时间:<asp:Label ID="timeDisplay" runat="server" Text=<%# Eval("time") %> Font-Size="Smaller"></asp:Label>
                <asp:LinkButton ID="btnReply" runat="server" CommandName="reply" CommandArgument='<%# Eval("id") %>' Text="回复"></asp:LinkButton></td> 
                        <asp:LinkButton ID="del" runat="server" Text="删除" CommandName="del" CommandArgument='<%# Eval("id") %>' OnClientClick="return confirm('删除后将无法恢复,是否继续?'); "></asp:LinkButton>
                        <asp:LinkButton ID="btnThumbsUp" runat="server" CommandName="good" CommandArgument='<%# Eval("id") %>' Text="点赞" Visible="True" Enabled="True"></asp:LinkButton><br />   <br />
            
            <br />
                         <asp:TextBox ID="replyText" runat="server" Visible="false" TextMode="MultiLine" MaxLength="200"></asp:TextBox>
                    <br /> <asp:Button ID="btnPost" runat="server" Text="回复" Visible="false" CommandName="btnreply" CommandArgument='<%# Eval("id") %>'/> <br />
                        
                        <asp:Repeater ID="replyDisplay" runat="server" Visible="false" OnItemCommand="replyDisplay_ItemCommand" OnItemDataBound="replyDisplay_ItemDataBound">
                <ItemTemplate>
                    
                    用户:<td align="center" valign="middle"><%# Eval("nickname") %></td>   <br />
                    内容:<td align="center" valign="middle"><%# Eval("text") %></td> <br />
                    时间:<asp:Label ID="timeDisplay" runat="server" Text=<%# Eval("time") %> Font-Size="Smaller"></asp:Label>
                    <br />
                </ItemTemplate>
            </asp:Repeater>
                    </tr>
                </ItemTemplate>
                <FooterTemplate>
                    </table>
                </FooterTemplate>


            </asp:Repeater>

    </div>
    <div id="Page1" runat="server" >
                <asp:LinkButton ID="up" runat="server" Text="上一页" OnClick="up_Click"></asp:LinkButton>&nbsp
            <asp:LinkButton ID="down" runat="server" Text="下一页" OnClick="down_Click"></asp:LinkButton>&nbsp
            <asp:LinkButton ID="firstPage" runat="server" Text="首页" OnClick="firstPage_Click"></asp:LinkButton>&nbsp
            <asp:LinkButton ID="endPage" runat="server" Text="尾页" OnClick="endPage_Click"></asp:LinkButton>
            第<asp:TextBox ID="nowPage" runat="server" Text="1" TextMode="Number" Width="30px"></asp:TextBox>页/共<asp:Label ID="tolPage" runat="server"></asp:Label>页
                <asp:Button ID="btnTurn" runat="server" Text="跳转" Height="21px" Width="43px" OnClick="btnTurn_Click" />
                <asp:Label ID="sql1" runat="server" Visible="false"></asp:Label>
            </div>
    
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="ContentPlaceHolder2" Runat="Server">
</asp:Content>

