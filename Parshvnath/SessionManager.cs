using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace Parshvnath
{
    public static class SessionManager
    {
        //Set Admin ID
        public static int AdminID
        {
            get
            {
                if (HttpContext.Current.Session["AdminID"] != null)
                    return Convert.ToInt32(HttpContext.Current.Session["AdminID"]);
                else return -1;
            }
            set
            {
                HttpContext.Current.Session["AdminID"] = value;
            }
        }

        // set AdminName
        public static string AdminName
        {
            get
            {
                if (HttpContext.Current.Session["AdminName"] != null)
                    return Convert.ToString(HttpContext.Current.Session["AdminName"]);
                else return string.Empty;
            }
            set
            {
                HttpContext.Current.Session["AdminName"] = value;
            }
        }
        public static string Path
        {
            get
            {
                if (HttpContext.Current.Session["Path"] != null)
                    return Convert.ToString(HttpContext.Current.Session["Path"]);
                else return "/";
            }
            set
            {
                HttpContext.Current.Session["Path"] = "/";
                //HttpContext.Current.Session["Path"] = "/parshva/";
            }
        }
    }
}