using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.Services;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.Script.Serialization;
namespace Parshvnath
{
    public partial class ViewUser : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

            if (SessionManager.AdminID == -1)
            {
                Response.Redirect("Default.aspx");
            }
            if (!IsPostBack)
            {
                BindUserGrid();
            }
        }
        protected void BindUserGrid()
        {

            try
            {
                grdUser.DataSource = Global.dc.UserDetails.Where(i => i.IsActive == true && (!i.IsDeleted.Value || !i.IsDeleted.HasValue)).ToList();
                grdUser.DataBind();
            }
            catch (Exception)
            {


            }
        }

        [WebMethod]
        public static string DeleteUser(string UserID)
        {
            string result = string.Empty;
            try
            {
                int ID = Convert.ToInt32(UserID);


                UserDetail user = Global.dc.UserDetails.FirstOrDefault(i => i.UserID == ID && i.IsActive == true && (!i.IsDeleted.Value || !i.IsDeleted.HasValue));

                if (user != null)
                {
                    user.IsDeleted = true;
                    int count = Global.dc.SaveChanges();
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
        public static string EditUser(string UserID)
        {
            UserDetail result = new UserDetail();
            int ID = Convert.ToInt32(UserID);
            Users user = new Users();
            try
            {

                result = Global.dc.UserDetails.Where(i => i.IsActive == true && (!i.IsDeleted.Value || !i.IsDeleted.HasValue) && i.UserID == ID).FirstOrDefault();
                if (result != null)
                {
                    user.CompanyAddress = result.CompanyAddress;
                    user.Email = result.Email;
                    user.CompanyName = result.CompanyAddress;
                    user.City = result.City;
                    user.Phone = result.PhoneNo;
                    user.UserID = result.UserID;
                }
            }
            catch (Exception)
            {


            }
            return new JavaScriptSerializer().Serialize(user);
        }

        [WebMethod]
        public static string AddUser(string Name, string Phone, string Address, string Email, string Operation, string ID, string PersonName, string City)
        {
            // result 0 for not saved
            // result -1 for some internal error
            // result 1 or greater than 1 for successfuly saved
            string result = "0";

            UserDetail user = new UserDetail();

            try
            {
                if (Operation == "add")
                {
                    var IsUserExsist = Global.dc.UserDetails.FirstOrDefault(i => i.IsActive == true && (!i.IsDeleted.Value || !i.IsDeleted.HasValue) && i.PhoneNo.ToLower() == Phone.ToLower() && (i.CompanyName.Replace(" ", "").ToLower() == Name.Replace(" ", "").ToLower() || i.PhoneNo == Phone));
                    if (IsUserExsist != null)
                    {
                        result = "2";
                    }
                    else
                    {
                        int UserID = Global.dc.UserDetails.Max(i => i.UserID) + 1;
                        user.UserID = UserID;
                        user.CompanyName = Name;
                        user.PhoneNo = Phone;
                        user.PersonName = PersonName;
                        user.City = City;
                        user.CompanyAddress = Address;
                        user.Email = Email;
                        user.CreatedBy = SessionManager.AdminID;
                        user.CreatedDate = DateTime.Now;

                        user.IsActive = true;
                        user.IsDeleted = false;
                        Global.dc.UserDetails.Add(user);

                        int count = Global.dc.SaveChanges();
                        result = Convert.ToString(count);
                    }
                }
                else if (Operation == "edit")
                {
                    int UserID = Convert.ToInt32(ID);

                    var IsUserExsist = Global.dc.UserDetails.FirstOrDefault(i => i.IsActive == true && (!i.IsDeleted.Value || !i.IsDeleted.HasValue) && i.PhoneNo.ToLower() == Phone.ToLower() && i.CompanyName.Replace(" ", "").ToLower() == Name.Replace(" ", "").ToLower() && i.UserID != UserID);
                    if (IsUserExsist != null)
                    {
                        result = "2";
                    }
                    else
                    {
                        user = Global.dc.UserDetails.FirstOrDefault((i => i.IsActive == true && (!i.IsDeleted.Value || !i.IsDeleted.HasValue) && i.UserID == UserID));
                        if (user != null)
                        {

                            user.CompanyName = "";
                            user.PhoneNo = Phone;
                            user.CompanyAddress = Address;
                            user.Email = Email;
                            user.PersonName = PersonName;
                            user.City = City;
                            user.CreatedBy = SessionManager.AdminID;
                            user.CreatedDate = DateTime.Now;
                            user.PersonName = Name;
                            user.IsActive = true;
                            user.IsDeleted = false;

                            int count = Global.dc.SaveChanges();
                            result = Convert.ToString(count);

                        }
                        else
                        {
                            result = "3";
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
        public static bool isCompanyExist(string CompanyName, string ID)
        {
            bool isExist = false;

            try
            {
                int companyID = Convert.ToInt32(ID);
                var company = Global.dc.UserDetails.FirstOrDefault(i => i.IsActive == true && (!i.IsDeleted.Value || !i.IsDeleted.HasValue) && i.CompanyName.Replace(" ", "").ToLower() == CompanyName.Replace(" ", "").ToLower());
                if (company != null)
                {
                    isExist = true;

                }
            }
            catch (Exception)
            {


            }
            return isExist;
        }


        [WebMethod]
        public static bool isPhoneExist(string Phone)
        {
            bool isExist = false;
            try
            {
                var company = Global.dc.UserDetails.FirstOrDefault(i => i.IsActive == true && (!i.IsDeleted.Value || !i.IsDeleted.HasValue) && i.PhoneNo == Phone);
                if (company != null)
                {
                    isExist = true;

                }
            }
            catch (Exception)
            {


            }
            return isExist;
        }


    }
}