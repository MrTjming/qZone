using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
public partial class _default : checkLogin
{
    static users user = new users();
    protected void Page_Load(object sender, EventArgs e)
    {
        string userLogin = Convert.ToString(Session["name"]);
        if (!IsPostBack)
        {

            DataTable newDataTable = user.getData("select nickname,id from friendview1 where user2=" + userLogin).Copy();//搜索表
            foreach (DataRow dr in user.getData("select nickname,id from friendview2 where user1=" + userLogin).Rows)//叠加搜索的信息
            {
                newDataTable.ImportRow(dr);
            }
            DataBindToRepeater(1, "friend", newDataTable);
            int applynum = Convert.ToInt32(user.operate(-1, 0, "select * from applyFriend where towho=" + userLogin));
            if (applynum > 0)
            {
                tip2.Visible = true;
                tip2.Text = "您有" + applynum + "条好友申请。点击查看";
                applyList.DataSource = user.getData("select * from applyFriend where towho=" + userLogin);
                applyList.DataBind();
            }
        }

    }


    protected void list_ItemCommand(object source, RepeaterCommandEventArgs e)
    {
        if (e.CommandName == "btnAdd")
        {
            string user1id = Convert.ToString(Session["name"]);
            string user2id = Convert.ToString(e.CommandArgument.ToString());
            if (user.checkFriends(user2id, user1id) == 0)
            {
                
                if (Convert.ToInt32(user.operate(-1, 0, "select * from applyfriend where fromwho=? and towho=?", user1id, user2id)) == 0)
                {
                    string time = DateTime.Now.ToString();
                    user.operate(-1, 0, "insert into applyfriend (fromwho,towho,fromname,time) values (?,?,?,?)", user1id, user2id, user.operate(0, 0, "select nickname from users where id =?", user1id), time);//添加到申请表
                    Response.Write("<script>alert('添加申请已发送！'); </script>");
                }
                else Response.Write("<script>alert('你已经发出了好友申请，不能重复发出！'); </script>");
            }
            else Response.Write("<script>alert('你和该用户已经是好友了'); </script>");

        }
        if (e.CommandName == "btnWatch")
        {
            string userid = Convert.ToString(e.CommandArgument.ToString());
            Response.Redirect("journalPage.aspx?id=" + userid);
        }
    }
    void DataBindToRepeater(int currentPage, string which, DataTable newDataTable)
    {
        string userLogin = Convert.ToString(Session["name"]);
        PagedDataSource pds = new PagedDataSource();
        pds.AllowPaging = true;
        pds.PageSize = 5;
        pds.DataSource = newDataTable.DefaultView;
        tolPage.Text = pds.PageCount.ToString();
        pds.CurrentPageIndex = currentPage - 1;//当前页数从零开始，故把接受的数减一
        if (which == "friend")
        {
            friends.DataSource = pds;
            friends.DataBind();
        }
        else if (which == "list")
        {
            list.DataSource = pds;
            list.DataBind();
        }





    } //分页管理函数

    protected void btnSearch_Click(object sender, EventArgs e) //检索按钮函数
    {
        recordText.Text = Server.HtmlEncode(textSearch.Text);
        string userLogin = Convert.ToString(Session["name"]);
        if (searchType.SelectedValue == "用户名")
        {
            string searchNum = user.operate(-1, 0, "select * from userInfoView where name like ? and id !=?", "%" + recordText.Text + "%", userLogin);
            recordType.Text = "name";
            DataTable newDataTable = user.getData("select * from userInfoView where name like " + "'%" + recordText.Text + "%' and id!=" + userLogin).Copy();
            DataBindToRepeater(1, "list", newDataTable);
            if (searchNum != "0")
            {
                tip1.Text = "总共检索到相关用户" + searchNum + "个";
            }
            else
            {
                tip1.Text = "没有检索到相关用户！";
            }

        }
        else if (searchType.SelectedValue == "昵称")
        {
            string searchNum = user.operate(-1, 0, "select * from userInfoView where nickname like ?", "%" + recordText.Text + "%");
            recordType.Text = "nickname";
            DataTable newDataTable = user.getData("select * from userInfoView where nickname like " + "'%" + recordText.Text + "%'").Copy();
            DataBindToRepeater(1, "list", newDataTable);
            if (searchNum != "0")
            {
                tip1.Text = "总共检索到相关用户" + searchNum + "个";

            }
            else
            {
                tip1.Text = "没有检索到相关用户！";
            }

        }
    }
    protected void up_Click(object sender, EventArgs e)//上一页
    {
        string NowPage = nowPage.Text;
        int ToPage = Convert.ToInt32(NowPage) - 1;
        string userLogin = Convert.ToString(Session["name"]);
        if (ToPage > 0)
        {
            nowPage.Text = Convert.ToString(ToPage);
            if (searchPage.Visible == true)
            {
                DataTable newDataTable = user.getData("select * from userInfoView where " + recordType.Text + " like " + "'%" + recordText.Text + "%' and id !=" + userLogin).Copy();
                DataBindToRepeater(ToPage, "list", newDataTable);
            }
            else if (friendList.Visible == true)
            {

                DataTable newDataTable = user.getData("select nickname,id from friendview1 where user2=" + userLogin).Copy();
                foreach (DataRow dr in user.getData("select nickname,id from friendview2 where user1=" + userLogin).Rows)
                {
                    newDataTable.ImportRow(dr);
                }
                DataBindToRepeater(ToPage, "friend", newDataTable);
            }


        }
        else Response.Write("<script>alert('已经到顶页了!')</script>");
    }

