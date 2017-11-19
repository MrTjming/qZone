using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;

/// <summary>
/// users 的摘要说明
/// </summary>
public class users
{
    static string str = @"server=DESKTOP-UNR7NUM;Integrated Security=SSPI;database=qZone;";

    public users()
    {
       
    }
    public int checkFriends(string user1,string user2) //判断是否为好友关系，其中user1和user2都是用户的 id （int型）
    {
        string num1= operateData("select * from friends where user1= '" + user1 + "' and user2 = '" + user2 +"'" , -1, 0);
        string num2 =operateData("select * from friends where user1= '" + user2 + "' and user2 = '" + user1+"'" , -1, 0);
        if (num1 == "1" || num2 == "1")
            return 1;
        else return 0;
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

    public string operateData(string sqlCmd, int Num1, int Num2) //(操作数据库，Num1=-1，为返回搜索到的数量)
    {
        string sql = sqlCmd;
        int num1 = Num1;
        int num2 = Num2;
        SqlConnection conn = new SqlConnection(str);
        System.Data.DataTable dt = new DataTable();
        conn.Open();
        SqlDataAdapter da = new SqlDataAdapter(sql, conn);
        da.Fill(dt);
        conn.Close();


        if (num1 == -1)
        {
            int num = dt.Rows.Count;
            return Convert.ToString(num);
        }

        else
        {
            string text = Convert.ToString(dt.Rows[num1][num2]);
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