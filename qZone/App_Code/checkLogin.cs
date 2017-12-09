using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

/// <summary>
/// checkLogin 的摘要说明
/// </summary>
public class checkLogin : System.Web.UI.Page
{
    static users user = new users();
    
    public checkLogin()
    {
        
    }

    protected override void OnPreInit(EventArgs e) //OnPreInit
    {
        
        base.OnPreInit(e);
        if (Session["name"] == null||Session["name"].ToString()=="")//判断session是否存在
        {
            Response.Redirect("login.aspx");
            return;
        }
        if(Convert.ToString(Request.QueryString["id"]) == ""||Request.QueryString["id"]==null) //判断问号传值是否存在
        {
            Response.Redirect(Request.RawUrl + "?id=" + Session["name"]);
            return;
        }
        try
        {
            int id= Convert.ToInt32(Request.QueryString["id"]);//防止非法字符输入
            if(id>999999999||id<=0)//防止溢出
                Response.Redirect("error.aspx");
            else
                if(user.operate(-1,0,"select * from users where id =?",id)=="0")
                Response.Redirect("error.aspx");

        }
        catch
        {
            Response.Redirect("error.aspx");
        }
        if(user.operate(0,0,"select visualtype from users where id =?", Convert.ToString(Request.QueryString["id"]))!="all")
        {
            if (Convert.ToString(Request.QueryString["id"]) != Convert.ToString(Session["name"]))
            {
                string userID = Convert.ToString(Request.QueryString["id"]);
                string userLogin = Convert.ToString(Session["name"]);
                string visualId = user.operate(0, 0, "select visual from users where id =?", userID);
                if(user.operate(-1,0,"select * from usergroup where id =? and visual like ?",visualId,"%,"+userLogin+",%")=="0")
                {
                    Response.Write("<script language=javascript>alert('您没有权限访问对方的空间');window.location = 'homePage.aspx?id=" + Convert.ToString(Session["name"]) + "';</script>");
                }
            }
        }

        


            //if(Convert.ToString(Request.QueryString["id"])!="" && Convert.ToString(Request.QueryString["id"])!=Convert.ToString( Session["name"]) && user.checkFriends(Convert.ToString(Session["name"]), Convert.ToString(Request.QueryString["id"]))==0)
            //{
            //    //判断好友关系
            //    Response.Write("<script language=javascript>alert('你还不是对方的好友');window.location = 'homePage.aspx?id=" + Convert.ToString(Session["name"]) + "';</script>");
            //    return;
            //}

            base.OnPreInit(e);
    }
}