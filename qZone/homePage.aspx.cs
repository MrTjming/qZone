using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class _Default : System.Web.UI.Page
{
    string watchID;
    static users user = new users();
    protected void Page_Load(object sender, EventArgs e)
    {
        string userLogin = Convert.ToString(Session["name"]);
        string userid = Convert.ToString(Request.QueryString["id"]);
        
        if (!IsPostBack)
        {
            if (userLogin != userid)
            {
                Response.Redirect("homePage.aspx?id=" + userLogin);
            }
            DataBindToRepeater(0);
        }

    }

    protected void news_ItemCommand(object source, RepeaterCommandEventArgs e)
    {
        if(e.CommandName=="reply")
        {
                Repeater RptReply = (Repeater)e.Item.FindControl("reply2");
                Button btnPost = (Button)e.Item.FindControl("btnPost");
                TextBox replyText = (TextBox)e.Item.FindControl("replyText");
                string id = Convert.ToString(e.CommandArgument.ToString());
            
            string type = user.operate(0, 0, "select type from news where id=?", id);
            string which = user.operate(0, 0, "select which from news where id =?",id);
            RptReply.DataSource = user.getData("select * from replyView where type='"+type+"' and towhich=" + which);
                RptReply.DataBind();
                RptReply.Visible = !RptReply.Visible;
                btnPost.Visible = !btnPost.Visible;
                replyText.Visible = !replyText.Visible;
        }
        else if(e.CommandName=="btnPost")
        {
            
            TextBox reply = (TextBox)e.Item.FindControl("replyText");
            if (reply.Text!="")
            {
                string id = Convert.ToString(e.CommandArgument.ToString());
                string type = user.operate(0, 0, "select type from news where id=?", id);
                string which = user.operate(0, 0, "select which from news where id =?", id);
                string time = DateTime.Now.ToString();
                string userLogin = Convert.ToString(Session["name"]);
                user.operate(-1, 0, "insert into reply (type,time,whose,text,towhich) values(?,?,?,?,?)", type, time, userLogin, Server.HtmlEncode(reply.Text), which);
                Response.Write("<script language=javascript>alert('评论成功');window.location = 'homePage.aspx?id='" + Convert.ToString(Session["name"]) + ";</script>");

            }
            else Response.Write("<script>alert('评论内容不能为空!')</script>");
        }
        else if(e.CommandName=="nickname")
        {
            string type = user.operate(0, 0, "select type from news where id=?", e.CommandArgument.ToString());
            string userid = user.operate(0,0,"Select whose from news where id=?", e.CommandArgument.ToString());
            Response.Redirect(type+"Page.aspx?id="+userid);
        }
        else if(e.CommandName=="watch")
        {
            string type = user.operate(0, 0, "select type from news where id=?", e.CommandArgument.ToString());
            string userid = user.operate(0, 0, "Select whose from news where id=?", e.CommandArgument.ToString());
            Response.Redirect(type + "Page.aspx?id=" + userid+"&which="+user.operate(0,0,"select which from news where id =?", e.CommandArgument.ToString()));
        }
        else if(e.CommandName=="good")
        {
            string userLogin = Convert.ToString(Session["name"]);
            string id = e.CommandArgument.ToString();
            string which = user.operate(0, 0, "select which from news where id =?", id);
            string type = user.operate(0, 0, "select type from news where id = ?", id);
            int num =Convert.ToInt32( user.operate(0, 0, "select num from thumbsup where which=? and type=?", which, type));
            string whoid = user.operate(0, 0, "select whoid from thumbsup where which=? and type=?", which, type);
            string whoname = user.operate(0, 0, "select whonickname from thumbsup where which=? and type=?", which, type);
            num++;
            whoid = whoid + "," + userLogin + ",";
            whoname=whoname+" "+user.operate(0,0,"select nickname from users where id = ?",userLogin)+" ";
            user.operate(-1, 0, "update thumbsup set num=?,whoid=?,whonickname=? where which = ? and type=?",num,whoid,whoname,which,type);
            Response.Redirect(Request.RawUrl);
        }
        else if (e.CommandName=="nogood")
        {
            string userLogin = Convert.ToString(Session["name"]);
            string id = e.CommandArgument.ToString();
            string which = user.operate(0, 0, "select which from news where id =?", id);
            string type = user.operate(0, 0, "select type from news where id = ?", id);
            int num = Convert.ToInt32(user.operate(0, 0, "select num from thumbsup where which=? and type=?", which, type));
            string whoid = user.operate(0, 0, "select whoid from thumbsup where which=? and type=?", which, type);
            string whoname = user.operate(0, 0, "select whonickname from thumbsup where which=? and type=?", which, type);
            num--;
            whoid = System.Text.RegularExpressions.Regex.Replace(whoid, "," + userLogin + ",", "");
            whoname = System.Text.RegularExpressions.Regex.Replace(whoname, " " + user.operate(0, 0, "select nickname from users where id = ?", userLogin) + " ", "");
            user.operate(-1, 0, "update thumbsup set num=?,whoid=?,whonickname=? where which = ? and type=?", num, whoid, whoname, which, type);
            Response.Redirect(Request.RawUrl);
        }
    }

    protected void newsType_SelectedIndexChanged(object sender, EventArgs e)
    {
        if(newsType.SelectedValue=="所有动态")
            DataBindToRepeater(0);
        //news.DataSource = user.getData("select * from newsView  order by time desc");
        else if(newsType.SelectedValue == "相册")
            DataBindToRepeater(-1);
        //news.DataSource = user.getData("select * from newsView where type ='album'  order by time desc");
        else if (newsType.SelectedValue == "日志")
            DataBindToRepeater(-2);
        //news.DataSource = user.getData("select * from newsView where type ='journal'  order by time desc");
        else if (newsType.SelectedValue == "说说")
            DataBindToRepeater(-3);
        //news.DataSource = user.getData("select * from newsView where type ='twiter' order by time desc ");
        // news.DataBind();
        //DataBindToRepeater(1);

    }

    void DataBindToRepeater(int currentPage)
    {
        DataTable dt = new DataTable();
        string userLogin = Convert.ToString(Session["name"]);
        if (currentPage==0)
        {
            dt = user.getNews(userLogin, "");
            currentPage = 1;
        }
        else if (currentPage==-1)
        {
            
            dt = user.getNews(userLogin, "photo");
            currentPage = 1;
        }
        else if (currentPage==-2)
        {
            dt = user.getNews(userLogin, "journal");
            currentPage = 1;
        }
        else if(currentPage==-3)
        {
            dt = user.getNews(userLogin, "twitter");
            currentPage = 1;
        }
        else
        {
            if(newsType.SelectedValue=="所有动态")
                dt = user.getNews(userLogin, "");
            else if (newsType.SelectedValue == "相册")
                dt = user.getNews(userLogin, "album");
            else if (newsType.SelectedValue == "日志")
                dt = user.getNews(userLogin, "journal");
            else if (newsType.SelectedValue == "说说")
                dt = user.getNews(userLogin, "twitter");
        }
        

        PagedDataSource pds = new PagedDataSource();

        pds.AllowPaging = true;

        pds.PageSize = 5;

        pds.DataSource = dt.DefaultView;
       

        tolPage.Text = pds.PageCount.ToString();

        pds.CurrentPageIndex = currentPage - 1;//当前页数从零开始，故把接受的数减一

        news.DataSource = pds;
       

        news.DataBind();

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

    protected void reply2_ItemCommand(object source, RepeaterCommandEventArgs e)
    {

    }

    protected void reply2_ItemDataBound(object sender, RepeaterItemEventArgs e)
    {

    }

    protected void news_ItemDataBound(object sender, RepeaterItemEventArgs e)
    {
        if (e.Item.ItemType == ListItemType.Item || e.Item.ItemType == ListItemType.AlternatingItem)
        {
            string userLogin = Convert.ToString(Session["name"]);
            LinkButton thumbsUp = (LinkButton)e.Item.FindControl("btnThumbsUp");
            string id = thumbsUp.CommandArgument.ToString();
            string which = user.operate(0, 0, "select which from news where id =?", id);
            string type = user.operate(0, 0, "select type from news where id = ?", id);
            if(user.operate(-1,0,"select * from thumbsup where which =? and type =? and whoid like ?",which,type,"%,"+userLogin+",%")!="0")
            {
                thumbsUp.Text = "取消赞";
                thumbsUp.CommandName = "nogood";
            }
            

        }
    }
}