//------------------------------------------------------------------------------
// <auto-generated>
//    This code was generated from a template.
//
//    Manual changes to this file may cause unexpected behavior in your application.
//    Manual changes to this file will be overwritten if the code is regenerated.
// </auto-generated>
//------------------------------------------------------------------------------

namespace Parshvnath
{
    using System;
    using System.Collections.Generic;
    
    public partial class HoardingHistory
    {
        public int HoadingHistoryID { get; set; }
        public Nullable<int> UserID { get; set; }
        public Nullable<int> HoardingMasterID { get; set; }
        public Nullable<System.DateTime> FromDate { get; set; }
        public Nullable<System.DateTime> ToDate { get; set; }
        public Nullable<decimal> Amount { get; set; }
        public string Status { get; set; }
        public string Type { get; set; }
        public string BannerName { get; set; }
        public Nullable<System.DateTime> CreatedDate { get; set; }
        public Nullable<int> CreatedBy { get; set; }
        public Nullable<System.DateTime> UpdatedBy { get; set; }
        public Nullable<System.DateTime> UpdatedDate { get; set; }
        public Nullable<bool> IsPermanent { get; set; }
        public Nullable<bool> IsExpired { get; set; }
        public Nullable<bool> IsRenewed { get; set; }
        public Nullable<bool> IsActive { get; set; }
        public Nullable<bool> IsDeleted { get; set; }
    
        public virtual UserDetail UserDetail { get; set; }
        public virtual HoardingMaster HoardingMaster { get; set; }
    }
}
