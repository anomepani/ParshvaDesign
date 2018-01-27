using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Services;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Parshvnath
{
    public partial class ViewCity : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

            if (SessionManager.AdminID == -1)
            {
                Response.Redirect("Default.aspx");
            }
            if (!IsPostBack)
            {
                BindCityGrid();
            }
        }
        protected void BindCityGrid()
        {

            try
            {
                grdCity.DataSource = Global.dc.CityDetails.Where(i => i.IsActive == true && (!i.IsDeleted.Value || !i.IsDeleted.HasValue)).ToList();
                grdCity.DataBind();
            }
            catch (Exception)
            {


            }
        }

      

        [WebMethod]
        public static string DeleteCity(string ID)
        {
            string result = string.Empty;
            try
            {
                int CityID = Convert.ToInt32(ID);
                AreaDetail area = Global.dc.AreaDetails.FirstOrDefault(i => i.ID == CityID && i.IsActive == true && (!i.IsDeleted.Value || !i.IsDeleted.HasValue));
                if (area != null)
                {
                    //City Is used in another 
                    result = "4";

                }
                else
                {
                    CityDetail city = Global.dc.CityDetails.FirstOrDefault(i => i.ID == CityID && i.IsActive == true && (!i.IsDeleted.Value || !i.IsDeleted.HasValue));
                    if (city != null)
                    {
                        city.IsDeleted = true;
                        int count = Global.dc.SaveChanges();
                        result = Convert.ToString(count);

                    }
                    else
                    {
                        result = "3";
                    }
                }
            }
            catch (Exception)
            {
                result = "-1";

            }
            return result;
        }

        [WebMethod]
        public static string AddCity(string CityName, string Operation, string ID)
        {
            // result 0 for not saved
            // result -1 for some internal error
            // result 1 or greater than 1 for successfuly saved
            string result = "0";
            CityDetail city = new CityDetail();

            try
            {

                if (Operation == "add")
                {
                    var IsCityExsist = Global.dc.CityDetails.FirstOrDefault(i => i.IsActive == true && (!i.IsDeleted.Value || !i.IsDeleted.HasValue) && i.CityName.ToLower() == CityName.ToLower());
                    if (IsCityExsist != null)
                    {
                        result = "2";
                    }
                    else
                    {

                        city.CityName = CityName;
                        city.IsActive = true;
                        city.IsDeleted = false;

                        Global.dc.CityDetails.Add(city);

                        int count = Global.dc.SaveChanges();
                        result = Convert.ToString(count);
                    }

                }
                else if (Operation == "edit")
                {
                    int CityID = Convert.ToInt32(ID);
                    var IsCityExsist = Global.dc.CityDetails.FirstOrDefault(i => i.IsActive == true && (!i.IsDeleted.Value || !i.IsDeleted.HasValue) && i.CityName.ToLower() == CityName.ToLower() && i.ID != CityID);
                    if (IsCityExsist != null)
                    {
                        result = "2";
                    }
                    else
                    {
                        city = Global.dc.CityDetails.FirstOrDefault(i => i.IsActive == true && (!i.IsDeleted.Value || !i.IsDeleted.HasValue));
                        if (city != null)
                        {
                            city.CityName = CityName;

                            int count = Global.dc.SaveChanges();
                            result = Convert.ToString(count);
                        }
                        else
                        {
                            result = "0";
                        }
                    }

                }
            }
            catch (Exception)
            {
                result = "-1";

            }
            return result;
        }

        [WebMethod]
        public static string EditCity(string ID)
        {
            string result = string.Empty;
            try
            {
                int CityID = Convert.ToInt32(ID);
                CityDetail city = Global.dc.CityDetails.FirstOrDefault(i => i.ID == CityID && i.IsActive == true && (!i.IsDeleted.Value || !i.IsDeleted.HasValue));
                if (city != null)
                {
                    result = city.CityName;

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


    }
}