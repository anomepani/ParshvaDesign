using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Parshvnath
{
    public partial class AdvanceBooking : System.Web.UI.Page
    {

        // private GridViewH
        private GridViewHelper helper;
        protected void Page_Load(object sender, EventArgs e)
        {
            if (SessionManager.AdminID == -1)
            {
                Response.Redirect("Default.aspx");
            }

            if (!IsPostBack)
            {
                helper = new GridViewHelper(this.gvHoardingMaster, false);
                helper.RegisterGroup("CityName", true, true);
                helper.RegisterGroup("Area", true, true);
                helper.RegisterGroup("SubArea", true, true);
                helper.GroupHeader += new GroupEvent(helper_GroupHeader);
                BindHoardingMasterGrid();

                //helper.ApplyGroupSort();


            }
        }
        private void helper_GroupHeader(string groupName, object[] values, GridViewRow row)
        {
            if (groupName == "CityName")
            {

                row.Cells[0].Text = "&nbsp;&nbsp;" + row.Cells[0].Text;
                row.Attributes.Add("class", "CityCell");
            }
            else if (groupName == "Area")
            {
                row.Cells[0].Text = "&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;" + row.Cells[0].Text;
                row.Attributes.Add("class", "AreaCell");

            }
            else if (groupName == "SubArea")
            {
                row.Cells[0].Text = "&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;" + row.Cells[0].Text;
                row.Attributes.Add("class", "SubAreaCell");

            }
        }

        protected void BindHoardingMasterGrid()
        {

            try
            {
                gvHoardingMaster.DataSource = Global.dc.GetAdvanceHoardingDetails().ToList();
                gvHoardingMaster.DataBind();
            }
            catch (Exception)
            {

            }
        }

        protected void gvHoardingMaster_RowDataBound(object sender, GridViewRowEventArgs e)
        {
            if (e.Row.RowType == DataControlRowType.DataRow)
            {


                var data = e.Row.DataItem as GetAdvanceHoardingDetails_Result;



                if (data.area != data.SubArea)
                {
                    if (data.area.ToLower().Trim() == "jubilee ground")
                    {
                        e.Row.Cells[0].Attributes.Add("class", "DarkBlue");

                    }
                    else if (data.area.ToLower().Trim() == "kutchmitra circle")
                    {
                        e.Row.Cells[0].Attributes.Add("class", "LightBlue");
                    }
                    else if (data.area.ToLower().Trim() == "bus station")
                    {
                        e.Row.Cells[0].Attributes.Add("class", "LightPink");
                    }
                }
                //If EndDate is less than current date then it is inactive(Expired) otherwise active  
                // Here we may have Advance booking if available 
                if (data.FromDate > DateTime.Now)
                {
                    e.Row.CssClass = "advance-booking";
                }
                else
                {
//                    e.Row.CssClass = "active-row";
                }
                e.Row.CssClass = e.Row.CssClass + " is-child child-" + (data.SubAreaID == null ? data.AreaID : data.SubAreaID);
                // OLD CODE COMMENTED
                //if (data.IsExpired.HasValue && !data.IsExpired.Value)
                //{
                //    //e.Row.CssClass = "active-row";
                //    e.Row.CssClass = "advance-booking";
                //}
                //else if (data.IsExpired.HasValue && data.IsExpired.Value)
                //{

                //    //e.Row.CssClass = "inactive-row";

                //}
                //else
                //{

                //    //  e.Row.CssClass="active-row";
                //}
                // OLD CODE END
                //bool isExpired = e.Row.FindControl("IsExpired") as Label;
                //int quantity = int.Parse(e.Row.Cells[1].Text);
                //foreach (TableCell cell in e.Row.Cells)
                //{
                //    if (quantity == 0)
                //    {
                //        cell.BackColor = Color.Red;
                //    }
                //    if (quantity > 0 && quantity <= 50)
                //    {
                //        cell.BackColor = Color.Yellow;
                //    }
                //    if (quantity > 50 && quantity <= 100)
                //    {
                //        cell.BackColor = Color.Orange;
                //    }
                //}
            }

        }

    }
}