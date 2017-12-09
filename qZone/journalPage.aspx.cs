using System;
using System.Collections.Generic;
using System.Data;
using System.IO;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
//using System.Windows.Forms;

public partial class _default : checkLogin //System.Web.UI.Page// 
{
    
    static users user = new users();
    protected void Page_Load(object sender, EventArgs e)
    {
        string userLogin = Convert.ToString(Session["name"]);
        string userid = Convert.ToString(Request.QueryString["id"]);
        if(userLogin!=userid)
        {
            btnWrite.Visible = false;
            btnManageType.Visible = false;
        }
        if (!IsPostBack)
        {
            typeList.DataValueField = "id";
            typeList.DataTextField = "name";
            typeList.DataSource = user.getData("select * from usergroup where whose =" + userid + " and grouptype = 'journal'");
            typeList.DataBind();
            if (typeList.SelectedValue != "")
            {
                news.DataSource = user.getData("select * from journal where type =" + typeList.SelectedValue + "and whose =" + userid+" and visual in (select id from usergroup where whose="+userid+" and visual like '%,"+userLogin+",%')");
                news.DataBind();
            }
        }
    }

    protected void news_ItemCommand(object source, RepeaterCommandEventArgs e)
    {
        if (e.CommandName == "edit")
        {
            journalList.Visible = false;
            addJournal.Visible = true;
            string userid = Convert.ToString(Session["name"]);
            string id = Convert.ToString(e.CommandArgument.ToString());
            journalTitle.Text = user.operate(0, 0, "select title from journal where id =?", id);
            choseType.DataValueField = "id";
            choseType.DataTextField = "name";

            choseType.DataSource = user.getData("select * from usergroup where whose = " + userid + " and grouptype = 'journal'");
            choseType.DataBind();
            choseType.SelectedValue = user.operate(0, 0, "select type from journal where id =?", id);
            myEditor.Text = user.operate(0, 0, "select text from journal where id =?", id);
            Session["journalId"] = id;
            check.Text = "1";

        }

        if (e.CommandName == "watch")
        {
            watchJournal.Visible = true;
            journalList.Visible = false;
            string id = Convert.ToString(e.CommandArgument.ToString());
            Session["journalId"] = id;
            titleDisplay.Text = user.operate(0, 0, "select title from journal where id =?", id);
            typeDisplay.Text = user.operate(0, 0, "select name from usergroup where id=?", user.operate(0, 0, "select type from journal where id =?", id));
            journalDisplay.Text = user.operate(0, 0, "select text from journal where id =?", id);
            journalId.Text = id;
            string userLogin = Convert.ToString(Session["name"]);
            string num = user.operate(0, 0, "select num from thumbsup where which =? and type=?", id, "journal");
            if (num != "0")
            {
                goodNameDisplay.Text = user.operate(0, 0, "select whonickname from thumbsup where which =? and type=?", id, "journal") + "等" +num + "人赞了该日志";
            }
            else goodNameDisplay.Visible = false;
            if (user.operate(-1, 0, "select * from thumbsup where which =? and type =? and whoid like ?", id, "journal", "%," + userLogin + ",%") != "0")
            {
                toGood.Text = "取消赞";
            }

            sql1.Text = "select * from replyView where type='journal' and towhich=" + id + " order by time desc";
            DataBindToRepeater(1);
        }
        if (e.CommandName == "delete")
        {
            user.operate(-1, 0, "delete from journal where id =?", Convert.ToString(e.CommandArgument.ToString()));
            user.operate(-1, 0, "delete from news where which=? and type=?", e.CommandArgument.ToString(), "journal");
            Response.Write("<script>alert('删除成功!')</script>");
            Response.Redirect("journalPage.aspx?id=" + Convert.ToString(Session["name"]));

        }
    }

    protected void btnWrite_Click(object sender, EventArgs e)
    {
        journalList.Visible = false;
        addJournal.Visible = true;
        string userid = Convert.ToString(Request.QueryString["id"]);
        choseType.DataValueField = "id";
        choseType.DataTextField = "name";
        choseType.DataSource = user.getData("select * from usergroup where whose = " + userid + " and grouptype = 'journal'");
        choseType.DataBind();
    }