    protected void firstPage_Click(object sender, EventArgs e)//首页
    {
        nowPage.Text = "1";
        if (searchPage.Visible == true)
        {
            string userLogin = Convert.ToString(Session["name"]);
            DataTable newDataTable = user.getData("select * from userInfoView where " + recordType.Text + " like " + "'%" + recordText.Text + "%' and id !=" + userLogin).Copy();
            DataBindToRepeater(1, "list", newDataTable);

        }
        else if (friendList.Visible == true)
        {
            string userLogin = Convert.ToString(Session["name"]);
            DataTable newDataTable = user.getData("select nickname,id from friendview1 where user2=" + userLogin).Copy();
            foreach (DataRow dr in user.getData("select nickname,id from friendview2 where user1=" + userLogin).Rows)
            {
                newDataTable.ImportRow(dr);
            }
            DataBindToRepeater(1, "friend", newDataTable);
        }
    }

    protected void endPage_Click(object sender, EventArgs e)//尾页的
    {
        nowPage.Text = tolPage.Text;
        if (searchPage.Visible == true)
        {
            string userLogin = Convert.ToString(Session["name"]);
            DataTable newDataTable = user.getData("select * from userInfoView where " + recordType.Text + " like " + "'%" + recordText.Text + "%' and id !=" + userLogin).Copy();
            DataBindToRepeater(Convert.ToInt32(tolPage.Text), "list", newDataTable);
        }
        else if (friendList.Visible == true)
        {
            string userLogin = Convert.ToString(Session["name"]);
            DataTable newDataTable = user.getData("select nickname,id from friendview1 where user2=" + userLogin).Copy();
            foreach (DataRow dr in user.getData("select nickname,id from friendview2 where user1=" + userLogin).Rows)
            {
                newDataTable.ImportRow(dr);
            }
            DataBindToRepeater(Convert.ToInt32(tolPage.Text), "friend", newDataTable);
        }
    }
    protected void down_Click(object sender, EventArgs e)//下一页
    {
        string NowPage = nowPage.Text;
        int ToPage = Convert.ToInt32(NowPage) + 1;
        string userLogin = Convert.ToString(Session["name"]);
        if (ToPage <= Convert.ToInt32(tolPage.Text))
        {
            nowPage.Text = Convert.ToString(ToPage);
            if (searchPage.Visible == true)
            {
                DataTable newDataTable = user.getData("select * from userInfoView where " + recordType.Text + " like " + "'%" + recordText.Text + "%' and id !=" + userLogin).Copy();
                DataBindToRepeater(ToPage, "list", newDataTable);
            }
            else if (friendList.Visible == true)
            {

                DataTable newDataTable = user.getData("select nickname,id from friendview1 where user2=" + userLogin).Copy();
                foreach (DataRow dr in user.getData("select nickname,id from friendview2 where user1=" + userLogin).Rows)
                {
                    newDataTable.ImportRow(dr);
                }
                DataBindToRepeater(ToPage, "friend", newDataTable);
            }

        }
        else Response.Write("<script>alert('已经到底页了!')</script>");

    }


