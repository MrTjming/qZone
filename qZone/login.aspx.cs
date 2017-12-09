using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class loginn : System.Web.UI.Page
{
    static users user = new users();
    protected void Page_Load(object sender, EventArgs e)
    {
        string txt = Convert.ToString(Session["name"]);
        if (txt != "")//若已经登录账号则转至登录界面
        {
            Response.Redirect("homePage.aspx?id=" + txt);
        }
        else
        if (!IsPostBack)
        {
            nameLogin.Text = "";
            pwdLogin.Text = "";
            validate.Text = "";
            if (HttpContext.Current.Request.Cookies["uName"] != null && HttpContext.Current.Request.Cookies["uCode"] != null) // 如果这个uname cookie 不为空
            {
                string userName = HttpContext.Current.Request.Cookies["uName"].Value.ToString();// 提取cookie
                string userCode = HttpContext.Current.Request.Cookies["uCode"].Value.ToString();

                string check1 = user.operate(-1, 0, "select checkcode from users where name =? and checkcode =?", userName, userCode);
                if (check1 == "1")
                {
                    String userid = user.operate(0, 0, "select id from users where name=?", userName);//user.operateData("select id from users where name='" + userName + "'", 0, 0);
                    Session["name"] = userid;
                    HttpCookie uCode = new HttpCookie("uCode");
                    string code = Guid.NewGuid().ToString(); // 随机数
                    uCode.Value = code;
                    uCode.Expires = DateTime.Now.AddDays(7);
                    HttpContext.Current.Response.Cookies.Add(uCode);
                    user.operate(-1, -0, "update users set checkcode =? where name =?", code, Server.HtmlEncode(userName));
                    Response.Redirect("homePage.aspx?id=" + userid);
                }
            }
        }
    }
    protected void btnLogin_Click(object sender, EventArgs e)
    {
        string name = nameLogin.Text;
        string pwd = pwdLogin.Text;
        int check = 0;
        string validatecode = validate.Text;
        switch (user.checklegal(name))
        {
            case 1: Response.Write("<script>alert('帐号长度只能是6-20个字符!')</script>"); check = 1; break;
            case 2: Response.Write("<script>alert('帐号含有非法字符!')</script>"); check = 1; break;
            case 0: break;
        }
        if (check == 0)
            switch (user.checklegal(pwd))
            {
                case 1: Response.Write("<script>alert('密码长度只能是6-20个字符!')</script>"); check = 1; break;
                case 2: Response.Write("<script>alert('密码含有非法字符!')</script>"); check = 1; break;
                case 0: break;
            };
        if (check == 0 && validatecode != Convert.ToString(Session["CheckCode"]))
        {
            Response.Write("<script>alert('验证码错误!')</script>");
            check = 1;
        }
        if (check == 0)
        {

            string result1 = user.operate(-1, 0, "select * from Users where name =?", name);//user.operateData("select * from Users where name = '" + name + "'", -1, 0);

            if (result1 == "0")
                Response.Write("<script>alert('帐号不存在!')</script>");
            else
            {
                pwd = user.MD5Encrypt32("~!@#$%^&*()_+" + pwd + "+_)(*&^%$#@!~", 32);
                if (user.operate(-1, 0, "select * from Users where name =? and pwd =?", name, pwd) == "0")
                    Response.Write("<script>alert('密码错误!')</script>");
                else
                {

                    if (autologin.Checked == true)
                    {
                        HttpCookie uName = new HttpCookie("uName"); // 创建一个名为uname的cookie
                        HttpCookie uCode = new HttpCookie("uCode");
                        uName.Expires = DateTime.Now.AddDays(7); // 设置该cookie的有效时间
                        uCode.Expires = DateTime.Now.AddDays(7); // 设置该cookie的有效时间
                        uName.Value = nameLogin.Text; // 给cookie赋值(也就是你想保存的账号，或者密码)
                        string code = Guid.NewGuid().ToString(); // 随机数
                        uCode.Value = code;
                        user.operate(-1, 0, "update users set checkcode =? where name =?", code, nameLogin.Text);
                        HttpContext.Current.Response.Cookies.Add(uName); // 提交cookie
                        HttpContext.Current.Response.Cookies.Add(uCode); 
                    }
                    String userid = user.operate(0, 0, "select id from users where name=?", name);
                    Session["name"] = userid;
                    Response.Write("<script language=javascript>alert('登陆成功');window.location = 'homePage.aspx?id=" + userid + "';</script>");

                }

            }


        }
    }//登录按钮事件


}