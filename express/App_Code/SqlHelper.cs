using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Data;
using System.Data.Sql;
using System.Data.SqlClient;

/// <summary>
/// SqlHelper 的摘要说明
/// </summary>
public class SqlHelper
{
    String connString = @"Data Source=.;Database=Express;Integrated Security=true";
    private SqlConnection conn = null;
    public SqlHelper()
    {
        conn = new SqlConnection(connString);
        Connect();
    }

    ~SqlHelper()
    {
        DisConnect();
    }

    private void Connect()
    {
        if (conn.State!= ConnectionState.Open) {
            conn.Open();
        }
    }

    public void DisConnect()
    {
        if (conn.State == ConnectionState.Open) {
            conn.Close();
        }
    }

    public DataTable Query(String sqlStr,SqlParameter[] parameters)
    {
        if (conn.State!=ConnectionState.Open) {
            Connect();
        }
        SqlCommand cmd = new SqlCommand(sqlStr,conn);
        if(parameters != null)
            cmd.Parameters.AddRange(parameters);
        SqlDataAdapter adp = new SqlDataAdapter(cmd);
        DataTable dt = new DataTable();
        adp.Fill(dt);
        return dt;
    }

    public void Save(String sqlStr, SqlParameter[] parameters)
    {
        if (conn.State != ConnectionState.Open)
        {
            Connect();
        }
        SqlCommand cmd = new SqlCommand(sqlStr, conn);
        cmd.Parameters.AddRange(parameters);
        cmd.ExecuteNonQuery();

    }
}