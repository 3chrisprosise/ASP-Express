using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class ModifyExpress : System.Web.UI.Page
{
    public Express CurrentExpress { get; set; }
    protected void Page_Load(object sender, EventArgs e)
    {
        ExpressService expressService = new ExpressService();
        if (!IsPostBack) {
            String id = Request["id"];
            CurrentExpress = expressService.FindExpressById(id);
        }
    }
}