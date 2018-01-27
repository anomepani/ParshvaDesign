using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Web;
using System.Configuration;

namespace Parshvnath
{
    /// <summary>
    /// Summary description for FileUploader
    /// </summary>
    public class FileUploader : IHttpHandler
    {

        public void ProcessRequest(HttpContext context)
        {

            context.Response.ContentType = "text/plain";

            context.Response.Expires = -1;

            try
            {

                HttpPostedFile postedFile = context.Request.Files["Filedata"];



                string savepath = "";

                string tempPath = "";

                tempPath = ConfigurationManager.AppSettings["FolderPath"];

                savepath = context.Server.MapPath(tempPath);

                string filename = GetTimeStamp() + Path.GetExtension(postedFile.FileName);

                if (!Directory.Exists(savepath))

                    Directory.CreateDirectory(savepath);



                postedFile.SaveAs(savepath +filename);

                context.Response.Write(filename);

                context.Response.StatusCode = 200;

            }

            catch (Exception ex)
            {

                context.Response.Write("Error: " + ex.Message);

            }

        }

        public bool IsReusable
        {
            get
            {
                return false;
            }
        }
        public static string GetTimeStamp()
        {
            return DateTime.Now.ToString("yyyyMMddHHmmssfff");
        }
    }
}