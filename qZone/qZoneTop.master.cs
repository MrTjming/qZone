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

        string name = Convert.ToString(Session["name"]);
        if (name != "")
             uNAME.Text = name;
        whoseZone.Text= Convert.ToString(Request.QueryString["id"]);

    }

    protected void menu_Click(object sender, EventArgs e)
    {
        string userid = Convert.ToString(Session["name"]);
        //String userid = user.operateData("select id from users where name='" + name + "'", 0, 0);
        if (userid == "")
        {
            Response.Write("<script>alert('您还没有登录');window.location = 'login.aspx'; </script>");
        }
        else Response.Redirect("homePage.aspx?id="+userid);
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
            HttpContext.Current.Response.Cookies["uName"].Expires = DateTime.Now.AddSeconds(-1);
            HttpContext.Current.Response.Cookies["uCode"].Expires = DateTime.Now.AddSeconds(-1);
            Response.Redirect("login.aspx");
        }
        
    }

    protected void btnPersonalInfo_Click(object sender, EventArgs e)
    {
        string userid = Convert.ToString(Session["name"]);
        //String userid = user.operateData("select id from users where name='" + name + "'", 0, 0);
        if (userid == "")
        {
            Response.Write("<script>alert('您还没有登录');window.location = 'login.aspx'; </script>");
        }
        else Response.Redirect("personalInfo.aspx?id=" + userid);

    }

    protected void myFriends_Click(object sender, EventArgs e)
    {
        string userid = Convert.ToString(Session["name"]);
        //String userid = user.operateData("select id from users where name='" + name + "'", 0, 0);
        if (userid == "")
        {
            Response.Write("<script>alert('您还没有登录');window.location = 'login.aspx'; </script>");
        }
        else Response.Redirect("myFriends.aspx?id=" + userid);
        
    }
}
