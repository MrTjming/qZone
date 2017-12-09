using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class getBackPwd : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {

    }
    static users user = new users();
    protected void btnRegister_Click(object sender, EventArgs e)
    {

    }

    protected void next1_Click(object sender, EventArgs e)
    {
        string name = nameGetBack.Text;
        int check = Convert.ToInt32(user.operate(-1, 0, "select * from users where name =?", name));
        int num = Convert.ToInt32(user.operate(0, 0, "select quesid from users where name =?", name));
        if (check == 0)
            Response.Write("<script>alert('用户不存在!')</script>");
        else
        {
            ques.Visible = true;
            text1.Visible = false;
            nextChange.Visible = false;
            validatePage.Visible = true;
            switch (num)
            {
                case 0: question.Text = "你的第一个宠物的名称？"; break;
                case 1: question.Text = "你最喜欢去的地方？"; break;
                case 2: question.Text = "你高中班主任的名字？"; break;
                case 3: question.Text = "你最喜欢的颜色？"; break;
                case 4: question.Text = "你父亲的名字？"; break;
                case 5: question.Text = "你母亲的名字？"; break;
                case 6: question.Text = "你第一个手机号是什么？"; break;
            }
            next1.Visible = false;
            next2.Visible = true;
        }
    }

    protected void next2_Click(object sender, EventArgs e)
    {
        string name = nameGetBack.Text;
        string ans = answer.Text;
        if (ans == "")
            Response.Write("<script>alert('密保答案不能为空!')</script>");
        else
        {
            int num = Convert.ToInt32(user.operate(-1, 0, "select * from users where name =? and ans=?", name, ans));
            if (validate1.Text != Convert.ToString(Session["CheckCode"]))
            {
                Response.Write("<script>alert('验证码错误!')</script>");
                validate1.Text = "";
            }
            else if (num == 0)
            {
                Response.Write("<script>alert('密保答案错误!')</script>");
            }
            else
            {
                pageChange.Visible = true;
                ques.Visible = false;
            }
        }


    }

    protected void changgeNext1_Click(object sender, EventArgs e)
    {
        string name = nameGetBack.Text;
        int check = Convert.ToInt32(user.operate(-1, 0, "select * from users where name =?", name));
        int num = Convert.ToInt32(user.operate(0, 0, "select quesid from users where name =?", name));
        if (check == 0)
            Response.Write("<script>alert('用户不存在!')</script>");
        else
        {
            pageGetBack.Visible = false;
            text2.Visible = false;
            pageChange1.Visible = true;
            pageChange.Visible = true;
            changgeNext1.Visible = false;
            validatePage.Visible = true;
        }
    }

    protected void fresh1_Click(object sender, EventArgs e) //刷新验证码按钮1
    {
        validateImage1.ImageUrl = "~/ValidateCode.aspx";
    }

    protected void fresh2_Click(object sender, EventArgs e)//刷新验证码按钮2
    {
        validateImage2.ImageUrl = "~/ValidateCode.aspx";
    }


    protected void btnChange_Click(object sender, EventArgs e)//修改密码按钮
    {
        string name = Server.HtmlEncode(nameGetBack.Text);
        string oldPassword = Server.HtmlEncode(oldPwd.Text);
        string newPassword1 = Server.HtmlEncode(newPwd1.Text);
        oldPassword = user.MD5Encrypt32("~!@#$%^&*()_+"+oldPassword+"+_)(*&^%$#@!~", 32);
        int num = Convert.ToInt32(user.operate(-1, 0, "select * from users where name =? and pwd =?", name, oldPassword));
        if(user.checklegal(newPwd1.Text)!=0)
        {
            Response.Write("<script>alert('密码不合法!')</script>");
        }
        else
        if (newPwd1.Text != newPwd2.Text)
        {
            Response.Write("<script>alert('两次密码不一样!')</script>");
        }
        else
            if (pageChange1.Visible == true)
        {
            switch (num)
            {
                case 1:
                    newPassword1 = user.MD5Encrypt32("~!@#$%^&*()_+" + newPassword1 + "+_)(*&^%$#@!~", 32);
                    user.operate(-1, 0, "UPDATE users SET pwd =?  where name =?", newPassword1, name);
                    Response.Write("<script language=javascript>alert('修改成功，返回登录界面！');window.location = 'login.aspx';</script>"); break;
                case 0: Response.Write("<script>alert('原密码错误!')</script>"); break;
            }
        }
        else
        {
            newPassword1 = user.MD5Encrypt32("~!@#$%^&*()_+" + newPassword1 + "+_)(*&^%$#@!~", 32);
            user.operate(-1, 0, "UPDATE users SET pwd =?  where name =?", newPassword1, name);
            Response.Write("<script language=javascript>alert('修改成功，返回登录界面！');window.location = 'login.aspx';</script>");

        }

    }

    protected void fresh3_Click(object sender, EventArgs e)
    {
        checkPhoto.ImageUrl = "~/ValidateCode.aspx";
    }

    protected void next_Click(object sender, EventArgs e)
    {
        string name = nameGetBack.Text;
        if (name == "")
        {
            Response.Write("<script>alert('用户名不能为空!')</script>");
        }
        else if (user.checklegal(name) == 1)
            Response.Write("<script>alert('用户名长度不合法!')</script>");
        else if (user.checklegal(name) == 2)
            Response.Write("<script>alert('用户名不能含有非法字符!')</script>");
        else if (user.checklegal(name) == 0)
        {
            int check = Convert.ToInt32(user.operate(-1, 0, "select * from users where name=?", name));
            string txt = checkNum.Text;
            int judge = 0;
            if (txt != Convert.ToString(Session["CheckCode"]))
            { Response.Write("<script>alert('验证码错误!')</script>"); judge = 1; }
            if (check == 0 && judge == 0)
            { Response.Write("<script>alert('用户不存在!')</script>"); judge = 1; }
            if (judge == 0)
            {
                page1.Visible = false;
                nextChange.Visible = true;
                pageGetBack.Visible = true;
                nameGetBack.ReadOnly = true;
            }
        }



    }
}