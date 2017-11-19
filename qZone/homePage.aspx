<%@ Page Title="" Language="C#" MasterPageFile="~/qZoneTop.master" AutoEventWireup="true" CodeFile="homePage.aspx.cs" Inherits="_Default" %>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
   <br /> <asp:DropDownList ID="newsType" runat="server" AutoPostBack="True">
        <asp:ListItem>所有动态</asp:ListItem>
        <asp:ListItem>相册</asp:ListItem>
        <asp:ListItem>日志</asp:ListItem>
        <asp:ListItem>说说</asp:ListItem>
    </asp:DropDownList>
    <asp:Repeater ID="news" runat="server" OnItemCommand="news_ItemCommand">
                <HeaderTemplate>
                    <table>
                        <tr>
                            <th align="center" valign="middle">借阅者</th>
                            <th align="center" valign="middle">借阅时间</th>
                            <th align="center" valign="middle">应还时间</th>
                            <th align="center" valign="middle">订单情况</th>
                            <th align="center" valign="middle">还书时间</th>
                            <th align="center" valign="middle">续期申请</th>
                            <th align="center" valign="middle">还书代码</th>

                        </tr>
                </HeaderTemplate>
                <ItemTemplate>
                    <tr>
                        <td align="center" valign="middle"><%# Eval("whoborrow") %></td>
                        <td align="center" valign="middle"><%# Eval("whenborrow") %></td>
                        <td align="center" valign="middle"><%# Eval("whenreturn") %></td>
                        <td align="center" valign="middle"><%# Eval("finished") %></td>
                        <td align="center" valign="middle"><%# Eval("truereturn") %></td>
                        <td align="center" valign="middle"><%# Eval("apply") %></td>
                        <td align="center" valign="middle"><%# Eval("code") %></td>
                    </tr>
                </ItemTemplate>
                <FooterTemplate>
                    </table>
                </FooterTemplate>


            </asp:Repeater>
</asp:Content>