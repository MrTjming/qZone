<%@ Page Title="" Language="C#" MasterPageFile="~/qZoneTop.master" AutoEventWireup="true" CodeFile="photoPage.aspx.cs" Inherits="_default" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    
    <link href="main.css" rel="stylesheet" type="text/css" />
    <br />----------------相册----------------<br />
    我的相册 &nbsp <asp:LinkButton ID="toAddPhoto" runat="server" Text="上传照片" OnClick="toAddPhoto_Click" ></asp:LinkButton> 
    
    <br />
    <div id="photoDIsplay" runat="server" >
    <asp:DropDownList ID="albumList" Visible="false" runat="server" AutoPostBack="True" OnSelectedIndexChanged="albumList_SelectedIndexChanged" style="height: 19px" ></asp:DropDownList>
    <asp:LinkButton ID="addList" runat="server" Text="相册管理" OnClick="addList_Click"></asp:LinkButton>
        <asp:DataList ID="dlphoto" runat="server" RepeatColumns="3" RepeatDirection="Horizontal"  OnItemCommand="dlphoto_ItemCommand" OnItemDataBound="dlphoto_ItemDataBound"   >
        	<itemtemplate>
            	<ul style="list-style:none; margin:6px 20px; padding:0;">
                	<li >
                    	<img src='<%#Eval("extra")%>' alt='<%#Eval("id")%>' class="photo"/></a><br />
                        相册名称：<%#Eval("name") %></a><br />相片数量: <asp:Label ID="photoNum" runat="server" Text=<%# Eval("id") %>  CommandArgument='<%# Eval("id") %>'></asp:Label> <br />
                        相册介绍：<%#Eval("introduce") %><span><br />&nbsp &nbsp   <asp:LinkButton ID="watch" runat="server" CommandName="watch" CommandArgument='<%# Eval("id") %>' Text="查看"></asp:LinkButton>
                           &nbsp &nbsp <asp:LinkButton ID="del" runat="server" OnClientClick="return confirm('删除后不可恢复,是否继续?'); " CommandName="del" CommandArgument='<%# Eval("id") %>' Text="删除"></asp:LinkButton>
                	</li>
                    
                </ul>
            </itemtemplate>
        </asp:DataList>
        </div>
        <div id="albumDisplay" runat="server" visible="false"><asp:Label ID="albumName" runat="server" ></asp:Label> 
           
             <asp:DataList ID="albumShow" runat="server" RepeatColumns="3" RepeatDirection="Horizontal" OnItemDataBound="albumShow_ItemDataBound"  OnItemCommand="albumShow_ItemCommand"  >
        	<itemtemplate>
            	<ul style="list-style:none; margin:6px 20px; padding:0;">
                	<li >
                    	<img src='<%#Eval("address")%>' alt='<%#Eval("id")%>' class="photo"/></a><br />
                        图片名称：<%#Eval("name") %></a><br />上传时间：<%#Eval("time") %><span><br /><asp:LinkButton ID="btnsetcover" runat="server" CommandName="cover" CommandArgument='<%# Eval("address") %>' Text="设为封面"></asp:LinkButton> 
                            <asp:LinkButton ID="watch" runat="server" CommandName="watch" CommandArgument='<%# Eval("id") %>' Text="查看"></asp:LinkButton> &nbsp &nbsp &nbsp
                            <asp:LinkButton ID="delete" runat="server" OnClientClick="return confirm('该操作不可逆,确认删除?'); " CommandName="delete" CommandArgument='<%# Eval("id") %>' Text="删除"></asp:LinkButton>
                	</li>
                    
                </ul>
            </itemtemplate>
        </asp:DataList>

        </div>
    
    <div id="addAlbum" runat="server" visible="false" >
        <asp:FileUpload ID="FileUpload1" runat="server" /><br />
        <br />
         相册<asp:DropDownList ID="toWhichGroup" runat="server" ></asp:DropDownList><br />
        名称<asp:TextBox id="photoName" runat="server" MaxLength="20"></asp:TextBox> <br />
        介绍<asp:TextBox ID="photoIntroduce" runat="server" TextMode="MultiLine" MaxLength="100"></asp:TextBox> <br />
    <asp:Button id="addPhoto" runat="server" Text="上传照片" OnClick="addPhoto_Click" Width="78px" />
        <br />
    <asp:Label id="tip" runat="server"></asp:Label>
    </div>
    <div id="listManage" runat="server" visible="false">
        <asp:DropDownList ID="groupInfo" runat="server" style="height: 19px" AutoPostBack="True" OnSelectedIndexChanged="groupInfo_SelectedIndexChanged" ></asp:DropDownList>
        <asp:LinkButton ID="addGroup" runat="server" Text="添加相册" OnClick="addGroup_Click"></asp:LinkButton><br />
        相册名称：<asp:TextBox ID="groupNameChange"  runat="server" MaxLength="20"></asp:TextBox><br />
        <asp:RadioButton ID="RadioButton4" runat="server" GroupName="power" Text="不改变" AutoPostBack="True" OnCheckedChanged="RadioButton1_CheckedChanged"/><br />
        <asp:RadioButton ID="RadioButton1" runat="server" GroupName="power" Text="所有人可见" AutoPostBack="True" OnCheckedChanged="RadioButton1_CheckedChanged" Checked="True"/><br />
        <asp:RadioButton ID="RadioButton2" runat="server" GroupName="power" Text="仅自己可见" AutoPostBack="True" OnCheckedChanged="RadioButton2_CheckedChanged"/><br />
        <asp:RadioButton ID="RadioButton3" runat="server" GroupName="power" Text="指定好友可见" OnCheckedChanged="RadioButton3_CheckedChanged" AutoPostBack="True" /><br />
        <div id="SetPower" runat="server" visible="false">
        
        <asp:Label ID="powertext" runat="server" Visible="false" ></asp:Label><br />
        
        好友列表
        <asp:BulletedList ID="friendsList" runat ="server" DisplayMode="LinkButton" Height="16px" OnClick="friendsList_Click" Width="267px" ></asp:BulletedList> 
        <br />可见列表
        <asp:BulletedList ID="addUsers" runat="server" DisplayMode="LinkButton" Height="16px" OnClick="addUsers_Click" Width="240px"></asp:BulletedList>
        <br />
       
           
    </div>
        <asp:Button ID="btnChangeGroup" runat="server" Text="修改相册" OnClick="btnChangeGroup_Click" />
        <asp:Button ID="delGroup" runat="server" Text="删除相册" OnClick="delGroup_Click" OnClientClick="return confirm('删除后该相册内所有照片也将被删除,是否继续?'); "/>

    </div>
    <div id="photoIntoDisplay" runat="server" visible="false">
        <asp:Label ID="photoId" runat="server" Visible="false"></asp:Label>
        <asp:Image ID="photo" runat="server" /><br />
        名称:<asp:Label ID="photoInfoName" runat="server"></asp:Label> <br />
        上传时间:<asp:Label ID="photoInfoTime" runat="server"></asp:Label> <br />
        介绍:<asp:Label ID="photoInfoIntroduce" runat="server"></asp:Label> <br />

        <asp:Label ID="goodNameDisplay" runat="server" ForeColor="#FFCC00"></asp:Label> <br />
        <asp:LinkButton ID="toGood" runat="server" Text="点赞" OnClick="toGood_Click"></asp:LinkButton> &nbsp
        <asp:LinkButton ID="btnToReply" runat="server" Text="评论" OnClick="btnToReply_Click"></asp:LinkButton> <br />
        <div runat="server" id="addReply" visible="false">

        
        <asp:TextBox ID="replyText" runat="server" Height="59px" TextMode="MultiLine" Width="424px" MaxLength="200" ></asp:TextBox><br />
        <asp:Button ID="btnPost" runat="server" Text="回复" OnClick="btnPost_Click" /><br />
            </div>
         <asp:Label ID="sql1" runat="server" Visible="false"></asp:Label>
    <asp:Repeater ID="reply1"  runat="server"  OnItemCommand="reply1_ItemCommand" OnItemDataBound="reply1_ItemDataBound">

        <ItemTemplate>
             用户:<td align="center" valign="middle"><%# Eval("nickname") %></td>   <br />
            内容:<td align="center" valign="middle"><%# Eval("text") %></td> <br />
            时间:<asp:Label ID="timeDisplay" runat="server" Text=<%# Eval("time") %> Font-Size="Smaller"></asp:Label>
                <asp:LinkButton ID="btnReply" runat="server" CommandName="reply" CommandArgument='<%# Eval("id") %>' Text="回复"></asp:LinkButton></td> 
             <asp:LinkButton ID="btnDel" runat="server" CommandName="del" OnClientClick="return confirm('确认删除?'); " CommandArgument='<%# Eval("id") %>' Text="删除"></asp:LinkButton></td> <br />
            <asp:TextBox ID="replyText" runat="server" Visible="false" TextMode="MultiLine" MaxLength="200"></asp:TextBox>
                    <br /> <asp:Button ID="btnPost" runat="server" Text="回复" Visible="false" CommandName="btnreply" CommandArgument='<%# Eval("id") %>'/><br />
            <asp:Repeater ID="replyDisplay" runat="server" Visible="false" >
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

