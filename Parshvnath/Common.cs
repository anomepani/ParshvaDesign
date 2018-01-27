using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace Parshvnath
{
    public static class Common
    {
    }

    public class Hoarding
    {
        public int? HoardingID { get; set; }
        public int ID { get; set; }
        public int? UserID { get; set; }
        public string HoardingNo { get; set; }
        public string Username { get; set; }
        public DateTime? FromDate { get; set; }
        public DateTime? ToDate { get; set; }
        public Decimal? Amount { get; set; }
        public int? CityID { get; set; }
        public int? AreaID { get; set; }
        public string CityName { get; set; }
        public string PhoneNo { get; set; }
        public string AreaName { get; set; }
        public string HoardingBanner { get; set; }
        public bool? IsExpired { get; set; }
        public bool? IsRenewed { get; set; }
        public bool? IsPermanent { get; set; }
        public string SubArea { get; set; } //Added new field
        public string Status { get; set; }
        public bool? IsActive { get; set; }
    }
    public class Users
    {
        public int UserID { get; set; }
        public string PersonName { get; set; } //Added new field

        public string Email { get; set; }
        public string Phone { get; set; }
        public string City { get; set; }
        public string CompanyName { get; set; } //Added new field
        public string CompanyAddress { get; set; }  //Added new field
    }




    public class DDLParty
    {
        public int ID { get; set; }

        public string PartyName { get; set; }
    }
    public class DDLCity
    {
        public int ID { get; set; }

        public string CityName { get; set; }
    }
    public class DDLArea
    {
        public int ID { get; set; }

        public string AreaName { get; set; }
    }
    public class DDLSubArea
    {
        public int ID { get; set; }
        public string SubAreaName { get; set; }
    }
    public class Area
    {
        public int ID { get; set; }
        public string AreaName { get; set; }
        public int CityID { get; set; }
        public string CityName { get; set; }
    }


    public class SubAreas
    {
        public int ID { get; set; }
        public string AreaName { get; set; }
        public int? AreaID { get; set; }
        public string SubAreaName { get; set; }
    }
}