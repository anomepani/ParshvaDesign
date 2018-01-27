use Parshva
Go
--- Start Renew Scheduling code
--Select CONVERT(dATE,GETDATE()),DATEADD(M,1,CONVERT(dATE,GETDATE())),dATEADD(dAY,-1,DATEADD(M,1,CONVERT(dATE,GETDATE())))-- where  
 
 --Note : for last month or last renewed not work correctly if renew period is not proper like 45 days or other days
 --First insert new record with proper fromdate and todate and also compare todate with today's date

Insert into HoardingHistory( UserID, HoardingMasterID, FromDate, ToDate, Amount, Status, Type, BannerName, CreatedDate, CreatedBy, UpdatedBy, UpdatedDate, IsPermanent, IsExpired, IsRenewed, IsActive, IsDeleted)
SELECT  UserID, HoardingMasterID, DATEADD(M,1,CONVERT(DATE,FromDate)), ToDate, Amount, Status, Type, BannerName, GETDATE(), CreatedBy, null, null, IsPermanent, IsExpired, IsRenewed, IsActive, IsDeleted
 FROM HoardingHistory
 where (IsActive is null or IsActive =1)
 and  (IsDeleted is null or IsDeleted=0)
 and (IsExpired is null or  IsExpired=0)
 and (IsRenewed =1) 
 and DATEADD(M,1,CONVERT(dATE,FromDate))<=CONVERT(dATE,GETDATE()) AND GETDATE()<ToDate
GO
--Second update toDate and EsExpired flag,isrenew flag for currently renewed entery 


 Update HoardingHistory set IsExpired=1,IsRenewed=0,  ToDate=DATEADD(M,1,CONVERT(dATE,FromDate))
 where (IsActive is null or IsActive =1)
 and  (IsDeleted is null or IsDeleted=0)
 and (IsExpired is null or  IsExpired=0)
 and IsRenewed=1
 and DATEADD(M,1,CONVERT(dATE,FromDate))<=CONVERT(dATE,GETDATE()) AND GETDATE()<ToDate
 GO

  --dATEADD(dAY,-1,DATEADD(M,1,CONVERT(dATE,GETDATE())))
--Update HoardingHistory set ToDate=dATEADD(dAY,-1,DATEADD(M,1,CONVERT(dATE,GETDATE())))
--End renew hoarding 

--Expire temporary entery

Update HoardingHistory 
SET ISActive=1
WHERE HoardingMasterID in 
(Select HoardingMasterID from HoardingHistory where (IsExpired Is Null OR IsExpired =0 )
and IsActive=1 
and (IsDeleted is null OR IsDeleted=0)
and ToDate<GetDate()
and type='temporary')

GO

Update HoardingHistory 
SET IsExpired=1
where (IsExpired Is Null OR IsExpired =0 )
and IsActive=1 
and (IsDeleted is null OR IsDeleted=0)
and ToDate<GetDate()
and type='temporary'
GO

-- Expire permanent entery
Update HoardingHistory 
SET ISExpired=1
where (IsExpired Is Null OR IsExpired =0 )
and IsActive=1 
and (IsDeleted is null OR IsDeleted=0)
and ToDate<GetDate()
and type='permanent'