    protected void saveJournal_Click(object sender, EventArgs e)
    {

        string text = myEditor.Text;
        if (text == "")
        {
            Response.Write("<script>alert('日志内容不能为空!')</script>");
        }
        else if (journalTitle.Text == "")
        {
            Response.Write("<script>alert('日志标题不能为空!')</script>");
        }
        else if (choseType.SelectedValue == "")
        {
            Response.Write("<script>alert('你必须选择一个日志分类!')</script>");
        }
        else
        {
            string time = DateTime.Now.ToString();
            string userLogin = Convert.ToString(Session["name"]);
            if (check.Text == "0")
            {
                if (RadioButton4.Checked == true)
                {
                    Response.Write("<script>alert('新建日志不能选不改变权限!')</script>");
                }
                else
                {
                    string visualId, id,visual;
                    if (RadioButton1.Checked == true)
                    {
                         visual = user.operate(0, 0, "select visual from usergroup where whose =? and grouptype=?", userLogin, "allpower");
                    }
                    else if (RadioButton2.Checked == true)
                    {
                        visual = "," + userLogin + ",";
                    }
                    else
                    {
                        visual = powertext.Text + "," + userLogin + ",";
                    }
                    visualId = user.operate(0, 0, "insert into usergroup (whose ,grouptype,visual) values (?,?,?) select @@identity", userLogin, "power", visual);
                    id = user.operate(0, 0, "insert into journal (whose,title,text,time,type,visual) values(?,?,?,?,?,?) select @@identity", userLogin, Server.HtmlEncode(journalTitle.Text), text, time, choseType.SelectedValue, visualId);
                    user.operate(-1, 0, "insert into news (type,whose,time,extra,display,which) values ('journal',?,?,?,?,?)", userLogin, time, "发表了日志--" + journalTitle.Text, visualId, id);
                    user.operate(-1, 0, "insert into thumbsup (which,type) values(?,?)", id, "journal");
                    powertext.Text = "";//清空
                    Response.Write("<script language=javascript>alert('发表成功');window.location = 'journalPage.aspx?id'" + userLogin + ";</script>");
                    Response.Redirect(Request.RawUrl );
                }
            }
            else
            {
                string visualId,id, visual;
                string which = Convert.ToString(Session["journalId"]);
                if (RadioButton4.Checked == true)
                {
                    user.operate(0, 0, "update journal set title=?,time=?,text=?,type=? where id =? ", Server.HtmlEncode(journalTitle.Text), time, text, choseType.SelectedValue,which);
                    user.operate(-1, 0, "insert into news (type,whose,time,extra,display,which) values ('journal',?,?,?,?,?)", userLogin, time, "修改了日志--" + journalTitle.Text, user.operate(0, 0, "select visual from usergroup where id=?", choseType.SelectedValue), which);

                    Response.Write("<script language=javascript>alert('修改成功');window.location = 'journalPage.aspx?id'" + userLogin + ";</script>");
                }
                else
                {

                    if (RadioButton1.Checked == true)
                    {
                        visual = user.operate(0, 0, "select visual from usergroup where whose =? and grouptype=?", userLogin, "allpower");
                    }
                    else if (RadioButton2.Checked == true)
                    {
                        visual = "," + userLogin + ",";
                    }
                    else
                    {
                        visual = powertext.Text + "," + userLogin + ",";
                    }
                    visualId = user.operate(0, 0, "select visual from journal where id=?", which);
                    user.operate(-1, 0, "update usergroup set visual =? where id =?", visual, visualId);
                    user.operate(-1, 0, "update journal set title=?,time=?,text=?,type=?,visual=? where id =? ", Server.HtmlEncode(journalTitle.Text), time, text, choseType.SelectedValue, visualId, which);
                     user.operate(-1, 0, "insert into news (type,whose,time,extra,display,which) values ('journal',?,?,?,?,?)", userLogin, time, "修改了日志--" + Server.HtmlEncode(journalTitle.Text), visualId, which);
                    powertext.Text = "";
                    Response.Write("<script language=javascript>alert('发表成功');window.location = 'journalPage.aspx?id'" + userLogin + ";</script>");
                }
                check.Text = "0";
            }
        }
    }

