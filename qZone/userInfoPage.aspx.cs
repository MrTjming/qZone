using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Xml;


public partial class _default : checkLogin
{
    public string CityName = "城市";
    static users user = new users();
    protected void Page_Load(object sender, EventArgs e)
    {
        string userLogin = Convert.ToString(Session["name"]);
        string userid = Convert.ToString(Request.QueryString["id"]);
        if (userid != userLogin)//判断是否本人空间
            btnChange.Visible = false;
        if (!IsPostBack)//绑定数据
        {
            string which = user.operate(0, 0, "select id from userinfo where userid =?", userid);
            string num = user.operate(0, 0, "select num from thumbsup where which =? and type=?", which, "userinfo");
            if (num != "0")
            {
               
                goodNameDisplay.Text = user.operate(0, 0, "select whonickname from thumbsup where which =? and type=?", which, "userinfo") + "等" + num + "人赞了该个人档";
            }
            else goodNameDisplay.Visible = false;
            
            if (user.operate(-1, 0, "select * from thumbsup where which =? and type =? and whoid like ?", which, "userinfo", "%," + userLogin + ",%") != "0")
                {
                    toGood.Text = "取消赞";
                }
            sexInfo.Text = user.operate(0, 0, "select sex from userInfo where userid=?", userid);
            ageInfo.Text = user.operate(0, 0, "select age from userInfo where userid=?", userid);
            birthdayInfo.Text = user.operate(0, 0, "select birthday from userInfo where userid=?", userid); 
            constellationInfo.Text = user.operate(0, 0, "select constellationInfo from userInfo where userid=?", userid);
            liveInfo.Text = user.operate(0, 0, "select livecountry from userInfo where userid=?", userid)+ user.operate(0, 0, "select liveprovince from userInfo where userid=?", userid)+ user.operate(0, 0, "select livecity from userInfo where userid=?", userid);
            marrageInfo.Text = user.operate(0, 0, "select marrageInfo from userInfo where userid=?", userid);
            bloodTypeInfo.Text = user.operate(0, 0, "select bloodTypeInfo from userInfo where userid=?", userid);
            hometownInfo.Text = user.operate(0, 0, "select hometowncountry from userInfo where userid=?", userid)+ user.operate(0, 0, "select hometownprovince from userInfo where userid=?", userid)+ user.operate(0, 0, "select hometowncity from userInfo where userid=?", userid); 
            workInfo.Text = user.operate(0, 0, "select workInfo from userInfo where userid=?", userid); 
            companyName.Text = user.operate(0, 0, "select companyName from userInfo where userid=?", userid);
            companyPlace.Text = user.operate(0, 0, "select companycountry from userInfo where userid=?", userid)+ user.operate(0, 0, "select companyprovince from userInfo where userid=?", userid)+ user.operate(0, 0, "select companycity from userInfo where userid=?", userid);
            addressInfo.Text = user.operate(0, 0, "select addressInfo from userInfo where userid=?", userid); 
           
        }
    }

    protected void Calendar_SelectionChanged(object sender, EventArgs e)//日期选择事件
    {
        if (Calendar.SelectedDate <= DateTime.Now)
        {
            birthdayDate.Text = Calendar.SelectedDate.ToShortDateString();
            tip2.Visible = false;
            changeDate.Visible = false;
            int month=Convert.ToInt32( Calendar.SelectedDate.ToString("MM")), day=Convert.ToInt32( Calendar.SelectedDate.ToString("dd"));
            string xingzuo="保密";
            switch(month)//星座判断
            {
                case 1: if (day >= 20) xingzuo = "水瓶座"; else xingzuo = "摩羯座"; break;
                case 2: if (day >= 19) xingzuo = "双鱼座"; else xingzuo = "水瓶座"; break;
                case 3: if (day >= 21) xingzuo = "白羊座"; else xingzuo = "双鱼座"; break;
                case 4: if (day >= 20) xingzuo = "金牛座"; else xingzuo = "白羊座"; break;
                case 5: if (day >= 21) xingzuo = "双子座"; else xingzuo = "金牛座"; break;
                case 6: if (day >= 22) xingzuo = "巨蟹座"; else xingzuo = "双子座"; break;
                case 7: if (day >= 23) xingzuo = "狮子座"; else xingzuo = "巨蟹座"; break;
                case 8: if (day >= 23) xingzuo = "处女座"; else xingzuo = "狮子座"; break;
                case 9: if (day >= 23) xingzuo = "天秤座"; else xingzuo = "处女座"; break;
                case 10: if (day >= 24) xingzuo = "天蝎座"; else xingzuo = "天秤座"; break;
                case 11: if (day >= 23) xingzuo = "射手座"; else xingzuo = "天蝎座"; break;
                case 12: if (day >= 22) xingzuo = "摩羯座"; else xingzuo = "射手座"; break;
               

            }
            constellationChange.Text = xingzuo;
            string age = Convert.ToString(Convert.ToInt32( DateTime.Now.ToString("yyyy")) - Convert.ToInt32(Calendar.SelectedDate.ToString("yyyy")));
            ageChange.Text = age;
        }
        else { tip2.Text = "您不能选择还未到的日期";tip2.Visible = true; }


    }

