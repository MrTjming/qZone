using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class registe : System.Web.UI.Page
{
    static users user = new users();
    protected void Page_Load(object sender, EventArgs e)
    {

    }
    protected void btnRegister_Click(object sender, EventArgs e)
    {
        string name = Server.HtmlEncode(nameRegister.Text);
        string pwd = Server.HtmlEncode(pwdRegister.Text);
        int quesid = Convert.ToInt32(quesIDlist.SelectedValue);
        string ans = Server.HtmlEncode(ansRegister.Text);
        int check = 0;
        string validatecode = Server.HtmlEncode(validate.Text);
        switch (user.checklegal(name))
        {
            case 1: tip1.Text = "帐号长度只能是6-20个字符!"; check = 1; break;
            case 2: tip1.Text = "帐号含有非法字符!"; check = 1; break;
            case 0: tip1.Text = ""; break;
        }
        if(check==0)
        switch(user.checkNum(nicknameRegister.Text,1,20))
        {
                case 0:tip6.Text = "昵称长度不合法";check = 1;break;
                case 1:tip6.Text=""; break;

        }
        if (check == 0)
            switch (user.checklegal(pwd))
            {
                case 1: tip2.Text = "密码长度只能是6-20个字符!"; check = 1; break;
                case 2: tip2.Text = "密码含有非法字符!')</script>"; check = 1; break;
                case 0: tip2.Text = ""; break;
            }
        if(check==0)
            switch(user.checkNum(ansRegister.Text,1,50))
            {
                case 0:tip5.Text = "答案长度不能超过50个字符";check = 1;break;
                case 1:tip5.Text = "";break;
            }
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
                if (user.operate(-1, 0, "select * from users where name =?", name) == "1") 
                    tip1.Text = "该帐号已被注册!";
                else
                {
                    tip1.Text = "";
                    pwd = user.MD5Encrypt32("~!@#$%^&*()_+" + pwd + "+_)(*&^%$#@!~", 32);
                    string userid =user.operate(0, 0, "insert into users (name,pwd,quesid,ans,nickname) values(?,?,?,?,?) select @@identity", name, pwd, quesid, ans, nicknameRegister.Text);
                    
                    string userinfoId= user.operate(0, 0, "insert into userInfo (userid) values (?) select @@identity", userid);//创建个人档案
                user.operate(-1, 0, "insert into thumbsup (which,type) values (?,?)", userinfoId, "userinfo");//创建个人档案的点赞管理
                    string allpowerID = user.operate(0, 0, "insert into usergroup (whose,grouptype,visual) values (?,?,?) select @@identity", userid, "allpower",","+userid+",");//创建所有好友表
                    user.operate(-1, 0, "insert into usergroup (whose,grouptype,name,visual) values (?,?,?,?)", userid, "journal", "个人日记",allpowerID);//创建默认日志分类
                    user.operate(-1, 0, "insert into usergroup (whose,grouptype,name,visual,extra) values (?,?,?,?,?)", userid, "album", "我的相册",allpowerID, "Photos/nophoto.png");//创建默认相册分类
                    string twitterId = user.operate(0, 0, "insert into twitter (whose,time ,text,visual) values (?,?,?,?) select @@identity", userid, DateTime.Now.ToString(), "我加了qq空间啦........", allpowerID);
                user.operate(-1, 0, "insert into thumbsup (which,type) values (?,?)", twitterId, "twitter");//创建上条说说的点赞管理
                user.operate(-1, 0, "insert into news (time,type,whose,extra,display,which) values (?,?,?,?,?,?)", DateTime.Now.ToString(), "twitter", userid,"我加了qq空间啦........",allpowerID,twitterId);//发个推
                
                    nameRegister.Text = "";
                    pwdRegister.Text = "";
                    Response.Write("<script language=javascript>alert('注册成功!跳到登录界面');window.location = 'login.aspx';</script>");

                }
        
        
    }
}