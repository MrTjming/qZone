using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Default2 : System.Web.UI.Page
{
    static users user = new users();
    protected void Page_Load(object sender, EventArgs e)
    {
        
        string userLogin = Convert.ToString(Session["name"]);
        string userid = Convert.ToString(Request.QueryString["id"]);
        if(userLogin!=userid)//判断是否本人登录,隐藏发说说按钮
        {
            btnAddTwitter.Visible = false;
        }
        if (!IsPostBack)
        {
            DataBindToRepeater(1);//数据绑定
        }
        
    }
    void DataBindToRepeater(int currentPage)
    {
        DataTable dt = new DataTable();
        string userLogin = Convert.ToString(Session["name"]);
        string whose = Convert.ToString(Request.QueryString["id"]);
        dt = user.getAppoint(userLogin, whose, "twitter");
        PagedDataSource pds = new PagedDataSource();
        pds.AllowPaging = true;
        pds.PageSize = 5;
        pds.DataSource = dt.DefaultView;
        tolPage.Text = pds.PageCount.ToString();
        pds.CurrentPageIndex = currentPage - 1;//当前页数从零开始，故把接受的数减一

        twitter.DataSource = pds;
        
        twitter.DataBind();

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
        string userLogin = Convert.ToString(Session["name"]);
        DataTable newDataTable = user.getData("select nickname,id from friendview1 where user2=" + userLogin).Copy();//绑定好友列表的数据
        foreach (DataRow dr in user.getData("select nickname,id from friendview2 where user1=" + userLogin).Rows)
        {
            newDataTable.ImportRow(dr);
        }
        friendsList.DataSource = newDataTable;
        friendsList.DataTextField = "nickname";
        friendsList.DataValueField = "id";
        friendsList.DataBind();
        addUsers.Items.Clear();//清空表
        powertext.Text = "";//清空权限
    }

    protected void friendsList_Click(object sender, BulletedListEventArgs e)//添加好友到可见列表
    {
        ListItem newitem = new ListItem();
        newitem.Value = friendsList.Items[e.Index].Value;
        newitem.Text = friendsList.Items[e.Index].Text;
        addUsers.Items.Add(newitem);
        powertext.Text = powertext.Text + "," + friendsList.Items[e.Index].Value + ",";
        friendsList.Items.RemoveAt(e.Index);
    }

    protected void addUsers_Click(object sender, BulletedListEventArgs e)//将好友从可见列表删除
    {
        ListItem newitem = new ListItem();
        newitem.Value = addUsers.Items[e.Index].Value;
        newitem.Text = addUsers.Items[e.Index].Text;
        friendsList.Items.Add(newitem);
        powertext.Text = System.Text.RegularExpressions.Regex.Replace(powertext.Text, "," + addUsers.Items[e.Index].Value + ",", "");
        addUsers.Items.RemoveAt(e.Index);
    }

    protected void btnPost_Click(object sender, EventArgs e)//发说说按钮
    {
        if(twiterText.Text=="")
            Response.Write("<script>alert('说说内容不能为空'); </script>");
        else
        {
            string userLogin = Convert.ToString(Session["name"]);
            string time = DateTime.Now.ToString();
            string visualId, id;
            if (RadioButton1.Checked == true)//所有人可见
            {
                 visualId = user.operate(0, 0, "select id from usergroup where whose =? and grouptype='allpower'", userLogin);//获取所有好友的id表
                id = user.operate(0, 0, "insert into twitter (whose,time,text,visual) values (?,?,?,?) select @@identity",userLogin,time, Server.HtmlEncode(twiterText.Text),visualId);
            }
            else if (RadioButton2.Checked == true)//仅自己可见
            {
                powertext.Text = "," + userLogin + ",";
                user.operate(-1, 0, "insert into usergroup (grouptype,visual) values (?,?)", "power", powertext.Text); //权限组
                 visualId = user.operate(0, 0, "select id from usergroup where grouptype=? and visual = ? order by id desc", "power", powertext.Text);
                 id = user.operate(0, 0, "insert into twitter (whose,time,text,visual) values (?,?,?,?) select @@identity", userLogin, time, Server.HtmlEncode(twiterText.Text), visualId);
            }
            else //指定好友可见
            {
                user.operate(-1, 0, "insert into usergroup (grouptype,visual) values (?,?)", "power", powertext.Text); //权限组
                visualId = user.operate(0, 0, "select id from usergroup where grouptype=? and visual = ? order by id desc", "power", powertext.Text);
                 id = user.operate(0, 0, "insert into twitter (whose,time,text,visual) values (?,?,?,?) select @@identity", userLogin, time, Server.HtmlEncode(twiterText.Text), visualId);
               
            }
            user.operate(-1, 0, "insert into news (time,type,whose,display,extra,which) values (?,?,?,?,?,?)", time, "twitter", userLogin, visualId, Server.HtmlEncode(twiterText.Text), id);//加入动态
            user.operate(-1, 0, "insert into thumbsup (which,type) values (?,?)", id, "twitter");//创建点赞管理
            Response.Write("<script language=javascript>alert('发表成功');window.location = 'twitterPage.aspx?id'" + Convert.ToString(Session["name"]) + ";</script>");
        }
        
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

    protected void twitter_ItemCommand(object source, RepeaterCommandEventArgs e)
    {
        if(e.CommandName=="reply")//查看回复按钮
        {
            Repeater RptReply = (Repeater)e.Item.FindControl("replyDisplay");
            Button btnPost = (Button)e.Item.FindControl("btnPost");
            TextBox replyText = (TextBox)e.Item.FindControl("replyText");
            string id = Convert.ToString(e.CommandArgument.ToString());
            RptReply.DataSource = user.getData("select * from replyView where type='twitter' and towhich=" + id);//绑定数据
            RptReply.DataBind();
            RptReply.Visible = !RptReply.Visible;
            btnPost.Visible = !btnPost.Visible;
            replyText.Visible = !replyText.Visible;
        }
        else if (e.CommandName == "btnreply")//回复按钮
        {
            TextBox reply = (TextBox)e.Item.FindControl("replyText");
            if (reply.Text != "")
            {
                string time = DateTime.Now.ToString();
                string userLogin = Convert.ToString(Session["name"]);
                user.operate(-1, 0, "insert into reply (type,time,whose,text,towhich) values(?,?,?,?,?)", "twitter", time, userLogin, reply.Text, Server.HtmlEncode(e.CommandArgument.ToString()));
                Response.Redirect(Request.RawUrl);
                //Response.Write("<script language=javascript>alert('发表成功');window.location = 'twitterPage.aspx?id='" + Convert.ToString(Session["name"]) + ";</script>");
            }
            else Response.Write("<script>alert('评论内容不能为空!')</script>");
        }
        else if(e.CommandName=="good")//点赞按钮
        {
            string userLogin = Convert.ToString(Session["name"]);
            string which = e.CommandArgument.ToString();
            int num = Convert.ToInt32(user.operate(0, 0, "select num from thumbsup where which=? and type=?", which, "twitter"));
            string whoid = user.operate(0, 0, "select whoid from thumbsup where which=? and type=?", which, "twitter");
            string whoname = user.operate(0, 0, "select whonickname from thumbsup where which=? and type=?", which, "twitter");
            num++;
            whoid = whoid + "," + userLogin + ",";
            whoname = whoname + " " + user.operate(0, 0, "select nickname from users where id = ?", userLogin) + " ";
            user.operate(-1, 0, "update thumbsup set num=?,whoid=?,whonickname=? where which = ? and type=?", num, whoid, whoname, which, "twitter");
            Response.Redirect(Request.RawUrl);
        }
        else if(e.CommandName=="nogood")//取消赞
        {
            string userLogin = Convert.ToString(Session["name"]);
            string which = e.CommandArgument.ToString();
            int num = Convert.ToInt32(user.operate(0, 0, "select num from thumbsup where which=? and type=?", which, "twitter"));
            string whoid = user.operate(0, 0, "select whoid from thumbsup where which=? and type=?", which, "twitter");
            string whoname = user.operate(0, 0, "select whonickname from thumbsup where which=? and type=?", which, "twitter");
            num--;
            whoid = System.Text.RegularExpressions.Regex.Replace(whoid, "," + userLogin + ",", "");
            whoname = System.Text.RegularExpressions.Regex.Replace(whoname, " " + user.operate(0, 0, "select nickname from users where id = ?", userLogin) + " ", "");
            user.operate(-1, 0, "update thumbsup set num=?,whoid=?,whonickname=? where which = ? and type=?", num, whoid, whoname, which, "twitter");
            Response.Redirect(Request.RawUrl);
        }
        else if(e.CommandName=="del")
        {
            user.operate(-1, 0, "delete from twitter where id =?", e.CommandArgument.ToString());
            user.operate(-1, 0, "delete from news where type=? and which=?", "twitter", e.CommandArgument.ToString());
            Response.Redirect(Request.RawUrl);
        }
    }

    protected void btnAddTwitter_Click(object sender, EventArgs e)
    {
        if (btnAddTwitter.Text == "写说说")
        {
            addTwitter.Visible = true;
            btnAddTwitter.Text = "取消";
        }
        else
        {
            btnAddTwitter.Text = "写说说";
            addTwitter.Visible = false;
        }
            
        
    }
    protected void replyDisplay_ItemCommand(object source, RepeaterCommandEventArgs e)
    {

    }

    protected void replyDisplay_ItemDataBound(object sender, RepeaterItemEventArgs e)
    {

    }

    protected void twitter_ItemDataBound(object sender, RepeaterItemEventArgs e)
    {
        if (e.Item.ItemType == ListItemType.Item || e.Item.ItemType == ListItemType.AlternatingItem)//
        {
            string userLogin = Convert.ToString(Session["name"]);
            LinkButton thumbsUp = (LinkButton)e.Item.FindControl("btnThumbsUp");
            string id = thumbsUp.CommandArgument.ToString();
            if (user.operate(-1, 0, "select * from thumbsup where which =? and type =? and whoid like ?", id, "twitter", "%," + userLogin + ",%") != "0")//判断是否点赞
            {
                thumbsUp.Text = "取消赞";
                thumbsUp.CommandName = "nogood";
            }
            LinkButton del = (LinkButton)e.Item.FindControl("del");
            if(userLogin!= Convert.ToString(Request.QueryString["id"]))//判断是否为本人
            {
                del.Visible = false;
            }


        }
    }
}