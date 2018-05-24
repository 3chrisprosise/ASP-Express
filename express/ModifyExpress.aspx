<%@ Page Language="C#" AutoEventWireup="true" CodeFile="ModifyExpress.aspx.cs" Inherits="ModifyExpress" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <style type="text/css">
          
    </style>
    <script type="text/javascript" src="Scripts/jquery-1.4.1.js"></script>
    <script type="text/javascript">
        function loadBuildings() {
            $.ajax({
                url: "GetBuilding.ashx",
                type: "POST",
                dataType: "json",
                success: function (response) {
                    if (response.Code == 0) {
                        var s = "";
                        for (var i = 0; i < response.Data.length; i++) {
                            s += "<option value='" + response.Data[i].Id + "'>" + response.Data[i].BuildingName + "</option>";
                        }
                        $("#BuildingId").html(s);
                        loadDorms();
                    } else {
                        alert(response.Message);
                    }
                }
            });
        }

        function loadDorms() {
            var buildingId = $("#BuildingId").val();
            if (buildingId == null || buildingId == "") {
                alert("宿舍楼号为空");
                return;
            } 
            $.ajax({
                url: "GetDorm.ashx",
                type: "POST",
                dataType: "json",
                data: {"buildingId": buildingId},
                success: function (response) {
                    if (response.Code == 0) {
                        var s = "";
                        for (var i = 0; i < response.Data.length; i++) {
                            s += "<option value='" + response.Data[i].Id + "'>" + response.Data[i].DormName + "</option>";
                        }
                        $("#DormId").html(s);
                        loadStudents();
                    } else {
                        alert(response.Message);
                    }
                }
            });
        }

        function loadStudents() {
            var dormId = $("#DormId").val();
            if (DormId == null || DormId == "") {
                alert("宿舍不能为空");
                return;
            }
            $.ajax({
                url: "GetStudent.ashx",
                type: "POST",
                dataType: "json",
                data: { "dormId": dormId },
                success: function (response) {
                    if (response.Code == 0) {
                        var s = "";
                        for (var i = 0; i < response.Data.length; i++) {
                            s += "<option value='" + response.Data[i].Id + "'>" + response.Data[i].StudentName + "</option>";
                        }
                        $("#StudentId").html(s);
                    } else {
                        alert(response.Message);
                    }
                }
            });
        }

        function loadSenders() {
            $.ajax({
                url: "GetSender.ashx",
                type: "POST",
                dataType: "json",
                success: function (response) {
                    if (response.Code == 0) {
                        var s = "";
                        for (var i = 0; i < response.Data.length; i++) {
                            s += "<option value='" + response.Data[i].Id + "'>" + response.Data[i].SenderName + "</option>";
                        }
                        $("#SenderId").html(s);
                    } else {
                        alert(response.Message);
                    }
                }
            });
        }
        function onBuildingChanged() {
            loadDorms();
        }

        function onDormChanged() {
            loadStudents();
        }

        $(function () {
            loadBuildings();
            loadSenders();
        });
</script>
    <title></title>
</head>
<body>
    <form id="form1" action="SaveExpress.ashx" method="post">

        <div>
            <input type="hidden" id="ExpressId" name="ExpressId" value="<%= CurrentExpress.Id %>"/>
            <p>
               编号:
                <input type="text" id="ExpressCode" name="ExpressCode" value="<%= CurrentExpress.ExpressCode %>" />
            </p>

            <p>
               名称:
                <input type="text" id="ExpressTitle" name="ExpressTitle" value="<%= CurrentExpress.ExpressTitle %>" />
            </p>
            <p>
                楼号:
                <select id="BuildingId" name="BuildingId" style="width:173px;height:21px;" onchange="onBuildingChanged();">

                </select>
            </p>
            <p>
                宿舍号:
                <select id="DormId" name="DormId" style="width:158px;height:21px;" onchange="onDormChanged();">

                </select>
            </p>
            <p>
                收件人:
                <select id="StudentId" style="width:158px;height:21px;" name="StudentId">

                </select>
            </p>
            <p>
                送货员:
                <select id="SenderId" style="width:158px;height:21px;" name="SenderId">

                </select>
            </p>
            <p>
                <input type="submit" name="submit" value="添加" />
            </p>
        </div>
    </form>
</body>
</html>
