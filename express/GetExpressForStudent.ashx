<%@ WebHandler Language="C#" Class="GetExpressForStudent" %>

using System;
using System.Web;
using System.Data;
using System.Data.Sql;
using System.Data.SqlClient;
using System.Web.Script.Serialization;
using System.Web.SessionState;

public class GetExpressForStudent : IHttpHandler,IRequiresSessionState {

    public void ProcessRequest (HttpContext context) {
        SqlHelper helper = null;
        try {
            helper = new SqlHelper();
            String accountId = (String)context.Session["accountId"];
            String sql = "select e.id,e.code,s.code as studentcode,"+
                    "s.name,s.id as studentid,b.building_name,r.sender_name," +
                    "d.dorm_name,e.delegate_time,e.receive_time,e.status"+
                    " from express e "+
                    "inner join student s on e.student_id=s.id " +
                    "inner join dorm d on e.dorm_id=d.id " +
                    "inner join building b on d.building_id=b.id " +
                    "inner join sender r on e.sender_id=r.id " +
                    "where s.account_id='"+accountId+"'";

            DataTable dt = helper.Query(sql,null);
            JsonResult result = new JsonResult();
            result.Code = 0;
            foreach (DataRow dr in dt.Rows)
            {
                Express express = new Express();
                express.Id = dr["id"].ToString();
                express.ExpressCode = dr["code"].ToString();
                express.StudentCode = dr["studentcode"].ToString();
                express.StudentName = dr["name"].ToString();
                express.StudentId = dr["studentid"].ToString();
                express.BuildingName = dr["building_name"].ToString();
                express.DormName = dr["dorm_name"].ToString();
                express.SenderName = dr["sender_name"].ToString();
                if (dr["delegate_time"] == DBNull.Value)
                    express.DelegateTime = null;
                else
                    express.DelegateTime = DateTime.Parse(dr["delegate_time"].ToString());
                if (dr["receive_time"] == DBNull.Value)
                    express.ReceiveTime = null;
                else
                    express.ReceiveTime = DateTime.Parse(dr["receive_time"].ToString());
                express.Status = int.Parse(dr["status"].ToString());
                result.Data.Add(express);
            }
            JavaScriptSerializer js = new JavaScriptSerializer();
            String json = js.Serialize(result);
            context.Response.ContentType = "text/json";
            context.Response.Write(json);
        } catch (Exception e) {
            JsonResult json = new JsonResult();
            json.Code = 1;
            json.Message = e.Message;
            context.Response.ContentType = "text/json";
            context.Response.Write(json.ToJson());
        }
        finally
        {
            if (helper != null)
                helper.DisConnect();
        }
    }

    public bool IsReusable {
        get {
            return false;
        }
    }

}