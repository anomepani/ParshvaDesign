using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Parshvnath
{
    public partial class ViewReport : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (SessionManager.AdminID == -1)
            {
                Response.Redirect("Default.aspx");
            }

            if (!IsPostBack)
            {
                BindHoardingGrid();
            }
        }


        protected void BindHoardingGrid()
        {

            try
            {
                var hoardingDetails = Global.dc.GetAllHoardingEntry();
                Session["HoardingDetails"] = hoardingDetails;
                grdHoarding.DataSource = hoardingDetails;
                grdHoarding.DataBind();
            }
            catch (Exception ex)
            {


            }
        }

    

        protected void ChangePage(object sender, GridViewPageEventArgs e)
        {
            try
            {
                List<Hoarding> hoarding = Session["HoardingDetails"] as List<Hoarding>;

                // hoarding = hoarding.OrderBy(i => i.ID).Skip().Take(2).ToList();
                if (ViewState["Exp"] == null)
                {
                    ViewState["Exp"] = "ID";
                    ViewState["Direction"] = "Asc";
                }
                //                hoarding = hoarding.OrderBy(i => i.ID).ToList();
                //hoardingSession["HoardingDetails"] = hoarding;
                grdHoarding.PageIndex = e.NewPageIndex;
                grdHoarding.DataSource = Session["HoardingDetails"];

                grdHoarding.DataBind();
            }
            catch (Exception ex)
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
                      //  hoarding = hoarding.OrderByDescending(i => i.HoardingNo).ToList();
                    }
                    else if (sortingDirection == "Asc" && e.SortExpression == "HoardingNo")
                    {
                        //hoarding = hoarding.OrderBy(i => i.HoardingNo).ToList();
                    }
                    else if (sortingDirection == "Desc" && e.SortExpression == "Area")
                    {
                       // hoarding = hoarding.OrderByDescending(i => i.AreaName).ToList();
                    }
                    else if (sortingDirection == "Asc" && e.SortExpression == "Area")
                    {
                   //     hoarding = hoarding.OrderBy(i => i.AreaName).ToList();
                    }
                    else if (sortingDirection == "Desc" && e.SortExpression == "ToDate")
                    {
                        hoarding = hoarding.OrderByDescending(i => i.ToDate).ToList();

                    }
                    else if (sortingDirection == "Asc" && e.SortExpression == "ToDate")
                    {
                        hoarding = hoarding.OrderBy(i => i.ToDate).ToList();

                    }


                    ViewState["Exp"] = e.SortExpression;
                    ViewState["Direction"] = sortingDirection;
                    Session["HoardingDetails"] = hoarding;

                    grdHoarding.DataSource = hoarding;
                    grdHoarding.DataBind();
                }
            }
            catch (Exception ex)
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

        protected void btnSearch_Click(object sender, EventArgs e)
        {
            List<GetAllHoardingEntry_Result> resultData = new List<GetAllHoardingEntry_Result>();
            try
            {
                if (ddlSearchType.SelectedValue == "0")
                {
               //     resultData = HoardingDetailList();
                }
                else if (ddlSearchType.SelectedValue == "1")
                {
              //      resultData = HoardingDetailList().Where(i => i.Username.ToLower().StartsWith(txtSearch.Text.Trim().ToLower())).ToList();
                }
                else if (ddlSearchType.SelectedValue == "2")
                {
              //      resultData = HoardingDetailList().Where(i => i.CityName.ToLower().StartsWith(txtSearch.Text.Trim().ToLower())).ToList();
                }
                else if (ddlSearchType.SelectedValue == "3")
                {
                    //                resultData = HoardingDetailList().Where(i => i.PhoneNo.ToLower().StartsWith(txtSearch.Text.Trim().ToLower())).ToList();
                }
                Session["HoardingDetails"] = resultData;
                grdHoarding.DataSource = resultData;
                grdHoarding.DataBind();

            }
            catch (Exception ex)
            {


            }


        }

        protected void txtSearch_TextChanged(object sender, EventArgs e)
        {
            List<GetAllHoardingEntry_Result> resultData = new List<GetAllHoardingEntry_Result>();
            try
            {
                if (ddlSearchType.SelectedValue == "0")
                {
                 //   resultData = HoardingDetailList().Where(i => i.IsExpired == chkIsExpired.Checked && i.IsRenewed == chkIsRenewed.Checked).ToList();
                }
                else if (ddlSearchType.SelectedValue == "1")
                {
               //     resultData = HoardingDetailList().Where(i => i.IsExpired == chkIsExpired.Checked && i.IsRenewed == chkIsRenewed.Checked && i.Username.ToLower().StartsWith(txtSearch.Text.Trim().ToLower())).ToList();
                }
                else if (ddlSearchType.SelectedValue == "2")
                {
              //      resultData = HoardingDetailList().Where(i => i.IsExpired == chkIsExpired.Checked && i.IsRenewed == chkIsRenewed.Checked && i.CityName.ToLower().StartsWith(txtSearch.Text.Trim().ToLower())).ToList();
                }
                else if (ddlSearchType.SelectedValue == "3")
                {
                    //                resultData = HoardingDetailList().Where(i => i.PhoneNo.ToLower().StartsWith(txtSearch.Text.Trim().ToLower())).ToList();
                }

                Session["HoardingDetails"] = resultData;
                grdHoarding.DataSource = resultData;
                grdHoarding.DataBind();

            }
            catch (Exception ex)
            {


            }

        }



    }
}