    protected void typeList_SelectedIndexChanged(object sender, EventArgs e)
    {
        string userid = Convert.ToString(Request.QueryString["id"]);
        string userLogin = Convert.ToString(Session["name"]);
        if(userLogin==userid)
        {
            news.DataSource = user.getData("select * from journal where whose =" + userid + "and type=" + typeList.SelectedValue);
            
        }
        else
        {
            news.DataSource = user.getData("select * from journal where whose =" + userid + "and type=" + typeList.SelectedValue+" and visual in(select id from usergroup where whose ="+userid+" and visual like '%,"+userLogin+",%')");
        }
        news.DataBind();

    }


    protected void addType_Click(object sender, EventArgs e)
    {
        string userLogin = Convert.ToString(Session["name"]);
        if (typeName.Text != "")
        {
            if (user.operate(-1, 0, "select * from usergroup where grouptype='journal' and name=? and whose=?", typeName.Text,userLogin) != "0")
            {
                Response.Write("<script>alert('添加失败,该分组名字已存在!')</script>");
            }
            else
            {
                user.operate(-1, 0, "insert into usergroup (whose ,name,grouptype) values (?,?,?)", userLogin, Server.HtmlEncode(typeName.Text), "journal");
                Response.Write("<script language=javascript>alert('添加成功');window.location = 'journalPage.aspx?id'" + userLogin + ";</script>");
            }
        }
        else Response.Write("<script>alert('分类名称不能为空!')</script>");
    }

    protected void changeType_Click(object sender, EventArgs e)
    {
        string userLogin = Convert.ToString(Session["name"]);
        if (typeName.Text != "" && typeList2.SelectedValue != "")
        {
            if (user.operate(-1, 0, "select * from usergroup where whose =? and name=? and grouptype=? and id!=?", userLogin, typeName.Text, "journal", typeList2.SelectedValue) != "0")
            {
                Response.Write("<script>alert('该名称已经存在!')</script>");
            }
            else
            {
                user.operate(-1, 0, "update usergroup set name = ? where id = ?", Server.HtmlEncode(typeName.Text), typeList2.SelectedValue);
                Response.Write("<script language=javascript>alert('修改成功');window.location = 'journalPage.aspx?id'" + userLogin + ";</script>");
            }
        }
        else Response.Write("<script>alert('分类名称为空或未选中分类!')</script>");
    }

    protected void delType_Click(object sender, EventArgs e)
    {
        string userid = Convert.ToString(Session["name"]);
        // if (user.operate(-1, 0, "select * from journal where type=?", typeList2.SelectedValue) == "0")
        //  {
        user.operate(-1, 0, "delete from journal where type=?", typeList2.SelectedValue);
        user.operate(-1, 0, "delete from usergroup where id =?", typeList2.SelectedValue);
        Response.Write("<script language=javascript>alert('操作成功');window.location = 'journalPage.aspx?id'" + Convert.ToString(Session["name"]) + ";</script>");

        //  }
        // else Response.Write("<script>alert('该分类下还有日志,不能删除!')</script>");
    }

    protected void btnManageType_Click(object sender, EventArgs e)
    {
        journalList.Visible = false;
        manageType.Visible = true;
        string userid = Convert.ToString(Session["name"]);
        typeList2.DataValueField = "id";
        typeList2.DataTextField = "name";
        typeList2.DataSource = user.getData("select * from usergroup where whose = " + userid + " and grouptype = 'journal'");
        typeList2.DataBind();
        try
        {
            typeName.Text = typeList.SelectedItem.Text;
        }
        catch
        {

        }
        
        
    }



