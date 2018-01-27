use parshva
go

CREATE  VIEW [dbo].[vwAdvanceHoardingDetails]
AS

-- I have added MinDate means first future entry for corresponding hoding						 
Select * FROM(
SELECT        dbo.UserDetail.CompanyName, dbo.HoardingHistory.FromDate, dbo.HoardingHistory.ToDate, dbo.HoardingHistory.Amount, dbo.HoardingHistory.IsExpired, dbo.HoardingHistory.Type, 
                         dbo.HoardingHistory.BannerName,dbo.HoardingHistory.HoadingHistoryID, dbo.HoardingHistory.IsActive, dbo.HoardingHistory.IsDeleted, dbo.HoardingHistory.IsPermanent, dbo.HoardingHistory.HoardingMasterID, MIN(ToDate) OVER(PARTITION BY HoardingMasterID) AS MinDate
FROM            dbo.HoardingHistory INNER JOIN
                         dbo.UserDetail ON dbo.HoardingHistory.UserID = dbo.UserDetail.UserID
WHERE        (dbo.HoardingHistory.IsActive = 1 OR
                         dbo.HoardingHistory.IsActive IS NULL) AND (dbo.HoardingHistory.IsDeleted = 0 OR
                         dbo.HoardingHistory.IsDeleted IS NULL)
						  AND (dbo.HoardingHistory.FromDate > GETDATE())
						 -- AND (dbo.HoardingHistory.IsExpired = 0 OR
                         --dbo.HoardingHistory.IsExpired IS NULL)
						 
						 ) as tmp 
WHERE tmp.ToDate= MinDate




GO


