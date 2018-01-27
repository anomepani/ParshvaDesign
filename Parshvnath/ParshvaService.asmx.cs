using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Script.Serialization;
using System.Web.Services;

namespace Parshvnath
{
    /// <summary>
    /// Summary description for ParshvaService
    /// </summary>
    [WebService(Namespace = "http://tempuri.org/")]
    [WebServiceBinding(ConformsTo = WsiProfiles.BasicProfile1_1)]
    [System.ComponentModel.ToolboxItem(false)]
    // To allow this Web Service to be called from script, using ASP.NET AJAX, uncomment the following line. 
    [System.Web.Script.Services.ScriptService]
    public class ParshvaService : System.Web.Services.WebService
    {

        [WebMethod(EnableSession = true)]
        public string HelloWorld()
        {
            return "Hello World";
        }

        [WebMethod(EnableSession = true)]
        public bool isCompanyExist(string CompanyName, string ID)
        {
            bool isExist = false;
            int userID = Convert.ToInt32(ID);
            try
            {
                var company = Global.dc.UserDetails.FirstOrDefault(i => i.IsActive == true && (!i.IsDeleted.Value || !i.IsDeleted.HasValue) && i.CompanyName.Replace(" ", "").ToLower() == CompanyName.Replace(" ", "").ToLower() && i.UserID != userID);
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


        [WebMethod(EnableSession = true)]

        public bool isPhoneExist(string Phone, string ID)
        {
            bool isExist = false;

            try
            {

                int userID = Convert.ToInt32(ID);
                var company = Global.dc.UserDetails.FirstOrDefault(i => i.IsActive == true && (!i.IsDeleted.Value || !i.IsDeleted.HasValue) && i.PhoneNo == Phone && i.UserID != userID);
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


        [WebMethod(EnableSession = true)]
        public string AddUser(string Name, string Phone, string Address, string Email, string Operation, string ID, string PersonName, string City)
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
                        user = new UserDetail();
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

                            user.CompanyName = Name;
                            user.PhoneNo = Phone;
                            user.CompanyAddress = Address;
                            user.Email = Email;
                            user.PersonName = PersonName;
                            user.City = City;
                            user.UpdatedBy = SessionManager.AdminID;
                            user.UpdatedDate = DateTime.Now;
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


        [WebMethod(EnableSession = true)]
        public string DeleteUser(string UserID)
        {
            string result = string.Empty;
            try
            {
                int ID = Convert.ToInt32(UserID);
                //Cascade check in hoarding history table
                var IsUsedInHoarding = Global.dc.HoardingHistories.FirstOrDefault(i => i.IsActive == true && (!i.IsDeleted.HasValue || !i.IsDeleted.Value) && i.UserID == ID);

                if (IsUsedInHoarding != null)
                {
                    return "4";
                }
                else
                {
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
            }
            catch (Exception)
            {
                result = "-1";

            }
            return result;
        }

        [WebMethod(EnableSession = true)]
        public string EditUser(string UserID)
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
                    user.CompanyName = result.CompanyName;
                    user.PersonName = result.PersonName;
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


        #region Area Operation



        [WebMethod(EnableSession = true)]
        public string AddArea(string CityID, string AreaName, string Operation, string ID)
        {
            // result 0 for not saved
            // result -1 for some internal error
            // result 1 or greater than 1 for successfuly saved
            string result = "0";
            AreaDetail area = new AreaDetail();

            try
            {
                if (Operation == "add")
                {
                    var isAreaExist = Global.dc.AreaDetails.FirstOrDefault(i => i.IsActive == true && (!i.IsDeleted.Value || !i.IsDeleted.HasValue) && i.Area.Replace(" ", "").ToLower() == AreaName.Replace(" ", "").ToLower());

                    if (isAreaExist != null)
                    {
                        result = "2";
                    }
                    else
                    {
                        area.CityID = Convert.ToInt32(CityID);
                        area.Area = AreaName;
                        area.IsActive = true;

                        area.IsDeleted = false;

                        Global.dc.AreaDetails.Add(area);

                        int count = Global.dc.SaveChanges();
                        result = Convert.ToString(count);
                    }
                }


                else if (Operation == "edit")
                {

                    int AreaID = Convert.ToInt32(ID);
                    var isAreaExist = Global.dc.AreaDetails.FirstOrDefault(i => i.IsActive == true && (!i.IsDeleted.Value || !i.IsDeleted.HasValue) && i.Area.Replace(" ", "").ToLower() == AreaName.Replace(" ", "").ToLower() && i.ID != AreaID);

                    if (isAreaExist != null)
                    {
                        result = "2";
                    }
                    else
                    {

                        area = Global.dc.AreaDetails.FirstOrDefault(i => i.IsActive == true && (!i.IsDeleted.Value || !i.IsDeleted.HasValue) && i.ID == AreaID);
                        if (area != null)
                        {
                            area.CityID = Convert.ToInt32(CityID);

                            area.Area = AreaName;
                            area.IsActive = true;
                            area.IsDeleted = false;


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


        [WebMethod(EnableSession = true)]
        public string DeleteArea(string ID)
        {
            string result = string.Empty;
            try
            {
                int AreaID = Convert.ToInt32(ID);
                //check for cascade delete in hoarding master 
                var IsUsedInHoarding = Global.dc.SubAreaDetails.FirstOrDefault(i => i.IsActive == true && (!i.IsDeleted.HasValue || !i.IsDeleted.Value) && i.AreaID == AreaID);

                if (IsUsedInHoarding != null)
                {
                    return "4";
                }
                else
                {
                    AreaDetail area = Global.dc.AreaDetails.FirstOrDefault(i => i.ID == AreaID && i.IsActive == true && (!i.IsDeleted.Value || !i.IsDeleted.HasValue));
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
            }
            catch (Exception)
            {
                result = "-1";

            }
            return result;
        }

        [WebMethod(EnableSession = true)]
        public string EditArea(string ID)
        {
            string result = string.Empty;
            Area data = new Area();
            try
            {
                int AreaID = Convert.ToInt32(ID);
                AreaDetail area = Global.dc.AreaDetails.FirstOrDefault(i => i.ID == AreaID && i.IsActive == true && (!i.IsDeleted.Value || !i.IsDeleted.HasValue));
                if (area != null)
                {
                    data.ID = area.ID;
                    data.AreaName = area.Area;
                    data.CityID = area.CityID;
                    data.CityName = area.CityDetail.CityName;
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

        #endregion

        #region SubArea Operation

        [WebMethod(EnableSession = true)]
        public string DeleteSubArea(string ID)
        {
            string result = string.Empty;
            try
            {
                int SubAreaID = Convert.ToInt32(ID);
                //check for cascade delete in hoarding master 
                var IsUsedInHoarding = Global.dc.HoardingMasters.FirstOrDefault(i => i.IsActive == true && (!i.IsDeleted.HasValue || !i.IsDeleted.Value) && i.SubAreaID == SubAreaID);

                if (IsUsedInHoarding != null)
                {
                    return "4";
                }
                else
                {
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
            }
            catch (Exception)
            {
                result = "-1";

            }
            return result;
        }

        [WebMethod(EnableSession = true)]
        public string AddSubArea(string AreaID, string SubAreaName, string Operation, string SubAreaID)
        {
            // result 0 for not saved
            // result -1 for some internal error
            // result 1 or greater than 1 for successfuly saved
            string result = "0";
            SubAreaDetail subArea = new SubAreaDetail();

            try
            {

                int areaID = Convert.ToInt32(AreaID);
                if (Operation == "add")
                {
                    subArea = Global.dc.SubAreaDetails.FirstOrDefault(i => i.IsActive == true && (!i.IsDeleted.Value || !i.IsDeleted.HasValue) && i.SubArea.Replace(" ", "").ToLower() == SubAreaName.Replace(" ", "").ToLower() && i.AreaID == areaID);
                    if (subArea != null)
                    {
                        return "2";
                    }
                    else
                    {
                        subArea = new SubAreaDetail();
                        subArea.AreaID = areaID;
                        subArea.SubArea = SubAreaName;
                        subArea.IsActive = true;

                        subArea.IsDeleted = false;

                        Global.dc.SubAreaDetails.Add(subArea);

                        int count = Global.dc.SaveChanges();
                        result = Convert.ToString(count);
                    }
                }

                else if (Operation == "edit")
                {

                    int ID = Convert.ToInt32(SubAreaID);
                    subArea = Global.dc.SubAreaDetails.FirstOrDefault(i => i.IsActive == true && (!i.IsDeleted.Value || !i.IsDeleted.HasValue) && i.SubArea.Replace(" ", "").ToLower() == SubAreaName.Replace(" ", "").ToLower() && i.AreaID == areaID && i.ID != ID);
                    if (subArea != null)
                    {
                        return "2";
                    }
                    else
                    {
                        subArea = Global.dc.SubAreaDetails.FirstOrDefault(i => i.IsActive == true && (!i.IsDeleted.Value || !i.IsDeleted.HasValue) && i.ID == ID);
                        if (subArea != null)
                        {
                            subArea.ID = Convert.ToInt32(SubAreaID);
                            subArea.AreaID = areaID;

                            subArea.SubArea = SubAreaName;
                            subArea.IsActive = true;

                            subArea.IsDeleted = false;
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

        [WebMethod(EnableSession = true)]
        public string EditSubArea(string ID)
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
                    data.AreaName = area.AreaDetail.Area;
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


        #endregion

        #region City Operation


        [WebMethod(EnableSession = true)]
        public string DeleteCity(string ID)
        {
            string result = string.Empty;
            try
            {
                int CityID = Convert.ToInt32(ID);
                AreaDetail area = Global.dc.AreaDetails.FirstOrDefault(i => i.CityID == CityID && i.IsActive == true && (!i.IsDeleted.Value || !i.IsDeleted.HasValue));
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

        [WebMethod(EnableSession = true)]
        public string AddCity(string CityName, string Operation, string ID)
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
                        city = Global.dc.CityDetails.FirstOrDefault(i => i.IsActive == true && (!i.IsDeleted.Value || !i.IsDeleted.HasValue) && i.ID == CityID);
                        if (city != null)
                        {
                            city.CityName = CityName;
                            city.IsActive = true;
                            city.IsDeleted = false;
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

        [WebMethod(EnableSession = true)]
        public string EditCity(string ID)
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



        #endregion

        #region autocomplete Binding Data

        [WebMethod(MessageName = "GetAllCity")]
        public List<DDLCity> GetCity()
        {
            List<DDLCity> result = new List<DDLCity>();
            try
            {

                result = Global.dc.CityDetails.Where(i => i.IsActive == true && (!i.IsDeleted.Value || !i.IsDeleted.HasValue)).Select(i => new DDLCity() { ID = i.ID, CityName = i.CityName }).ToList();
            }
            catch (Exception)
            {


            }
            return result;
        }

        [WebMethod]
        public List<DDLArea> GetArea(string CityID)
        {

            List<DDLArea> result = new List<DDLArea>();
            try
            {
                int ID = Convert.ToInt32(CityID);

                result = Global.dc.AreaDetails.Where(i => i.CityID == ID && i.IsActive == true && (!i.IsDeleted.Value || !i.IsDeleted.HasValue)).Select(i => new DDLArea() { ID = i.ID, AreaName = i.Area }).ToList();
            }
            catch (Exception)
            {


            }
            return result;
        }

        [WebMethod]
        public List<DDLArea> GetAllArea(string Area)
        {

            List<DDLArea> result = new List<DDLArea>();
            try
            {

                result = Global.dc.AreaDetails.Where(i => i.IsActive == true && (!i.IsDeleted.Value || !i.IsDeleted.HasValue)).Select(i => new DDLArea() { ID = i.ID, AreaName = i.Area }).ToList().FindAll(i => i.AreaName.ToLower().Replace(" ", "").StartsWith(Area.ToLower().Replace(" ", ""))).ToList();
            }
            catch (Exception)
            {


            }
            return result;
        }

        [WebMethod]
        public List<DDLCity> GetCity(string City)
        {
            List<DDLCity> result = new List<DDLCity>();
            try
            {

                // result = Global.dc.CityDetails.Where(i => i.IsActive == true && (!i.IsDeleted.Value || !i.IsDeleted.HasValue)).Select(i => new DDLCity() { ID = i.ID, CityName = i.CityName }).ToList().FindAll(i => i.CityName.ToLower().StartsWith(City.ToLower())).ToList();
                result = Global.dc.CityDetails.Where(i => i.IsActive == true && (!i.IsDeleted.Value || !i.IsDeleted.HasValue)).Select(i => new DDLCity() { ID = i.ID, CityName = i.CityName }).ToList().FindAll(i => i.CityName.ToLower().StartsWith(City.ToLower())).ToList();
            }
            catch (Exception)
            {


            }
            return result;
        }

        [WebMethod]
        public List<DDLArea> GetArea(string CityID, string Area)
        {

            List<DDLArea> result = new List<DDLArea>();
            try
            {
                int ID = Convert.ToInt32(CityID);

                //                result = Global.dc.AreaDetails.Where(i => i.CityID == ID).Select(i => new DDLArea() { ID = i.ID, AreaName = i.Area }).ToList().FindAll(i => i.AreaName.ToLower().StartsWith(Area)).ToList();
                result = Global.dc.AreaDetails.Where(i => i.CityID == ID && i.IsActive == true && (!i.IsDeleted.Value || !i.IsDeleted.HasValue)).Select(i => new DDLArea() { ID = i.ID, AreaName = i.Area }).ToList().FindAll(i => i.AreaName.ToLower().StartsWith(Area.ToLower())).ToList();
            }
            catch (Exception)
            {


            }
            return result;
        }

        [WebMethod]
        public List<DDLSubArea> GetSubArea(string AreaID, string SubArea)
        {
            List<DDLSubArea> result = new List<DDLSubArea>();
            try
            {
                int areaID = Convert.ToInt32(AreaID);

                result = Global.dc.SubAreaDetails.Where(i => i.IsActive == true && (!i.IsDeleted.Value || !i.IsDeleted.HasValue) && i.AreaID == areaID).Select(i => new DDLSubArea() { ID = i.ID, SubAreaName = i.SubArea }).ToList().FindAll(i => i.SubAreaName.ToLower().StartsWith(SubArea.ToLower())).ToList();
            }
            catch (Exception)
            {


            }
            return result;
        }



        [WebMethod(EnableSession = true)]
        public DDLParty[] GetParty(string Party)
        {
            List<DDLParty> result = new List<DDLParty>();
            try
            {

                result = Global.dc.UserDetails.Where(i => i.IsActive == true && (!i.IsDeleted.Value || !i.IsDeleted.HasValue)).Select(i => new DDLParty() { ID = i.UserID, PartyName = i.CompanyName }).ToList().FindAll(i => i.PartyName.ToLower().StartsWith(Party.ToLower())).ToList();
            }
            catch (Exception)
            {


            }
            return result.ToArray();
        }

        #endregion

        #region Hoarding Master

        [WebMethod(EnableSession = true)]
        public string AddHoardingMaster(string CityID, string AreaID, string SubAreaID, string HoardingNo, string HoardingMasterID, string HoardingSize, string Operation)
        {
            string result = string.Empty;
            int count = 0;
            HoardingMaster hoardingMaster = new HoardingMaster();

            try
            {
                int? subAreaID;
                if (!string.IsNullOrEmpty(SubAreaID))
                {
                    subAreaID = Convert.ToInt32(SubAreaID);
                }
                else
                {
                    subAreaID = null;
                }

                if (Operation.ToLower() == "add")
                {


                    var hoarding = Global.dc.IsHoardingExsist(subAreaID, (int?)Convert.ToInt32(HoardingNo), (int?)Convert.ToInt32(AreaID)).ToList();
                    if (hoarding.Count > 0)
                    {
                        result = "2";
                    }
                    else
                    {
                        hoardingMaster.CityID = Convert.ToInt32(CityID);
                        hoardingMaster.AreaID = Convert.ToInt32(AreaID);
                        hoardingMaster.HoardingSize = HoardingSize;
                        if (!string.IsNullOrEmpty(SubAreaID))
                        {

                            hoardingMaster.SubAreaID = subAreaID;
                        }

                        hoardingMaster.HoardingNo = (int?)Convert.ToInt32(HoardingNo.Trim());
                        hoardingMaster.IsActive = true;
                        hoardingMaster.IsDeleted = false;
                        Global.dc.HoardingMasters.Add(hoardingMaster);

                        count = Global.dc.SaveChanges();
                        result = count.ToString();
                    }
                }
                else if (Operation.ToLower() == "update")
                {
                    var hoarding = Global.dc.IsHoardingExsist(subAreaID, (int?)Convert.ToInt32(HoardingNo), (int?)Convert.ToInt32(AreaID)).ToList();
                    if (hoarding.Count > 0 && hoarding.FirstOrDefault().HoardingSize != null)
                    {
                        //HoardingSize field is added at the end so while updating we need to always check for already assign hoarding

                        int ID = Convert.ToInt32(HoardingMasterID);
                        hoardingMaster = Global.dc.HoardingMasters.FirstOrDefault(i => i.ID == ID);

                        if (hoardingMaster != null)
                        {

                            hoardingMaster.HoardingSize = HoardingSize;
                            count = Global.dc.SaveChanges();
                            result = Convert.ToString(count);
                        }
                        else
                        {
                            result = "2";
                        }



                    }
                    else
                    {

                        int ID = Convert.ToInt32(HoardingMasterID);
                        hoardingMaster = Global.dc.HoardingMasters.FirstOrDefault(i => i.ID == ID);
                        if (hoardingMaster != null)
                        {
                            hoardingMaster.CityID = Convert.ToInt32(CityID);
                            hoardingMaster.AreaID = Convert.ToInt32(AreaID);
                            hoardingMaster.SubAreaID = subAreaID;

                            hoardingMaster.HoardingSize = HoardingSize;
                            hoardingMaster.HoardingNo = (int?)Convert.ToInt32(HoardingNo.Trim());
                            hoardingMaster.IsActive = true;
                            hoardingMaster.IsDeleted = false;
                            count = Global.dc.SaveChanges();
                            result = count.ToString();
                        }
                        else
                        {
                            //Record not found
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

        [WebMethod(EnableSession = true)]
        public string EditHoardingMaster(string ID)
        {
            string result = string.Empty;

            try
            {
                int HoardingMasterID = Convert.ToInt32(ID);

                var hoardingMaster = Global.dc.GetHoardingMasterByID(HoardingMasterID).FirstOrDefault();

                if (hoardingMaster != null)
                {
                    result = new JavaScriptSerializer().Serialize(hoardingMaster);
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


        [WebMethod(EnableSession = true)]
        public string DeleteHoardingMaster(string ID)
        {
            string result = string.Empty;
            try
            {

                int HoardingID = Convert.ToInt32(ID);

                //Cascade check in hoarding history table
                var IsUsedInHoarding = Global.dc.HoardingHistories.FirstOrDefault(i => i.IsActive == true && (!i.IsDeleted.HasValue || !i.IsDeleted.Value) && i.HoardingMasterID == HoardingID);

                if (IsUsedInHoarding != null)
                {
                    return "4";
                }
                else
                {
                    //extra condition
                    //&& i.IsActive == true && (!i.IsDeleted.Value || !i.IsDeleted.HasValue)
                    HoardingMaster hoarding = Global.dc.HoardingMasters.FirstOrDefault(i => i.ID == HoardingID);
                    if (hoarding != null)
                    {
                        hoarding.IsDeleted = true;
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
        [WebMethod(EnableSession = true)]
        public string RenewHoarding(string ID)
        {
            string result = string.Empty;
            int count = 0;

            try
            {
                int HoardingID = Convert.ToInt32(ID);
                DateTime toDate;
                //Cascade check in hoarding history table
                var hoarding = Global.dc.HoardingHistories.FirstOrDefault(i => i.IsActive == true && (!i.IsDeleted.HasValue || !i.IsDeleted.Value) && (!i.IsExpired.HasValue || !i.IsExpired.Value) && i.HoadingHistoryID == HoardingID);
                //if not null also needs to check for todate value is greater than current date or not
                if (hoarding != null && hoarding.ToDate>DateTime.Now.Date)
                {
                    //if hoarding is not null update record for expire and if successfully expired then renew this hoarding
                    hoarding.IsExpired = true;
                    toDate = hoarding.ToDate.Value;
                    hoarding.ToDate = DateTime.Now.Date;
                    hoarding.UpdatedDate = DateTime.Now;

                    count = Global.dc.SaveChanges();
                    if (count > 0)
                    {
                        HoardingHistory renewHoarding = new HoardingHistory();
                        renewHoarding.UserID = hoarding.UserID;
                        renewHoarding.HoardingMasterID = hoarding.HoardingMasterID;
                        renewHoarding.IsPermanent = hoarding.IsPermanent;
                        renewHoarding.Status = hoarding.Status;
                        renewHoarding.Type = hoarding.Type;
                        renewHoarding.FromDate = DateTime.Now.Date;
                        renewHoarding.ToDate = toDate;
                        renewHoarding.Amount = hoarding.Amount;
                        renewHoarding.BannerName = hoarding.BannerName;
                        renewHoarding.IsActive = true;
                        renewHoarding.IsDeleted = false;
                        renewHoarding.IsExpired = false;
                        renewHoarding.IsRenewed = true;
                        renewHoarding.CreatedBy = SessionManager.AdminID;
                        renewHoarding.CreatedDate = DateTime.Now;

                        Global.dc.HoardingHistories.Add(renewHoarding);
                        count = 0;
                        count = Global.dc.SaveChanges();
                        if (count > 0)
                        {
                            result = Convert.ToString(count);
                        }
                        else
                        {
                            result = "0";
                        }


                    }
                    else
                    {
                        result = "0";
                    }
                }
                else
                {
                    result = "0";
                }

            }
            catch (Exception)
            {

                result = "-1";
            }
            return result;
        }
        #endregion
    }
}
