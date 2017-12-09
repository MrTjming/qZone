using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class qZoneTop : System.Web.UI.MasterPage
{
    
    static users user = new users();
    protected void Page_Load(object sender, EventArgs e)
    {
        
        string userLogin = Convert.ToString(Session["name"]);
        string userid= Convert.ToString(Request.QueryString["id"]);
        if(!IsPostBack)
        {
            whoseZone.Text = user.operate(0, 0, "select nickname from users where id =?", userid);
            //menu.Text = user.operate(0, 0, "select nickname from users where id =?", userLogin);
            zoneName.Text = user.operate(0, 0, "select zonename from userinfo where userid =?", userid);
            introduce.Text = user.operate(0, 0, "select zoneintroduce from userinfo where userid =?", userid);
        }
        
    }

    protected void menu_Click(object sender, EventArgs e)
    {
       
        string userid = Convert.ToString(Session["name"]);
        if (userid == "")
        {
            Response.Write("<script>alert('您还没有登录');window.location = 'login.aspx'; </script>");
        }
        else Response.Redirect("homePage.aspx?id=" + userid);
        
    }

    protected void logout_Click(object sender, EventArgs e)
    {
        string name = Convert.ToString(Session["name"]);
        if (name == "")
        {
            Response.Write("<script>alert('您还没有登录');window.location = 'login.aspx'; </script>");
        }
        else
        {
            Session["name"] = "";
            HttpContext.Current.Response.Cookies["uName"].Expires = DateTime.Now.AddSeconds(-1);//使cookies过期
            HttpContext.Current.Response.Cookies["uCode"].Expires = DateTime.Now.AddSeconds(-1);
            Response.Redirect("login.aspx");
        }
        
    }

    protected void btnuserInfoPage_Click(object sender, EventArgs e)
    {
       string userid = Convert.ToString(Request.QueryString["id"]);
        if (userid == "")
        {
            userid = Convert.ToString(Session["name"]);
            if (userid == "")
                Response.Write("<script>alert('您还没有登录');window.location = 'login.aspx'; </script>");
            else Response.Redirect("homePage.aspx?id=" + userid);
        }
        else Response.Redirect("userInfoPage.aspx?id=" + userid);
    }

    protected void myFriends_Click(object sender, EventArgs e)
    {
        string userid = Convert.ToString(Session["name"]);
        if (userid == "")
        {
             Response.Write("<script>alert('您还没有登录');window.location = 'login.aspx'; </script>");
        }
        else Response.Redirect("myFriends.aspx?id=" + userid);
        
    }

    protected void btnMsgBoard_Click(object sender, EventArgs e)
    {
        string userid = Convert.ToString(Request.QueryString["id"]);
        if (userid == "")
        {
            userid = Convert.ToString(Session["name"]);
            if (userid == "")
                Response.Write("<script>alert('您还没有登录');window.location = 'login.aspx'; </script>");
            else Response.Redirect("homePage.aspx?id=" + userid);
        }
        else Response.Redirect("msgBoardPage.aspx?id=" + userid);

    }

    protected void btnAlbum_Click(object sender, EventArgs e)
    {
        string userid = Convert.ToString(Request.QueryString["id"]);
        if (userid == "")
        {
            userid = Convert.ToString(Session["name"]);
            if (userid == "")
                Response.Write("<script>alert('您还没有登录');window.location = 'login.aspx'; </script>");
            else Response.Redirect("homePage.aspx?id=" + userid);
        }
        else Response.Redirect("photoPage.aspx?id=" + userid);
    }

    protected void btnJournal_Click(object sender, EventArgs e)
    {
        string userid = Convert.ToString(Request.QueryString["id"]);
        if (userid == "")
        {
            userid = Convert.ToString(Session["name"]);
            if (userid == "")
                Response.Write("<script>alert('您还没有登录');window.location = 'login.aspx'; </script>");
            else Response.Redirect("homePage.aspx?id=" + userid);
        }
        else Response.Redirect("journalPage.aspx?id=" + userid);
    }

    protected void btnTwitter_Click(object sender, EventArgs e)
    {
        string userid = Convert.ToString(Request.QueryString["id"]);
        if (userid == "")
        {
            userid = Convert.ToString(Session["name"]);
            if (userid == "")
                Response.Write("<script>alert('您还没有登录');window.location = 'login.aspx'; </script>");
            else Response.Redirect("homePage.aspx?id=" + userid);
        }
        else Response.Redirect("twitterPage.aspx?id=" + userid);
    }

    protected void setting_Click(object sender, EventArgs e)
    {
        string userid = Convert.ToString(Session["name"]);
        if (userid == "")
        {
            Response.Write("<script>alert('您还没有登录');window.location = 'login.aspx'; </script>");
        }
        else Response.Redirect("settingPage.aspx?id=" + userid);
    }
}
