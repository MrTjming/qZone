using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class register : System.Web.UI.Page
{
    static users user = new users();
    protected void Page_Load(object sender, EventArgs e)
    {
    }


    protected void btnRegister_Click(object sender, EventArgs e)
    {
        string name = nameRegister.Text;
        string pwd = pwdRegister.Text;
        int quesid = Convert.ToInt32(quesIDlist.SelectedValue);
        string ans = ansRegister.Text;
        int check = 0;
        string validatecode = validate.Text;
        switch (user.checklegal(name))
        {
            case 1: tip1.Text = "帐号长度只能是6-20个字符!"; check = 1; break;
            case 2: tip1.Text = "帐号含有非法字符!"; check = 1; break;
            case 0: tip1.Text = ""; break;
        }
        if (check == 0)
            switch (user.checklegal(pwd))
            {
                case 1: tip2.Text = "密码长度只能是6-20个字符!"; check = 1; break;
                case 2: tip2.Text = "密码含有非法字符!')</script>"; check = 1; break;
                case 0: tip2.Text = ""; break;
            };

        if (check == 0 && pwdRegister.Text != pwdAgain.Text)
        {
            tip3.Text = "两次输入的密码不一样!";
            check = 1;
        }
        else tip3.Text = "";
        if (check == 0 && ansRegister.Text == "")
        {
            tip5.Text = "密保答案不能为空!";
            check = 1;
        }
        else tip5.Text = "";
        if (check == 0 && validatecode != Convert.ToString(Session["CheckCode"]))
        {
            tip4.Text = "验证码错误!";
            check = 1;
        }
        else tip4.Text = "";
        if (check == 0)
            if (user.operateData("select * from Users where name = '" + name + "'", -1, 0) == "1")
                tip1.Text = "该帐号已被注册!";

            else
            {
                tip1.Text = "";
                pwd = user.MD5Encrypt32("(*#&#"+pwd+"(@(*", 32);
                user.operateData("insert into users (name,pwd,quesid,ans,type,nickname,sex,age,introduce) values('" + name + "','" + pwd + "','" + quesid + "','" + ans + "',0,'保密','保密','保密','保密')", -1, 0);
                string userid = user.operateData("select id from users where name ='" + name + "'", 0, 0);
                user.operateData("insert into userInfo (userid) values('" + userid + "')",-1,0);
                nameRegister.Text = "";
                pwdRegister.Text = "";
                Response.Write("<script>alert('注册成功!跳到登录界面');window.location = 'login.aspx'; </script>");

            }


    }





    protected void pwdAgain_TextChanged(object sender, EventArgs e)
    {
        string pwd1 = pwdRegister.Text;
        string pwd2 = pwdAgain.Text;
        if (pwd2 != pwd1)
            tip3.Visible = true;
        else tip3.Visible = false;
    }
}