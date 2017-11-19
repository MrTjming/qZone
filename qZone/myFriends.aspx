<%@ Page Title="" Language="C#" MasterPageFile="~/qZoneTop.master" AutoEventWireup="true" CodeFile="myFriends.aspx.cs" Inherits="_Default" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    <br />
    <div id="searchPage" runat="server" visible="false">
    <asp:DropDownList ID="searchType" runat="server">
        <asp:ListItem>用户名</asp:ListItem>
        <asp:ListItem>昵称</asp:ListItem>
    </asp:DropDownList> <asp:TextBox ID="textSearch" runat="server" ></asp:TextBox> <asp:Button ID="btnSearch" runat="server" Text="检索" OnClick="btnSearch_Click" />
    <asp:Label ID="sql1" runat="server" Visible="false"></asp:Label> <br />
    <asp:Label ID="tip1" runat="server"></asp:Label>
    <asp:Repeater ID="list" runat="server" OnItemCommand="list_ItemCommand">
                <HeaderTemplate>
                    <table>
                        <tr>
                            <th align="center" valign="middle">用户名</th>
                            <th align="center" valign="middle">昵称</th>
                            <th align="center" valign="middle">性别</th>
                            <th align="center" valign="middle">年龄</th>
                            <th align="center" valign="middle">自我介绍</th>
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
                        <td align="center" valign="middle"><%# Eval("introduce") %></td>
                        <td align="center" valign="middle"><asp:LinkButton ID="btnWatch" runat="server" CommandName="watch" CommandArgument='<%# Eval("id") %>' Text="查看"></asp:LinkButton></td>
                    <td align="center" valign="middle"><asp:LinkButton ID="btnAdd" runat="server" CommandName="add" CommandArgument='<%# Eval("id") %>' Text="添加"></asp:LinkButton></td>
                    </tr>
                </ItemTemplate>
                <FooterTemplate>
                    </table>
                </FooterTemplate>


            </asp:Repeater>
    <div id="Page1" runat="server" visible="true">
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

