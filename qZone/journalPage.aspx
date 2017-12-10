<%@ Page Title="" Language="C#" MasterPageFile="~/qZoneTop.master" AutoEventWireup="true" CodeFile="journalPage.aspx.cs" Inherits="_default"  %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
    <script type="text/javascript" src="../ueditor/ueditor.config.js"></script>
    <script type="text/javascript" src="../ueditor/ueditor.all.js"></script>
    <link rel="stylesheet" href="../editor/themes/default/dialogbase.css" />
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
   
    <br />
    ----------------日志----------------<br />
    <div id="journalList" runat="server">
        <asp:LinkButton ID="btnWrite" runat="server" Text="写日志" OnClick="btnWrite_Click"></asp:LinkButton>
        <br />
        <asp:Label ID="check" runat="server" Visible="false" Text="0"></asp:Label>
        <asp:DropDownList ID="typeList" runat="server" AutoPostBack="True" OnSelectedIndexChanged="typeList_SelectedIndexChanged"></asp:DropDownList>
        <asp:LinkButton ID="btnManageType" runat="server" Text="管理" OnClick="btnManageType_Click"></asp:LinkButton>
        <asp:Repeater ID="news" runat="server" OnItemCommand="news_ItemCommand" OnItemDataBound="news_ItemDataBound">
            <HeaderTemplate>
                <table>
            </HeaderTemplate>
            <ItemTemplate>
                <tr>
                    <td align="center" valign="middle">
                        <asp:LinkButton ID="btnTitle" runat="server" CommandName="watch" CommandArgument='<%# Eval("id") %>' Text='<%# Eval("title") %>'></asp:LinkButton>
                        <td align="center" valign="middle"><%# Eval("time") %></td>
                        <td align="center" valign="middle">
                            <asp:LinkButton ID="btnEdit" runat="server" CommandName="edit" CommandArgument='<%# Eval("id") %>' Text="编辑"></asp:LinkButton></td>
                        <td align="center" valign="middle">
                            <asp:LinkButton ID="btnDelete" runat="server" CommandName="delete" CommandArgument='<%# Eval("id") %>' Text="删除" OnClientClick="return confirm('删除后不可恢复,是否继续?'); "></asp:LinkButton></td>
                </tr>
            </ItemTemplate>
            <FooterTemplate>
                </table>
            </FooterTemplate>
        </asp:Repeater>
    </div>



    <div id="manageType" runat="server" visible="false">
        分类列表：<asp:DropDownList ID="typeList2" runat="server" OnSelectedIndexChanged="typeList2_SelectedIndexChanged" AutoPostBack="True"></asp:DropDownList>
        <asp:LinkButton ID="addType" runat="server" Text="添加分类" OnClick="addType_Click"></asp:LinkButton>
        <br />
        分类名称：<asp:TextBox ID="typeName" runat="server" MaxLength="20" AutoPostBack="True"></asp:TextBox><br />


        <asp:LinkButton ID="changeType" runat="server" Text="修改分类" OnClick="changeType_Click"></asp:LinkButton>
        &nbsp
        <asp:LinkButton ID="delType" runat="server" Text="删除分类" OnClick="delType_Click" OnClientClick="return confirm('删除后该分类内的所有日志也将被删除,是否继续?'); "></asp:LinkButton>
    </div>

    <div id="addJournal" runat="server" visible="false">
        <asp:ScriptManager ID="ScriptManager1" runat="server"></asp:ScriptManager>
        <asp:UpdatePanel ID="UpdatePanel1" runat="server">
            <ContentTemplate>
                日志标题：<asp:TextBox ID="journalTitle" runat="server" MaxLength="64"></asp:TextBox>
                日志分类：<asp:DropDownList ID="choseType" runat="server"></asp:DropDownList>
                <br />

                权限管理<br />
                <asp:RadioButton ID="RadioButton4" runat="server" GroupName="power" Text="不改变权限" AutoPostBack="True" OnCheckedChanged="RadioButton1_CheckedChanged" /><br />
                <asp:RadioButton ID="RadioButton1" runat="server" GroupName="power" Text="所有人可见" AutoPostBack="True" OnCheckedChanged="RadioButton1_CheckedChanged" Checked="True" /><br />
                <asp:RadioButton ID="RadioButton2" runat="server" GroupName="power" Text="仅自己可见" AutoPostBack="True" OnCheckedChanged="RadioButton2_CheckedChanged" /><br />
                <asp:RadioButton ID="RadioButton3" runat="server" GroupName="power" Text="指定好友可见" OnCheckedChanged="RadioButton3_CheckedChanged" AutoPostBack="True" /><br />
                <div id="chosePower" runat="server" visible="false">

                    <asp:Label ID="powertext" runat="server" Visible="false"></asp:Label><br />
                    好友列表
        <asp:BulletedList ID="friendsList" runat="server" DisplayMode="LinkButton" Height="16px" OnClick="friendsList_Click" Width="267px"></asp:BulletedList>
                    <br />
                    可见列表
        <asp:BulletedList ID="addUsers" runat="server" DisplayMode="LinkButton" Height="16px" OnClick="addUsers_Click" Width="240px"></asp:BulletedList>
                    <br />

                </div>
            </ContentTemplate>
        </asp:UpdatePanel>
        <script id="myEditor1" type="text/plain"></script>

        <asp:TextBox ID="myEditor" name="myEditor" runat="server" onblur="setUeditor()" Style="width: 1030px; height: 250px;"
            TextMode="MultiLine"></asp:TextBox>
        <br />
        <asp:Label ID="display" runat="server"></asp:Label>
        <asp:Button ID="saveJournal" runat="server" Text="发表" OnClick="saveJournal_Click" />
        <script type="text/javascript">
            var editor = new baidu.editor.ui.Editor({
                readonly: false, toolbars: [['fullscreen', 'source', 'undo', 'redo', 'bold', 'italic',
'underline', 'fontborder', 'backcolor', 'fontsize', 'fontfamily',
'justifyleft', 'justifyright', 'justifycenter', 'justifyjustify',
'strikethrough', 'superscript', 'subscript', 'removeformat',
'formatmatch', 'autotypeset', 'blockquote', 'pasteplain', '|',
'forecolor', 'backcolor', 'insertorderedlist', 'insertunorderedlist',
'selectall', 'cleardoc', 'link', 'unlink', 'emotion', 'help']
                ]
            });
            editor.render("<%=myEditor.ClientID%>");
        </script>
    </div>
    <div id="watchJournal" runat="server" visible="false">
        <asp:Label ID="journalId" runat="server" Visible="false"></asp:Label>
        日志标题:<asp:Label ID="titleDisplay" runat="server"></asp:Label>
        &nbsp 日志分类:
        <asp:Label ID="typeDisplay" runat="server"></asp:Label><br />
        <%# Eval("time") %>
        <br />
        ------------------------------------------------------------------------------<br />
        <asp:Label ID="journalDisplay" runat="server"></asp:Label>
        <%-- <textarea id="myEditor2" name="myEditor2" runat="server" onblur="setUeditor()" style="width: 1030px; height: 250px;"
            disabled="disabled" visible="false"></textarea>--%>
        <br />
        ------------------------------------------------------------------------------<br />
        
        <asp:Label ID="goodNameDisplay" runat="server" ForeColor="#FFCC00"></asp:Label> <br />
        <asp:LinkButton ID="toGood" runat="server" Text="点赞" OnClick="toGood_Click"></asp:LinkButton> &nbsp
        <asp:LinkButton ID="btnToReply" runat="server" Text="评论" OnClick="btnToReply_Click"></asp:LinkButton>
        <br />
        <div runat="server" id="addReply" visible="false">


            <asp:TextBox ID="replyText" runat="server" Height="59px" TextMode="MultiLine" Width="424px" MaxLength="200"></asp:TextBox><br />
            <asp:Button ID="btnPost" runat="server" Text="回复" OnClick="btnPost_Click" /><br />
        </div>
        <asp:Label ID="sql1" runat="server" Visible="false"></asp:Label>
        <asp:Repeater ID="reply1" runat="server" OnItemCommand="reply1_ItemCommand" OnItemDataBound="reply1_ItemDataBound">

            <ItemTemplate>
                用户:<td align="center" valign="middle"><%# Eval("nickname") %></td>
                <br />
                内容:<td align="center" valign="middle"><%# Eval("text") %></td>
                <br />
                时间:<asp:Label ID="timeDisplay" runat="server" Text='<%# Eval("time") %>' Font-Size="Smaller"></asp:Label>
                <asp:LinkButton ID="btnReply" runat="server" CommandName="reply" CommandArgument='<%# Eval("id") %>' Text="回复"></asp:LinkButton></td> 
             <asp:LinkButton ID="btnDel" runat="server" CommandName="del" OnClientClick="return confirm('确认删除?'); " CommandArgument='<%# Eval("id") %>' Text="删除"></asp:LinkButton></td>
                <br />
                <asp:TextBox ID="replyText" runat="server" Visible="false" TextMode="MultiLine" MaxLength="200"></asp:TextBox>
                <br />
                <asp:Button ID="btnPost" runat="server" Text="回复" Visible="false" CommandName="btnreply" CommandArgument='<%# Eval("id") %>' /><br />
                <asp:Repeater ID="replyDisplay" runat="server" Visible="false" OnItemCommand="replyDisplay_ItemCommand" OnItemDataBound="replyDisplay_ItemDataBound">
                    <ItemTemplate>
                        用户:<td align="center" valign="middle"><%# Eval("nickname") %></td>
                        <br />
                        内容:<td align="center" valign="middle"><%# Eval("text") %></td>
                        <br />
                        时间:<asp:Label ID="timeDisplay" runat="server" Text='<%# Eval("time") %>' Font-Size="Smaller"></asp:Label>
                        <br />
                    </ItemTemplate>
                </asp:Repeater>
                <br />
            </ItemTemplate>
            <FooterTemplate>
            </FooterTemplate>
        </asp:Repeater>
        <div id="Page1" runat="server">
            <asp:LinkButton ID="up" runat="server" Text="上一页" OnClick="up_Click"></asp:LinkButton>&nbsp
            <asp:LinkButton ID="down" runat="server" Text="下一页" OnClick="down_Click"></asp:LinkButton>&nbsp
            <asp:LinkButton ID="firstPage" runat="server" Text="首页" OnClick="firstPage_Click"></asp:LinkButton>&nbsp
            <asp:LinkButton ID="endPage" runat="server" Text="尾页" OnClick="endPage_Click"></asp:LinkButton>
            第<asp:TextBox ID="nowPage" runat="server" Text="1" TextMode="Number" Width="30px"></asp:TextBox>页/共<asp:Label ID="tolPage" runat="server"></asp:Label>页
                <asp:Button ID="btnTurn" runat="server" Text="跳转" Height="21px" Width="43px" OnClick="btnTurn_Click" />

        </div>
    </div>

</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="ContentPlaceHolder2" runat="Server">
</asp:Content>

