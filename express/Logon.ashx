<%@ WebHandler Language="C#" Class="Login" %>

using System;
using System.Web;
using System.Data;
using System.Data.Sql;
using System.Data.SqlClient;
using System.Web.SessionState;

public class Login : IHttpHandler,IRequiresSessionState {

    public void ProcessRequest (HttpContext context) {
        String username = context.Request["username"];
        String password = context.Request["password"];
        SqlHelper helper = null;
        try
        {
            helper = new SqlHelper();
            String sql = "select * from account where user_name=@user_name and password=@password";
            SqlParameter[] p = new SqlParameter[2];
            p[0] = new SqlParameter("@user_name",username);
            p[1] = new SqlParameter("@password",password);
            DataTable dt = helper.Query(sql,p);//查询数据库中的内容
            if (dt.Rows.Count > 0)//如果数据接收到了返回
            {
                String roleId = dt.Rows[0]["role_id"].ToString();//转换成对应的字符串
                String accountId = dt.Rows[0]["id"].ToString();
                context.Session["accountId"] = accountId;//将accountId保存在session中
                if (roleId == "2")
                {
                    context.Response.Redirect("Dispatch.aspx");
                }
                else if (roleId == "3")
                {
                    context.Response.Redirect("Sender.aspx");
                } else if (roleId == "4")
                {
                    context.Response.Redirect("Student.aspx");
                }
            }
            else
            {
                throw new Exception("用户名或密码错误");
            }
        }
        catch (Exception e)
        {
            context.Response.ContentType = "text/html";
            context.Response.Write("<html><body><script type='text/javascript'>");
            context.Response.Write("alert('"+e.Message+"');");
            context.Response.Write("window.location.href='Login.aspx';");
            context.Response.Write("</script></body></html>");
            context.Response.End();
        }
        finally
        {
            if (helper!=null) {
                helper.DisConnect();
            }
        }
    }

    public bool IsReusable {
        get {
            return false;
        }
    }

}