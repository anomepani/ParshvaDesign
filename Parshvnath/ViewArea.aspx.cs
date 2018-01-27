using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Services;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.Script.Serialization;
namespace Parshvnath
{
    public partial class ViewArea : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

            if (SessionManager.AdminID == -1)
            {
                Response.Redirect("Default.aspx");
            }
            if (!IsPostBack)
            {
                BindAreaGrid();
            }
        }
        protected void BindAreaGrid()
        {

            try
            {
                grdArea.DataSource = Global.dc.AreaDetails.Where(i => i.IsActive == true && (!i.IsDeleted.Value || !i.IsDeleted.HasValue)).Select(i => new Area() { ID = i.ID, AreaName = i.Area, CityID = i.CityID, CityName = i.CityDetail.CityName }).ToList();
                grdArea.DataBind();
            }
            catch (Exception)
            {


            }
        }


        [WebMethod]
        public static string AddArea(string CityID, string AreaName, string Operation, string ID)
        {
            // result 0 for not saved
            // result -1 for some internal error
            // result 1 or greater than 1 for successfuly saved
            string result = "0";
            AreaDetail area = new AreaDetail();

            try
            {
                int AreaID = Convert.ToInt32(ID);
                if (Operation == "add")
                {


                    area.CityID = Convert.ToInt32(ID); ;

                    area.IsActive = true;

                    area.IsDeleted = false;

                    Global.dc.AreaDetails.Add(area);

                    int count = Global.dc.SaveChanges();
                    result = Convert.ToString(count);
                }


                else if (Operation == "edit")
                {

                    area.CityID = Convert.ToInt32(ID); ;

                    area.Area = AreaName;

                    int count = Global.dc.SaveChanges();
                    result = Convert.ToString(count);


                }
            }
            catch (Exception)
            {
                result = "-1";

            }
            return result;
        }



    }
}