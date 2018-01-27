using System;
using System.Collections.Generic;
using System.Data;
using System.Globalization;
using System.Linq;
using System.Web;
using System.Web.Script.Serialization;
using System.Web.Services;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Parshvnath
{
    public partial class ViewHoarding : System.Web.UI.Page
    {
        private GridViewHelper helper;
        protected void Page_Load(object sender, EventArgs e)
        {

            if (SessionManager.AdminID == -1)
            {
                Response.Redirect("Default.aspx");
            }

            if (!IsPostBack)
            {
                //helper = new GridViewHelper(this.grdHoarding, false);
                //helper.RegisterGroup("CompanyName", true, true);
                ////  helper.RegisterGroup("Area", true, true);
                //helper.RegisterGroup("SubArea", true, true);
                //helper.GroupHeader += new GroupEvent(helper_GroupHeader);
                BindHoardingGrid();
            }

        }

        private void helper_GroupHeader(string groupName, object[] values, GridViewRow row)
        {
            if (groupName == "CompanyName")
            {

                row.Cells[0].Text = "&nbsp;&nbsp;" + row.Cells[0].Text;
                row.Attributes.Add("class", "CityCell");
            }
            //else if (groupName == "Area")
            //{
            //    row.Cells[0].Text = "&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;" + row.Cells[0].Text;
            //    row.Attributes.Add("class", "AreaCell");

            //}
            //else if (groupName == "SubArea")
            //{
            //    row.Cells[0].Text = "&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;" + row.Cells[0].Text;
            //    row.Attributes.Add("class", "SubAreaCell");

            //}
        }

        protected void BindHoardingGrid()
        {

            try
            {
                var hoardingDetails = Global.dc.GetAllHoardingEntry().ToList();
                Session["HoardingDetails"] = hoardingDetails;
                grdHoarding.DataSource = hoardingDetails;
                grdHoarding.DataBind();

            }
            catch (Exception)
            {


            }
        }

        protected void ChangePage(object sender, GridViewPageEventArgs e)
        {
            try
            {
                List<GetAllHoardingEntry_Result> hoarding = Session["HoardingDetails"] as List<GetAllHoardingEntry_Result>;

                // hoarding = hoarding.OrderBy(i => i.ID).Skip().Take(2).ToList();
                if (ViewState["Exp"] == null)
                {
                    ViewState["Exp"] = "HoadingHistoryID";
                    ViewState["Direction"] = "Asc";
                }
                //                hoarding = hoarding.OrderBy(i => i.ID).ToList();
                //hoardingSession["HoardingDetails"] = hoarding;
                grdHoarding.PageIndex = e.NewPageIndex;
                grdHoarding.DataSource = Session["HoardingDetails"];

                grdHoarding.DataBind();
            }
            catch (Exception)
            {
            }
            finally
            {

            }
        }


        protected void Sorting(object sender, GridViewSortEventArgs e)
        {
            try
            {
                List<GetAllHoardingEntry_Result> hoarding = Session["HoardingDetails"] as List<GetAllHoardingEntry_Result>;


                string sortingDirection = string.Empty;

                if (Dir == SortDirection.Ascending)
                {

                    Dir = SortDirection.Descending;

                    sortingDirection = "Desc";

                }
                else
                {

                    Dir = SortDirection.Ascending;

                    sortingDirection = "Asc";

                }

                if (hoarding != null && hoarding.Count > 0)
                {

                    if (sortingDirection == "Desc" && e.SortExpression == "HoardingNo")
                    {
                        hoarding = hoarding.OrderByDescending(i => i.HoardingNo).ToList();
                    }
                    else if (sortingDirection == "Asc" && e.SortExpression == "HoardingNo")
                    {
                        hoarding = hoarding.OrderBy(i => i.HoardingNo).ToList();
                    }
                    else if (sortingDirection == "Desc" && e.SortExpression == "CompanyName")
                    {
                        hoarding = hoarding.OrderByDescending(i => i.CompanyName).ToList();
                    }
                    else if (sortingDirection == "Asc" && e.SortExpression == "CompanyName")
                    {
                        hoarding = hoarding.OrderBy(i => i.CompanyName).ToList();
                    }
                    else if (sortingDirection == "Desc" && e.SortExpression == "Amount")
                    {
                        hoarding = hoarding.OrderByDescending(i => i.Amount).ToList();
                    }
                    else if (sortingDirection == "Asc" && e.SortExpression == "Amount")
                    {
                        hoarding = hoarding.OrderBy(i => i.Amount).ToList();
                    }
                    else if (sortingDirection == "Desc" && e.SortExpression == "ToDate")
                    {
                        hoarding = hoarding.OrderByDescending(i => i.ToDate).ToList();
                    }
                    else if (sortingDirection == "Asc" && e.SortExpression == "ToDate")
                    {
                        hoarding = hoarding.OrderBy(i => i.ToDate).ToList();
                    }
                    else if (sortingDirection == "Desc" && e.SortExpression == "FromDate")
                    {
                        hoarding = hoarding.OrderByDescending(i => i.FromDate).ToList();

                    }
                    else if (sortingDirection == "Asc" && e.SortExpression == "FromDate")
                    {
                        hoarding = hoarding.OrderBy(i => i.FromDate).ToList();

                    }
                    else if (sortingDirection == "Desc" && e.SortExpression == "CityName")
                    {
                        hoarding = hoarding.OrderByDescending(i => i.CityName).ToList();

                    }
                    else if (sortingDirection == "Asc" && e.SortExpression == "CityName")
                    {
                        hoarding = hoarding.OrderBy(i => i.CityName).ToList();

                    }
                    else if (sortingDirection == "Desc" && e.SortExpression == "Area")
                    {
                        hoarding = hoarding.OrderByDescending(i => i.Area).ToList();

                    }
                    else if (sortingDirection == "Asc" && e.SortExpression == "Area")
                    {
                        hoarding = hoarding.OrderBy(i => i.Area).ToList();

                    }
                    else if (sortingDirection == "Desc" && e.SortExpression == "SubArea")
                    {
                        hoarding = hoarding.OrderByDescending(i => i.SubArea).ToList();

                    }
                    else if (sortingDirection == "Asc" && e.SortExpression == "SubArea")
                    {
                        hoarding = hoarding.OrderBy(i => i.SubArea).ToList();

                    }


                    ViewState["Exp"] = e.SortExpression;
                    ViewState["Direction"] = sortingDirection;
                    Session["HoardingDetails"] = hoarding;

                    grdHoarding.DataSource = hoarding;
                    grdHoarding.DataBind();
                }
            }
            catch (Exception)
            {
            }
            finally
            { }
        }

        public SortDirection Dir
        {

            get
            {

                if (ViewState["dirState"] == null)
                {

                    ViewState["dirState"] = SortDirection.Ascending;

                }

                return (SortDirection)ViewState["dirState"];

            }

            set
            {

                ViewState["dirState"] = value;

            }

        }







        [WebMethod]
        public static string DeleteHoarding(string ID)
        {


            string result = string.Empty;
            try
            {
                int HoardingID = Convert.ToInt32(ID);


                //Remove hoarding history details
                HoardingHistory hoardingHistory = Global.dc.HoardingHistories.FirstOrDefault(i => i.HoadingHistoryID == HoardingID && i.IsActive == true && (!i.IsDeleted.Value || !i.IsDeleted.HasValue));
                if (hoardingHistory != null)
                {

                    hoardingHistory.IsDeleted = true;
                    int count = Global.dc.SaveChanges();
                    if (count > 0)
                    {
                        //HoardingDetail hoarding = Global.dc.HoardingDetails.FirstOrDefault(i => i.HoardingID == hoardingHistory.HoardingID && i.IsActive == true && (!i.IsDeleted.Value || !i.IsDeleted.HasValue));
                        //if (hoarding != null)
                        //{
                        //    count = 0;
                        //    hoarding.IsDeleted = true;
                        //    count = Global.dc.SaveChanges();
                        //    result = count.ToString();
                        //}
                        //else
                        //{
                        //    result = "3";
                        //}
                    }
                    else
                    {
                        result = "2";

                    }
                    result = Convert.ToString(count);

                }
                else
                {
                    result = "3";
                }
            }
            catch (Exception)
            {
                result = "-1";

            }
            return result;
        }

        [WebMethod]
        public static string EditHoarding(string ID)
        {


            HoardingHistory hoardingHistory = new HoardingHistory();
            Hoarding hoarding = new Hoarding();
            UserDetail result = new UserDetail();
            int HoardingID = Convert.ToInt32(ID);
            try
            {
                hoardingHistory = Global.dc.HoardingHistories.FirstOrDefault(i => i.HoadingHistoryID == HoardingID && i.IsActive == true && (!i.IsDeleted.Value || !i.IsDeleted.HasValue));
                if (hoardingHistory != null)
                {
                    //hoarding.Amount = hoardingHistory.Amount;
                    //hoarding.FromDate = hoardingHistory.FromDate;
                    //hoarding.ToDate = hoardingHistory.ToDate;
                    //hoarding.CityID = hoardingHistory.City;
                    //hoarding.AreaID = hoardingHistory.Area;
                    //hoarding.AreaName = hoardingHistory.AreaDetail.Area;

                    //hoarding.CityName = hoardingHistory.CityDetail.CityName;
                    //hoarding.HoardingBanner = hoardingHistory.BannerName;
                    //hoarding.UserID = hoardingHistory.HoardingDetail.UserID;
                    //hoarding.HoardingNo = hoardingHistory.HoardingNo;
                    //hoarding.HoardingID = hoardingHistory.HoardingID;
                    //hoarding.Username = hoardingHistory.HoardingDetail.UserDetail.PersonName;
                    //hoarding.ID = hoardingHistory.HoadingHistoryID;
                }
            }
            catch (Exception)
            {


            }
            return new JavaScriptSerializer().Serialize(hoarding);
        }

        [WebMethod]
        public static string UpdateHoarding(string ID, string HoardingNo, string User, string Area, string City, string FromDate, string ToDate, string Amount, string FileName)
        {
            // result 0 for not saved
            // result -1 for some internal error
            // result 1 or greater than 1 for successfuly saved
            string result = "0";

            UserDetail user = new UserDetail();
            HoardingHistory hoarding = new HoardingHistory();
            int HoardingHistoryID = Convert.ToInt32(ID);
            try
            {
                hoarding = Global.dc.HoardingHistories.FirstOrDefault(i => i.IsActive == true && (!i.IsDeleted.Value || !i.IsDeleted.HasValue) && i.HoadingHistoryID == HoardingHistoryID);

                if (hoarding != null)
                {
                    //hoarding.HoardingNo = HoardingNo;
                    //hoarding.Area = Convert.ToInt32(Area);
                    //hoarding.City = Convert.ToInt32(City);
                    //hoarding.FromDate = DateTime.ParseExact(FromDate, "dd/MM/yyyy", null);
                    //hoarding.ToDate = DateTime.ParseExact(ToDate, "dd/MM/yyyy", null);
                    //hoarding.Amount = Convert.ToDecimal(Amount);
                    //if (!string.IsNullOrEmpty(FileName))
                    //{
                    //    hoarding.BannerName = FileName;
                    //}
                    //int count = Global.dc.SaveChanges();
                    // result = count.ToString();
                }
                else
                {
                    result = "3";
                }
            }
            catch (Exception)
            {
                result = "-1";

            }
            return result;

        }

        protected void grdHoarding_RowDataBound(object sender, GridViewRowEventArgs e)
        {
            if (e.Row.RowType == DataControlRowType.DataRow)
            {

                var data = e.Row.DataItem as GetAllHoardingEntry_Result;


                if (data.IsExpired.HasValue && !data.IsExpired.Value)
                {
                    e.Row.CssClass = "active-row";

                }
                else if (data.IsExpired.HasValue && data.IsExpired.Value)
                {

                    //   e.Row.CssClass = "inactive-row";

                }
                else
                {

                    //  e.Row.CssClass="active-row";
                }

            }

        }

        protected void btnHoarding_Click(object sender, EventArgs e)
        {
            Response.Redirect("HoardingEntery.aspx");
        }

        protected void btnSearch_Click(object sender, EventArgs e)
        {
            try
            {
                if (txtSearch.Text.Trim().Length > 0)
                {
                    var hoardingDetails = Global.dc.GetAllHoardingEntry().ToList();
                    hoardingDetails = hoardingDetails.FindAll(i => i.CompanyName.ToLower().StartsWith(txtSearch.Text.ToLower())).ToList();
                    Session["HoardingDetails"] = hoardingDetails;
                    grdHoarding.DataSource = hoardingDetails;
                    grdHoarding.DataBind();

                }
            }
            catch (Exception)
            {

            }

        }
    }

}
