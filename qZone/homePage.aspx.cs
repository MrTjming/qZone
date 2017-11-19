using System;
using System.Collections.Generic;
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
        String loginID = Convert.ToString(Session["name"]);
        if(loginID=="")
            Response.Write("<script>alert('您还没有登录');window.location ='login.aspx'; </script>");
        else
        {
            string toID = Convert.ToString(Request.QueryString["id"]);
            if (toID == "")
            {
                watchID = loginID;
            }
            else watchID = toID;
            if(watchID!=loginID)
            {
                if (user.checkFriends(loginID, watchID) != 1)
                    Response.Write("<script>alert('你还不是对方的好友');window.location = 'homePage.aspx?id="+loginID+"; </script>");
                //else news.DataSource = user.getData(" ");
            }
        }
            

    }

    protected void news_ItemCommand(object source, RepeaterCommandEventArgs e)
    {

    }
}