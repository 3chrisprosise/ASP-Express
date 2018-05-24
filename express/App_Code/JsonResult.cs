using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Script.Serialization;

/// <summary>
/// JsonResult 的摘要说明
/// </summary>
public class JsonResult
{
    public int Code { get; set; }//0:success;1:false
    public String Message { get; set; }
    public List<object> Data { get; set; }

    public JsonResult()
    {
        Data = new List<object>();
    }

    public string ToJson()
    {
        JavaScriptSerializer js = new JavaScriptSerializer();
        return js.Serialize(this);
    }
}