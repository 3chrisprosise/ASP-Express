<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Dispatch.aspx.cs" Inherits="Dispatch" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <title></title>
    <style type="text/css">
        table {
            border-collapse : collapse

        }
        td,th{
            border : 1px solid #564545
        }
    </style>
    <script type="text/javascript" src="Scripts/jquery-1.4.1.js"></script>

    <script type="text/javascript">
        function ChangeDateFormat(val) {
            if (val != null) {
                var date = new Date(parseInt(val.replace("/Date(", "").replace(")/", ""), 10));
                //月份为0-11，所以+1，月份小于10时补个0
                var month = date.getMonth() + 1 < 10 ? "0" + (date.getMonth() + 1) : date.getMonth() + 1;
                var currentDate = date.getDate() < 10 ? "0" + date.getDate() : date.getDate();
                return date.getFullYear() + "-" + month + "-" + currentDate + " " + date.getHours() + ":" + date.getMilliseconds() + ":" + date.getSeconds();
            }

            return "";
        }
        function ConvertJSONDateToJSDate(jsondate) {
            var date = new Date(parseInt(jsondate.replace("/Date(", "").replace(")/", ""), 10));
            
            return date;
        }
        function load() {
            $.ajax({
                url: "GetExpress.ashx",
                type: "post",
                dataType: "json",
                success: function (json) {
                    if (json.Code == 0) {
                        var s = "<table cellspacing=0 style='width:100%'>";
                        s += "<tr><td>快递单号</td><td>收件人</td><td>楼号</td><td>宿舍号</td><td>派送时间</td><td>快递状态</td><td>操作</td></tr>";
                        for (var i = 0; i < json.Data.length; i++) {
                            s += "<tr>";
                            s += "<td>" + json.Data[i].ExpressCode + "</td>";
                            s += "<td>" + json.Data[i].StudentName + "</td>";
                            s += "<td>" + json.Data[i].BuildingName + "</td>";
                            s += "<td>" + json.Data[i].DormName + "</td>";
                            if (json.Data[i].DelegateTime == null)
                                s += "<td>未知</td>";
                            else
                                var ss = ChangeDateFormat(json.Data[i].DelegateTime);
                            s += "<td>" + ss + "</td>";
                            //s += "<td>"+json.Data[i].DelegateTime + "</td>";
                            if (json.Data[i].Status == 0)
                                s += "<td>待投递</td>";
                            else if (json.Data[i].Status == 1)
                                s += "<td>已签收</td>";
                            else
                                s += "<td>已完成</td>";
                            s += "<td><a href='ModifyExpress.aspx?id=" + json.Data[i].Id + "' >修改</a ></td > ";
                            s += "</tr>";

                        }

                        $("#expressList").html(s);
                    }
                    else
                        alert(json.Message);
                }
            })
        }
        $(function () {
            load();
        });
        
        function onclickfinish(id) {
            $.ajax({
                url: "UpdateExpressStatus.ashx",
                type: "post",
                data: {id:id,status:2},
                success: function (response) {
                    if (response.Code == 0) {
                        alert("修改成功");
                        load();
                        
                    } else {
                        alert(response.Message);
                    }
                }
            });
        }
    </script>
</head>
<body>
    <form id="form1">
        <div>
            <h1>分拣员主页</h1>
            <div>
                <a href="AddExpress.aspx" >添加快递</a>
            </div>
            <div id="expressList">

            </div>
        </div>
    </form>
</body>
</html>
