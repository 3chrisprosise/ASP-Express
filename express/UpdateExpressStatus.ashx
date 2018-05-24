<%@ WebHandler Language="C#" Class="UpdateExpressStatus" %>

using System;
using System.Web;

public class UpdateExpressStatus : IHttpHandler {

    public void ProcessRequest (HttpContext context) {
        String expressId = context.Request["id"];
        int status = int.Parse(context.Request["status"]);

        try
        {
            ExpressService expressService = new ExpressService();
            Express express = new Express();
            if (expressId.Equals("2"))
            {
                express.Status = status;
                express.Id = expressId;
                expressService.SaveExpress(express);
                JsonResult json = new JsonResult();
                json.Code = 0;
                context.Response.ContentType = "text/json";
                context.Response.Write(json.ToJson());
            }else if(expressId.Equals("1")){
                express.Status = status;
                express.Id = expressId;
                expressService.SaveExpress(express);
                JsonResult json = new JsonResult();
                json.Code = 0;
                context.Response.ContentType = "text/json";
                context.Response.Write(json.ToJson());
            }


        }catch(Exception e)
        {
            JsonResult json = new JsonResult();
            json.Code = 1;
            json.Message = e.Message;
            context.Response.ContentType = "text/json";
            context.Response.Write(json.ToJson());
        }
    }

    public bool IsReusable {
        get {
            return false;
        }
    }

}