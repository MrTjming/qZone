<%@ Page Title="" Language="C#" MasterPageFile="~/qZoneTop.master" AutoEventWireup="true" CodeFile="myFriends.aspx.cs" Inherits="_default" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    <br />----------------好友中心----------------<br />
    
        我的好友<asp:LinkButton ID="toAddFriend" runat="server" Text="添加好友" OnClick="toAddFriend_Click"></asp:LinkButton> <br />
        <div id="applyFriend">
            <asp:LinkButton ID="tip2" runat="server" OnClick="tip2_Click"></asp:LinkButton>
             <asp:Repeater ID="applyList" runat="server" OnItemCommand="applyList_ItemCommand" Visible="false">
                <HeaderTemplate>
                    <table>
                        <tr>
                            <th align="center" valign="middle">昵称</th>
                            <th align="center" valign="middle">同意</th>
                            <th align="center" valign="middle">拒绝</th>
                        </tr>
                </HeaderTemplate>
                <ItemTemplate>
                    <tr>
                        <td align="center" valign="middle"><%# Eval("fromname") %></td>
                        <td align="center" valign="middle"><asp:LinkButton ID="btnAgree" runat="server" CommandName="agree" CommandArgument='<%# Eval("id") %>' Text="同意"></asp:LinkButton></td>
                    <td align="center" valign="middle"><asp:LinkButton ID="btnDisagree" runat="server" CommandName="disagree" CommandArgument='<%# Eval("id") %>' Text="拒绝"></asp:LinkButton></td>
                    </tr>
                </ItemTemplate>
                <FooterTemplate>
                    </table>
                </FooterTemplate>
            </asp:Repeater>
        </div>
      <div id="friendList" runat="server">
        <asp:Repeater ID="friends" runat="server" OnItemCommand="friends_ItemCommand">
                <HeaderTemplate>
                    <table>
                        <tr>
                            <th align="center" valign="middle">用户名</th>
                            <th align="center" valign="middle">查看</th>
                            <th align="center" valign="middle">删除</th>

                        </tr>
                </HeaderTemplate>
                <ItemTemplate>
                    <tr>
                        <td align="center" valign="middle"><%# Eval("nickname") %></td>
                        <td align="center" valign="middle"><asp:LinkButton ID="btnWatch" runat="server" CommandName="watch" CommandArgument='<%# Eval("id") %>' Text="查看"></asp:LinkButton></td>
                    <td align="center" valign="middle"><asp:LinkButton ID="btnDel" runat="server" CommandName="del" CommandArgument='<%# Eval("id") %>' Text="删除"></asp:LinkButton></td>
                    </tr>
                </ItemTemplate>
                <FooterTemplate>
                    </table>
                </FooterTemplate>
            </asp:Repeater>

    </div>
    <div id="searchPage" runat="server" visible="false">
    <asp:DropDownList ID="searchType" runat="server">
        <asp:ListItem>用户名</asp:ListItem>
        <asp:ListItem>昵称</asp:ListItem>
    </asp:DropDownList> <asp:TextBox ID="textSearch" runat="server" MaxLength="20" ></asp:TextBox>
         <asp:Button ID="btnSearch" runat="server" Text="检索" OnClick="btnSearch_Click" />
    <asp:Label ID="sql1" runat="server" Visible="false"></asp:Label> <br />
    <asp:Label ID="tip1" runat="server"></asp:Label>
        <asp:Label ID="recordType" runat="server" Text="name" Visible="false"></asp:Label>
        <asp:Label ID="recordText" runat="server" Visible="false"></asp:Label>
    <asp:Repeater ID="list" runat="server" OnItemCommand="list_ItemCommand">
                <HeaderTemplate>
                    <table>
                        <tr>
                            <th align="center" valign="middle">用户名</th>
                            <th align="center" valign="middle">昵称</th>
                            <th align="center" valign="middle">性别</th>
                            <th align="center" valign="middle">年龄</th>
                            <th align="center" valign="middle">查看</th>
                            <th align="center" valign="middle">添加</th>

                        </tr>
                </HeaderTemplate>
                <ItemTemplate>
                    <tr>
                        <td align="center" valign="middle"><%# Eval("name") %></td>
                        <td align="center" valign="middle"><%# Eval("nickname") %></td>
                        <td align="center" valign="middle"><%# Eval("sex") %></td>
                        <td align="center" valign="middle"><%# Eval("age") %></td>
                        <td align="center" valign="middle"><asp:LinkButton ID="btnWatch" runat="server" CommandName="btnWatch" CommandArgument='<%# Eval("id") %>' Text="查看"></asp:LinkButton></td>
                    <td align="center" valign="middle"><asp:LinkButton ID="btnAdd" runat="server" CommandName="btnAdd" CommandArgument='<%# Eval("id") %>' Text="添加"></asp:LinkButton></td>
                    </tr>
                </ItemTemplate>
                <FooterTemplate>
                    </table>
                </FooterTemplate>


            </asp:Repeater>
         </div>
    <div id="Page1" runat="server" visible="true">
                <asp:LinkButton ID="up" runat="server" Text="上一页" OnClick="up_Click"></asp:LinkButton>&nbsp
            <asp:LinkButton ID="down" runat="server" Text="下一页" OnClick="down_Click"></asp:LinkButton>&nbsp
            <asp:LinkButton ID="firstPage" runat="server" Text="首页" OnClick="firstPage_Click"></asp:LinkButton>&nbsp
            <asp:LinkButton ID="endPage" runat="server" Text="尾页" OnClick="endPage_Click"></asp:LinkButton>
            第<asp:TextBox ID="nowPage" runat="server" Text="1" Width="46px" TextMode="Number"></asp:TextBox>页/共<asp:Label ID="tolPage" runat="server"></asp:Label>页
                <asp:Button ID="btnTurn" runat="server" Text="跳转" Height="21px" Width="43px" OnClick="btnTurn_Click" />
           
        </div>
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="ContentPlaceHolder2" Runat="Server">
</asp:Content>

