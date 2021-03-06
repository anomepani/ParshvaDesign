USE [Parshva]
GO
/****** Object:  StoredProcedure [dbo].[GetHoardingDetails]    Script Date: 12/27/2014 2:46:53 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- =============================================
CREATE  PROCEDURE [dbo].[GetAdvanceHoardingDetails] 

AS
BEGIN

 SELECT CityName,area, ISNULL(SubArea, Area)AS SubArea,hoardingmaster.ID,
       isnull(BannerName,'NoImage.png') as BannerName,
       CompanyName,
       hoardingmaster.HoardingNo,
	    hoardingmaster.CityID,
       hoardingmaster.AreaID,
	   hoardingmaster.SubAreaID,
	   hoardingmaster.HoardingSize,
	   FromDate,
       ToDate,
       IsExpired,
       Amount,
	   vwAdvanceHoardingDetails.HoadingHistoryID,
       IsPermanent,

       Left(upper([Type]),1 )as[Type]
FROM   hoardingmaster
       left JOIN vwAdvanceHoardingDetails
              ON  vwAdvanceHoardingDetails.HoardingMasterID= hoardingmaster.ID
       JOIN citydetail
         ON citydetail.ID = hoardingmaster.CityID
       JOIN areadetail
         ON areadetail.ID = hoardingmaster.AreaID
       LEFT JOIN subareadetail
              ON subareadetail.ID = hoardingmaster.SubAreaID  
			  	  Where (vwAdvanceHoardingDetails.IsDeleted is null or vwAdvanceHoardingDetails.IsDeleted=0 ) AND (Type='permanent' OR Type is null)  
				  and (CityDetail.IsActive=1 or CityDetail.IsActive is null) and (CityDetail.IsDeleted=0 or CityDetail.IsDeleted is null)
				  and (AreaDetail.IsActive=1 or AreaDetail.IsActive is null) and (AreaDetail.IsDeleted=0 or AreaDetail.IsDeleted is null) 
				   and (SubAreaDetail.IsActive=1 or SubAreaDetail.IsActive is null) and (SubAreaDetail.IsDeleted=0 or SubAreaDetail.IsDeleted is null) 
  and (hoardingmaster.IsActive=1 or hoardingmaster.IsActive is null) and (hoardingmaster.IsDeleted=0 or hoardingmaster.IsDeleted is null) 
			 Order BY CityID,AreaID,SubAreaID,HoardingNo
		
END



