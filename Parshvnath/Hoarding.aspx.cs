using System;
using System.Collections.Generic;
using System.Globalization;
using System.IO;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Configuration;
namespace Parshvnath
{
    public partial class Hoarding1 : System.Web.UI.Page
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
                        txtHoardingNo.Text = Convert.ToString(result.HoardingNo);
                        hdnArea.Value = Convert.ToString(result.AreaID);
                        hdnCity.Value = Convert.ToString(result.CityID);
                        hdnSubArea.Value = Convert.ToString(result.SubAreaID);
                        hdnHoardingMasterID.Value = Convert.ToString(result.ID);
                        btnUpdateHoarding.Visible = false;
                        btnHoardingEntry.Visible = true;

                    }
                    else
                    {
                        // No Such ID Found
                        Response.Redirect("/HoardingMAsterDetail.aspx", false);
                    }

                }
                else if (!IsPostBack && Request.QueryString["HoardingHistoryID"] != null)
                {
                    //For Updatation
                    var ID = Convert.ToInt32(Request.QueryString["HoardingHistoryID"]);
                    var result = Global.dc.GetHoardingEntryByID(ID).FirstOrDefault();
                    hdnHoardingHistoryID.Value = Convert.ToString(ID);
                    txtCompany.Text = result.CompanyName;
                    txtArea.Text = result.area;
                    city.Text = result.CityName;
                    txtSubArea.Text = result.SubArea;
                    hdnParty.Value = Convert.ToString(result.UserID);
                    txtHoardingNo.Text = Convert.ToString(result.HoardingNo);
                    hdnArea.Value = Convert.ToString(result.AreaID);
                    hdnCity.Value = Convert.ToString(result.CityID);
                    hdnSubArea.Value = Convert.ToString(result.SubAreaID);
                    hdnHoardingMasterID.Value = Convert.ToString(result.ID);
                    txtFromDate.Text = result.FromDate.Value.ToString("dd-MM-yy");
                    txtToDate.Text = result.ToDate.Value.ToString("dd-MM-yy");
                    hdnToDate.Value = result.ToDate.Value.ToString("MM/dd/yy");
                    hdnFromDate.Value = result.FromDate.Value.ToString("MM/dd/yy");
                    txtDayOrMonth.Text = Convert.ToString(result.ToDate.Value.Subtract(result.FromDate.Value).Days);
                    hdnDayOrMonth.Value = txtDayOrMonth.Text;
                    imgHoarding.Src = "/Images/HoardingImage/" + result.BannerName;
                    txtMonthlyAmount.Text = Convert.ToString(result.Amount.Value);
                    btnUpdateHoarding.Visible = true;
                    btnHoardingEntry.Visible = false;
                    //set dropdown
                    if (result.Type != null && result.Type.ToLower() == "p")
                    {
                        ddlAccountType.Items.FindByValue("Temporary").Selected = false;
                        ddlAccountType.Items.FindByValue("Permanent").Selected = true;
                    }
                    else if (result.Type != null && result.Type.ToLower() == "t")
                    {
                        ddlAccountType.Items.FindByValue("Permanent").Selected = false;

                        ddlAccountType.Items.FindByValue("Temporary").Selected = true;

                    }
                    //set Renew field
                    hdnIsRenew.Value = Convert.ToString(result.IsRenewed).ToLower();

                    //Set image
                    imgHoarding.Style.Add("display", "block");
                    btnHoardingEntry.Visible = false;
                    ClientScript.RegisterClientScriptBlock(this.GetType(), "DayOrMonth", "CalculateDate(" + hdnDayOrMonth.Value + ");", true);
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


                #region Date time conversion

                fromDate = DateTime.ParseExact(Request.Form["hdnFromDate"], "MM/dd/yy", CultureInfo.InvariantCulture);
                ToDate = DateTime.ParseExact(Request.Form["hdnToDate"], "MM/dd/yy", CultureInfo.InvariantCulture);


                #endregion


                //ToDate = DateTime.Parse(txtToDate.Text);

                accounType = Request.Form["ddlAccountType"];
                int hoardingMasterID = Convert.ToInt32(hdnHoardingMasterID.Value);
                int DayCount = Convert.ToInt32(txtDayOrMonth.Text);

                if (accounType.ToLower() == "permanent")
                {
                    var result = Global.dc.CheckPermanentEntry(fromDate, ToDate, accounType.ToLower(), Convert.ToInt32(hdnHoardingMasterID.Value)).FirstOrDefault();


                    if (result != null)
                    {
                        Response.Write("<script>alert('Hoarding Entry Already Exist ');</script>");
                    }
                    else
                    {
                        #region Insert New Permanent Entry

                        //                        int hoardingID = Global.dc.HoardingHistories.Max(i => i.HoadingHistoryID) + 1;
                        //                      hoarding.HoardingID = hoardingID;
                        hoardingHistory.UserID = Convert.ToInt32(Request.Form["hdnParty"]);
                        hoardingHistory.HoardingMasterID = Convert.ToInt32(Request.Form["hdnHoardingMasterID"]);
                        hoardingHistory.IsActive = true;
                        hoardingHistory.IsDeleted = false;
                        hoardingHistory.IsPermanent = true;
                        if (ToDate < DateTime.Now)
                        {
                            hoardingHistory.IsExpired = true;
                        }
                        else
                        {
                            hoardingHistory.IsExpired = false;
                        }

                        hoardingHistory.FromDate = fromDate;
                        hoardingHistory.ToDate = ToDate;
                        hoardingHistory.Type = accounType.ToLower();
                        hoardingHistory.Amount = Convert.ToDecimal(txtMonthlyAmount.Text);

                        //set Renew value for insertion

                        if (!string.IsNullOrEmpty(hdnIsRenew.Value))
                        {
                            if (hdnIsRenew.Value.ToLower() == "true")
                            {
                                hoardingHistory.IsRenewed = true;
                            }
                            else
                            {
                                hoardingHistory.IsRenewed = false;
                            }
                        }
                        else
                        {
                            hoardingHistory.IsRenewed = false;
                        }
                        //end renew code
                        string path = ConfigurationManager.AppSettings["FolderPath"];

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


                                hoardingHistory.BannerName = replaceFilename;
                            }
                        }
                        //Set image file name in database  

                        hoardingHistory.IsPermanent = true;
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
                            Response.Write("<script>alert('Record insertion failed');</script>");
                        }

                        #endregion
                    }

                }
                else if (accounType.ToLower() == "temporary")
                {
                    var result = Global.dc.CheckTemporaryEntry(fromDate, ToDate, accounType.ToLower(), Convert.ToInt32(hdnHoardingMasterID.Value)).FirstOrDefault();
                    if (result != null)
                    {
                        Response.Write("<script>alert('Temporary Hoarding Entry Already Exist ');</script>");
                    }
                    else
                    {

                        var resultPermanentData = Global.dc.HoardingHistories.FirstOrDefault(i => i.Type.ToLower() == "permanent" && i.IsActive == true && (!i.IsDeleted.HasValue || i.IsDeleted == false) && i.HoardingMasterID == hoardingMasterID && i.FromDate <= fromDate && i.ToDate >= ToDate);

                        var hoardingEntery = Global.dc.CheckPermanentEntry(resultPermanentData.FromDate, resultPermanentData.ToDate.Value.AddDays(DayCount), resultPermanentData.Type, resultPermanentData.HoardingMasterID).FirstOrDefault();
                        if (hoardingEntery != null)
                        {
                            // if future hoarding is booked
                            Response.Write("<script>alert('Permanent Hoarding Entry Already Exist For Extend days ');</script>");
                        }
                        else
                        {
                            #region Insert New Temporary Entry

                            //                        int hoardingID = Global.dc.HoardingHistories.Max(i => i.HoadingHistoryID) + 1;
                            //                      hoarding.HoardingID = hoardingID;


                            hoardingHistory.UserID = Convert.ToInt32(Request.Form["hdnParty"]);
                            hoardingHistory.HoardingMasterID = Convert.ToInt32(Request.Form["hdnHoardingMasterID"]);
                            hoardingHistory.IsActive = true;
                            hoardingHistory.IsDeleted = false;
                            hoardingHistory.FromDate = fromDate;
                            hoardingHistory.IsPermanent = false;

                            if (ToDate < DateTime.Now)
                            {
                                hoardingHistory.IsExpired = true;
                            }
                            else
                            {
                                hoardingHistory.IsExpired = false;
                            }

                            hoardingHistory.ToDate = ToDate;
                            hoardingHistory.Type = accounType.ToLower();
                            hoardingHistory.Amount = Convert.ToDecimal(txtMonthlyAmount.Text);

                            //for temporary Entery Renew is not possible so set it direct to false
                            hoardingHistory.IsRenewed = false;

                            string path = ConfigurationManager.AppSettings["FolderPath"];

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

                                    hoardingHistory.BannerName = replaceFilename;
                                }
                            }
                            //Set image file name in database  


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

                                //After temporary entery save update record of permamanet entery by adding extra days to it expire date

                                //var resultData = Global.dc.CheckPermanentEntry(fromDate, ToDate, "permanent", Convert.ToInt32(hdnHoardingMasterID.Value)).FirstOrDefault();

                                var resultData = Global.dc.HoardingHistories.FirstOrDefault(i => i.Type.ToLower() == "permanent" && i.IsActive == true && (!i.IsDeleted.HasValue || i.IsDeleted == false) && i.HoardingMasterID == hoardingMasterID && i.FromDate <= fromDate && i.ToDate >= ToDate);


                                if (resultData != null)
                                {
                                    resultData.IsActive = false;
                                    resultData.ToDate = resultData.ToDate.Value.AddDays(DayCount);
                                    var cnt = Global.dc.SaveChanges();

                                }

                                Response.Write("<script>alert('Hoarding Entry done successfully.');</script>");


                            }
                            else
                            {
                                //Record insertion failed
                                Response.Write("<script>alert('Record insertion failed');</script>");
                            }

                            #endregion
                        }
                    }


                }




            }
            catch (Exception ex)
            {
                string message = "<script>alert('some internal problem');</script>";
                //Response.Write(ex.Message);
                hdnError.Value = ex.Message;
                Response.Write(message);
                //ClientScript.RegisterStartupScript(this.GetType(), "alert", message);
            }

        }

        public static string GetTimeStamp()
        {
            return DateTime.Now.ToString("yyyyMMddHHmmssfff");
        }

        protected void btnUpdateHoarding_Click(object sender, EventArgs e)
        {



            HoardingHistory hoardingHistory = new HoardingHistory();
            string originalFilename = string.Empty, replaceFilename = string.Empty;
            string accounType = string.Empty;
            DateTime fromDate, ToDate;
            try
            {


                #region Date time conversion
                fromDate = DateTime.ParseExact(Request.Form["hdnFromDate"], "MM/dd/yy", CultureInfo.InvariantCulture);
                ToDate = DateTime.ParseExact(Request.Form["hdnToDate"], "MM/dd/yy", CultureInfo.InvariantCulture);


                #endregion


                //ToDate = DateTime.Parse(txtToDate.Text);

                accounType = Request.Form["ddlAccountType"];
                int HoardingHistoryID = Convert.ToInt32(hdnHoardingHistoryID.Value);
                int hoardingMasterID = Convert.ToInt32(hdnHoardingMasterID.Value);
                int DayCount = Convert.ToInt32(txtDayOrMonth.Text);
                if (accounType.ToLower() == "permanent")
                {
                    var result = Global.dc.CheckPermanentEntryForUpdate(fromDate, ToDate, accounType.ToLower(), Convert.ToInt32(hdnHoardingMasterID.Value), HoardingHistoryID).FirstOrDefault();

                    if (result != null && result.HoadingHistoryID != HoardingHistoryID)
                    {
                        Response.Write("<script>alert('Hoarding Entry Already Exist ');</script>");
                    }
                    else
                    {
                        #region Update Permanent Entry

                        //                        int hoardingID = Global.dc.HoardingHistories.Max(i => i.HoadingHistoryID) + 1;
                        //                      hoarding.HoardingID = hoardingID;

                        hoardingHistory = Global.dc.HoardingHistories.FirstOrDefault(i => i.IsActive == true && (!i.IsDeleted.HasValue || i.IsDeleted == false) && i.HoadingHistoryID == HoardingHistoryID);

                        hoardingHistory.UserID = Convert.ToInt32(Request.Form["hdnParty"]);
                        hoardingHistory.HoardingMasterID = Convert.ToInt32(Request.Form["hdnHoardingMasterID"]);
                        if (ToDate < DateTime.Now)
                        {
                            hoardingHistory.IsExpired = true;
                        }
                        else
                        {
                            hoardingHistory.IsExpired = false;
                        }

                        hoardingHistory.FromDate = fromDate;
                        hoardingHistory.ToDate = ToDate;
                        hoardingHistory.Type = accounType.ToLower();
                        hoardingHistory.Amount = Convert.ToDecimal(txtMonthlyAmount.Text);

                        //set Renew value for insertion

                        if (!string.IsNullOrEmpty(hdnIsRenew.Value))
                        {
                            if (hdnIsRenew.Value.ToLower() == "true")
                            {
                                hoardingHistory.IsRenewed = true;
                            }
                            else
                            {
                                hoardingHistory.IsRenewed = false;
                            }
                        }
                        else
                        {
                            hoardingHistory.IsRenewed = false;
                        }
                        //end renew code
                        string path = ConfigurationManager.AppSettings["FolderPath"];

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

                                hoardingHistory.BannerName = replaceFilename;

                            }
                        }
                        //Set image file name in database  

                        // hoardingHistory.IsPermanent = true;
                        hoardingHistory.UpdatedDate = DateTime.Now;

                        // Global.dc.HoardingHistories.Add(hoardingHistory);
                        int count = Global.dc.SaveChanges();
                        if (count > 0)
                        {

                            Response.Write("<script>alert('Hoarding Entry updated successfully.');</script>");


                        }
                        else
                        {
                            //Record insertion failed
                            Response.Write("<script>alert('Record updation failed');</script>");
                        }

                        #endregion
                    }

                }
                else if (accounType.ToLower() == "temporary")
                {
                    var result = Global.dc.CheckTemporaryEntryForUpdate(fromDate, ToDate, accounType.ToLower(), Convert.ToInt32(hdnHoardingMasterID.Value), HoardingHistoryID).FirstOrDefault();
                    if (result != null && result.HoadingHistoryID != HoardingHistoryID)
                    {
                        Response.Write("<script>alert('Temporary Hoarding Entry Already Exist ');</script>");
                    }
                    else
                    {
                        var resultPermanentData = Global.dc.HoardingHistories.FirstOrDefault(i => i.Type.ToLower() == "permanent" && i.IsActive == true && (!i.IsDeleted.HasValue || i.IsDeleted == false) && i.HoardingMasterID == hoardingMasterID && i.FromDate <= fromDate && i.ToDate >= ToDate);

                        var hoardingEntery = Global.dc.CheckPermanentEntryForUpdate(resultPermanentData.FromDate, resultPermanentData.ToDate.Value.AddDays(DayCount), resultPermanentData.Type, resultPermanentData.HoardingMasterID, HoardingHistoryID).FirstOrDefault();
                        if (hoardingEntery != null)
                        {
                            // if future hoarding is booked
                            Response.Write("<script>alert('Permanent Hoarding Entry Already Exist For Extend days ');</script>");
                        }
                        else
                        {

                            #region Update Temporary Entry

                            //                        int hoardingID = Global.dc.HoardingHistories.Max(i => i.HoadingHistoryID) + 1;
                            //                      hoarding.HoardingID = hoardingID;

                            hoardingHistory = Global.dc.HoardingHistories.FirstOrDefault(i => i.IsActive == true && (!i.IsDeleted.HasValue || i.IsDeleted == false) && i.HoadingHistoryID == HoardingHistoryID);

                            hoardingHistory.UserID = Convert.ToInt32(Request.Form["hdnParty"]);
                            hoardingHistory.HoardingMasterID = Convert.ToInt32(Request.Form["hdnHoardingMasterID"]);
                            hoardingHistory.FromDate = fromDate;
                            if (ToDate < DateTime.Now)
                            {
                                hoardingHistory.IsExpired = true;
                            }
                            else
                            {
                                hoardingHistory.IsExpired = false;
                            }

                            hoardingHistory.ToDate = ToDate;
                            hoardingHistory.Type = accounType.ToLower();
                            hoardingHistory.Amount = Convert.ToDecimal(txtMonthlyAmount.Text);

                            // For temporary entery renew is not possible so set direct to false
                            hoardingHistory.IsRenewed = false;

                            string path = ConfigurationManager.AppSettings["FolderPath"];

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

                                    hoardingHistory.BannerName = replaceFilename;
                                }
                            }
                            //Set image file name in database  


                            if (accounType.ToLower() == "permanent")
                            {
                                hoardingHistory.IsPermanent = true;


                            }
                            else if (accounType.ToLower() == "temporary")
                            {
                                hoardingHistory.IsPermanent = false;
                            }
                            hoardingHistory.UpdatedDate = DateTime.Now;

                            //                        Global.dc.HoardingHistories.Add(hoardingHistory);
                            int count = Global.dc.SaveChanges();
                            if (count > 0)
                            {

                                //After temporary entery save update record of permamanet entery by adding extra days to it expire date

                                //var resultData = Global.dc.CheckPermanentEntry(fromDate, ToDate, "permanent", Convert.ToInt32(hdnHoardingMasterID.Value)).FirstOrDefault();

                                var resultData = Global.dc.HoardingHistories.FirstOrDefault(i => i.Type.ToLower() == "permanent" && i.IsActive == true && (!i.IsDeleted.HasValue || i.IsDeleted == false) && i.HoardingMasterID == hoardingMasterID && i.FromDate <= fromDate && i.ToDate >= ToDate);
                                if (resultData != null)
                                {
                                    resultData.IsActive = false;

                                    resultData.ToDate = resultData.ToDate.Value.AddDays(DayCount);
                                    var cnt = Global.dc.SaveChanges();

                                }

                                Response.Write("<script>alert('Hoarding Entry updated successfully.');</script>");


                            }
                            else
                            {
                                //Record insertion failed
                                Response.Write("<script>alert('Record insertion failed');</script>");
                            }

                            #endregion
                        }
                    }


                }




            }
            catch (Exception ex)
            {
                string message = "<script>alert('some internal problem');</script>";
                //Response.Write(ex.Message);
                hdnError.Value = ex.Message;
                Response.Write(message);
                //ClientScript.RegisterStartupScript(this.GetType(), "alert", message);
            }



        }
    }

}