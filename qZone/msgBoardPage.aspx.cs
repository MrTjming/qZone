using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Default2 : checkLogin//System.Web.UI.Page
{
    static users user = new users();
    protected void Page_Load(object sender, EventArgs e)
    {
        string userLogin = Convert.ToString(Session["name"]);
        string userid = Convert.ToString(Request.QueryString["id"]);
        try
        {
            if (userid == "")
                userid = userLogin;
            else if (user.operate(-1, 0, "select * from users where id =?", userid) == "0")
                userid = userLogin;
        }
        catch
        {
            userid = userLogin;
        }
        if (userid != userLogin)
            btnToSay.Visible = false;
        if (!IsPostBack)
        {
            sql1.Text = "select * from messageBoard where towho =" + userid + " order by time desc";
            DataBindToRepeater(1);
            hostSay.Text = user.operate(0, 0, "select hostsay from userinfo where userid =?", userid);
        }
    }

    protected void myBoard_ItemCommand(object source, RepeaterCommandEventArgs e)
    {
        if (e.CommandName == "reply") //查看回复
        {

            Repeater RptReply = (Repeater)e.Item.FindControl("replyDisplay");
            Button  btnPost= (Button)e.Item.FindControl("btnPost");
            TextBox replyText = (TextBox)e.Item.FindControl("replyText");
            string id = Convert.ToString(e.CommandArgument.ToString());
            RptReply.DataSource = user.getData("select * from replyView where type='msgBoard' and towhich=" + id);//绑定回复数据
            RptReply.DataBind();
            RptReply.Visible = !RptReply.Visible;
            btnPost.Visible = !btnPost.Visible;
            replyText.Visible = !replyText.Visible;
        }
        else if (e.CommandName == "del")//删除
        {
            user.operate(-1, 0, "delete from msgboard where id=?", Convert.ToString(e.CommandArgument.ToString()));
            Response.Write("<script language=javascript>alert('操作成功');window.location = 'msgBoardPage.aspx?id='" + Convert.ToString(Session["name"]) + ";</script>");
            Response.Redirect(Request.RawUrl);
        }
        else if (e.CommandName == "btnreply")//回复
        {
            TextBox reply = (TextBox)e.Item.FindControl("replyText");
            if (reply.Text != "")
            {

                string time = DateTime.Now.ToString();
                string userLogin = Convert.ToString(Session["name"]);

                user.operate(-1, 0, "insert into reply (type,time,whose,text,towhich) values(?,?,?,?,?)", "msgboard", time, userLogin, Server.HtmlEncode(reply.Text), e.CommandArgument.ToString());
                Response.Write("<script language=javascript>alert('发表成功');</script>");
            }
            else Response.Write("<script>alert('留言内容不能为空!')</script>");

        }
    }


    protected void myBoard_ItemDataBound(object sender, RepeaterItemEventArgs e)
    {
        if (e.Item.ItemType == ListItemType.Item || e.Item.ItemType == ListItemType.AlternatingItem)
        {
            string userLogin = Convert.ToString(Session["name"]);
            string userid = Convert.ToString(Request.QueryString["id"]);
            DataRowView rowv = (DataRowView)e.Item.DataItem;
            int ID = Convert.ToInt32(rowv["id"]);
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

        myBoard.DataSource = pds;

        myBoard.DataBind();

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

    protected void btnToAddMsg_Click(object sender, EventArgs e)
    {
        if (btnToAddMsg.Text == "我要留言")
        {
            addMsgDisplay.Visible = true;
            btnToAddMsg.Text = "取消";
        }
        else if (btnToAddMsg.Text == "取消")
        {
            addMsgDisplay.Visible = false;
            btnToAddMsg.Text = "我要留言";
        }

    }

    protected void btnPost_Click(object sender, EventArgs e)
    {
        if (msgText.Text != "")//发表留言
        {
            string time = DateTime.Now.ToString();
            string userLogin = Convert.ToString(Session["name"]);
            string userid = Convert.ToString(Request.QueryString["id"]);
            user.operate(-1, 0, "insert into msgboard (text,fromwho,towho,time) values (?,?,?,?)", Server.HtmlEncode(msgText.Text), userLogin, userid, time);
            Response.Write("<script language=javascript>alert('发表成功');window.location = 'msgBoardPage.aspx?id='" + Convert.ToString(Session["name"]) + ";</script>");
            Response.Redirect(Request.RawUrl);
        }
        else Response.Write("<script>alert('留言内容不能为空!')</script>");
    }

    protected void replyDisplay_ItemCommand(object source, RepeaterCommandEventArgs e)
    {
        
    }

    protected void replyDisplay_ItemDataBound(object sender, RepeaterItemEventArgs e)
    {
        if (e.Item.ItemType == ListItemType.Item || e.Item.ItemType == ListItemType.AlternatingItem)
        {
            Button btnReply =(Button)e.Item.FindControl("btnReply");
        }
    }

    protected void btnSaveSay_Click(object sender, EventArgs e)
    {
        user.operate(-1, 0, "update userinfo set hostsay =? where userid =?", Server.HtmlEncode(hostSayText.Text), Convert.ToString(Session["name"]));
        Response.Redirect(Request.RawUrl);
    }

    protected void btnToSay_Click(object sender, EventArgs e)
    {
        hosterSayDisplay.Visible = true;
    }
}