<%@ WebHandler Language="C#" Class="GetStudent" %>

using System;
using System.Web;
using System.Data;
using System.Data.Sql;
using System.Data.SqlClient;
public class GetStudent : IHttpHandler {

    public void ProcessRequest (HttpContext context) {
        SqlHelper helper = null;
        try
        {
            String dormId = context.Request["dormId"];
            helper = new SqlHelper();
            String sql = "select * from student where dorm_id=@dorm_id";
            SqlParameter[] p = new SqlParameter[1];
            p[0] = new SqlParameter("@dorm_id",dormId);
            DataTable dt = helper.Query(sql,p);
            JsonResult result = new JsonResult();
            result.Code = 0;
            foreach (DataRow dr in dt.Rows)
            {
                StudentInfo student = new StudentInfo();
                student.Id = dr["id"].ToString();
                student.StudentName = dr["name"].ToString();
                student.StudentCode = dr["code"].ToString();
                student.DormId = dr["dorm_id"].ToString();
                result.Data.Add(student);
            }
            context.Response.ContentType = "text/json";
            context.Response.Write(result.ToJson());

        }catch(Exception e)
        {
            JsonResult result = new JsonResult();
            result.Code = 1;
            result.Message = e.Message;
            context.Response.ContentType = "text/json";
            context.Response.Write(result.ToJson());
        }
        finally
        {
            if (helper != null)
            {
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