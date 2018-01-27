using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Parshvnath
{
    public partial class AdminLogin : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (SessionManager.AdminID != -1)
            {
                Response.Redirect("HoardingMasterDetail.aspx");
            }
        }

        protected void btnLogin_Click(object sender, EventArgs e)
        {
            try
            {
                if (!string.IsNullOrEmpty(txtUsername.Text.Trim()) && !string.IsNullOrEmpty(txtPassword.Text.Trim()))
                {
                    var result = Global.dc.Admins.Where(i => i.Username.ToLower() == txtUsername.Text.ToLower() && i.Password == txtPassword.Text && i.IsActive.Value && (!i.IsDeleted.Value || !i.IsDeleted.HasValue)).FirstOrDefault();

                    if (result != null)
                    {
                        //success Login
                        SessionManager.AdminID = result.ID;
                        SessionManager.AdminName = result.Username;
                        Response.Redirect("HoardingMasterDetail.aspx", false);
                        //    Response.Write("<script>alert('Login Successfull');</script>");
                    }
                    else
                    {
                        lblStatus.Visible = true;
                        lblStatus.Text = "Incorrect Username/password";
                        //Incorrect Username & Password
                    }

                }


            }
            catch (Exception)
            {
                lblStatus.Visible = true;
                lblStatus.Text = "Some Internal problem while login";


            }

        }
    }
}