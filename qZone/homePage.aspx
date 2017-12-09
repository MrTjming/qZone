<%@ Page Title="" Language="C#" MasterPageFile="~/qZoneTop.master" AutoEventWireup="true" CodeFile="homePage.aspx.cs" Inherits="_Default" %>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    <link href="main.css" rel="stylesheet" type="text/css" />
    <br />----------------个人中心----------------<br />
     <asp:DropDownList ID="newsType" runat="server" AutoPostBack="True" OnSelectedIndexChanged="newsType_SelectedIndexChanged">
        <asp:ListItem>所有动态</asp:ListItem>
        <asp:ListItem>相册</asp:ListItem>
        <asp:ListItem>日志</asp:ListItem>
        <asp:ListItem>说说</asp:ListItem>
    </asp:DropDownList>
    <asp:Repeater ID="news" runat="server" OnItemCommand="news_ItemCommand" OnItemDataBound="news_ItemDataBound">
                <ItemTemplate>
                    <br /><tr>
            <h3> 用户:<asp:LinkButton ID="nickname" runat="server" Text=<%# Eval("nickname") %> CommandName="nickname" CommandArgument='<%# Eval("id") %>'></asp:LinkButton> </h3> 
            内容:<td align="center" valign="middle"><%# Eval("extra") %></td> <br />
                        <img id="image" src='<%#Eval("extra2")%>'  class="newsPhoto"/>
                        <asp:Image ID="Image1" runat="server" ImageUrl=<%# Eval("extra2") %> CssClass="newsPhoto"  Visible="false" /> <br />
                         
            时间:<asp:Label ID="timeDisplay" runat="server" Text=<%# Eval("time") %> Font-Size="Smaller"></asp:Label>
                        <asp:LinkButton ID="btnWatch" runat="server" CommandName="watch" CommandArgument='<%# Eval("id") %>' Text="查看"></asp:LinkButton>
                <asp:LinkButton ID="btnReply" runat="server" CommandName="reply" CommandArgument='<%# Eval("id") %>' Text="回复" ></asp:LinkButton></td>
                        <asp:LinkButton ID="btnThumbsUp" runat="server" CommandName="good" CommandArgument='<%# Eval("id") %>' Text="点赞" Visible="True" Enabled="True"></asp:LinkButton>  <br />
                       <asp:TextBox ID="replyText" runat="server" TextMode="MultiLine" Visible="false" MaxLength="200"></asp:TextBox><br />
                        
                        <asp:Button ID="btnPost" runat="server" Text="回复" Visible="false" CommandName="btnPost" CommandArgument='<%# Eval("id") %>' /><br />
                        <asp:Repeater ID="reply2" runat="server" Visible="false" OnItemCommand="reply2_ItemCommand" OnItemDataBound="reply2_ItemDataBound" >
                            <ItemTemplate>
                                 用户:<asp:LinkButton ID="nickname" runat="server" Text=<%# Eval("nickname") %> Font-Size="Smaller"></asp:LinkButton>  <br />
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
    <div id="Page1" runat="server" >
                <asp:LinkButton ID="up" runat="server" Text="上一页" OnClick="up_Click"></asp:LinkButton>&nbsp
            <asp:LinkButton ID="down" runat="server" Text="下一页" OnClick="down_Click"></asp:LinkButton>&nbsp
            <asp:LinkButton ID="firstPage" runat="server" Text="首页" OnClick="firstPage_Click"></asp:LinkButton>&nbsp
            <asp:LinkButton ID="endPage" runat="server" Text="尾页" OnClick="endPage_Click"></asp:LinkButton>
            第<asp:TextBox ID="nowPage" runat="server" Text="1" TextMode="Number" Width="45px" MaxLength="200"></asp:TextBox>页/共<asp:Label ID="tolPage" runat="server"></asp:Label>页
                <asp:Button ID="btnTurn" runat="server" Text="跳转" Height="21px" Width="43px" OnClick="btnTurn_Click" />
                <asp:Label ID="sql1" runat="server" Visible="false"></asp:Label>
            </div>
</asp:Content>