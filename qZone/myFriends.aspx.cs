using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class _Default : System.Web.UI.Page
{
    static users user = new users();
    protected void Page_Load(object sender, EventArgs e)
    {
        String txt = Convert.ToString(Session["name"]);
        if (txt == "")
            Response.Write("<script>alert('您还没有登录');window.location = 'login.aspx'; </script>");
        else
        {
            if(!IsPostBack)
            {

                sql1.Text = "select * from users";
                DataBindToRepeater(1);
                Page1.Visible = true;
                string num = user.operateData("select * from users", -1, 0);
                tip1.Text = "空间目前有" + num + "个用户";
            }
            
        }
    }


    protected void list_ItemCommand(object source, RepeaterCommandEventArgs e)
    {
        if (e.CommandName == "add")
        {
            string user2id = Convert.ToString(e.CommandArgument.ToString());
            String txt = Convert.ToString(Session["name"]);
            string user1id = user.operateData("select id from users where name='" + txt + "'", 0, 0);
            if(user.checkFriends(user2id,txt)==0 )
            {
                if (Convert.ToInt32(user.operateData("select * from applyfriend where fromwho = '" + user1id + "' and towho ='" + user2id + "'", -1, 0)) == 0)
                {
                    user.operateData("insert into applyfriend (fromwho,towho) values('" + user1id + "','" + user2id + "')", -1, 0);
                    Response.Write("<script>alert('添加申请已发送！'); </script>");
                } 
                else Response.Write("<script>alert('你已经发出了好友申请，不能重复发出！'); </script>");
            }
            else Response.Write("<script>alert('你和该用户已经是好友了'); </script>");

        }
        if (e.CommandName == "watch")
        {

        }
    }
    void DataBindToRepeater(int currentPage)
    {

        DataTable dt = new DataTable();

        dt = user.getData(sql1.Text);

        PagedDataSource pds = new PagedDataSource();

        pds.AllowPaging = true;

        pds.PageSize = 5;

        pds.DataSource = dt.DefaultView;

        tolPage.Text = pds.PageCount.ToString();

        pds.CurrentPageIndex = currentPage - 1;//当前页数从零开始，故把接受的数减一

        list.DataSource = pds;

        list.DataBind();

    } //分页管理函数

    protected void btnSearch_Click(object sender, EventArgs e) //检索按钮函数
    {
        if (searchType.SelectedValue == "用户名")
        {
            sql1.Text = "select * from users where name like '%" + textSearch.Text + "%'";
            string searchNum = user.operateData("select * from users where name like '%" + textSearch.Text + "%'", -1, 0);
            DataBindToRepeater(1);
            if (searchNum != "0")
            {
                tip1.Text = "总共检索到相关用户" + searchNum + "个";
                
            }
            else tip1.Text = "没有检索到相关用户！";
        }
        else if(searchType.SelectedValue == "昵称")
        {
            sql1.Text = "select * from users where nikename like '%" + textSearch.Text + "%'";
            string searchNum = user.operateData("select * from users where nikename like '%" + textSearch.Text + "%'", -1, 0);
            DataBindToRepeater(1);
            if (searchNum != "0")
            {
                tip1.Text = "总共检索到相关用户" + searchNum + "个";
                
            }
            else tip1.Text = "没有检索到相关用户！";

        }
    }
    protected void up_Click(object sender, EventArgs e)
    {
        string NowPage = nowPage.Text;
        int ToPage = Convert.ToInt32(NowPage) - 1;
        if (ToPage > 0)
        {
            nowPage.Text = Convert.ToString(ToPage);
            DataBindToRepeater(ToPage);

        }
        else Response.Write("<script>alert('已经到顶页了!')</script>");
    }

    protected void firstPage_Click(object sender, EventArgs e)
    {
        nowPage.Text = "1";
        DataBindToRepeater(1);
    }

    protected void endPage_Click(object sender, EventArgs e)
    {
        nowPage.Text = tolPage.Text;
        DataBindToRepeater(Convert.ToInt32(tolPage.Text));
    }
    protected void down_Click(object sender, EventArgs e)
    {
        string NowPage = nowPage.Text;
        int ToPage = Convert.ToInt32(NowPage) + 1;
        if (ToPage <= Convert.ToInt32(tolPage.Text))
        {
            nowPage.Text = Convert.ToString(ToPage);
            DataBindToRepeater(ToPage);

        }
        else Response.Write("<script>alert('已经到底页了!')</script>");

    }


    protected void btnTurn_Click(object sender, EventArgs e)
    {
        int num = Convert.ToInt32(nowPage.Text);
        if (num > 0 && num <= Convert.ToInt32(tolPage.Text))
            DataBindToRepeater(num);
        else Response.Write("<script>alert('没有该页面!')</script>");
    }
}