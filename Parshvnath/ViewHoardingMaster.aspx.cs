using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Parshvnath
{
    public partial class ViewHoardingMaster : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (SessionManager.AdminID == -1)
            {
                Response.Redirect("Default.aspx");
            }
            if (!IsPostBack)
            {
                BindHoardingMasterGrid();
            }
        }

        protected void BindHoardingMasterGrid()
        {

            try
            {

                gvHoardingMaster.DataSource = Global.dc.GetHoardingMaster().ToList();
                gvHoardingMaster.DataBind();
            }
            catch (Exception)
            {

            }
        }

    }
}