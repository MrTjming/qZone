using System;
using System.Collections.Generic;
using System.Data;
using System.IO;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class _default : checkLogin
{
    static users user = new users();
    protected void Page_Load(object sender, EventArgs e)
    {
        string userLogin = Convert.ToString(Session["name"]);
        string userid = Convert.ToString(Request.QueryString["id"]);
        if (userid != userLogin) //判断是否本人
        {
            addList.Visible = false;
            toAddPhoto.Visible = false;
        }
        if(Convert.ToString(Request.QueryString["which"])!=""&& Request.QueryString["which"] !=null )
        {
            if(!IsPostBack && user.operate(-1, 0, "select * from photo where id =?", Request.QueryString["which"]) != "0")
            {
                addList.Visible = false;
                addPhoto.Visible = false;
                albumDisplay.Visible = false;
                photoIntoDisplay.Visible = true;
                string id = Convert.ToString(Request.QueryString["which"]);
                photoId.Text = id;
                photo.ImageUrl = user.operate(0, 0, "select address from photo where id =?", id);
                photoInfoName.Text = user.operate(0, 0, "select name from photo where id =?", id);
                photoInfoTime.Text = user.operate(0, 0, "select time from photo where id =?", id);
                photoInfoIntroduce.Text = user.operate(0, 0, "select introduce from photo where id =?", id);
                sql1.Text = "select * from replyView where type='photo' and towhich=" + id + " order by time desc";
                string num = user.operate(0, 0, "select num from thumbsup where which =? and type=?", id, "photo");
                if (num != "0")//判断点赞数
                {
                    goodNameDisplay.Text = user.operate(0, 0, "select whonickname from thumbsup where which =? and type=?", id, "photo") + "等" + num + "人赞了该照片";
                }
                else goodNameDisplay.Visible = false;

                if (user.operate(-1, 0, "select * from thumbsup where which =? and type =? and whoid like ?", id, "photo", "%," + userLogin + ",%") != "0")
                {
                    toGood.Text = "取消赞";
                }

                DataBindToRepeater(1);
            }
            
        }
        else
        {
            if (!IsPostBack)//绑定相册列表数据
            {
                albumList.DataValueField = "id";
                albumList.DataTextField = "name";
                albumList.DataSource = user.getData("select * from usergroup where whose = " + userid + " and grouptype = 'album'");
                albumList.DataBind();
                if (userid == userLogin)
                {
                    dlphoto.DataSource = user.getData("select * from usergroup where whose =" + userid + " and grouptype='album'");
                }
                else
                {
                    dlphoto.DataSource = user.getData("select * from usergroup where grouptype='album' and whose =" + userid + " and visual in(select id from usergroup where whose =" + userid + " and visual like '%," + userLogin + ",%')");
                }

                dlphoto.DataBind();
            }
        }
        

    }

    protected void addPhoto_Click(object sender, EventArgs e) //照片上传
    {
        Boolean fileOk = false;
        string userid = Convert.ToString(Session["name"]);
        string path = Server.MapPath("~/Photos/" + userid + "/");

        //判断是否已经选取文件
        if (FileUpload1.HasFile)
        {
            //取得文件的扩展名,并转换成小写
            string fileExtension = System.IO.Path.GetExtension(FileUpload1.FileName).ToLower();
            string[] allowExtension = { ".jpg", ".gif", ".txt", ".xls", ".png" };
            for (int i = 0; i < allowExtension.Length; i++)
            {
                if (fileExtension == allowExtension[i])
                {
                    fileOk = true;
                    break;
                }
            }
            if (fileOk)
            {
                tip.Text = "要上传的文件类型不对！";
            }
            if (FileUpload1.PostedFile.ContentLength > 5024000)//对上传文件的大小进行检测，限定文件最大不超过5M
            {
                fileOk = false;
            }
            if (fileOk)
            {
                try
              {
                    string time = DateTime.Now.ToString();
                    string userLogin = Convert.ToString(Session["name"]);
                if (!File.Exists(path))
                {
                    Directory.CreateDirectory(path);
                }
                FileUpload1.PostedFile.SaveAs(path + FileUpload1.FileName);
                    string id = user.operate(0, 0, "insert into photo (whose,whichgroup,name,introduce,address,time) values (?,?,?,?,?,?) select @@identity", userid, toWhichGroup.SelectedValue, photoName.Text, photoIntroduce.Text, "Photos/" + userid + "/" + FileUpload1.PostedFile.FileName, time);
                user.operate(-1, 0, "insert into news (type,whose,time,extra,display,which,extra2) values ('photo',?,?,?,?,?,?)", userLogin, time, "上传了新照片到--<" + Server.HtmlEncode(toWhichGroup.Items[toWhichGroup.SelectedIndex].ToString()) + ">", user.operate(0, 0, "select visual from usergroup where id=?", toWhichGroup.SelectedValue),id, "Photos/" + userid + "/" + FileUpload1.PostedFile.FileName);
                    user.operate(-1, 0, "insert into thumbsup (which,type) values(?,?)", id, "photo");//创建点赞管理
                    if (user.operate(0, 0, "select extra from usergroup where id=?", toWhichGroup.SelectedValue) == "Photos/nophoto.png")//检测相册封面是否存在
                    user.operate(-1, 0, "update usergroup set extra=? where id =?", "Photos/" + userid + "/" + Server.HtmlEncode(FileUpload1.PostedFile.FileName), toWhichGroup.SelectedValue);
                tip.Text = "上传成功,你可以继续上传";
              }
               catch
              {

                tip.Text = "上传失败";
             }
            }
            else
            {
                tip.Text = "文件类型或者文件大小超出１Ｍ或者文件类型不对";
            }

        }
    }

    protected void toAddPhoto_Click(object sender, EventArgs e)
    {

        string userid = Convert.ToString(Session["name"]);
        if (toAddPhoto.Text == "上传照片")
        {
            albumDisplay.Visible = false;
            dlphoto.Visible = false;
            photoDIsplay.Visible = false;
            addAlbum.Visible = true;
            listManage.Visible = false;
            toWhichGroup.DataValueField = "id";
            toWhichGroup.DataTextField = "name";
            toWhichGroup.DataSource = user.getData("select * from usergroup where whose = " + userid + " and grouptype = 'album'");
            toWhichGroup.DataBind();
            toAddPhoto.Text = "预览";
        }
        else
        {
            Response.Redirect("photoPage.aspx?id=" + userid);
        }

    }

    protected void albumList_SelectedIndexChanged(object sender, EventArgs e)
    {
        dlphoto.DataSource = user.getData("select * from photo where whichgroup ='" + albumList.SelectedValue + "'");
        dlphoto.DataBind();
    }

    protected void dlphoto_ItemCommand(object source, DataListCommandEventArgs e)
    {
        if (e.CommandName == "watch")//查看相册内的照片
        {
            photoDIsplay.Visible = false;
            albumDisplay.Visible = true;
            albumShow.DataSource = user.getData("select * from photo where whichgroup=" + Convert.ToString(e.CommandArgument.ToString()));
            albumShow.DataBind();
            albumName.Text = user.operate(0, 0, "select name from usergroup where id=?", Convert.ToString(e.CommandArgument.ToString()));
        }
        else if(e.CommandName=="del")//删除相册
        {
            int num = Convert.ToInt32(user.operate(-1, 0, "select * from photo where whichgroup =?", e.CommandArgument.ToString()));
            for (int a=0;a<num;a++)
            {
                string tmpRootDir = HttpContext.Current.Server.MapPath(System.Web.HttpContext.Current.Request.ApplicationPath.ToString());//获取程序根目录  
                string strUrl = user.operate(0, 0, "Select address from photo where id=?", user.operate(a,0,"select id from photo where whichgroup =?", e.CommandArgument.ToString()));//获取绝对目录
                string urlPath = tmpRootDir + strUrl.Replace(@"/", @"/");//将绝对目录转化为实际目录
                System.IO.File.Delete(urlPath);//删除图片文件
            }
            user.operate(-1, 0, "delete from photo where whichgroup=?", e.CommandArgument.ToString());
                user.operate(-1, 0, "delete from usergroup where id =?", e.CommandArgument.ToString());
                Response.Redirect("photoPage.aspx?id=" + Convert.ToString(Session["name"]));
                Response.Write("<script language=javascript>alert('操作成功');window.location = 'photoPage.aspx?id=" + Convert.ToString(Session["name"]) + "';</script>");
            
            
        }

    }
    protected void albumShow_ItemCommand(object source, DataListCommandEventArgs e)//repeater响应事件
    {
        if (e.CommandName == "delete") //相册内图片删除
        {
            string userLogin = Convert.ToString(Session["name"]);
            string whichgroup = user.operate(0, 0, "select whichgroup from photo where id=?", Convert.ToString(e.CommandArgument.ToString()));
            if (user.operate(0, 0, "select extra from usergroup where id = ?", whichgroup) == user.operate(0, 0, "select address from photo where id=?", Convert.ToString(e.CommandArgument.ToString())))
            {
                //上面检测所属相册的封面是否是待删相片,若是则执行
                string tmpRootDir = HttpContext.Current.Server.MapPath(System.Web.HttpContext.Current.Request.ApplicationPath.ToString());//获取程序根目录  
                string strUrl = user.operate(0, 0, "Select address from photo where id=?", e.CommandArgument.ToString());//获取绝对目录
                string urlPath = tmpRootDir + strUrl.Replace(@"/", @"/");//将绝对目录转化为实际目录
                System.IO.File.Delete(urlPath);//删除图片文件
                user.operate(-1, 0, "delete from photo where id =?", Convert.ToString(e.CommandArgument.ToString()));//删除数据库记录
                if(user.operate(-1,0,"select * from photo where whichgroup=?",whichgroup)!="0")//检测删除后相册内是否还有相片,若有则选择第一张做封面
                {
                     string newAddress = user.operate(0, 0, "select address from photo where whichgroup=?", whichgroup);
                    user.operate(-1, 0, "update usergroup set extra =? where id =?", newAddress, whichgroup);
                }
                else//否则用 默认图做封面
                {

                    user.operate(-1, 0, "update usergroup set extra =? where id =?", "Photos/nophoto.png", whichgroup);
                }
            }
            else
            {
                string tmpRootDir = HttpContext.Current.Server.MapPath(System.Web.HttpContext.Current.Request.ApplicationPath.ToString());//获取程序根目录  
                string strUrl = user.operate(0, 0, "Select address from photo where id=?", e.CommandArgument.ToString());
                string urlPath = tmpRootDir + strUrl.Replace(@"/", @"/");
                System.IO.File.Delete(urlPath);//删除图片文件
                user.operate(-1, 0, "delete from photo where id =?", Convert.ToString(e.CommandArgument.ToString()));//删除数据库记录
            }
               

            Response.Write("<script>alert('删除成功!')</script>");
            Response.Redirect("photoPage.aspx?id=" + Convert.ToString(Session["name"]));
        }
        if (e.CommandName == "watch")//查看相片
        {
            Response.Redirect(Request.RawUrl + "&which=" + e.CommandArgument.ToString());
            //albumDisplay.Visible = false;
            //photoIntoDisplay.Visible = true;
            //string id= e.CommandArgument.ToString();
            //photoId.Text = id;
            //photo.ImageUrl = user.operate(0, 0, "select address from photo where id =?", id);
            //photoInfoName.Text = user.operate(0, 0, "select name from photo where id =?", id);
            //photoInfoTime.Text = user.operate(0, 0, "select time from photo where id =?", id);
            //photoInfoIntroduce.Text = user.operate(0, 0, "select introduce from photo where id =?", id);
            //sql1.Text="select * from replyView where type='photo' and towhich="+id+" order by time desc";

            //string userLogin = Convert.ToString(Session["name"]);
            //string num = user.operate(0, 0, "select num from thumbsup where which =? and type=?", id, "photo");
            //if (num != "0")//判断点赞数
            //{
            //    goodNameDisplay.Text = user.operate(0, 0, "select whonickname from thumbsup where which =? and type=?", id, "photo") + "等" + num + "人赞了该照片";
            //}
            //else goodNameDisplay.Visible = false;
           
            //if (user.operate(-1, 0, "select * from thumbsup where which =? and type =? and whoid like ?", id, "photo", "%," + userLogin + ",%") != "0")
            //{
            //    toGood.Text = "取消赞";
            //}

            //DataBindToRepeater(1);
        }

        if(e.CommandName=="cover")
        {
            string address = e.CommandArgument.ToString();
            string albumId = user.operate(-1, 0, "update usergroup set extra=? where whose =? and name=?", address, Convert.ToString(Session["name"]), albumName.Text);
            Response.Write("<script>alert('操作成功!')</script>");
            Response.Redirect("photoPage.aspx?id=" + Convert.ToString(Session["name"]));

        }

    }


    protected void addList_Click(object sender, EventArgs e)//相册管理按钮事件 将所需数据绑定
    {
        listManage.Visible = true;
        photoDIsplay.Visible = false;
        string userid = Convert.ToString(Session["name"]);
        groupInfo.DataValueField = "id";
        groupInfo.DataTextField = "name";
        groupInfo.DataSource = user.getData("select * from usergroup where whose = " + userid + " and grouptype = 'album'");
        groupInfo.DataBind();
        
        
        DataTable newDataTable = user.getData("select nickname,id from friendview1 where user2=" + userid).Copy();
        foreach (DataRow dr in user.getData("select nickname,id from friendview2 where user1=" + userid).Rows)
        {
            newDataTable.ImportRow(dr);
        }
        friendsList.DataSource = newDataTable;
        friendsList.DataTextField = "nickname";
        friendsList.DataValueField = "id";
        friendsList.DataBind();
        try
        {
            groupNameChange.Text = albumList.SelectedItem.Text;
        }
        catch
        {

        }
    }

    protected void btnChangeGroup_Click(object sender, EventArgs e) //修改相册
    {
        string userid = Convert.ToString(Session["name"]);
        if (groupNameChange.Text != "" && groupInfo.SelectedValue!="")
        {
            string id;
            if (user.operate(-1, 0, "select * from usergroup where whose =? and name=? and grouptype=? and id!=?", userid, groupNameChange.Text, "album", groupInfo.SelectedValue) != "0")
            {
                Response.Write("<script>alert('该名称已经存在!')</script>");
            }
            else
            {
                string userLogin = Convert.ToString(Session["name"]);
                if (RadioButton4.Checked == true)
                {
                    user.operate(-1, 0, "update usergroup set name = ? where id = ?", Server.HtmlEncode(groupNameChange.Text), groupInfo.SelectedValue);
                }
                else
                {
                    if (RadioButton1.Checked == true)
                    {
                        
                        if (user.operate(-1, 0, "select * from usergroup where whose =? and grouptype=?", userLogin, "allpower") == "0")
                        {
                            user.operate(-1, 0, "insert into usergroup (whose,grouptype) values(?,?)", userLogin, "allpower");
                        }
                        id = user.operate(0, 0, "select * from usergroup where whose =? and grouptype=?", userLogin, "allpower");

                    }
                    else if (RadioButton2.Checked == true)
                    {
                        powertext.Text = "," + userid + ",";
                        user.operate(-1, 0, "insert into usergroup (grouptype,visual,whose) values (?,?,?)", "power", powertext.Text,userLogin); //权限组
                        id = user.operate(0, 0, "select id from usergroup where grouptype=? and visual = ? order by id desc", "power", powertext.Text);

                    }
                    else
                    {
                        powertext.Text = powertext.Text + "," + userid + ",";
                        user.operate(-1, 0, "insert into usergroup (grouptype,visual,whose) values (?,?,?)", "power", powertext.Text,userLogin);
                        id = user.operate(0, 0, "select id from usergroup where grouptype=? and visual = ? order by id desc", "power", powertext.Text);

                    }
                    user.operate(-1, 0, "update usergroup set name = ? , visual=? where id = ?", Server.HtmlEncode(groupNameChange.Text), id, groupInfo.SelectedValue);
                }
                Response.Write("<script language=javascript>alert('修改成功');window.location = 'photoPage.aspx?id=" + Convert.ToString(Session["name"]) + "';</script>");
            }
        }
        else Response.Write("<script>alert('分类名称为空或未选中相册!')</script>");
    }

    protected void delGroup_Click(object sender, EventArgs e)//删除相册的事件
    {

        user.operate(-1, 0, "delete from usergroup where id =?", groupInfo.SelectedValue);
        Response.Write("<script language=javascript>alert('操作成功');window.location = 'photoPage.aspx?id=" + Convert.ToString(Session["name"]) + "';</script>");

    }

    protected void addGroup_Click(object sender, EventArgs e)//新建相册的事件
    {
        string userid = Convert.ToString(Session["name"]);
        if (groupNameChange.Text != "")
        {
            if (RadioButton4.Checked == true)
            {
                Response.Write("<script>alert('新建相册不能选不改变权限!')</script>");
            }
            else
            {
                if (user.operate(-1, 0, "select * from usergroup where grouptype='album' and name=? and whose=?", groupNameChange.Text,userid) != "0")
                {
                    Response.Write("<script>alert('添加失败,该相册名已存在!')</script>");
                }
                else if (RadioButton1.Checked == true)
                {
                    string userLogin = Convert.ToString(Session["name"]);
                    if (user.operate(-1, 0, "select * from usergroup where whose =? and grouptype=?", userLogin, "allpower") == "0")
                    {
                        user.operate(-1, 0, "insert into usergroup (whose,grouptype) values(?,?)", userLogin, "allpower");
                    }
                    string id = user.operate(0, 0, "select * from usergroup where whose =? and grouptype=?", userLogin, "allpower");
                    user.operate(-1, 0, "insert into usergroup (whose ,name,grouptype,visual,extra) values (?,?,?,?,?)", userid, Server.HtmlEncode(groupNameChange.Text), "album", id, "Photos/nophoto.png");
                }
                else if (RadioButton2.Checked == true)
                {
                    powertext.Text = "," + userid + ",";
                    user.operate(-1, 0, "insert into usergroup (grouptype,visual,whose) values (?,?,?)", "power", powertext.Text,userid); //权限组
                    string id = user.operate(0, 0, "select id from usergroup where grouptype=? and visual = ? order by id desc", "power", powertext.Text);
                    user.operate(-1, 0, "insert into usergroup (whose ,name,grouptype,visual,extra) values (?,?,?,?,?)", userid, Server.HtmlEncode(groupNameChange.Text), "album", id, "Photos/nophoto.png");//实际组
                }
                else if (RadioButton3.Checked)
                {
                    powertext.Text = powertext.Text + "," + userid + ",";
                    user.operate(-1, 0, "insert into usergroup (grouptype,visual,whose) values (?,?,?)", "power", powertext.Text,userid);
                    string id = user.operate(0, 0, "select id from usergroup where grouptype=? and visual = ? order by id desc", "power", powertext.Text);
                    user.operate(-1, 0, "insert into usergroup (whose ,name,grouptype,visual,extra) values (?,?,?,?,?)", userid, Server.HtmlEncode(groupNameChange.Text), "album", id, "Photos/nophoto.png");
                }
                Response.Write("<script language=javascript>alert('添加成功');window.location = 'photoPage.aspx?id=" + Convert.ToString(Session["name"]) + "';</script>");
            }
        }
        else Response.Write("<script>alert('相册名称不能为空!')</script>");
        
    }





    protected void dlphoto_ItemDataBound(object sender, DataListItemEventArgs e)//repeater的事件管理
    {
        if (e.Item.ItemType == ListItemType.Item || e.Item.ItemType == ListItemType.AlternatingItem)
        {
            Label photoNum = (Label)e.Item.FindControl("photoNum");
            photoNum.Text = user.operate(-1, 0, "select * from photo where whichgroup=?", photoNum.Text);
            
            string userLogin = Convert.ToString(Session["name"]);
            string userid = Convert.ToString(Request.QueryString["id"]);
            if(userLogin!=userid)
            {
                LinkButton del = (LinkButton)e.Item.FindControl("del");
                del.Visible = false;
            }
                
            
            
        }
    }

    protected void friendsList_Click(object sender, BulletedListEventArgs e)//权限管理的好友列表单击事件 将单击选择的好友移至addusers列表
    {
        ListItem newitem = new ListItem();
        newitem.Value = friendsList.Items[e.Index].Value;
        newitem.Text = friendsList.Items[e.Index].Text;
        addUsers.Items.Add(newitem);
        powertext.Text = powertext.Text + "," + friendsList.Items[e.Index].Value + ",";
        friendsList.Items.RemoveAt(e.Index);
    }

    protected void addUsers_Click(object sender, BulletedListEventArgs e)//权限管理的已选择好友的单击事件 将单击选择的好友移回friendslist列表 并从权限暂存文本中删除该项
    {
        ListItem newitem = new ListItem();
        newitem.Value = addUsers.Items[e.Index].Value;
        newitem.Text = addUsers.Items[e.Index].Text;
        friendsList.Items.Add(newitem);
        powertext.Text = System.Text.RegularExpressions.Regex.Replace(powertext.Text, "," + addUsers.Items[e.Index].Value + ",", "");//在权限中删除 选中的好友
        addUsers.Items.RemoveAt(e.Index);
    }

    protected void RadioButton1_CheckedChanged(object sender, EventArgs e)
    {
        SetPower.Visible = false;
    }

    protected void RadioButton2_CheckedChanged(object sender, EventArgs e)
    {
        SetPower.Visible = false;
    }

    protected void RadioButton3_CheckedChanged(object sender, EventArgs e)
    {
        SetPower.Visible = true;
        friendsList.Items.Clear();
        addUsers.Items.Clear();
        powertext.Text = "";
        string userid = Convert.ToString(Session["name"]);
        DataTable newDataTable = user.getData("select nickname,id from friendview1 where user2=" + userid).Copy();
        foreach (DataRow dr in user.getData("select nickname,id from friendview2 where user1=" + userid).Rows)
        {
            newDataTable.ImportRow(dr);
        }
        friendsList.DataSource = newDataTable;
        friendsList.DataTextField = "nickname";
        friendsList.DataValueField = "id";
        friendsList.DataBind();
    }
    

    protected void albumShow_ItemDataBound(object sender, DataListItemEventArgs e)//albumShow repeater的事件管理
    {
        if (e.Item.ItemType == ListItemType.Item || e.Item.ItemType == ListItemType.AlternatingItem)
        {
            
            string userLogin = Convert.ToString(Session["name"]);
            string userid = Convert.ToString(Request.QueryString["id"]);
            if (userLogin != userid)
            {
                LinkButton del = (LinkButton)e.Item.FindControl("delete");
                del.Visible = false;
                LinkButton setcover = (LinkButton)e.Item.FindControl("btnsetcover");
                setcover.Visible = false;
            }
        }
    }

    protected void down_Click(object sender, EventArgs e)
    {
        string NowPage = nowPage.Text;
        int ToPage = Convert.ToInt32(NowPage) + 1;
        if (ToPage <= Convert.ToInt32(tolPage.Text))
        {
            nowPage.Text = Convert.ToString(ToPage);
            DataBindToRepeater(ToPage);

        }
        else Response.Write("<script>alert('已经到底页了!')</script>");

    }

    protected void up_Click(object sender, EventArgs e)
    {
        string NowPage = nowPage.Text;
        int ToPage = Convert.ToInt32(NowPage) - 1;
        if (ToPage > 0)
        {
            nowPage.Text = Convert.ToString(ToPage);
            DataBindToRepeater(ToPage);

        }
        else Response.Write("<script>alert('已经到顶页了!')</script>");
    }

    protected void firstPage_Click(object sender, EventArgs e)
    {
        nowPage.Text = "1";
        DataBindToRepeater(1);
    }

    protected void endPage_Click(object sender, EventArgs e)
    {
        nowPage.Text = tolPage.Text;
        DataBindToRepeater(Convert.ToInt32(tolPage.Text));
    }
    protected void btnTurn_Click(object sender, EventArgs e)
    {
        int num = Convert.ToInt32(nowPage.Text);
        if (num > 0 && num <= Convert.ToInt32(tolPage.Text))
            DataBindToRepeater(num);
        else Response.Write("<script>alert('没有该页面!')</script>");
    }

    protected void reply1_ItemCommand(object source, RepeaterCommandEventArgs e)
    {
        if (e.CommandName == "reply")//查看回复按钮事件
        {

            Repeater RptReply = (Repeater)e.Item.FindControl("replyDisplay");
            Button btnPost = (Button)e.Item.FindControl("btnPost");
            TextBox replyText = (TextBox)e.Item.FindControl("replyText");
            string id = Convert.ToString(e.CommandArgument.ToString());
            RptReply.DataSource = user.getData("select * from replyView where type='photo' and towhich=" + id);
            RptReply.DataBind();
            RptReply.Visible = !RptReply.Visible;
            btnPost.Visible = !btnPost.Visible;
            replyText.Visible = !replyText.Visible;
        }
        else if (e.CommandName == "del")//删除按钮事件
        {
            user.operate(-1, 0, "delete from reply where id=?", Convert.ToString(e.CommandArgument.ToString()));
            Response.Write("<script language=javascript>alert('操作成功');window.location = '" + Request.RawUrl + "';</script>");
        }
        else if (e.CommandName == "btnreply")//回复
        {
            TextBox reply = (TextBox)e.Item.FindControl("replyText");
            if (reply.Text != "")
            {
                string time = DateTime.Now.ToString();
                string userLogin = Convert.ToString(Session["name"]);
                user.operate(-1, 0, "insert into reply (type,time,whose,text,towhich) values(?,?,?,?,?)", "photo", time, userLogin, Server.HtmlEncode(reply.Text), e.CommandArgument.ToString());
                Response.Redirect(Request.RawUrl);
            }
            else Response.Write("<script>alert('留言内容不能为空!')</script>");
        }
    }
    protected void reply1_ItemDataBound(object sender, RepeaterItemEventArgs e)//reply1 repeater的事件管理
    {
        if (e.Item.ItemType == ListItemType.Item || e.Item.ItemType == ListItemType.AlternatingItem)
        {
            string userLogin = Convert.ToString(Session["name"]);
            string userid = Convert.ToString(Request.QueryString["id"]);
            DataRowView rowv = (DataRowView)e.Item.DataItem;
            if (userLogin != userid)
            {
                LinkButton del = (LinkButton)e.Item.FindControl("btnDel");//非本人 不显示删除
                del.Visible = false;
            }
        }
    }
    void DataBindToRepeater(int currentPage)//翻页
    {

        DataTable dt = new DataTable();

        dt = user.getData(sql1.Text);

        PagedDataSource pds = new PagedDataSource();

        pds.AllowPaging = true;

        pds.PageSize = 5;

        pds.DataSource = dt.DefaultView;

        tolPage.Text = pds.PageCount.ToString();

        pds.CurrentPageIndex = currentPage - 1;//当前页数从零开始，故把接受的数减一

        reply1.DataSource = pds;

        reply1.DataBind();

    }
    

    protected void btnPost_Click(object sender, EventArgs e)//回复事件
    {
        if(replyText.Text!="")
        {
            string time = DateTime.Now.ToString();
            string userLogin = Convert.ToString(Session["name"]);
            user.operate(-1, 0, "insert into reply (type,text,whose,towhich,time) values (?,?,?,?,?)", "photo", Server.HtmlEncode(replyText.Text), userLogin, photoId.Text, time);
            Response.Write("<script language=javascript>alert('评论成功');");
        }
        else Response.Write("<script>alert('留言内容不能为空!')</script>");


    }

    protected void btnToReply_Click(object sender, EventArgs e)
    {
        if(btnToReply.Text=="评论")
        {
            addReply.Visible = true; btnToReply.Text = "取消";

        }
        else
        {
            addReply.Visible = false; btnToReply.Text = "评论";
        }
    }

    protected void toGood_Click(object sender, EventArgs e)
    {
        string userLogin = Convert.ToString(Session["name"]);
        string userid = Convert.ToString(Request.QueryString["id"]);
        string which = photoId.Text;
        if (toGood.Text == "点赞")
        {
            int num = Convert.ToInt32(user.operate(0, 0, "select num from thumbsup where which=? and type=?", which, "photo"));
            string whoid = user.operate(0, 0, "select whoid from thumbsup where which=? and type=?", which, "photo");
            string whoname = user.operate(0, 0, "select whonickname from thumbsup where which=? and type=?", which, "photo");
            num++;
            whoid = whoid + "," + userLogin + ",";
            whoname = whoname + " " + user.operate(0, 0, "select nickname from users where id = ?", userLogin) + " ";
            user.operate(-1, 0, "update thumbsup set num=?,whoid=?,whonickname=? where which = ? and type=?", num, whoid, whoname, which, "photo");
            
        }
        if (toGood.Text == "取消赞")
        {
            int num = Convert.ToInt32(user.operate(0, 0, "select num from thumbsup where which=? and type=?", which, "photo"));
            string whoid = user.operate(0, 0, "select whoid from thumbsup where which=? and type=?", which, "photo");
            string whoname = user.operate(0, 0, "select whonickname from thumbsup where which=? and type=?", which, "photo");
            num--;
            whoid = System.Text.RegularExpressions.Regex.Replace(whoid, "," + userLogin + ",", "");
            whoname = System.Text.RegularExpressions.Regex.Replace(whoname, " " + user.operate(0, 0, "select nickname from users where id = ?", userLogin) + " ", "");
            user.operate(-1, 0, "update thumbsup set num=?,whoid=?,whonickname=? where which = ? and type=?", num, whoid, whoname, which, "photo");
            
        }
    }

    protected void groupInfo_SelectedIndexChanged(object sender, EventArgs e)
    {
        groupNameChange.Text = groupInfo.SelectedItem.Text;
    }
}