    protected void news_ItemDataBound(object sender, RepeaterItemEventArgs e)
    {
        if (e.Item.ItemType == ListItemType.Item || e.Item.ItemType == ListItemType.AlternatingItem)
        {
            string userLogin = Convert.ToString(Session["name"]);
            string userid = Convert.ToString(Request.QueryString["id"]);
            if (userLogin != userid)
            {
                LinkButton btnEdit = (LinkButton)e.Item.FindControl("btnEdit");
                LinkButton btnDel = (LinkButton)e.Item.FindControl("btnDelete");
                btnEdit.CommandName = "watch";
                btnDel.Visible = false;
                btnEdit.Visible = false;

            }
        }
    }



    protected void friendsList_Click(object sender, BulletedListEventArgs e)
    {
        ListItem newitem = new ListItem();
        newitem.Value = friendsList.Items[e.Index].Value;
        newitem.Text = friendsList.Items[e.Index].Text;
        addUsers.Items.Add(newitem);
        //addUsers.Items.AddRange(friendsList.Items[e.Index].);
        powertext.Text = powertext.Text + "," + friendsList.Items[e.Index].Value + ",";
        friendsList.Items.RemoveAt(e.Index);


    }

    protected void addUsers_Click(object sender, BulletedListEventArgs e)
    {
        ListItem newitem = new ListItem();
        newitem.Value = addUsers.Items[e.Index].Value;
        newitem.Text = addUsers.Items[e.Index].Text;
        friendsList.Items.Add(newitem);
        powertext.Text = System.Text.RegularExpressions.Regex.Replace(powertext.Text, "," + addUsers.Items[e.Index].Value + ",", "");
        addUsers.Items.RemoveAt(e.Index);

    }



