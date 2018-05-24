<%@ WebHandler Language="C#" Class="GetDorm" %>

using System;
using System.Web;
using System.Data;
using System.Data.Sql;
using System.Data.SqlClient;

public class GetDorm : IHttpHandler {

    public void ProcessRequest (HttpContext context) {
        SqlHelper helper = null;
        try
        {
            String buildingId = context.Request["buildingId"];
            helper = new SqlHelper();
            String sql = "select * from dorm where building_id=@building_id";
            SqlParameter[] p = new SqlParameter[1];
            p[0] = new SqlParameter("@building_id",buildingId);
            DataTable dt = helper.Query(sql,p);
            JsonResult result = new JsonResult();
            result.Code = 0;
            foreach (DataRow dr in dt.Rows)
            {
                Dorm dorm = new Dorm();
                dorm.Id = dr["id"].ToString();
                dorm.DormName = dr["dorm_name"].ToString();
                dorm.BuildingId = dr["building_id"].ToString();
                result.Data.Add(dorm);
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