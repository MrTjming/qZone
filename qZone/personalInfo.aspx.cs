using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class _Default : System.Web.UI.Page
{
    static users user = new users();
    protected void Page_Load(object sender, EventArgs e)
    {
        string userid = Convert.ToString(Request.QueryString["id"]);
        if (userid == "")
            userid = Session["name"].ToString();
        if (!IsPostBack)
        {
            sexInfo.Text = user.operateData("select sex from userInfo where userid=" + userid, 0, 0);
            ageInfo.Text = user.operateData("select age from userInfo where userid=" + userid, 0, 0);
            birthdayInfo.Text = user.operateData("select birthday from userInfo where userid=" + userid, 0, 0);
            constellationInfo.Text = user.operateData("select constellationInfo from userInfo where userid=" + userid, 0, 0);
            liveInfo.Text = user.operateData("select liveInfo from userInfo where userid=" + userid, 0, 0);
            marrageInfo.Text = user.operateData("select marrageInfo from userInfo where userid=" + userid, 0, 0);
            bloodTypeInfo.Text = user.operateData("select bloodTypeInfo from userInfo where userid=" + userid, 0, 0);
            hometownInfo.Text = user.operateData("select hometownInfo from userInfo where userid=" + userid, 0, 0);
            workInfo.Text = user.operateData("select workInfo from userInfo where userid=" + userid, 0, 0);
            companyName.Text = user.operateData("select companyName from userInfo where userid=" + userid, 0, 0);
            companyPlace.Text = user.operateData("select companyPlace from userInfo where userid=" + userid, 0, 0);
            addressInfo.Text = user.operateData("select addressInfo from userInfo where userid=" + userid, 0, 0);

        }
    }

    protected void Calendar_SelectionChanged(object sender, EventArgs e)
    {
        if (Calendar.SelectedDate <= DateTime.Now)
        {
            birthdayDate.Text = Calendar.SelectedDate.ToShortDateString();
            tip2.Visible = false;
            changeDate.Visible = false;

        }
        else { tip2.Text = "您不能选择还未到的日期";tip2.Visible = true; }


    }

    protected void btnBirthdayDate_Click(object sender, EventArgs e)
    {
        changeDate.Visible = !changeDate.Visible;
        if(checkAdd.Text=="no")
        {
            int nowYear = Convert.ToInt32(DateTime.Now.ToString("yyyy")), nowMonth = Convert.ToInt32(DateTime.Now.ToString("MM"));
            for (int year = nowYear; year > nowYear - 150; year--)
                yearSelect.Items.Add(year.ToString());
            for (int month = 1; month < 13; month++)
            {
                monthSelect.Items.Add(month.ToString());
            }
            yearSelect.SelectedValue = nowYear.ToString();
            monthSelect.SelectedValue = nowMonth.ToString();
            checkAdd.Text = "yes";
        }
       
            
        
    }

    protected void btnChange_Click(object sender, EventArgs e)
    {
        infoDisplay.Visible = false;
        changePage.Visible = true;
    }

    protected void yearSelect_SelectedIndexChanged(object sender, EventArgs e)
    {
        Calendar.VisibleDate =Convert.ToDateTime( yearSelect.Text + "-" + monthSelect.Text + "-01");
    }

    protected void monthSelect_SelectedIndexChanged(object sender, EventArgs e)
    {
        Calendar.VisibleDate = Convert.ToDateTime(yearSelect.Text + "-" + monthSelect.Text + "-01");
    }
}