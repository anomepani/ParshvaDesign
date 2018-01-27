﻿//------------------------------------------------------------------------------
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
    using System.Data.Entity;
    using System.Data.Entity.Infrastructure;
    using System.Data.Objects;
    using System.Data.Objects.DataClasses;
    using System.Linq;
    
    public partial class ParshvnathEntities : DbContext
    {
        public ParshvnathEntities()
            : base("name=ParshvnathEntities")
        {
        }
    
        protected override void OnModelCreating(DbModelBuilder modelBuilder)
        {
            throw new UnintentionalCodeFirstException();
        }
    
        public DbSet<Admin> Admins { get; set; }
        public DbSet<AreaDetail> AreaDetails { get; set; }
        public DbSet<CityDetail> CityDetails { get; set; }
        public DbSet<HoardingHistory> HoardingHistories { get; set; }
        public DbSet<ReceiptDetail> ReceiptDetails { get; set; }
        public DbSet<SubAreaDetail> SubAreaDetails { get; set; }
        public DbSet<UserDetail> UserDetails { get; set; }
        public DbSet<HoardingMaster> HoardingMasters { get; set; }
        public DbSet<vwAdvanceHoardingDetail> vwAdvanceHoardingDetails { get; set; }
        public DbSet<vwHoardingDetail> vwHoardingDetails { get; set; }
    
        public virtual ObjectResult<GetHoardingDetails_Result> GetHoardingDetails()
        {
            return ((IObjectContextAdapter)this).ObjectContext.ExecuteFunction<GetHoardingDetails_Result>("GetHoardingDetails");
        }
    
        public virtual ObjectResult<GetHoardingMaster_Result> GetHoardingMaster()
        {
            return ((IObjectContextAdapter)this).ObjectContext.ExecuteFunction<GetHoardingMaster_Result>("GetHoardingMaster");
        }
    
        public virtual ObjectResult<CheckPermanentEntry_Result> CheckPermanentEntry(Nullable<System.DateTime> fromDate, Nullable<System.DateTime> toDate, string type, Nullable<int> hoardingMasterID)
        {
            var fromDateParameter = fromDate.HasValue ?
                new ObjectParameter("fromDate", fromDate) :
                new ObjectParameter("fromDate", typeof(System.DateTime));
    
            var toDateParameter = toDate.HasValue ?
                new ObjectParameter("toDate", toDate) :
                new ObjectParameter("toDate", typeof(System.DateTime));
    
            var typeParameter = type != null ?
                new ObjectParameter("type", type) :
                new ObjectParameter("type", typeof(string));
    
            var hoardingMasterIDParameter = hoardingMasterID.HasValue ?
                new ObjectParameter("hoardingMasterID", hoardingMasterID) :
                new ObjectParameter("hoardingMasterID", typeof(int));
    
            return ((IObjectContextAdapter)this).ObjectContext.ExecuteFunction<CheckPermanentEntry_Result>("CheckPermanentEntry", fromDateParameter, toDateParameter, typeParameter, hoardingMasterIDParameter);
        }
    
        public virtual ObjectResult<CheckTemporaryEntry_Result> CheckTemporaryEntry(Nullable<System.DateTime> fromDate, Nullable<System.DateTime> toDate, string type, Nullable<int> hoardingMasterID)
        {
            var fromDateParameter = fromDate.HasValue ?
                new ObjectParameter("fromDate", fromDate) :
                new ObjectParameter("fromDate", typeof(System.DateTime));
    
            var toDateParameter = toDate.HasValue ?
                new ObjectParameter("toDate", toDate) :
                new ObjectParameter("toDate", typeof(System.DateTime));
    
            var typeParameter = type != null ?
                new ObjectParameter("type", type) :
                new ObjectParameter("type", typeof(string));
    
            var hoardingMasterIDParameter = hoardingMasterID.HasValue ?
                new ObjectParameter("hoardingMasterID", hoardingMasterID) :
                new ObjectParameter("hoardingMasterID", typeof(int));
    
            return ((IObjectContextAdapter)this).ObjectContext.ExecuteFunction<CheckTemporaryEntry_Result>("CheckTemporaryEntry", fromDateParameter, toDateParameter, typeParameter, hoardingMasterIDParameter);
        }
    
        public virtual ObjectResult<GetHoardingMasterByID_Result> GetHoardingMasterByID(Nullable<int> iD)
        {
            var iDParameter = iD.HasValue ?
                new ObjectParameter("ID", iD) :
                new ObjectParameter("ID", typeof(int));
    
            return ((IObjectContextAdapter)this).ObjectContext.ExecuteFunction<GetHoardingMasterByID_Result>("GetHoardingMasterByID", iDParameter);
        }
    
        public virtual ObjectResult<IsHoardingExsist_Result> IsHoardingExsist(Nullable<int> subAreaID, Nullable<int> hoardingNo, Nullable<int> areaID)
        {
            var subAreaIDParameter = subAreaID.HasValue ?
                new ObjectParameter("SubAreaID", subAreaID) :
                new ObjectParameter("SubAreaID", typeof(int));
    
            var hoardingNoParameter = hoardingNo.HasValue ?
                new ObjectParameter("HoardingNo", hoardingNo) :
                new ObjectParameter("HoardingNo", typeof(int));
    
            var areaIDParameter = areaID.HasValue ?
                new ObjectParameter("AreaID", areaID) :
                new ObjectParameter("AreaID", typeof(int));
    
            return ((IObjectContextAdapter)this).ObjectContext.ExecuteFunction<IsHoardingExsist_Result>("IsHoardingExsist", subAreaIDParameter, hoardingNoParameter, areaIDParameter);
        }
    
        public virtual ObjectResult<GetAllHoardingEntry_Result> GetAllHoardingEntry()
        {
            return ((IObjectContextAdapter)this).ObjectContext.ExecuteFunction<GetAllHoardingEntry_Result>("GetAllHoardingEntry");
        }
    
        public virtual ObjectResult<GetHoardingEntryByID_Result> GetHoardingEntryByID(Nullable<int> hoardingHistoryID)
        {
            var hoardingHistoryIDParameter = hoardingHistoryID.HasValue ?
                new ObjectParameter("HoardingHistoryID", hoardingHistoryID) :
                new ObjectParameter("HoardingHistoryID", typeof(int));
    
            return ((IObjectContextAdapter)this).ObjectContext.ExecuteFunction<GetHoardingEntryByID_Result>("GetHoardingEntryByID", hoardingHistoryIDParameter);
        }
    
        public virtual ObjectResult<CheckPermanentEntryForUpdate_Result> CheckPermanentEntryForUpdate(Nullable<System.DateTime> fromDate, Nullable<System.DateTime> toDate, string type, Nullable<int> hoardingMasterID, Nullable<int> hoardingHistoryID)
        {
            var fromDateParameter = fromDate.HasValue ?
                new ObjectParameter("fromDate", fromDate) :
                new ObjectParameter("fromDate", typeof(System.DateTime));
    
            var toDateParameter = toDate.HasValue ?
                new ObjectParameter("toDate", toDate) :
                new ObjectParameter("toDate", typeof(System.DateTime));
    
            var typeParameter = type != null ?
                new ObjectParameter("type", type) :
                new ObjectParameter("type", typeof(string));
    
            var hoardingMasterIDParameter = hoardingMasterID.HasValue ?
                new ObjectParameter("hoardingMasterID", hoardingMasterID) :
                new ObjectParameter("hoardingMasterID", typeof(int));
    
            var hoardingHistoryIDParameter = hoardingHistoryID.HasValue ?
                new ObjectParameter("hoardingHistoryID", hoardingHistoryID) :
                new ObjectParameter("hoardingHistoryID", typeof(int));
    
            return ((IObjectContextAdapter)this).ObjectContext.ExecuteFunction<CheckPermanentEntryForUpdate_Result>("CheckPermanentEntryForUpdate", fromDateParameter, toDateParameter, typeParameter, hoardingMasterIDParameter, hoardingHistoryIDParameter);
        }
    
        public virtual ObjectResult<CheckTemporaryEntryForUpdate_Result> CheckTemporaryEntryForUpdate(Nullable<System.DateTime> fromDate, Nullable<System.DateTime> toDate, string type, Nullable<int> hoardingMasterID, Nullable<int> hoardingHistoryID)
        {
            var fromDateParameter = fromDate.HasValue ?
                new ObjectParameter("fromDate", fromDate) :
                new ObjectParameter("fromDate", typeof(System.DateTime));
    
            var toDateParameter = toDate.HasValue ?
                new ObjectParameter("toDate", toDate) :
                new ObjectParameter("toDate", typeof(System.DateTime));
    
            var typeParameter = type != null ?
                new ObjectParameter("type", type) :
                new ObjectParameter("type", typeof(string));
    
            var hoardingMasterIDParameter = hoardingMasterID.HasValue ?
                new ObjectParameter("hoardingMasterID", hoardingMasterID) :
                new ObjectParameter("hoardingMasterID", typeof(int));
    
            var hoardingHistoryIDParameter = hoardingHistoryID.HasValue ?
                new ObjectParameter("hoardingHistoryID", hoardingHistoryID) :
                new ObjectParameter("hoardingHistoryID", typeof(int));
    
            return ((IObjectContextAdapter)this).ObjectContext.ExecuteFunction<CheckTemporaryEntryForUpdate_Result>("CheckTemporaryEntryForUpdate", fromDateParameter, toDateParameter, typeParameter, hoardingMasterIDParameter, hoardingHistoryIDParameter);
        }
    
        public virtual int ExpireHoarding()
        {
            return ((IObjectContextAdapter)this).ObjectContext.ExecuteFunction("ExpireHoarding");
        }
    
        public virtual int ExpireTemporaryHoarding()
        {
            return ((IObjectContextAdapter)this).ObjectContext.ExecuteFunction("ExpireTemporaryHoarding");
        }
    
        public virtual ObjectResult<GetAdvanceHoardingDetails_Result> GetAdvanceHoardingDetails()
        {
            return ((IObjectContextAdapter)this).ObjectContext.ExecuteFunction<GetAdvanceHoardingDetails_Result>("GetAdvanceHoardingDetails");
        }
    }
}