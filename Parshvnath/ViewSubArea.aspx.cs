using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Script.Serialization;
using System.Web.Services;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Parshvnath
{
    public partial class ViewSubArea : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (SessionManager.AdminID == -1)
            {
                Response.Redirect("Default.aspx");
            }

            if(!IsPostBack){
            BindSubAreaGrid();}

        }

        [WebMethod]
        public static List<DDLArea> GetAllArea()
        {

            List<DDLArea> result = new List<DDLArea>();
            try
            {


                result = Global.dc.AreaDetails.Where(i => i.IsActive == true && (!i.IsDeleted.Value || !i.IsDeleted.HasValue)).Select(i => new DDLArea() { ID = i.ID, AreaName = i.Area }).ToList();
            }
            catch (Exception)
            {


            }
            return result;
        }

        protected void BindSubAreaGrid()
        {

            try
            {
                //grdArea.DataSource = Global.dc.SubAreaDetails.Where(i => i.IsActive == true && (!i.IsDeleted.Value || !i.IsDeleted.HasValue)).Select(i => new Area() { ID = i.ID, AreaName = i.SubArea, CityID = i.AreaID.Value }).ToList();
                grdSubArea.DataSource = Global.dc.SubAreaDetails.Where(i => i.IsActive == true && (!i.IsDeleted.Value || !i.IsDeleted.HasValue)).Select(i => new SubAreas() { ID = i.ID, AreaID = i.AreaID, SubAreaName = i.SubArea, AreaName = i.AreaDetail.Area }).ToList();
                grdSubArea.DataBind();
            }
            catch (Exception)
            {


            }
        }

        [WebMethod]
        public static string DeleteSubArea(string ID)
        {
            string result = string.Empty;
            try
            {
                int SubAreaID = Convert.ToInt32(ID);

                var area = Global.dc.SubAreaDetails.FirstOrDefault(i => i.ID == SubAreaID && i.IsActive == true && (!i.IsDeleted.Value || !i.IsDeleted.HasValue));
                if (area != null)
                {
                    area.IsDeleted = true;
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
        public static string AddSubArea(string AreaID, string SubAreaName, string Operation, string SubAreaID)
        {
            // result 0 for not saved
            // result -1 for some internal error
            // result 1 or greater than 1 for successfuly saved
            string result = "0";
            SubAreaDetail area = new SubAreaDetail();

            try
            {

                int areaID = Convert.ToInt32(AreaID);
                if (Operation == "add")
                {
                    area = Global.dc.SubAreaDetails.FirstOrDefault(i => i.IsActive == true && (!i.IsDeleted.Value || !i.IsDeleted.HasValue) && i.SubArea.Replace(" ", "").ToLower() == SubAreaName.Replace(" ", "").ToLower() && i.AreaID == areaID);
                    if (area != null)
                    {
                        return "2";
                    }
                    else
                    {
                        area = new SubAreaDetail();
                        area.AreaID = areaID;
                        area.SubArea = SubAreaName;
                        area.IsActive = true;

                        area.IsDeleted = false;

                        Global.dc.SubAreaDetails.Add(area);

                        int count = Global.dc.SaveChanges();
                        result = Convert.ToString(count);
                    }
                }

                else if (Operation == "edit")
                {

                    int ID = Convert.ToInt32(SubAreaID);
                    area = Global.dc.SubAreaDetails.FirstOrDefault(i => i.IsActive == true && (!i.IsDeleted.Value || !i.IsDeleted.HasValue) && i.SubArea.Replace(" ", "").ToLower() == SubAreaName.Replace(" ", "").ToLower() && i.AreaID == areaID && i.ID != ID);
                    if (area != null)
                    {
                        return "2";
                    }
                    else
                    {
                        area = Global.dc.SubAreaDetails.FirstOrDefault(i => i.IsActive == true && (!i.IsDeleted.Value || !i.IsDeleted.HasValue) && i.ID == ID);
                        if (area != null)
                        {
                            area.ID = Convert.ToInt32(SubAreaID);
                            area.AreaID = areaID;

                            area.SubArea = SubAreaName;

                            int count = Global.dc.SaveChanges();
                            result = Convert.ToString(count);
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
        public static string EditSubArea(string ID)
        {
            string result = string.Empty;
            SubAreas data = new SubAreas();
            try
            {
                int SubAreaID = Convert.ToInt32(ID);
                var area = Global.dc.SubAreaDetails.FirstOrDefault(i => i.ID == SubAreaID && i.IsActive == true && (!i.IsDeleted.Value || !i.IsDeleted.HasValue));
                if (area != null)
                {
                    data.ID = area.ID;
                    data.AreaID = area.AreaID;
                    data.SubAreaName = area.SubArea;
                    result = new JavaScriptSerializer().Serialize(data);

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

        public class SubAreas
        {
            public int ID { get; set; }
            public string AreaName { get; set; }
            public int? AreaID { get; set; }
            public string SubAreaName { get; set; }
        }

    }
}