using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class _Default : checkLogin //System.Web.UI.Page
{
    static users user = new users();
    protected void Page_Load(object sender, EventArgs e)
    {
        string userLogin = Convert.ToString(Session["name"]);
        string userid = Convert.ToString(Request.QueryString["id"]);
        if(userid != userLogin)//判断是否为本人
        {
            Response.Redirect("settingPage.aspx?id=" + userLogin);
        }
    }

    protected void btnSave_Click(object sender, EventArgs e)
    {
        string userLogin = Convert.ToString(Session["name"]);
         user.operate(-1, 0, "update userinfo set zonename=?,zoneintroduce=? where userid =?", Server.HtmlEncode(zoneName.Text), Server.HtmlEncode(zoneintroduce.Text), userLogin);
        Response.Redirect(Request.RawUrl);
    }
    protected void friendsList_Click(object sender, BulletedListEventArgs e)//添加好友至权限
    {
        ListItem newitem = new ListItem();
        newitem.Value = friendsList.Items[e.Index].Value;
        newitem.Text = friendsList.Items[e.Index].Text;
        addUsers.Items.Add(newitem);
        powertext.Text = powertext.Text + "," + friendsList.Items[e.Index].Value + ",";
        friendsList.Items.RemoveAt(e.Index);


    }

    protected void addUsers_Click(object sender, BulletedListEventArgs e)//从权限删除好友
    {
        ListItem newitem = new ListItem();
        newitem.Value = addUsers.Items[e.Index].Value;
        newitem.Text = addUsers.Items[e.Index].Text;
        friendsList.Items.Add(newitem);
        powertext.Text = System.Text.RegularExpressions.Regex.Replace(powertext.Text, "," + addUsers.Items[e.Index].Value + ",", "");
        addUsers.Items.RemoveAt(e.Index);

    }



    protected void RadioButton3_CheckedChanged(object sender, EventArgs e) //绑定好友数据
    {
        chosePower.Visible = true;
        friendsList.Items.Clear();
        addUsers.Items.Clear();
        powertext.Text = "";
        string userid = Convert.ToString(Session["name"]);
        DataTable newDataTable = user.getData("select nickname,id from friendview1 where user2=" + userid).Copy();
        foreach (DataRow dr in user.getData("select nickname,id from friendview2 where user1=" + userid).Rows)
        {
            newDataTable.ImportRow(dr);
        }
        friendsList.DataSource = newDataTable;
        friendsList.DataTextField = "nickname";
        friendsList.DataValueField = "id";
        friendsList.DataBind();

    }

    protected void RadioButton1_CheckedChanged(object sender, EventArgs e)
    {
        chosePower.Visible = false;
        
    }

    protected void RadioButton2_CheckedChanged(object sender, EventArgs e)
    {
        chosePower.Visible = false;
    }

    protected void btnSetPower_Click(object sender, EventArgs e)
    {
        setPower.Visible = !setPower.Visible;
        string visualType = user.operate(0, 0, "select visualtype from users where id =?", Convert.ToString(Session["name"]));
        switch (visualType)
        {
            case "all":RadioButton1.Checked = true;break;
            case "host":RadioButton2.Checked = true;break;
            case "allpower":RadioButton4.Checked = true;break;
            case "point": RadioButton3.Checked = true; break;
        }
        
    }

    protected void btnSavePower_Click(object sender, EventArgs e)//设置空间访问权限
    {
        string userLogin = Convert.ToString(Session["name"]);
        if (RadioButton1.Checked)//所有人可见
        {
            user.operate(-1, 0, "update users set visualtype = ? where id =?", "all", userLogin);
            
        }
        else if(RadioButton2.Checked)//仅自己可见
        {
            string visualId= user.operate(0, 0, "insert into usergroup (whose,visual,grouptype) values (?,?,?) select @@identity", userLogin, "," + userLogin + ",", "host");
            user.operate(-1, 0, "update users set visualtype =? ,visual=? where id =?", "host", visualId, userLogin);
        }
        else if(RadioButton3.Checked)//指定可见
        {
            string power =powertext.Text+","+userLogin+",";
            string visualId = user.operate(0, 0, "insert into usergroup (whose,visual,grouptype) values (?,?,?) select @@identity", userLogin, power, "power");
            user.operate(-1, 0, "update users set visualtype =? ,visual=? where id =?", "point", visualId, userLogin);
        }
        else if(RadioButton4.Checked)//仅好友可见
        {
            string allpower = user.operate(0, 0, "select visual from usergroup where whose=? and grouptype=?", userLogin, "allpower");
            string visualId = user.operate(0, 0, "insert into usergroup (whose,visual,grouptype) values (?,?,?) select @@identity", userLogin, allpower, "allpower");
            user.operate(-1, 0, "update users set visualtype =? ,visual=? where id =?", "allpower", visualId, userLogin);
        }
        Response.Redirect(Request.RawUrl);
    }

    protected void btnSetZone_Click(object sender, EventArgs e)
    {
        zoneSet.Visible = !zoneSet.Visible;
        zoneName.Text = user.operate(0, 0, "select zonename from userinfo where userid=?", Convert.ToString(Session["name"]));
        zoneintroduce.Text = user.operate(0, 0, "select zoneintroduce from userinfo where userid=?", Convert.ToString(Session["name"]));
    }
}