USE [Parshva]
GO
/****** Object:  StoredProcedure [dbo].[GetHoardingEntryByID]    Script Date: 12/27/2014 4:45:57 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- =============================================
ALTER  PROCEDURE [dbo].[GetHoardingEntryByID]
@HoardingHistoryID INT
AS
BEGIN


 SELECT CityName,area, ISNULL(SubArea, Area)AS SubArea,hoardingmaster.ID,
       BannerName,
       CompanyName,
                   hoardingmaster.HoardingNo,
			hoardingmaster.CityID,
       hoardingmaster.AreaID,
	   hoardingmaster.SubAreaID,
	   hoardingmaster.HoardingSize,
	   FromDate,
       ToDate,
       IsExpired,
	   UserDetail.UserID,
       Amount,
       IsPermanent,
	  ISNULL(IsRenewed,0) as IsRenewed,

       Left(upper([Type]),1 )as[Type]
FROM   hoardingmaster
        JOIN HoardingHistory
              ON hoardingmaster.ID = HoardingHistory.HoardingMasterID
       Join UserDetail on UserDetail.UserID=HoardingHistory.UserID
	   JOIN citydetail
         ON citydetail.ID = hoardingmaster.CityID
       JOIN areadetail
         ON areadetail.ID = hoardingmaster.AreaID
       LEFT JOIN subareadetail
              ON subareadetail.ID = hoardingmaster.SubAreaID  
			  Where HoardingHistory.IsActive=1 and (HoardingHistory.IsDeleted is null or HoardingHistory.IsDeleted=0) and HoardingHistory.HoadingHistoryID=@HoardingHistoryID 

			  Order BY CityID,AreaID,SubAreaID,HoardingNo

END

