<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Login.aspx.cs" Inherits="Login" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <title></title>
</head>
<body>
    <form id="form1" method="post" action="Logon.ashx">
        <div>
            <p>用户名:<input type="text" name="username" value=""/></p>
            <p>密码: &nbsp <input type="password" name="password" value=""/></p>
            <p><input type="submit" name="submit" value="登录"/></p>
        </div>
    </form>
</body>
</html>
