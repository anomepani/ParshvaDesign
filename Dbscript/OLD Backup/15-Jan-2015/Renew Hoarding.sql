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
 and DATEADD(M,1,CONVERT(dATE,FromDate))=CONVERT(dATE,GETDATE()) AND GETDATE()<ToDate
GO
--Second update toDate and EsExpired flag for currently renewed entery 
 Update HoardingHistory set IsExpired=1, ToDate=dATEADD(dAY,-1,DATEADD(M,1,CONVERT(dATE,GETDATE())))
 where (IsActive is null or IsActive =1)
 and  (IsDeleted is null or IsDeleted=0)
 and (IsExpired is null or  IsExpired=0)
 and DATEADD(M,1,CONVERT(dATE,FromDate))=CONVERT(dATE,GETDATE()) AND GETDATE()<ToDate
 GO

  --dATEADD(dAY,-1,DATEADD(M,1,CONVERT(dATE,GETDATE())))
--Update HoardingHistory set ToDate=dATEADD(dAY,-1,DATEADD(M,1,CONVERT(dATE,GETDATE())))
GO