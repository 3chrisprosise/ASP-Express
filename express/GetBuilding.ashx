<%@ WebHandler Language="C#" Class="GetBuilding" %>

using System;
using System.Web;
using System.Data;
using System.Data.Sql;
using System.Data.SqlClient;
using System.Web.Script.Serialization;
public class GetBuilding : IHttpHandler {

    public void ProcessRequest (HttpContext context) {
        SqlHelper helper = null;
        try
        {
            helper = new SqlHelper();
            String sql = "select * from building";
            DataTable dt = helper.Query(sql,null);
            JsonResult result = new JsonResult();
            result.Code = 0;
            foreach (DataRow dr in dt.Rows)
            {
                Building building = new Building();
                building.Id = dr["id"].ToString();
                building.BuildingName = dr["building_name"].ToString();
                result.Data.Add(building);
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