using System;
using System.Collections.Generic;
using System.Data;
using System.Data.Common;
using System.Data.SqlClient;
using System.Linq;
using System.Text;
using System.Web;

/// <summary>
/// users 的摘要说明
/// </summary>
public class users
{
    static string str = @"server=DESKTOP-UNR7NUM;Integrated Security=SSPI;database=qZone;";

    public int checkNum(string txt,int min,int max)
    {
        if (txt.Length > max || txt.Length < min)
            return 0;//返回0不符合
        else return 1;//返回1符合
    }
    public users()
    {
       
    }
    public int checkFriends(string user1,string user2) //判断是否为好友关系，其中user1和user2都是用户的 id （int型）
    {
        string num1= operate(-1, 0, "select * from friends where user1=? and user2 =?", user1, user2); //operateData("select * from friends where user1= '" + user1 + "' and user2 = '" + user2 +"'" , -1, 0);
        string num2 = operate(-1, 0, "select * from friends where user1=? and user2 =?", user2, user1);//operateData("select * from friends where user1= '" + user2 + "' and user2 = '" + user1+"'" , -1, 0);
        if (num1 == "1" || num2 == "1")
            return 1;
        else return 0;
    }
    public DataTable getAppoint(string userLogin, string whose,string type)
    {
        int num = Convert.ToInt32(operate(-1, 0, "select * from usergroup where (grouptype=? or grouptype=?) and visual like ? and whose =?", "power", "allpower", "%," + userLogin + ",%",whose));
       DataTable newsData = new DataTable();
        if(num>0)
        {
            newsData = getData("select * from "+type+"View where visual=" + operate(0, 0, "select id from usergroup where (grouptype='power' or grouptype='allpower') and visual like ? and whose =?", "%," + userLogin + ",%", whose) + " order by time desc");//new DataTable();
          //  newsData = getData("select * from newsView where type='" + type + "' and display=" + operate(0, 0, "select id from usergroup where (grouptype='power' or grouptype='allpower') and visual like ? and whose =?", "%," + userLogin + ",%",whose) + " order by time desc");//new DataTable();
            for (int n = 1; n < num; n++)
            {
                foreach (DataRow dr in getData("select * from " + type + "View where visual='" + operate(n, 0, "select id from usergroup where (grouptype='power' or grouptype='allpower') and visual like ? and whose =?", "%," + userLogin + ",%", whose) + "' order by time desc").Rows)

               //     foreach (DataRow dr in getData("select * from newsView where type='" + type + "' and display='" + operate(n, 0, "select id from usergroup where (grouptype='power' or grouptype='allpower') and visual like ? and whose =?", "%," + userLogin + ",%",whose) + "' order by time desc").Rows)
                {
                    newsData.ImportRow(dr);
                }
            }
            newsData.DefaultView.Sort = "time desc";

        }

        return newsData;


        // int num = Convert.ToInt32(operate(-1, 0, "select * from twitter where whose =?"));
    }
    public DataTable getNews(string userLogin, string type)
    {
        int num = Convert.ToInt32(operate(-1, 0, "select * from usergroup where (grouptype=? or grouptype=?) and visual like ?", "power", "allpower", "%," + userLogin + ",%"));

        DataTable newsData = new DataTable();
        if (num > 0)
        {
            if (type != "")
            {
                newsData = getData("select * from newsView where type='" + type + "' and display=" + operate(0, 0, "select id from usergroup where (grouptype='power' or grouptype='allpower') and visual like ?", "%," + userLogin + ",%") + " order by time desc");//new DataTable();

                for (int n = 1; n < num; n++)
                {

                    foreach (DataRow dr in getData("select * from newsView where type='" + type + "' and display='" + operate(n, 0, "select id from usergroup where (grouptype='power' or grouptype='allpower') and visual like ?", "%," + userLogin + ",%") + "' order by time desc").Rows)
                    {
                        newsData.ImportRow(dr);
                    }

                }
                newsData.DefaultView.Sort = "time desc";
            }
            else
            {
                newsData = getData("select * from newsView where display='" + operate(0, 0, "select id from usergroup where( grouptype='power' or grouptype='allpower') and visual like ?", "%," + userLogin + ",%") + "' order by time desc");

                for (int n = 1; n < num; n++)
                {
                    foreach (DataRow dr in getData("select * from newsView where display='" + operate(n, 0, "select id from usergroup where (grouptype='power' or grouptype='allpower') and visual like ?", "%," + userLogin + ",%") + "' order by time desc").Rows)
                    {
                        newsData.ImportRow(dr);
                    }
                }
                newsData.DefaultView.Sort = "time desc";
            }
        }
    
        
        return newsData;
    }
    public DataTable getData(string txt) //取得数据库
    {
        string sql = txt;
        SqlConnection conn = new SqlConnection(str);
        System.Data.DataTable dt = new DataTable();
        conn.Open();
        SqlDataAdapter da = new SqlDataAdapter(sql, conn);
        da.Fill(dt);
        conn.Close();
        return dt;
    }
    public string operate (int Num1, int Num2,string sql, params object[] trueValue)//操作数据库
    {
        SqlCommand comm = new SqlCommand();
        string str = @"server=DESKTOP-UNR7NUM;Integrated Security=SSPI;database=qZone;";
        SqlConnection conn = new SqlConnection(str);
        comm.CommandText = sql;
        if (trueValue != null && trueValue.Length >= 0)
        {
            if (comm.CommandText.IndexOf("?") == -1)//检测sql文本中的'?'
            {
                string[] temp = sql.Split('@');
                for (int i = 0; i < trueValue.Length; i++)
                {
                    string parameter;
                    if (temp[i + 1].IndexOf(" ") > -1)
                    {
                        parameter = "@" + temp[i + 1].Substring(0, temp[i + 1].IndexOf(" "));
                    }
                    else
                    {
                        parameter = "@" + temp[i + 1];
                    }
                    DbParameter p = comm.CreateParameter();
                    p.DbType = DbType.String;
                    p.ParameterName = parameter;
                    p.Value = trueValue[i];
                    comm.Parameters.Add(p);
                }
            }
            else
            {
                string[] temp = sql.Split('?');
                for (int i = 0; i < trueValue.Length; i++)
                {
                    temp[i] = temp[i] + "@p" + (i + 1).ToString();
                    string parameter = "@p" + (i + 1).ToString();
                    DbParameter p = comm.CreateParameter();
                    p.DbType = DbType.String;
                    p.ParameterName = parameter;
                    p.Value = trueValue[i];
                    comm.Parameters.Add(p);
                }
                StringBuilder sb = new StringBuilder();
                for (int i = 0; i < temp.Length; i++)
                {
                    sb.Append(temp[i]);
                }
                comm.CommandText = sb.ToString();
            }
        }
        comm.Connection = conn;
        System.Data.DataTable dt = new DataTable();
        SqlDataAdapter da = new SqlDataAdapter();
        da.SelectCommand = comm;
        da.Fill(dt);
        if (Num1 == -1)
        {
            int num = dt.Rows.Count;
            return Convert.ToString(num);
        }

        else
        {
            string text = Convert.ToString(dt.Rows[Num1][Num2]);
            return text;
        }
    }
   
    public int checklegal(string txt) //检测输入的文本是否符合 帐号密码的 输入规范
    {
        string text = txt;
        int num = text.Length;
        if (num > 20 || num < 6)
            return 1;//返回1，长度不合法
        else
            for (int a = 0; a < num; a++)
            {
                if ((text[a] >= 'a' && text[a] <= 'z') || (text[a] >= 'A' && text[a] <= 'Z') || (text[a] >= '0' && text[a] <= '9') || (text[a] == '_'))
                    continue;
                else return 2;//返回2，含有非法字符
            }
        return 0;//返回0，文本合法
    }
    public string MD5Encrypt32(string password, int codeLength)
    {
        if (!string.IsNullOrEmpty(password))
        {
            // 16位MD5加密（取32位加密的9~25字符）  
            if (codeLength == 16)
            {
                return System.Web.Security.FormsAuthentication.HashPasswordForStoringInConfigFile(password, "MD5").ToLower().Substring(8, 16);
            }

            // 32位加密
            if (codeLength == 32)
            {
                return System.Web.Security.FormsAuthentication.HashPasswordForStoringInConfigFile(password, "MD5").ToLower();
            }
        }
        return string.Empty;
    }
}