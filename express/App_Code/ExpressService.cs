using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

/// <summary>
/// ExpressService 的摘要说明
/// </summary>
public class ExpressService
{
    private ExpressDao expressDao;
    public ExpressService()
    {
        expressDao = new ExpressDao();
    }

    public List<Express> FindExpress(String condition)
    {
        return expressDao.Find(condition);
    }

    public Express FindExpressById(String id)
    {
        return expressDao.FindOne(id);
    }

    public void SaveExpress(Express express)
    {
        if (String.IsNullOrEmpty(express.Id))
        {
            expressDao.Insert(express);
        }else {
            expressDao.Update(express);
        }
    }
}