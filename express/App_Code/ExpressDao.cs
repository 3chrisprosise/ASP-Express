using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Data;
using System.Data.Sql;
using System.Data.SqlClient;

/// <summary>
/// ExpressDao 的摘要说明
/// </summary>
public class ExpressDao
{
    
    public ExpressDao()
    {
    }

    public List<Express> Find(String condition)
    {
        SqlHelper helper = null;
        try
        {
            helper = new SqlHelper();
            String sql = "select e.id,e.code,e.title,s.code as studentcode," +
                    "s.name,s.id as studentid,b.building_name," +
                    "d.dorm_name,e.delegate_time,e.receive_time,e.status, " +
                    "e.dorm_id,e.sender_id " +
                    " from express e " +
                    "inner join student s on e.student_id=s.id " +
                    "inner join dorm d on e.dorm_id=d.id " +
                    "inner join building b on d.building_id=b.id " +
                    "inner join sender r on e.sender_id=r.id ";
            if (!String.IsNullOrEmpty(condition))
            {
                sql += " where "+condition;
            }
            List<Express> result = new List<Express>();        
            DataTable dt = helper.Query(sql, null);
            foreach (DataRow dr in dt.Rows)
            {
                Express express = new Express();
                express.Id = dr["id"].ToString();
                express.ExpressCode = dr["code"].ToString();
                express.ExpressTitle = dr["title"].ToString();
                express.StudentCode = dr["studentcode"].ToString();
                express.StudentName = dr["name"].ToString();
                express.StudentId = dr["studentid"].ToString();
                express.BuildingName = dr["building_name"].ToString();
                express.DormName = dr["dorm_name"].ToString();
                if (dr["delegate_time"] == DBNull.Value)
                    express.DelegateTime = null;
                else
                    express.DelegateTime = DateTime.Parse(dr["delegate_time"].ToString());
                if (dr["receive_time"] == DBNull.Value)
                    express.ReceiveTime = null;
                else
                    express.ReceiveTime = DateTime.Parse(dr["receive_time"].ToString());
                express.Status = int.Parse(dr["status"].ToString());
                result.Add(express);
            }
            return result;
        }

        catch (Exception e)
        {
            throw e;
        }
        finally
        {
            if(helper != null)
                helper.DisConnect();
        }
    }

    public Express FindOne(String id)
    {
        List<Express> data = Find("e.id='"+id+"'");
        if (data == null || data.Count == 0)
            return null;
        return data[0];
     
    }

    public void Insert(Express express)
    {
        SqlHelper helper = null;
        try
        {
            helper = new SqlHelper();
            
            String sql = "insert into express (id,code,title,dorm_id,student_id,sender_id,delegate_time,status) " +
                    " values(@id,@code,@title,@dorm_id,@student_id,@sender_id,@delegate_time,0)";
            SqlParameter[] p = new SqlParameter[7];
            p[0] = new SqlParameter("@id", Guid.NewGuid().ToString());
            p[1] = new SqlParameter("@code", express.ExpressCode);
            p[2] = new SqlParameter("@title", express.ExpressTitle);
            p[3] = new SqlParameter("@dorm_id", express.DormId);
            p[4] = new SqlParameter("@student_id", express.StudentId);
            p[5] = new SqlParameter("@sender_id", express.SenderId);
            p[6] = new SqlParameter("@delegate_time", DateTime.Now);
            helper.Save(sql, p);
        }
        catch (Exception e)
        {
            throw e;
        }
        finally
        {
            if (helper != null)
            {
                helper.DisConnect();
            }
        }
    }

    public void Update(Express express)
    {
        SqlHelper helper = null;
        try
        {
            helper = new SqlHelper();
            if (express.Id.Equals("2"))
            {
                String sql = "update express set status=@status where id=@id";
                SqlParameter[] p = new SqlParameter[2];
                p[0] = new SqlParameter("@status", express.Status);
                p[1] = new SqlParameter("@id", express.Id);
                helper.Save(sql, p);
            }
            else if (express.Id.Equals("1"))
            {
                string time = DateTime.Now.ToString("yyyy-MM-dd HH:mm:ss");
                String sql = "update express set status=@status,receive_time=@time where id=@id";
                SqlParameter[] p = new SqlParameter[3];
                p[0] = new SqlParameter("@status", express.Status);
                p[1] = new SqlParameter("@time", time);
                p[2] = new SqlParameter("@id", express.Id);
                helper.Save(sql, p);
            }
        }
        catch (Exception e)
        {
            throw e;
        }
        finally
        {
            if (helper != null)
            {
                helper.DisConnect();
            }
        }
    }

    public void Delete(String id)
    {

    }

    private Express ToExpress(DataRow dr)
    {
        Express express = new Express();
        express.Id = dr["id"].ToString();
        express.ExpressCode = dr["code"].ToString();
        express.StudentCode = dr["studentcode"].ToString();
        express.StudentName = dr["name"].ToString();
        express.StudentId = dr["studentid"].ToString();
        express.BuildingName = dr["building_name"].ToString();
        express.DormName = dr["dorm_name"].ToString();
        express.DormId = dr["dorm_id"].ToString();
        express.SenderId = dr["sender_id"].ToString();
        if (dr["delegate_time"] == DBNull.Value)
            express.DelegateTime = null;
        else
            express.DelegateTime = DateTime.Parse(dr["delegate_time"].ToString());
        if (dr["receive_time"] == DBNull.Value)
            express.ReceiveTime = null;
        else
            express.ReceiveTime = DateTime.Parse(dr["receive_time"].ToString());
        express.Status = int.Parse(dr["status"].ToString());
        return express;
    }
}