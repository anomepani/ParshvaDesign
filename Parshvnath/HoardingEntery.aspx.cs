using System;
using System.Collections.Generic;
using System.Globalization;
using System.IO;
using System.Linq;
using System.Web;
using System.Web.Services;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Parshvnath
{
    public partial class HoardingEntery : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {


            if (SessionManager.AdminID == -1)
            {
                Response.Redirect("Default.aspx");
            }
            else
            {
                if (!IsPostBack && Request.QueryString["ID"] != null)
                {
                    int hoardingMasterID = Convert.ToInt32(Request.QueryString["ID"]);

                    var result = Global.dc.GetHoardingMasterByID(hoardingMasterID).FirstOrDefault();
                    if (result != null)
                    {
                        //record found so bind data to form
                        txtArea.Text = result.Area;
                        city.Text = result.CityName;
                        txtSubArea.Text = result.SubArea;
                        txtHoardingNo.Text = Convert.ToString( result.HoardingNo);
                        hdnArea.Value = Convert.ToString(result.AreaID);
                        hdnCity.Value = Convert.ToString(result.CityID);
                        hdnSubArea.Value = Convert.ToString(result.SubAreaID);
                        hdnHoardingMasterID.Value = Convert.ToString(result.ID);

                    }
                    else
                    {
                        // No Such ID Found
                        Response.Redirect("/HoardingMAsterDetail.aspx", false);
                    }

                }
                else
                {

                }
            }
        }

        protected void btnHoardingEntry_Click(object sender, EventArgs e)
        {
            HoardingHistory hoardingHistory = new HoardingHistory();
            string originalFilename = string.Empty, replaceFilename = string.Empty;
            string accounType = string.Empty;
            DateTime fromDate, ToDate;
            try
            {
                fromDate = DateTime.Parse(txtFromDate.Text);
                ToDate = DateTime.Parse(txtToDate.Text);

                accounType = Request.Form["ddlAccountType"];

                if (accounType.ToLower() == "permanent")
                {
                    var result = Global.dc.CheckPermanentEntry(fromDate, ToDate, accounType.ToLower(), Convert.ToInt32(hdnHoardingMasterID.Value)).FirstOrDefault();


                    if (result != null)
                    {
                        Response.Write("<script>alert('Hoarding Entry Already Exist ');</script>");
                    }
                    else
                    {
                        #region Insert New Entry

                        //                        int hoardingID = Global.dc.HoardingHistories.Max(i => i.HoadingHistoryID) + 1;
                        //                      hoarding.HoardingID = hoardingID;
                        hoardingHistory.UserID = Convert.ToInt32(Request.Form["hdnParty"]);
                        hoardingHistory.HoardingMasterID = Convert.ToInt32(Request.Form["hdnHoardingMasterID"]);
                        hoardingHistory.IsActive = true;
                        hoardingHistory.IsDeleted = false;
                        hoardingHistory.FromDate = fromDate;
                        hoardingHistory.ToDate = ToDate;
                        hoardingHistory.Type = accounType.ToLower();
                        hoardingHistory.Amount = Convert.ToDecimal(txtMonthlyAmount.Text);


                        string path = "/Images/HoardingImage/";

                        DirectoryInfo dirInfo = new DirectoryInfo(Server.MapPath(path));

                        if (!dirInfo.Exists)
                        {
                            DirectoryInfo dir = Directory.CreateDirectory(Server.MapPath(path));
                        }

                        if (fileHoardingImage.HasFile)
                        {
                            if (!Directory.Exists(path))
                            {
                                originalFilename = fileHoardingImage.FileName;
                                replaceFilename = GetTimeStamp() + Path.GetExtension(originalFilename);
                                fileHoardingImage.SaveAs(Server.MapPath(path) + replaceFilename);

                            }
                        }
                        //Set image file name in database  

                        hoardingHistory.BannerName = replaceFilename;

                        if (accounType.ToLower() == "permanent")
                        {
                            hoardingHistory.IsPermanent = true;


                        }
                        else if (accounType.ToLower() == "temporary")
                        {
                            hoardingHistory.IsPermanent = false;
                        }
                        hoardingHistory.CreatedDate = DateTime.Now;

                        Global.dc.HoardingHistories.Add(hoardingHistory);
                        int count = Global.dc.SaveChanges();
                        if (count > 0)
                        {

                            Response.Write("<script>alert('Hoarding Entry done successfully.');</script>");


                        }
                        else
                        {
                            //Record insertion failed
                            Response.Write("<script>alert('Some  Internal problem');</script>");
                        }

                        #endregion
                    }

                }
                else if (accounType.ToLower() == "temporary")
                {
                    var result = Global.dc.CheckTemporaryEntry(fromDate, ToDate, accounType.ToLower(), Convert.ToInt32(hdnHoardingMasterID.Value)).ToList();
                    if (result != null)
                    {
                        Response.Write("<script>alert('Temporary Hoarding Entry Already Exist ');</script>");
                    }
                    else
                    {
                        #region Insert New Entry

                        //                        int hoardingID = Global.dc.HoardingHistories.Max(i => i.HoadingHistoryID) + 1;
                        //                      hoarding.HoardingID = hoardingID;
                        hoardingHistory.UserID = Convert.ToInt32(Request.Form["hdnParty"]);
                        hoardingHistory.HoardingMasterID = Convert.ToInt32(Request.Form["hdnHoardingMasterID"]);
                        hoardingHistory.IsActive = true;
                        hoardingHistory.IsDeleted = false;
                        hoardingHistory.FromDate = fromDate;
                        hoardingHistory.ToDate = ToDate;
                        hoardingHistory.Type = accounType.ToLower();
                        hoardingHistory.Amount = Convert.ToDecimal(txtMonthlyAmount.Text);


                        string path = "/Images/HoardingImage/";

                        DirectoryInfo dirInfo = new DirectoryInfo(Server.MapPath(path));

                        if (!dirInfo.Exists)
                        {
                            DirectoryInfo dir = Directory.CreateDirectory(Server.MapPath(path));
                        }

                        if (fileHoardingImage.HasFile)
                        {
                            if (!Directory.Exists(path))
                            {
                                originalFilename = fileHoardingImage.FileName;
                                replaceFilename = GetTimeStamp() + Path.GetExtension(originalFilename);
                                fileHoardingImage.SaveAs(Server.MapPath(path) + replaceFilename);

                            }
                        }
                        //Set image file name in database  

                        hoardingHistory.BannerName = replaceFilename;

                        if (accounType.ToLower() == "permanent")
                        {
                            hoardingHistory.IsPermanent = true;


                        }
                        else if (accounType.ToLower() == "temporary")
                        {
                            hoardingHistory.IsPermanent = false;
                        }
                        hoardingHistory.CreatedDate = DateTime.Now;

                        Global.dc.HoardingHistories.Add(hoardingHistory);
                        int count = Global.dc.SaveChanges();
                        if (count > 0)
                        {

                            Response.Write("<script>alert('Hoarding Entry done successfully.');</script>");


                        }
                        else
                        {
                            //Record insertion failed
                            Response.Write("<script>alert('Some  Internal problem');</script>");
                        }

                        #endregion

                    }


                }




            }
            catch (Exception ex)
            {
                Response.Write("<script>alert('Some  Internal problem');</script>");
            }

        }

        public static string GetTimeStamp()
        {
            return DateTime.Now.ToString("yyyyMMddHHmmssfff");
        }

        [WebMethod]
        public static List<DDLCity> GetCity(string City)
        {
            List<DDLCity> result = new List<DDLCity>();
            try
            {

                result = Global.dc.CityDetails.Where(i => i.IsActive == true && (!i.IsDeleted.Value || !i.IsDeleted.HasValue)).Select(i => new DDLCity() { ID = i.ID, CityName = i.CityName }).ToList().FindAll(i => i.CityName.ToLower().StartsWith(City.ToLower())).ToList();
            }
            catch (Exception ex)
            {


            }
            return result;
        }

        [WebMethod]
        public static List<DDLArea> GetArea(string CityID, string Area)
        {

            List<DDLArea> result = new List<DDLArea>();
            try
            {
                int ID = Convert.ToInt32(CityID);

                result = Global.dc.AreaDetails.Where(i => i.CityID == ID).Select(i => new DDLArea() { ID = i.ID, AreaName = i.Area }).ToList().FindAll(i => i.AreaName.ToLower().StartsWith(Area)).ToList();
            }
            catch (Exception ex)
            {


            }
            return result;
        }

        [WebMethod]
        public static List<DDLArea> GetAllArea()
        {

            List<DDLArea> result = new List<DDLArea>();
            try
            {

                result = Global.dc.AreaDetails.Select(i => new DDLArea() { ID = i.ID, AreaName = i.Area }).ToList();
            }
            catch (Exception ex)
            {


            }
            return result;
        }


        [WebMethod]
        public static DDLParty[] GetParty(string Party)
        {
            List<DDLParty> result = new List<DDLParty>();
            try
            {

                result = Global.dc.UserDetails.Where(i => i.IsActive == true && (!i.IsDeleted.Value || !i.IsDeleted.HasValue)).Select(i => new DDLParty() { ID = i.UserID, PartyName = i.CompanyName }).ToList().FindAll(i => i.PartyName.ToLower().StartsWith(Party.ToLower()));
            }
            catch (Exception ex)
            {


            }
            return result.ToArray();
        }

        [WebMethod]
        public static List<DDLSubArea> GetSubArea(string AreaID, string SubArea)
        {
            List<DDLSubArea> result = new List<DDLSubArea>();
            try
            {
                int areaID = Convert.ToInt32(AreaID);

                result = Global.dc.SubAreaDetails.Where(i => i.IsActive == true && (!i.IsDeleted.Value || !i.IsDeleted.HasValue) && i.AreaID == i.AreaID).Select(i => new DDLSubArea() { ID = i.ID, SubAreaName = i.SubArea }).ToList().FindAll(i => i.SubAreaName.ToLower().StartsWith(SubArea.ToLower())).ToList();
            }
            catch (Exception ex)
            {


            }
            return result;
        }



        [WebMethod]
        public static string AddArea(string CityID, string AreaName)
        {
            // result 0 for not saved
            // result -1 for some internal error
            // result 1 or greater than 1 for successfuly saved
            string result = "0";
            AreaDetail area = new AreaDetail();
            try
            {
                area.CityID = Convert.ToInt32(CityID);
                area.Area = AreaName;
                area.IsActive = true;
                area.IsDeleted = false;
                Global.dc.AreaDetails.Add(area);

                int count = Global.dc.SaveChanges();
                result = Convert.ToString(count);
            }
            catch (Exception)
            {
                result = "-1";

            }
            return result;
        }

        [WebMethod]
        public static string AddCity(string CityName)
        {
            // result 0 for not saved
            // result -1 for some internal error
            // result 1 or greater than 1 for successfuly saved
            string result = "0";
            CityDetail city = new CityDetail();

            try
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
            catch (Exception)
            {
                result = "-1";

            }
            return result;
        }
        [WebMethod]
        public static string AddParty(string Name, string Phone, string Address, string Email)
        {
            // result 0 for not saved
            // result -1 for some internal error
            // result 1 or greater than 1 for successfuly saved
            string result = "0";
            UserDetail user = new UserDetail();

            try
            {
                var IsUserExsist = Global.dc.UserDetails.FirstOrDefault(i => i.IsActive == true && (!i.IsDeleted.Value || !i.IsDeleted.HasValue) && i.PhoneNo.ToLower() == Phone.ToLower());
                if (IsUserExsist != null)
                {
                    result = "2";
                }
                else
                {
                    user = new UserDetail();
                    user.UserID = Global.dc.UserDetails.Max(i => i.UserID) + 1;

                    user.PersonName = Name;
                    user.PhoneNo = Phone;
                    user.CompanyAddress = Address;
                    user.Email = Email;
                    user.City = "";
                    user.CreatedBy = SessionManager.AdminID;
                    user.CreatedDate = DateTime.Now;

                    user.IsActive = true;
                    user.IsDeleted = false;
                    Global.dc.UserDetails.Add(user);

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