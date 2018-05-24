<%@ WebHandler Language="C#" Class="GetExpressForSender" %>

using System;
using System.Web;
using System.Web.SessionState;
using System.Collections.Generic;
public class GetExpressForSender : IHttpHandler,IRequiresSessionState {

    public void ProcessRequest (HttpContext context) {
        try
        {
            ExpressService expressService = new ExpressService();
            String accountId = (String)context.Session["accountId"];
            List<Express> list = expressService.FindExpress("r.account_id='"+accountId+"'");
            JsonResult result = new JsonResult();
            result.Code = 0;
            result.Data = new List<object>();
            foreach(Express x in list)
            {
                result.Data.Add(x);
            }
            context.Response.ContentType = "text/json";
            context.Response.Write(result.ToJson());
        }

        catch (Exception e)
        {
            JsonResult result = new JsonResult();
            result.Code = 1;
            result.Message = e.Message;
            context.Response.Write(result.ToJson());
        }
    }

    public bool IsReusable {
        get {
            return false;
        }
    }

}