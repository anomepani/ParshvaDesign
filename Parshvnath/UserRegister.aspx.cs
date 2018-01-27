using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Services;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Parshvnath
{
    public partial class UserRegister : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (SessionManager.AdminID == -1)
            {
                Response.Redirect("Default.aspx");
            }
            if (!IsPostBack)
            {

            }
        }

        protected void btnRegister_Click(object sender, EventArgs e)
        {
            UserDetail user = new UserDetail();
            int UserID = Global.dc.UserDetails.Max(i => i.UserID) + 1;
            try
            {

                var result = Global.dc.UserDetails.FirstOrDefault(i => i.IsActive == true && (!i.IsDeleted.Value || !i.IsDeleted.HasValue) && (i.CompanyName.Replace(" ", "").ToLower() == txtCompanyName.Text.Replace(" ", "").ToLower() || i.PhoneNo == txtPhone.Text));

                if (result != null)
                {
                    Response.Write("<script>alert('Company Name/Phone already exsist');</script>");
                }
                else
                {
                    //New Record insertion

                    user.UserID = UserID;
                    user.City =
                    user.CompanyAddress = txtCompanyAddress.Text;
                    user.PhoneNo = txtPhone.Text;
                    user.CompanyName = txtCompanyName.Text;
                    user.City = txtCity.Text;
                    user.Email = txtEmail.Text;
                    user.IsActive = true;
                    user.IsDeleted = false;
                    user.CreatedDate = DateTime.Now;
                    user.CreatedBy = SessionManager.AdminID;

                    Global.dc.UserDetails.Add(user);
                    int count = Global.dc.SaveChanges();
                    if (count > 0)
                    {
                        //Record Saved successfully
                        Response.Write("<script>alert('Record Saved successfully');</script>");
                    }
                    else
                    {
                        Response.Write("<script>alert('Record insertion failed');</script>");
                        //Record insertion failed
                    }
                }
            }
            catch (Exception ex)
            {
                Response.Write("<script>alert('Some Internal problem');</script>");
            }

        }

        [WebMethod]
        public static bool isCompanyExist(string CompanyName)
        {
            bool isExist = false;
            try
            {
                var company = Global.dc.UserDetails.FirstOrDefault(i => i.IsActive == true && (!i.IsDeleted.Value || !i.IsDeleted.HasValue) && i.CompanyName.Replace(" ", "").ToLower() == CompanyName.Replace(" ", "").ToLower());
                if (company != null)
                {
                    isExist = true;

                }
            }
            catch (Exception ex)
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
            catch (Exception ex)
            {


            }
            return isExist;
        }
    }
}