    protected void btnBirthdayDate_Click(object sender, EventArgs e)//年月的下拉框数据绑定
    {
        changeDate.Visible = !changeDate.Visible;
        if(checkAdd.Text=="no")
        {
            int nowYear = Convert.ToInt32(DateTime.Now.ToString("yyyy")), nowMonth = Convert.ToInt32(DateTime.Now.ToString("MM"));
            for (int year = nowYear; year > nowYear - 150; year--)//从当前年至150年前
                yearSelect.Items.Add(year.ToString());
            for (int month = 1; month < 13; month++)//十二个月份
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
        if(btnChange.Text=="修改")//修改个人档
        {
            goodNameDisplay.Visible = false;
            toGood.Visible = false;
            infoDisplay.Visible = false;
            changePage.Visible = true;
            BindProvince(1);
            BindProvince(2);
            BindProvince(3);
            btnChange.Visible = false;
            string userid = Session["name"].ToString();
            sexChange.SelectedValue= user.operate(0, 0, "select sex from userInfo where userid=?", userid);
            birthdayDate.Text = user.operate(0, 0, "select birthday from userInfo where userid=?", userid);
            ageChange.Text = user.operate(0, 0, "select age from userInfo where userid=?", userid);
            constellationChange.Text = user.operate(0, 0, "select constellationInfo from userInfo where userid=?", userid);
            bloodTypeChange.SelectedValue = user.operate(0, 0, "select bloodTypeInfo from userInfo where userid=?", userid);
            marrageInfoChange.SelectedValue = user.operate(0, 0, "select marrageInfo from userInfo where userid=?", userid);
            workChange.Text = user.operate(0, 0, "select workInfo from userInfo where userid=?", userid);
            companyChange.Text = user.operate(0, 0, "select companyName from userInfo where userid=?", userid);
            addressChange.Text = user.operate(0, 0, "select addressInfo from userInfo where userid=?", userid);
            string countryText= user.operate(0, 0, "select livecountry from userInfo where userid=?", userid);
            if (countryText == "外国")
            { Country.SelectedValue = countryText; Province.Items.Clear(); Province.Items.Add("省份"); Province.Items.Add("外国的省"); }
            else
            {

                Country.SelectedValue = countryText;
                BindProvince(1);
                Province.SelectedValue = user.operate(0, 0, "select liveprovince from userInfo where userid=?", userid);
                BindCity(1);
                City.SelectedValue = user.operate(0, 0, "select livecity from userInfo where userid=?", userid);
            }
            string countryText2 = user.operate(0, 0, "select hometowncountry from userInfo where userid=?", userid);
            if (countryText2 == "外国")
            { Country2.SelectedValue = countryText2; Province2.Items.Clear(); Province2.Items.Add("省份"); Province2.Items.Add("外国的省"); }
            else
            {

                Country2.SelectedValue = countryText2;
                BindProvince(2);
                Province2.SelectedValue = user.operate(0, 0, "select hometownprovince from userInfo where userid=?", userid);
                BindCity(2);
                City2.SelectedValue = user.operate(0, 0, "select hometowncity from userInfo where userid=?", userid);
            }
            string countryText3 = user.operate(0, 0, "select companycountry from userInfo where userid=?", userid);
            if (countryText3 == "外国")
            { Country3.SelectedValue = countryText3; Province3.Items.Clear(); Province3.Items.Add("省份"); Province3.Items.Add("外国的省"); }
            else
            {

                Country3.SelectedValue = countryText3;
                BindProvince(3);
                Province3.SelectedValue = user.operate(0, 0, "select companyprovince from userInfo where userid=?", userid);
                BindCity(3);
                City3.SelectedValue = user.operate(0, 0, "select companycity from userInfo where userid=?", userid);
            }
        }


    }

    protected void yearSelect_SelectedIndexChanged(object sender, EventArgs e)//年份选择下拉框
    {
        Calendar.VisibleDate =Convert.ToDateTime( yearSelect.Text + "-" + monthSelect.Text + "-01");//绑定日期到日历
    }

    protected void monthSelect_SelectedIndexChanged(object sender, EventArgs e)//月份选择下拉框
    {
        Calendar.VisibleDate = Convert.ToDateTime(yearSelect.Text + "-" + monthSelect.Text + "-01");//绑定日期到日历
    }

    protected void Country_SelectedIndexChanged(object sender, EventArgs e)
    {
        if (Country.SelectedValue == "中国")
        {
            BindProvince(1);
        }
        else {
            Province.Items.Clear();
            City.Items.Clear();
            Province.Items.Add("省份");
            Province.Items.Add("外国的省"); }
    }
    void BindProvince(int num) //省份联动 num为1\2\3分别对应3个地址
    {
        if(num==1)
        {
            string CurrentPath = this.Server.MapPath(".");


            if (System.IO.File.Exists(CurrentPath + "//Province.xml"))
            {
                this.Province.Items.Clear();

                System.Xml.XmlDocument doc = new System.Xml.XmlDocument();
                doc.Load(CurrentPath + "//Province.xml");

                XmlNodeList nodes = doc.DocumentElement.ChildNodes;

                XmlNode nodeCity = doc.DocumentElement.SelectSingleNode(@"Province/City[@Name='" + this.City + "']");

                foreach (XmlNode node in nodes)
                {
                    this.Province.Items.Add(node.Attributes["Name"].Value);
                    int n = this.Province.Items.Count - 1;

                    if (nodeCity != null && node == nodeCity.ParentNode)
                        this.Province.SelectedIndex = n;
                }
                BindCity(1);
            }
            else
            {

            }
        }
        else if(num==2)
        {
            string CurrentPath = this.Server.MapPath(".");


            if (System.IO.File.Exists(CurrentPath + "//Province.xml"))
            {
                this.Province2.Items.Clear();

                System.Xml.XmlDocument doc = new System.Xml.XmlDocument();
                doc.Load(CurrentPath + "//Province.xml");

                XmlNodeList nodes = doc.DocumentElement.ChildNodes;

                XmlNode nodeCity = doc.DocumentElement.SelectSingleNode(@"Province/City[@Name='" + this.City2 + "']");

                foreach (XmlNode node in nodes)
                {
                    this.Province2.Items.Add(node.Attributes["Name"].Value);
                    int n = this.Province2.Items.Count - 1;

                    if (nodeCity != null && node == nodeCity.ParentNode)
                        this.Province2.SelectedIndex = n;
                }
                BindCity(2);
            }
            else
            {

            }
        }
        else
        {
            string CurrentPath = this.Server.MapPath(".");


            if (System.IO.File.Exists(CurrentPath + "//Province.xml"))
            {
                this.Province3.Items.Clear();

                System.Xml.XmlDocument doc = new System.Xml.XmlDocument();
                doc.Load(CurrentPath + "//Province.xml");

                XmlNodeList nodes = doc.DocumentElement.ChildNodes;

                XmlNode nodeCity = doc.DocumentElement.SelectSingleNode(@"Province/City[@Name='" + this.City3 + "']");

                foreach (XmlNode node in nodes)
                {
                    this.Province3.Items.Add(node.Attributes["Name"].Value);
                    int n = this.Province3.Items.Count - 1;

                    if (nodeCity != null && node == nodeCity.ParentNode)
                        this.Province3.SelectedIndex = n;
                }
                BindCity(3);
            }
            else
            {

            }
        }
        
    }
    void BindCity(int num)//城市联动num为1\2\3分别对应3个地址
    {
        if(num==1)
        {
            string CurrentPath = this.Server.MapPath(".");

            if (System.IO.File.Exists(CurrentPath + "//Province.xml"))
            {
                this.City.Items.Clear();

                System.Xml.XmlDocument doc = new System.Xml.XmlDocument();
                doc.Load(CurrentPath + "//Province.xml");

                XmlNodeList nodes = doc.DocumentElement.ChildNodes[this.Province.SelectedIndex].ChildNodes;

                foreach (XmlNode node in nodes)
                {
                    this.City.Items.Add(node.Attributes["Name"].Value);
                    int n = this.City.Items.Count - 1;
                    if (node.Attributes["Name"].Value == this.CityName)
                    {
                        this.City.SelectedIndex = n;
                    }
                }

                if (this.City.SelectedIndex == -1)
                    this.City.SelectedIndex = 0;
            }
            else
            {

            }
        }
        else if(num==2)
        {
            string CurrentPath = this.Server.MapPath(".");

            if (System.IO.File.Exists(CurrentPath + "//Province.xml"))
            {
                this.City2.Items.Clear();

                System.Xml.XmlDocument doc = new System.Xml.XmlDocument();
                doc.Load(CurrentPath + "//Province.xml");

                XmlNodeList nodes = doc.DocumentElement.ChildNodes[this.Province2.SelectedIndex].ChildNodes;

                foreach (XmlNode node in nodes)
                {
                    this.City2.Items.Add(node.Attributes["Name"].Value);
                    int n = this.City2.Items.Count - 1;
                    if (node.Attributes["Name"].Value == this.CityName)
                    {
                        this.City2.SelectedIndex = n;
                    }
                }

                if (this.City2.SelectedIndex == -1)
                    this.City2.SelectedIndex = 0;
            }
            else
            {

            }
        }
        else
        {
            string CurrentPath = this.Server.MapPath(".");

            if (System.IO.File.Exists(CurrentPath + "//Province.xml"))
            {
                this.City3.Items.Clear();

                System.Xml.XmlDocument doc = new System.Xml.XmlDocument();
                doc.Load(CurrentPath + "//Province.xml");

                XmlNodeList nodes = doc.DocumentElement.ChildNodes[this.Province3.SelectedIndex].ChildNodes;

                foreach (XmlNode node in nodes)
                {
                    this.City3.Items.Add(node.Attributes["Name"].Value);
                    int n = this.City3.Items.Count - 1;
                    if (node.Attributes["Name"].Value == this.CityName)
                    {
                        this.City3.SelectedIndex = n;
                    }
                }

                if (this.City3.SelectedIndex == -1)
                    this.City3.SelectedIndex = 0;
            }
            else
            {

            }
        }
        
    }

    protected void Province_SelectedIndexChanged(object sender, EventArgs e)
    {
        if(Province.SelectedValue=="外国的省")
            { City.Items.Clear(); City.Items.Add("城市"); City.Items.Add("外国的市"); }
        else
            BindCity(1);
        
    }

    protected void Country2_SelectedIndexChanged(object sender, EventArgs e)
    {
        if (Country2.SelectedValue == "中国")
        {
            BindProvince(2);
        }
        else
        {
            Province2.Items.Clear();
            City2.Items.Clear();
            Province2.Items.Add("省份");
            Province2.Items.Add("外国的省");
        }
    }

    protected void Province2_SelectedIndexChanged(object sender, EventArgs e)
    {
        if (Province2.SelectedValue == "外国的省")
        { City2.Items.Clear(); City2.Items.Add("城市"); City2.Items.Add("外国的市"); }
        else
            BindCity(2);
    }

    protected void Country3_SelectedIndexChanged(object sender, EventArgs e)
    {
        if (Country3.SelectedValue == "中国")
        {
            BindProvince(3);
        }
        else
        {
            Province3.Items.Clear();
            City3.Items.Clear();
            Province3.Items.Add("省份");
            Province3.Items.Add("外国的省");
        }
    }

    protected void Province3_SelectedIndexChanged(object sender, EventArgs e)
    {
        if (Province3.SelectedValue == "外国的省")
        { City3.Items.Clear(); City3.Items.Add("城市"); City3.Items.Add("外国的市"); }
        else
            BindCity(3);
    }

    protected void saveChange_Click(object sender, EventArgs e)//信息修改
    {
        string userid = Session["name"].ToString();
        string nowtime = Convert.ToString(DateTime.Now);
        user.operate(-1, -0, "update userinfo set sex=?,birthday=?,age=?,constellationInfo=?,livecountry=?,liveprovince=?,livecity=?,marrageInfo=?,bloodTypeInfo=?,hometowncountry=?,hometownprovince=?,hometowncity=?,workInfo=?,companyName=?,companycountry=?,companyprovince=?,companycity=?,addressinfo=? where userid =?", sexChange.SelectedValue, birthdayDate.Text, ageChange.Text, constellationChange.Text, Country.SelectedValue, Province.SelectedValue , City.SelectedValue, marrageInfoChange.SelectedValue, bloodTypeChange.SelectedValue, Country2.SelectedValue , Province2.SelectedValue , City2.SelectedValue, Server.HtmlEncode(workChange.Text), Server.HtmlEncode(companyChange.Text), Country3.SelectedValue , Province3.SelectedValue ,City3.SelectedValue, Server.HtmlEncode(addressChange.Text), userid);
        if (showOther.Checked==false)
        {
            string id = user.operate(0, 0, "select id from userinfo where userid=?", userid);
            string allpower = user.operate(0, 0, "Select id from usergroup where whose =? and grouptype =?", userid, "allpower");
            user.operate(-1, 0, "insert into news (time,type,whose,display,extra,which) values(?,?,?,?,?,?)", nowtime, "userInfo", userid, allpower, "更新了个人档",id);
        }
        changePage.Visible = false;
        infoDisplay.Visible = true;
        Response.Write("<script>alert('修改成功!')</script>");
        goodNameDisplay.Visible = true;
        toGood.Visible = true;
        Response.Redirect("userInfoPage.aspx?id="+userid);
    }

    protected void toGood_Click(object sender, EventArgs e)
    {
        string userLogin = Convert.ToString(Session["name"]);
        string userid = Convert.ToString(Request.QueryString["id"]);
        if (toGood.Text=="点赞")
        {
           string which= user.operate(0, 0, "select id from userinfo where userid =?", userid);
            int num = Convert.ToInt32(user.operate(0, 0, "select num from thumbsup where which=? and type=?", which, "userinfo"));
            string whoid = user.operate(0, 0, "select whoid from thumbsup where which=? and type=?", which, "userinfo");
            string whoname = user.operate(0, 0, "select whonickname from thumbsup where which=? and type=?", which, "userinfo");
            num++;//记录点赞数
            whoid = whoid + "," + userLogin + ",";//添加id至点赞表的用户id名单
            whoname = whoname + " " + user.operate(0, 0, "select nickname from users where id = ?", userLogin) + " ";//添加用户昵称至名单
            user.operate(-1, 0, "update thumbsup set num=?,whoid=?,whonickname=? where which = ? and type=?", num, whoid, whoname, which, "userinfo");//更新数据
            Response.Redirect(Request.RawUrl);
        }
        if(toGood.Text=="取消赞")
        {
            string which = user.operate(0, 0, "select id from userinfo where userid =?", userid);
            int num = Convert.ToInt32(user.operate(0, 0, "select num from thumbsup where which=? and type=?", which, "userinfo"));
            string whoid = user.operate(0, 0, "select whoid from thumbsup where which=? and type=?", which, "userinfo");
            string whoname = user.operate(0, 0, "select whonickname from thumbsup where which=? and type=?", which, "userinfo");
            num--;//点赞数
            whoid = System.Text.RegularExpressions.Regex.Replace(whoid, "," + userLogin + ",", "");//从点赞用户id名单删除
            whoname = System.Text.RegularExpressions.Regex.Replace(whoname, " " + user.operate(0, 0, "select nickname from users where id = ?", userLogin) + " ", "");//昵称删除
            user.operate(-1, 0, "update thumbsup set num=?,whoid=?,whonickname=? where which = ? and type=?", num, whoid, whoname, which, "userinfo");//更新数据
            Response.Redirect(Request.RawUrl);
        }
    }
}