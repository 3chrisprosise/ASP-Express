<%@ WebHandler Language="C#" Class="SaveExpress" %>

using System;
using System.Web;


public class SaveExpress : IHttpHandler {

    public void ProcessRequest (HttpContext context) {

        try
        {
            ExpressService expressService = new ExpressService();
            Express express = new Express();
            express.ExpressCode = context.Request["ExpressCode"];
            express.ExpressTitle = context.Request["ExpressTitle"];
            express.StudentId = context.Request["StudentId"];
            express.SenderId = context.Request["SenderId"];
            express.DormId = context.Request["DormId"];
            expressService.SaveExpress(express);
            context.Response.Redirect("Dispatch.aspx");
        }
        catch (Exception e)
        {
            context.Response.Write(e.Message);
        }
    }

    public bool IsReusable {
        get {
            return false;
        }
    }

}