    protected void btnTurn_Click(object sender, EventArgs e) //跳转
    {
        int num = Convert.ToInt32(nowPage.Text);
        if (num > 0 && num <= Convert.ToInt32(tolPage.Text))
        {
            string userLogin = Convert.ToString(Session["name"]);
            if (searchPage.Visible == true)
            {
                DataTable newDataTable = user.getData("select * from userInfoView where " + recordType.Text + " like " + "'%" + recordText.Text + "%' and id !=" + userLogin).Copy();
                DataBindToRepeater(num, "list", newDataTable);
            }
            else if (friendList.Visible == true)
            {

                DataTable newDataTable = user.getData("select nickname,id from friendview1 where user2=" + userLogin).Copy();
                foreach (DataRow dr in user.getData("select nickname,id from friendview2 where user1=" + userLogin).Rows)
                {
                    newDataTable.ImportRow(dr);
                }
                DataBindToRepeater(num, "friend", newDataTable);
            }
        }
        else Response.Write("<script>alert('没有该页面!')</script>");
    }

    protected void toAddFriend_Click(object sender, EventArgs e)
    {
        friendList.Visible = false;
        searchPage.Visible = true;
        string userLogin = Convert.ToString(Session["name"]);
        DataTable newDataTable = user.getData("select * from userInfoView where id !=" + userLogin).Copy();
        DataBindToRepeater(1, "list", newDataTable);
        string num = user.operate(-1, 0, "select * from users where id !=?", userLogin);
        tip1.Text = "空间目前还有" + num + "个用户";
    }

    protected void applyList_ItemCommand(object source, RepeaterCommandEventArgs e)
    {
        string id = Convert.ToString(e.CommandArgument.ToString());
        if (e.CommandName == "agree") //同意添加
        {
            string time = DateTime.Now.ToString();
            string user1 = user.operate(0, 0, "select fromwho from applyFriend where id=" + id);
            string user2 = Convert.ToString(Session["name"]);
            user.operate(-1, 0, "insert into friends (user1,user2,time) values (?,?,?)", user1, user2, time);//加入好友表
            user.operate(-1, 0, "delete from applyFriend where id =" + id);//删除申请信息
            string allpower = user.operate(0, 0, "select visual from usergroup where grouptype='allpower' and whose =?", user2);
            user.operate(-1, 0, "update usergroup set visual = ? where grouptype='allpower' and whose =?", allpower + "," + user1 + ",", user2);//在用户2的所有好友权限表加入用户1
            allpower = user.operate(0, 0, "select visual from usergroup where grouptype='allpower' and whose =?", user1);
            user.operate(-1, 0, "update usergroup set visual = ? where grouptype='allpower' and whose =?", allpower + "," + user2 + ",", user1);//在用户1的所有好友权限表加入用户2
            Response.Write("<script>alert('操作成功！'); </script>");
            Response.Redirect(Request.Url.ToString());
        }
        if (e.CommandName == "disagree")//拒绝添加
        {
            user.operate(-1, 0, "delete from applyFriend where id =" + id);
            Response.Write("<script>alert('操作成功！'); </script>");
            Response.Redirect(Request.Url.ToString());
        }
    }


    protected void friends_ItemCommand(object source, RepeaterCommandEventArgs e)
    {
        string userLogin = Convert.ToString(Session["name"]);
        string id = Convert.ToString(e.CommandArgument.ToString());
        if (e.CommandName == "watch")
        {
            Response.Redirect("journalPage.aspx?id=" + id);//跳转好友空间页面
        }
        if (e.CommandName == "del")
        {
            user.operate(-1, 0, "delete from friends where user1 =? and user2=?", id, userLogin);//删除好友表
            user.operate(-1, 0, "delete from friends where user1 =? and user2=?", userLogin, id);//删除好友表
            string allpower = user.operate(0, 0, "select visual from usergroup where whose=? and grouptype='allpower'", userLogin);
            allpower = System.Text.RegularExpressions.Regex.Replace(allpower, "," + id + ",", ""); //从权限表中删除
            user.operate(-1, 0, "update usergroup set visual = ? where whose=? and grouptype='allpower'", allpower, userLogin);

            allpower = user.operate(0, 0, "select visual from usergroup where whose=? and grouptype='allpower'", id);
            allpower = System.Text.RegularExpressions.Regex.Replace(allpower, "," + userLogin + ",", ""); //从权限表中删除
            user.operate(-1, 0, "update usergroup set visual = ? where whose=? and grouptype='allpower'", allpower, id);
            Response.Write("<script>alert('操作成功！'); </script>");
            Response.Redirect(Request.Url.ToString());
        }
    }

    protected void tip2_Click(object sender, EventArgs e)
    {
        applyList.Visible = !applyList.Visible;
    }
}