    protected void RadioButton3_CheckedChanged(object sender, EventArgs e)
    {
        chosePower.Visible = true;
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

    protected void RadioButton1_CheckedChanged(object sender, EventArgs e)
    {
        chosePower.Visible = false;
    }

    protected void RadioButton2_CheckedChanged(object sender, EventArgs e)
    {
        chosePower.Visible = false;
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
    void DataBindToRepeater(int currentPage)
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
    protected void btnPost_Click(object sender, EventArgs e)
    {
        if (replyText.Text != "")
        {
            string time = DateTime.Now.ToString();
            string userLogin = Convert.ToString(Session["name"]);
            user.operate(-1, 0, "insert into reply (type,text,whose,towhich,time) values (?,?,?,?,?)", "journal", Server.HtmlEncode(replyText.Text), userLogin, journalId.Text, time);
            Response.Write("<script language=javascript>alert('回复成功');</script>");

        }
        else Response.Write("<script>alert('留言内容不能为空!')</script>");


    }
    protected void btnToReply_Click(object sender, EventArgs e)
    {
        if (btnToReply.Text == "评论")
        {
            addReply.Visible = true; btnToReply.Text = "取消";

        }
        else
        {
            addReply.Visible = false; btnToReply.Text = "评论";
        }
    }



    protected void reply1_ItemCommand(object source, RepeaterCommandEventArgs e)
    {
        if (e.CommandName == "reply")
        {

            Repeater RptReply = (Repeater)e.Item.FindControl("replyDisplay");
            Button btnPost = (Button)e.Item.FindControl("btnPost");
            TextBox replyText = (TextBox)e.Item.FindControl("replyText");
            string id = Convert.ToString(e.CommandArgument.ToString());
            RptReply.DataSource = user.getData("select * from replyView where type='journal' and towhich=" + id);
            RptReply.DataBind();
            RptReply.Visible = !RptReply.Visible;
            btnPost.Visible = !btnPost.Visible;
            replyText.Visible = !replyText.Visible;


        }
        else if (e.CommandName == "del")
        {
            user.operate(-1, 0, "delete from reply where id=?", Convert.ToString(e.CommandArgument.ToString()));
            string id = Convert.ToString(e.CommandArgument.ToString());
            Response.Write("<script language=javascript>alert('操作成功');window.location = 'photoPage.aspx?id='" + Convert.ToString(Session["name"]) + ";</script>");
        }
        else if (e.CommandName == "btnreply")
        {
            TextBox reply = (TextBox)e.Item.FindControl("replyText");
            if (reply.Text != "")
            {

                string time = DateTime.Now.ToString();
                string userLogin = Convert.ToString(Session["name"]);

                user.operate(-1, 0, "insert into reply (type,time,whose,text,towhich) values(?,?,?,?,?)", "journal", time, userLogin, Server.HtmlEncode(reply.Text), e.CommandArgument.ToString());
                Response.Write("<script language=javascript>alert('发表成功');window.location = 'photoPage.aspx?id='" + Convert.ToString(Session["name"]) + ";</script>");
            }
            else Response.Write("<script>alert('留言内容不能为空!')</script>");

        }
    }

    protected void reply1_ItemDataBound(object sender, RepeaterItemEventArgs e)
    {
        if (e.Item.ItemType == ListItemType.Item || e.Item.ItemType == ListItemType.AlternatingItem)
        {
            string userLogin = Convert.ToString(Session["name"]);
            string userid = Convert.ToString(Request.QueryString["id"]);
            DataRowView rowv = (DataRowView)e.Item.DataItem;
            // int ID = Convert.ToInt32(rowv["id"]);
            // Repeater RptReply = (Repeater)e.Item.FindControl("replyDisplay");
            //  RptReply.DataSource = user.getData("select * from replyView where type='msgBoard' and towhich=" + ID);
            //  RptReply.DataBind();
            if (userLogin != userid)
            {
                LinkButton del = (LinkButton)e.Item.FindControl("btnDel");
                del.Visible = false;
            }
        }
    }
    protected void replyDisplay_ItemCommand(object source, RepeaterCommandEventArgs e)
    {

    }

    protected void replyDisplay_ItemDataBound(object sender, RepeaterItemEventArgs e)
    {

    }


    protected void toGood_Click(object sender, EventArgs e)
    {
        string userLogin = Convert.ToString(Session["name"]);
        string userid = Convert.ToString(Request.QueryString["id"]);
        string which = Session["journalId"].ToString();
        if (toGood.Text == "点赞")
        {
            int num = Convert.ToInt32(user.operate(0, 0, "select num from thumbsup where which=? and type=?", which, "journal"));
            string whoid = user.operate(0, 0, "select whoid from thumbsup where which=? and type=?", which, "journal");
            string whoname = user.operate(0, 0, "select whonickname from thumbsup where which=? and type=?", which, "journal");
            num++;
            whoid = whoid + "," + userLogin + ",";
            whoname = whoname + " " + user.operate(0, 0, "select nickname from users where id = ?", userLogin) + " ";
            user.operate(-1, 0, "update thumbsup set num=?,whoid=?,whonickname=? where which = ? and type=?", num, whoid, whoname, which, "journal");
            Response.Redirect(Request.RawUrl);
        }
        if (toGood.Text == "取消赞")
        {
            int num = Convert.ToInt32(user.operate(0, 0, "select num from thumbsup where which=? and type=?", which, "journal"));
            string whoid = user.operate(0, 0, "select whoid from thumbsup where which=? and type=?", which, "journal");
            string whoname = user.operate(0, 0, "select whonickname from thumbsup where which=? and type=?", which, "journal");
            num--;
            whoid = System.Text.RegularExpressions.Regex.Replace(whoid, "," + userLogin + ",", "");
            whoname = System.Text.RegularExpressions.Regex.Replace(whoname, " " + user.operate(0, 0, "select nickname from users where id = ?", userLogin) + " ", "");
            user.operate(-1, 0, "update thumbsup set num=?,whoid=?,whonickname=? where which = ? and type=?", num, whoid, whoname, which, "journal");
            Response.Redirect(Request.RawUrl);
        }
    }
    protected void typeList2_SelectedIndexChanged(object sender, EventArgs e)
    {
        typeName.Text = typeList2.SelectedItem.Text;
    }
}