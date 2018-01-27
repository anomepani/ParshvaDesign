using System;
using System.Collections.Generic;
using System.Data.Objects;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Parshvnath
{
    public partial class FullReport : System.Web.UI.Page
    {
        static int d = 20;
        protected void Page_Load(object sender, EventArgs e)
        {
            d = 21;

            Response.Write("<h1>" + d + "</h1>");
            d = d + 1;
            if (!IsPostBack)
            {
                gvReport.DataSource = Global.dc.UserDetails.Where(i => i.IsActive.Value && (!i.IsDeleted.HasValue || !i.IsDeleted.Value)).ToList();
                gvReport.DataBind();
            }
            Response.Write(d);
            Response.Write("<h1>" + d + "</h1>");

        }

        protected void gvReport_RowDataBound(object sender, GridViewRowEventArgs e)
        {
            //if (e.Row.RowType == DataControlRowType.DataRow)
            //{
            //    GridView gvReports = e.Row.FindControl("gvMonths") as GridView;
            //    gvReports.DataSource = getMonths();
            //    gvReports.DataBind();
            //}
            if (e.Row.RowType == DataControlRowType.DataRow)
            {
                GridView gvYears = e.Row.FindControl("gvYears") as GridView;
                gvYears.DataSource = getYears();
                gvYears.DataBind();
            }
        }
        public class Years
        {
            public int Year { get; set; }
            public int YearID { get; set; }

        }
        public List<Years> getYears()
        {
            List<Years> result = new List<Years>() 
            {
            new Years(){YearID=1,Year=2014}
            ,new Years(){YearID=2,Year=2015}
           // ,new Years(){YearID=1,Year=2016}
            };
            return result;
        }
        public class Months
        {

            public string Month { get; set; }
            public int MonthID { get; set; }
        }

        public List<Months> getMonths()
        {
            List<Months> result = new List<Months>()
            {
                new Months() { Month = "January",MonthID=1 }
                , new Months() { Month = "February",MonthID=2 }
                , new Months() { Month = "March" ,MonthID=3}
                ,   new Months() { Month = "April" ,MonthID=4}
                , new Months() { Month = "May" ,MonthID=5}
                , new Months() { Month = "June" ,MonthID=6}
                ,  new Months() { Month = "July" ,MonthID=7}
                , new Months() { Month = "August" ,MonthID=8}
                , new Months() { Month = "September" ,MonthID=9},
                new Months() { Month = "October" ,MonthID=10}
                , new Months() { Month = "November" ,MonthID=11}
                , new Months() { Month = "December" ,MonthID=12}
            };

            return result;
        }

        protected void gvMonths_RowDataBound(object sender, GridViewRowEventArgs e)
        {
            if (e.Row.RowType == DataControlRowType.DataRow)
            {
                int userid = Convert.ToInt32((e.Row.Parent.Parent.Parent.Parent.Parent.Parent.Parent.Parent.FindControl("hdnUserID") as HiddenField).Value);
                GridView gvMonth = e.Row.Parent.Parent as GridView;
                int month = Convert.ToInt32(gvMonth.DataKeys[e.Row.RowIndex].Value.ToString());
              int year= Convert.ToInt32((e.Row.Parent.Parent.Parent.Parent.FindControl("hdnYear")  as HiddenField).Value);
                GridView gvHoardings = e.Row.FindControl("gvHoardings") as GridView;
                //gvHoardings.DataSource =  Global.dc.HoardingHistories.Where(i => i.FromDate.Value.ToString("MMMM").ToLower() == months.ToLower()).ToList();
                gvHoardings.DataSource = (from hoarding in Global.dc.HoardingHistories
                                          where hoarding.FromDate.Value.Year == year && hoarding.FromDate.Value.Year == year && hoarding.UserID == userid
                                          select hoarding).ToList();
                gvHoardings.DataBind();
            }

        }

        protected void gvYears_RowDataBound(object sender, GridViewRowEventArgs e)
        {
            if (e.Row.RowType == DataControlRowType.DataRow)
            {
                GridView gvMonths = e.Row.FindControl("gvMonths") as GridView;
                gvMonths.DataSource = getMonths();
                gvMonths.DataBind();
            }
        }
    }
}