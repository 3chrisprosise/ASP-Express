using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

/// <summary>
/// Express 的摘要说明
/// </summary>
public class Express
{
    public String Id { get; set; }
    public String ExpressCode { get; set; }
    public String ExpressTitle { get; set; }
    public String StudentCode{ get; set; }
    public String StudentName { get; set; }
    public String StudentId { get; set; }
    public String BuildingName { get; set; }
    public String DormId { get; set; }
    public String DormName { get; set; }
    public DateTime? DelegateTime { get; set; }
    public DateTime? ReceiveTime { get; set; }
    public int Status { get; set; }
    public String SenderId { get; set; }
    public String SenderName { get; set; }
    public Express()
    {
        //
        // TODO: 在此处添加构造函数逻辑
        //
    }
}