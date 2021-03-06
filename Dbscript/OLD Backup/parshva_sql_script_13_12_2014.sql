USE [master]
GO
/****** Object:  Database [Parshva]    Script Date: 12/13/2014 10:33:19 AM ******/
CREATE DATABASE [Parshva] ON  PRIMARY 
( NAME = N'Parshva', FILENAME = N'f:\Program Files\Microsoft SQL Server\MSSQL11.SQLSERVER\MSSQL\DATA\Parshva.mdf' , SIZE = 4096KB , MAXSIZE = UNLIMITED, FILEGROWTH = 1024KB )
 LOG ON 
( NAME = N'Parshva_log', FILENAME = N'f:\Program Files\Microsoft SQL Server\MSSQL11.SQLSERVER\MSSQL\DATA\Parshva_log.ldf' , SIZE = 1024KB , MAXSIZE = 2048GB , FILEGROWTH = 10%)
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [Parshva].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [Parshva] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [Parshva] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [Parshva] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [Parshva] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [Parshva] SET ARITHABORT OFF 
GO
ALTER DATABASE [Parshva] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [Parshva] SET AUTO_CREATE_STATISTICS ON 
GO
ALTER DATABASE [Parshva] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [Parshva] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [Parshva] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [Parshva] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [Parshva] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [Parshva] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [Parshva] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [Parshva] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [Parshva] SET  DISABLE_BROKER 
GO
ALTER DATABASE [Parshva] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [Parshva] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [Parshva] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [Parshva] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [Parshva] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [Parshva] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [Parshva] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [Parshva] SET RECOVERY FULL 
GO
ALTER DATABASE [Parshva] SET  MULTI_USER 
GO
ALTER DATABASE [Parshva] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [Parshva] SET DB_CHAINING OFF 
GO
EXEC sys.sp_db_vardecimal_storage_format N'Parshva', N'ON'
GO
USE [Parshva]
GO
/****** Object:  StoredProcedure [dbo].[CheckPermanentEntry]    Script Date: 12/13/2014 10:33:20 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- =============================================
CREATE  PROCEDURE [dbo].[CheckPermanentEntry]
@fromDate DATETIME2=NULL,
@toDate DATETIME2=NULL,
@type VARCHAR(20)=NULL,
@hoardingMasterID INT=NULL
AS
BEGIN

Select * from  HoardingHistory where type='permanent'  and hoardingmasterid=@hoardingMasterID  -- and (IsExpired is null  or IsExpired=0)
and ( 
--between Date and overright date check
( FromDate<=@fromDate and ToDate>=@toDate)
OR
-- 
( FromDate>@fromDate and ToDate>=@toDate)
OR
-- 
( FromDate>@fromDate and ToDate<@toDate)
--OR
-- 
--( FromDate<@fromDate and ToDate<@toDate)
)


END

GO
/****** Object:  StoredProcedure [dbo].[CheckPermanentEntryForUpdate]    Script Date: 12/13/2014 10:33:20 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- =============================================
CREATE PROCEDURE [dbo].[CheckPermanentEntryForUpdate]
@fromDate DATETIME2=NULL,
@toDate DATETIME2=NULL,
@type VARCHAR(20)=NULL,
@hoardingMasterID INT=NULL,
@hoardingHistoryID INT=NULL
AS
BEGIN

Select * from  HoardingHistory where type='permanent'  and hoardingmasterid=@hoardingMasterID and HoadingHistoryID!=@hoardingHistoryID -- and (IsExpired is null  or IsExpired=0)
and ( 
--between Date and overright date check
( FromDate<=@fromDate and ToDate>=@toDate)
OR
-- 
( FromDate>@fromDate and ToDate>=@toDate)
OR
-- 
( FromDate>@fromDate and ToDate<@toDate)
--OR
-- 
--( FromDate<@fromDate and ToDate<@toDate)
)


END

GO
/****** Object:  StoredProcedure [dbo].[CheckTemporaryEntry]    Script Date: 12/13/2014 10:33:20 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- =============================================
CREATE  PROCEDURE [dbo].[CheckTemporaryEntry]
@fromDate DATETIME2=NULL,
@toDate DATETIME2=NULL,
@type VARCHAR(20)=NULL,
@hoardingMasterID INT=NULL
AS
BEGIN

Select * from  HoardingHistory where type='temporary'  and hoardingmasterid=@hoardingMasterID 
--and (IsExpired is null  or IsExpired=0) 
and ( FromDate<=@fromDate and ToDate>=@toDate)


END

GO
/****** Object:  StoredProcedure [dbo].[CheckTemporaryEntryForUpdate]    Script Date: 12/13/2014 10:33:20 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- =============================================
create  PROCEDURE [dbo].[CheckTemporaryEntryForUpdate]
@fromDate DATETIME2=NULL,
@toDate DATETIME2=NULL,
@type VARCHAR(20)=NULL,
@hoardingMasterID INT=NULL,
@hoardingHistoryID INT=NULL
AS
BEGIN

Select * from  HoardingHistory where type='temporary'  and hoardingmasterid=@hoardingMasterID and HoadingHistoryID!=@hoardingHistoryID
--and (IsExpired is null  or IsExpired=0) 
and ( FromDate<=@fromDate and ToDate>=@toDate)


END

GO
/****** Object:  StoredProcedure [dbo].[ExpireHoarding]    Script Date: 12/13/2014 10:33:20 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[ExpireHoarding] 
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
Update HoardingHistory 
SET ISExpired=1
where (IsExpired Is Null OR IsExpired =0 )
and IsActive=1 
and (IsDeleted is null OR IsDeleted=0)
and ToDate<GetDate()
and type='permanent'
END

GO
/****** Object:  StoredProcedure [dbo].[ExpireTemporaryHoarding]    Script Date: 12/13/2014 10:33:20 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[ExpireTemporaryHoarding] 
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

Update HoardingHistory 
SET ISActive=1
WHERE HoardingMasterID in 
(Select HoardingMasterID from HoardingHistory where (IsExpired Is Null OR IsExpired =0 )
and IsActive=1 
and (IsDeleted is null OR IsDeleted=0)
and ToDate<GetDate()
and type='temporary');



Update HoardingHistory 
SET IsExpired=1
where (IsExpired Is Null OR IsExpired =0 )
and IsActive=1 
and (IsDeleted is null OR IsDeleted=0)
and ToDate<GetDate()
and type='temporary';

END

GO
/****** Object:  StoredProcedure [dbo].[GetAllHoardingEntry]    Script Date: 12/13/2014 10:33:20 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- =============================================
CREATE  PROCEDURE [dbo].[GetAllHoardingEntry]
AS
BEGIN


Select HoadingHistoryID,HoardingMaster.CityID,HoardingMaster.AreaID, CityName,AreaDetail.Area,SubAreaDetail.SubArea,HoardingMaster.HoardingNo,HoardingMaster.HoardingSize, UserDetail.UserID,UserDetail.PersonName,UserDetail.CompanyName,UserDetail.PhoneNo,UserDetail.City, HoardingMasterID, FromDate, ToDate, Amount, [Status], [Type], BannerName, IsPermanent, IsExpired, IsRenewed 
FROM HoardingHistory
Join UserDetail on HoardingHistory.UserID=UserDetail.UserID
join HoardingMaster on HoardingMaster.ID=HoardingHistory.HoardingMasterID
JOIN CityDetail  ON CityDetail.ID = HoardingMaster.CityID
JOIN AreaDetail  ON AreaDetail.ID = HoardingMaster.AreaID
LEFT JOIN subareadetail ON subareadetail.ID = HoardingMaster.SubAreaID
WHERE (HoardingHistory.IsDeleted=0 or HoardingHistory.IsDeleted is null)
Order BY CityID,AreaID,SubAreaID,HoardingNo


END


GO
/****** Object:  StoredProcedure [dbo].[GetHoardingDetails]    Script Date: 12/13/2014 10:33:20 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- =============================================
CREATE  PROCEDURE [dbo].[GetHoardingDetails] 

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
	   vwHoardingDetails.HoadingHistoryID,
       IsPermanent,

       Left(upper([Type]),1 )as[Type]
FROM   hoardingmaster
       left JOIN vwhoardingdetails
              ON  vwhoardingdetails.HoardingMasterID= hoardingmaster.ID
       JOIN citydetail
         ON citydetail.ID = hoardingmaster.CityID
       JOIN areadetail
         ON areadetail.ID = hoardingmaster.AreaID
       LEFT JOIN subareadetail
              ON subareadetail.ID = hoardingmaster.SubAreaID  
			  	  Where (vwhoardingdetails.IsDeleted is null or vwHoardingDetails.IsDeleted=0 ) AND (Type='permanent' OR Type is null)  
				  and (CityDetail.IsActive=1 or CityDetail.IsActive is null) and (CityDetail.IsDeleted=0 or CityDetail.IsDeleted is null)
				  and (AreaDetail.IsActive=1 or AreaDetail.IsActive is null) and (AreaDetail.IsDeleted=0 or AreaDetail.IsDeleted is null) 
				   and (SubAreaDetail.IsActive=1 or SubAreaDetail.IsActive is null) and (SubAreaDetail.IsDeleted=0 or SubAreaDetail.IsDeleted is null) 
  and (hoardingmaster.IsActive=1 or hoardingmaster.IsActive is null) and (hoardingmaster.IsDeleted=0 or hoardingmaster.IsDeleted is null) 
			 Order BY CityID,AreaID,SubAreaID,HoardingNo
		
END




GO
/****** Object:  StoredProcedure [dbo].[GetHoardingEntryByID]    Script Date: 12/13/2014 10:33:20 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- =============================================
CREATE  PROCEDURE [dbo].[GetHoardingEntryByID]
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


GO
/****** Object:  StoredProcedure [dbo].[GetHoardingMaster]    Script Date: 12/13/2014 10:33:20 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- =============================================
CREATE  PROCEDURE [dbo].[GetHoardingMaster] 

AS
BEGIN
Select HoardingMaster.ID,CityName,HoardingMaster.CityID,HoardingMaster.AreaID,HoardingMaster.SubAreaID,Area,SubArea , HoardingMaster.HoardingNo,HoardingMaster.HoardingSize,HoardingMaster.IsActive,HoardingMaster.IsDeleted
from HoardingMaster
   join CityDetail on CityDetail.ID=HoardingMaster.CityID
   join AreaDetail on AreaDetail.ID=HoardingMaster.AreaID
   left join SubAreaDetail on SubAreaDetail.ID  = HoardingMaster.SubAreaID  
   Where HoardingMaster.IsActive=1 and (HoardingMaster.IsDeleted is null or HoardingMaster.IsDeleted=0)
   	  and (CityDetail.IsActive=1 or CityDetail.IsActive is null) and (CityDetail.IsDeleted=0 or CityDetail.IsDeleted is null)
				  and (AreaDetail.IsActive=1 or AreaDetail.IsActive is null) and (AreaDetail.IsDeleted=0 or AreaDetail.IsDeleted is null) 
				   and (SubAreaDetail.IsActive=1 or SubAreaDetail.IsActive is null) and (SubAreaDetail.IsDeleted=0 or SubAreaDetail.IsDeleted is null) 
			
END


GO
/****** Object:  StoredProcedure [dbo].[GetHoardingMasterByID]    Script Date: 12/13/2014 10:33:20 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- =============================================
CREATE  PROCEDURE [dbo].[GetHoardingMasterByID]
@ID INT=NULL
AS
BEGIN
Select HoardingMaster.ID,CityName,HoardingMaster.CityID,HoardingMaster.AreaID,HoardingMaster.SubAreaID,Area,SubArea , HoardingMaster.HoardingNo,HoardingMaster.HoardingSize,HoardingMaster.IsActive,HoardingMaster.IsDeleted
from HoardingMaster
   join CityDetail on CityDetail.ID=HoardingMaster.CityID
   join AreaDetail on AreaDetail.ID=HoardingMaster.AreaID
   left join SubAreaDetail on SubAreaDetail.ID  = HoardingMaster.SubAreaID  
   WHERE HoardingMaster.ID=@ID
END


GO
/****** Object:  StoredProcedure [dbo].[IsHoardingExsist]    Script Date: 12/13/2014 10:33:20 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- =============================================
CREATE  PROCEDURE [dbo].[IsHoardingExsist]
@SubAreaID INT=NULL,
@HoardingNo INT=NULL,
@AreaID INT=NULL
AS
BEGIN

Select * from HoardingMaster where( (SubAreaID=@SubAreaID and HoardingNo=@HoardingNo) or (AreaID=@AreaID and  HoardingNo=@HoardingNo and SubAreaID is null)) and (IsDeleted=0 or IsDeleted is null) and (IsActive=1 or IsActive is null)


END


GO
/****** Object:  Table [dbo].[Admin]    Script Date: 12/13/2014 10:33:20 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Admin](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[Username] [nvarchar](50) NULL,
	[Password] [nvarchar](50) NULL,
	[CreatedDate] [datetime2](7) NULL,
	[CreatedBy] [int] NULL,
	[UpdatedDate] [datetime2](7) NULL,
	[UpdatedBy] [int] NULL,
	[IsActive] [bit] NULL,
	[IsDeleted] [bit] NULL,
 CONSTRAINT [PK_Admin] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[AreaDetail]    Script Date: 12/13/2014 10:33:20 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[AreaDetail](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[CityID] [int] NOT NULL,
	[Area] [nvarchar](500) NULL,
	[IsActive] [bit] NULL,
	[IsDeleted] [bit] NULL,
 CONSTRAINT [PK_AreaDetail] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[CityDetail]    Script Date: 12/13/2014 10:33:20 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[CityDetail](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[CityName] [nvarchar](50) NULL,
	[IsActive] [bit] NULL,
	[IsDeleted] [bit] NULL,
 CONSTRAINT [PK_CityDetail] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[HoardingHistory]    Script Date: 12/13/2014 10:33:20 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[HoardingHistory](
	[HoadingHistoryID] [int] IDENTITY(1,1) NOT NULL,
	[UserID] [int] NULL,
	[HoardingMasterID] [int] NULL,
	[FromDate] [datetime2](7) NULL,
	[ToDate] [datetime2](7) NULL,
	[Amount] [money] NULL,
	[Status] [nvarchar](50) NULL,
	[Type] [nvarchar](50) NULL,
	[BannerName] [nvarchar](200) NULL,
	[CreatedDate] [datetime2](7) NULL,
	[CreatedBy] [int] NULL,
	[UpdatedBy] [datetime2](7) NULL,
	[UpdatedDate] [datetime2](7) NULL,
	[IsPermanent] [bit] NULL,
	[IsExpired] [bit] NULL,
	[IsRenewed] [bit] NULL,
	[IsActive] [bit] NULL,
	[IsDeleted] [bit] NULL,
 CONSTRAINT [PK_HoardingHistory] PRIMARY KEY CLUSTERED 
(
	[HoadingHistoryID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[HoardingMaster]    Script Date: 12/13/2014 10:33:20 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[HoardingMaster](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[CityID] [int] NULL,
	[AreaID] [int] NULL,
	[SubAreaID] [int] NULL,
	[HoardingNo] [int] NULL,
	[HoardingSize] [nvarchar](50) NULL,
	[IsActive] [bit] NULL,
	[IsDeleted] [bit] NULL,
 CONSTRAINT [PK_HoardingMaster] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[ReceiptDetail]    Script Date: 12/13/2014 10:33:20 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[ReceiptDetail](
	[ReceiptNo] [int] IDENTITY(1,1) NOT NULL,
	[ReceiptDate] [datetime2](7) NULL,
	[CompanyName] [varchar](50) NULL,
	[Amount] [money] NULL,
 CONSTRAINT [PK_ReceiptDetail] PRIMARY KEY CLUSTERED 
(
	[ReceiptNo] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[SubAreaDetail]    Script Date: 12/13/2014 10:33:20 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[SubAreaDetail](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[AreaID] [int] NULL,
	[SubArea] [varchar](50) NULL,
	[IsActive] [bit] NULL,
	[IsDeleted] [bit] NULL,
 CONSTRAINT [PK_SubAreaDetail] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[UserDetail]    Script Date: 12/13/2014 10:33:20 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[UserDetail](
	[UserID] [int] IDENTITY(3,1) NOT NULL,
	[CompanyName] [nvarchar](50) NULL,
	[PersonName] [nvarchar](50) NULL,
	[PhoneNo] [nvarchar](50) NULL,
	[City] [nvarchar](50) NULL,
	[CompanyAddress] [nvarchar](500) NULL,
	[Email] [nvarchar](50) NULL,
	[CreatedDate] [datetime2](7) NULL,
	[CreatedBy] [int] NULL,
	[UpdatedDate] [datetime2](7) NULL,
	[UpdatedBy] [int] NULL,
	[IsActive] [bit] NULL,
	[IsDeleted] [bit] NULL,
 CONSTRAINT [PK_UserDetail] PRIMARY KEY CLUSTERED 
(
	[UserID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  View [dbo].[vwHoardingDetails]    Script Date: 12/13/2014 10:33:20 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO




CREATE VIEW [dbo].[vwHoardingDetails]
AS
--SELECT        UserDetail.CompanyName, HoardingHistory.FromDate, HoardingHistory.ToDate, HoardingHistory.Amount, HoardingHistory.IsExpired, HoardingHistory.Type, 
--                         HoardingHistory.BannerName, HoardingHistory.IsActive, HoardingHistory.IsDeleted, HoardingHistory.IsPermanent, HoardingHistory.HoardingMasterID
--FROM            HoardingHistory INNER JOIN
--                         UserDetail ON HoardingHistory.UserID = UserDetail.UserID
--WHERE        (HoardingHistory.IsActive = 1 OR
--                         HoardingHistory.IsActive IS NULL) AND (HoardingHistory.IsDeleted = 0 OR
--                         HoardingHistory.IsDeleted IS NULL) AND (HoardingHistory.FromDate <=GETDATE() AND (  HoardingHistory.IsExpired=0 or HoardingHistory.IsExpired IS NULL))
						 
Select * FROM(
SELECT        dbo.UserDetail.CompanyName, dbo.HoardingHistory.FromDate, dbo.HoardingHistory.ToDate, dbo.HoardingHistory.Amount, dbo.HoardingHistory.IsExpired, dbo.HoardingHistory.Type, 
                         dbo.HoardingHistory.BannerName,dbo.HoardingHistory.HoadingHistoryID, dbo.HoardingHistory.IsActive, dbo.HoardingHistory.IsDeleted, dbo.HoardingHistory.IsPermanent, dbo.HoardingHistory.HoardingMasterID, MAX(ToDate) OVER(PARTITION BY HoardingMasterID) AS MaxDate
FROM            dbo.HoardingHistory INNER JOIN
                         dbo.UserDetail ON dbo.HoardingHistory.UserID = dbo.UserDetail.UserID
WHERE        (dbo.HoardingHistory.IsActive = 1 OR
                         dbo.HoardingHistory.IsActive IS NULL) AND (dbo.HoardingHistory.IsDeleted = 0 OR
                         dbo.HoardingHistory.IsDeleted IS NULL)
						  AND (dbo.HoardingHistory.FromDate <= GETDATE())
						 -- AND (dbo.HoardingHistory.IsExpired = 0 OR
                         --dbo.HoardingHistory.IsExpired IS NULL)
						 
						 ) as tmp 
WHERE tmp.ToDate= MaxDate




GO
SET IDENTITY_INSERT [dbo].[Admin] ON 

GO
INSERT [dbo].[Admin] ([ID], [Username], [Password], [CreatedDate], [CreatedBy], [UpdatedDate], [UpdatedBy], [IsActive], [IsDeleted]) VALUES (1, N'admin', N'admin', NULL, NULL, NULL, NULL, 1, 0)
GO
SET IDENTITY_INSERT [dbo].[Admin] OFF
GO
SET IDENTITY_INSERT [dbo].[AreaDetail] ON 

GO
INSERT [dbo].[AreaDetail] ([ID], [CityID], [Area], [IsActive], [IsDeleted]) VALUES (2, 2, N'Jubilee Ground', 1, 0)
GO
INSERT [dbo].[AreaDetail] ([ID], [CityID], [Area], [IsActive], [IsDeleted]) VALUES (3, 2, N'Kutchh Mitra', 1, 0)
GO
INSERT [dbo].[AreaDetail] ([ID], [CityID], [Area], [IsActive], [IsDeleted]) VALUES (4, 2, N'Bus Station', 1, 0)
GO
INSERT [dbo].[AreaDetail] ([ID], [CityID], [Area], [IsActive], [IsDeleted]) VALUES (5, 2, N'Kenson Tower', 1, 0)
GO
INSERT [dbo].[AreaDetail] ([ID], [CityID], [Area], [IsActive], [IsDeleted]) VALUES (6, 2, N'Hill Garden Turn', 1, 0)
GO
INSERT [dbo].[AreaDetail] ([ID], [CityID], [Area], [IsActive], [IsDeleted]) VALUES (7, 2, N'Relience Pump', 1, 0)
GO
INSERT [dbo].[AreaDetail] ([ID], [CityID], [Area], [IsActive], [IsDeleted]) VALUES (8, 2, N'General Hospital Circle', 1, 0)
GO
INSERT [dbo].[AreaDetail] ([ID], [CityID], [Area], [IsActive], [IsDeleted]) VALUES (9, 2, N'RTO Circle', 1, 0)
GO
INSERT [dbo].[AreaDetail] ([ID], [CityID], [Area], [IsActive], [IsDeleted]) VALUES (10, 2, N'RTO Pase', 1, 0)
GO
INSERT [dbo].[AreaDetail] ([ID], [CityID], [Area], [IsActive], [IsDeleted]) VALUES (11, 2, N'Madhapar Madhuli', 1, 0)
GO
INSERT [dbo].[AreaDetail] ([ID], [CityID], [Area], [IsActive], [IsDeleted]) VALUES (12, 2, N'Juno Aajkal', 1, 0)
GO
INSERT [dbo].[AreaDetail] ([ID], [CityID], [Area], [IsActive], [IsDeleted]) VALUES (13, 2, N'Bhid  Circle', 1, 0)
GO
INSERT [dbo].[AreaDetail] ([ID], [CityID], [Area], [IsActive], [IsDeleted]) VALUES (14, 2, N'Lal Tekari', 1, 0)
GO
INSERT [dbo].[AreaDetail] ([ID], [CityID], [Area], [IsActive], [IsDeleted]) VALUES (15, 2, N'GEB Gate', 1, 0)
GO
INSERT [dbo].[AreaDetail] ([ID], [CityID], [Area], [IsActive], [IsDeleted]) VALUES (16, 2, N'Golden Palace', 1, 0)
GO
INSERT [dbo].[AreaDetail] ([ID], [CityID], [Area], [IsActive], [IsDeleted]) VALUES (17, 2, N'Revenue Colony', 1, 0)
GO
INSERT [dbo].[AreaDetail] ([ID], [CityID], [Area], [IsActive], [IsDeleted]) VALUES (18, 2, N'Viram Hotel', 1, 0)
GO
INSERT [dbo].[AreaDetail] ([ID], [CityID], [Area], [IsActive], [IsDeleted]) VALUES (19, 2, N'Town Hall', 1, 0)
GO
INSERT [dbo].[AreaDetail] ([ID], [CityID], [Area], [IsActive], [IsDeleted]) VALUES (20, 2, N'Swaminarayan Mandir', 1, 0)
GO
INSERT [dbo].[AreaDetail] ([ID], [CityID], [Area], [IsActive], [IsDeleted]) VALUES (21, 2, N'Mangalam Turn', 1, 0)
GO
INSERT [dbo].[AreaDetail] ([ID], [CityID], [Area], [IsActive], [IsDeleted]) VALUES (22, 2, N'Passport Gate Gahenani Same', 1, 0)
GO
INSERT [dbo].[AreaDetail] ([ID], [CityID], [Area], [IsActive], [IsDeleted]) VALUES (23, 2, N'Changleshvar', 1, 0)
GO
INSERT [dbo].[AreaDetail] ([ID], [CityID], [Area], [IsActive], [IsDeleted]) VALUES (24, 2, N'Bhuj English School', 1, 0)
GO
INSERT [dbo].[AreaDetail] ([ID], [CityID], [Area], [IsActive], [IsDeleted]) VALUES (25, 2, N'jjj', 1, 1)
GO
INSERT [dbo].[AreaDetail] ([ID], [CityID], [Area], [IsActive], [IsDeleted]) VALUES (26, 2, N't', 1, 1)
GO
SET IDENTITY_INSERT [dbo].[AreaDetail] OFF
GO
SET IDENTITY_INSERT [dbo].[CityDetail] ON 

GO
INSERT [dbo].[CityDetail] ([ID], [CityName], [IsActive], [IsDeleted]) VALUES (2, N'Bhuj', 1, 0)
GO
INSERT [dbo].[CityDetail] ([ID], [CityName], [IsActive], [IsDeleted]) VALUES (3, N'Anjar', 1, 0)
GO
INSERT [dbo].[CityDetail] ([ID], [CityName], [IsActive], [IsDeleted]) VALUES (4, N'Kandla', 1, 1)
GO
INSERT [dbo].[CityDetail] ([ID], [CityName], [IsActive], [IsDeleted]) VALUES (5, N'Kandla', 1, 0)
GO
SET IDENTITY_INSERT [dbo].[CityDetail] OFF
GO
SET IDENTITY_INSERT [dbo].[HoardingHistory] ON 

GO
INSERT [dbo].[HoardingHistory] ([HoadingHistoryID], [UserID], [HoardingMasterID], [FromDate], [ToDate], [Amount], [Status], [Type], [BannerName], [CreatedDate], [CreatedBy], [UpdatedBy], [UpdatedDate], [IsPermanent], [IsExpired], [IsRenewed], [IsActive], [IsDeleted]) VALUES (1, 1, 2, CAST(0x0700000000001B390B AS DateTime2), CAST(0x07000000000025390B AS DateTime2), 5000.0000, NULL, N'permanent', N'20141020012319103.png', CAST(0x073079BA454712390B AS DateTime2), NULL, NULL, CAST(0x07C9C0B2A30B25390B AS DateTime2), 1, 1, NULL, 1, 1)
GO
INSERT [dbo].[HoardingHistory] ([HoadingHistoryID], [UserID], [HoardingMasterID], [FromDate], [ToDate], [Amount], [Status], [Type], [BannerName], [CreatedDate], [CreatedBy], [UpdatedBy], [UpdatedDate], [IsPermanent], [IsExpired], [IsRenewed], [IsActive], [IsDeleted]) VALUES (2, 1, 2, CAST(0x0700000000001B390B AS DateTime2), CAST(0x07000000000025390B AS DateTime2), 1000.0000, NULL, N'temporary', N'20141001090018073.png', CAST(0x0769C9AD7A4B12390B AS DateTime2), NULL, NULL, NULL, 0, 1, NULL, 1, 0)
GO
INSERT [dbo].[HoardingHistory] ([HoadingHistoryID], [UserID], [HoardingMasterID], [FromDate], [ToDate], [Amount], [Status], [Type], [BannerName], [CreatedDate], [CreatedBy], [UpdatedBy], [UpdatedDate], [IsPermanent], [IsExpired], [IsRenewed], [IsActive], [IsDeleted]) VALUES (3, 1, 6, CAST(0x0700000000001B390B AS DateTime2), CAST(0x0700000000002F390B AS DateTime2), 7000.0000, NULL, N'permanent', N'20141020012355512.png', CAST(0x072593E5FAB219390B AS DateTime2), NULL, NULL, CAST(0x07AF3C66B90B25390B AS DateTime2), 1, 1, NULL, 1, 0)
GO
INSERT [dbo].[HoardingHistory] ([HoadingHistoryID], [UserID], [HoardingMasterID], [FromDate], [ToDate], [Amount], [Status], [Type], [BannerName], [CreatedDate], [CreatedBy], [UpdatedBy], [UpdatedDate], [IsPermanent], [IsExpired], [IsRenewed], [IsActive], [IsDeleted]) VALUES (4, 1, 5, CAST(0x0700000000001B390B AS DateTime2), CAST(0x0700000000002F390B AS DateTime2), 1000.0000, NULL, N'permanent', N'20141008222541297.png', CAST(0x07404A90FDBB19390B AS DateTime2), NULL, NULL, CAST(0x077A66B77A0743390B AS DateTime2), 1, 1, NULL, 1, 0)
GO
INSERT [dbo].[HoardingHistory] ([HoadingHistoryID], [UserID], [HoardingMasterID], [FromDate], [ToDate], [Amount], [Status], [Type], [BannerName], [CreatedDate], [CreatedBy], [UpdatedBy], [UpdatedDate], [IsPermanent], [IsExpired], [IsRenewed], [IsActive], [IsDeleted]) VALUES (6, 1, 6, CAST(0x0700000000001B390B AS DateTime2), CAST(0x0700000000002F390B AS DateTime2), 1000.0000, NULL, N'temporary', N'20141008223330543.png', CAST(0x07E2004B15BD19390B AS DateTime2), NULL, NULL, NULL, 0, 1, NULL, 1, 0)
GO
INSERT [dbo].[HoardingHistory] ([HoadingHistoryID], [UserID], [HoardingMasterID], [FromDate], [ToDate], [Amount], [Status], [Type], [BannerName], [CreatedDate], [CreatedBy], [UpdatedBy], [UpdatedDate], [IsPermanent], [IsExpired], [IsRenewed], [IsActive], [IsDeleted]) VALUES (7, 1, 10, CAST(0x07000000000016390B AS DateTime2), CAST(0x07000000000020390B AS DateTime2), 1000.0000, NULL, N'permanent', N'20141009000451464.png', CAST(0x07141DBCAD001A390B AS DateTime2), NULL, NULL, NULL, 1, 1, NULL, 1, 0)
GO
INSERT [dbo].[HoardingHistory] ([HoadingHistoryID], [UserID], [HoardingMasterID], [FromDate], [ToDate], [Amount], [Status], [Type], [BannerName], [CreatedDate], [CreatedBy], [UpdatedBy], [UpdatedDate], [IsPermanent], [IsExpired], [IsRenewed], [IsActive], [IsDeleted]) VALUES (8, 1, 11, CAST(0x07000000000012390B AS DateTime2), CAST(0x07000000000021390B AS DateTime2), 4000.0000, NULL, N'permanent', N'20141009001152676.png', CAST(0x071ED3CBA8011A390B AS DateTime2), NULL, NULL, NULL, 1, 1, NULL, 1, 0)
GO
INSERT [dbo].[HoardingHistory] ([HoadingHistoryID], [UserID], [HoardingMasterID], [FromDate], [ToDate], [Amount], [Status], [Type], [BannerName], [CreatedDate], [CreatedBy], [UpdatedBy], [UpdatedDate], [IsPermanent], [IsExpired], [IsRenewed], [IsActive], [IsDeleted]) VALUES (9, 1, 8, CAST(0x07000000000012390B AS DateTime2), CAST(0x0700000000001C390B AS DateTime2), 4100.0000, NULL, N'permanent', N'20141009231748559.png', CAST(0x0756C89545C31A390B AS DateTime2), NULL, NULL, NULL, 1, 1, NULL, 1, 0)
GO
INSERT [dbo].[HoardingHistory] ([HoadingHistoryID], [UserID], [HoardingMasterID], [FromDate], [ToDate], [Amount], [Status], [Type], [BannerName], [CreatedDate], [CreatedBy], [UpdatedBy], [UpdatedDate], [IsPermanent], [IsExpired], [IsRenewed], [IsActive], [IsDeleted]) VALUES (10, 1, 2, CAST(0x0700000000001B390B AS DateTime2), CAST(0x0700000000002A390B AS DateTime2), 4100.0000, NULL, N'permanent', N'20141009234417607.png', CAST(0x07F4C5C4F8C61A390B AS DateTime2), NULL, NULL, NULL, 1, 0, NULL, 1, 1)
GO
INSERT [dbo].[HoardingHistory] ([HoadingHistoryID], [UserID], [HoardingMasterID], [FromDate], [ToDate], [Amount], [Status], [Type], [BannerName], [CreatedDate], [CreatedBy], [UpdatedBy], [UpdatedDate], [IsPermanent], [IsExpired], [IsRenewed], [IsActive], [IsDeleted]) VALUES (11, 1, 3, CAST(0x07000000000031390B AS DateTime2), CAST(0x0700000000003B390B AS DateTime2), 4100.0000, NULL, N'permanent', N'20141020012501130.png', CAST(0x07AD3C5958011B390B AS DateTime2), NULL, NULL, CAST(0x0760818DE00B25390B AS DateTime2), 1, 1, NULL, 1, 0)
GO
INSERT [dbo].[HoardingHistory] ([HoadingHistoryID], [UserID], [HoardingMasterID], [FromDate], [ToDate], [Amount], [Status], [Type], [BannerName], [CreatedDate], [CreatedBy], [UpdatedBy], [UpdatedDate], [IsPermanent], [IsExpired], [IsRenewed], [IsActive], [IsDeleted]) VALUES (12, 1, 4, CAST(0x07000000000012390B AS DateTime2), CAST(0x07000000000021390B AS DateTime2), 4100.0000, NULL, N'permanent', N'20141010001319794.png', CAST(0x0786F4B6DC011B390B AS DateTime2), NULL, NULL, NULL, 1, 1, NULL, 1, 0)
GO
INSERT [dbo].[HoardingHistory] ([HoadingHistoryID], [UserID], [HoardingMasterID], [FromDate], [ToDate], [Amount], [Status], [Type], [BannerName], [CreatedDate], [CreatedBy], [UpdatedBy], [UpdatedDate], [IsPermanent], [IsExpired], [IsRenewed], [IsActive], [IsDeleted]) VALUES (13, 8, 6, CAST(0x0700000000003B390B AS DateTime2), CAST(0x0700000000006D390B AS DateTime2), 4100.0000, NULL, N'permanent', N'20141010023910522.png', CAST(0x078204223E161B390B AS DateTime2), NULL, NULL, CAST(0x07FE8FBAD98254390B AS DateTime2), 1, 0, NULL, 1, 0)
GO
INSERT [dbo].[HoardingHistory] ([HoadingHistoryID], [UserID], [HoardingMasterID], [FromDate], [ToDate], [Amount], [Status], [Type], [BannerName], [CreatedDate], [CreatedBy], [UpdatedBy], [UpdatedDate], [IsPermanent], [IsExpired], [IsRenewed], [IsActive], [IsDeleted]) VALUES (14, 3, 7, CAST(0x0700000000001B390B AS DateTime2), CAST(0x07000000000030390B AS DateTime2), 4100.0000, NULL, N'permanent', N'20141010040559521.png', CAST(0x07A6E2D75D221B390B AS DateTime2), NULL, NULL, NULL, 1, 1, NULL, 1, 0)
GO
INSERT [dbo].[HoardingHistory] ([HoadingHistoryID], [UserID], [HoardingMasterID], [FromDate], [ToDate], [Amount], [Status], [Type], [BannerName], [CreatedDate], [CreatedBy], [UpdatedBy], [UpdatedDate], [IsPermanent], [IsExpired], [IsRenewed], [IsActive], [IsDeleted]) VALUES (15, 3, 7, CAST(0x0700000000001B390B AS DateTime2), CAST(0x07000000000030390B AS DateTime2), 4100.0000, NULL, N'temporary', N'20141010040648302.png', CAST(0x07D667DF7C221B390B AS DateTime2), NULL, NULL, NULL, 0, 1, NULL, 1, 0)
GO
INSERT [dbo].[HoardingHistory] ([HoadingHistoryID], [UserID], [HoardingMasterID], [FromDate], [ToDate], [Amount], [Status], [Type], [BannerName], [CreatedDate], [CreatedBy], [UpdatedBy], [UpdatedDate], [IsPermanent], [IsExpired], [IsRenewed], [IsActive], [IsDeleted]) VALUES (16, 1, 2, CAST(0x0700000000001C390B AS DateTime2), CAST(0x07000000000030390B AS DateTime2), 4500.0000, NULL, N'permanent', N'20141010233142145.png', CAST(0x0732994E3AC51B390B AS DateTime2), NULL, NULL, NULL, 1, 1, NULL, 1, 0)
GO
INSERT [dbo].[HoardingHistory] ([HoadingHistoryID], [UserID], [HoardingMasterID], [FromDate], [ToDate], [Amount], [Status], [Type], [BannerName], [CreatedDate], [CreatedBy], [UpdatedBy], [UpdatedDate], [IsPermanent], [IsExpired], [IsRenewed], [IsActive], [IsDeleted]) VALUES (17, 6, 17, CAST(0x0700000000001B390B AS DateTime2), CAST(0x07000000000033390B AS DateTime2), 1400.0000, NULL, N'permanent', N'20141012095756453.png', CAST(0x07B9391688531D390B AS DateTime2), NULL, NULL, CAST(0x0753BD64D90741390B AS DateTime2), 1, 1, NULL, 1, 0)
GO
INSERT [dbo].[HoardingHistory] ([HoadingHistoryID], [UserID], [HoardingMasterID], [FromDate], [ToDate], [Amount], [Status], [Type], [BannerName], [CreatedDate], [CreatedBy], [UpdatedBy], [UpdatedDate], [IsPermanent], [IsExpired], [IsRenewed], [IsActive], [IsDeleted]) VALUES (18, 6, 11, CAST(0x0700000000001E390B AS DateTime2), CAST(0x07000000000033390B AS DateTime2), 14555.0000, NULL, N'permanent', N'20141012100525468.png', CAST(0x073443AB93541D390B AS DateTime2), NULL, NULL, NULL, 1, 1, NULL, 1, 0)
GO
INSERT [dbo].[HoardingHistory] ([HoadingHistoryID], [UserID], [HoardingMasterID], [FromDate], [ToDate], [Amount], [Status], [Type], [BannerName], [CreatedDate], [CreatedBy], [UpdatedBy], [UpdatedDate], [IsPermanent], [IsExpired], [IsRenewed], [IsActive], [IsDeleted]) VALUES (19, 6, 16, CAST(0x0700000000001B390B AS DateTime2), CAST(0x0700000000002A390B AS DateTime2), 1522.0000, NULL, N'permanent', N'20141012100603604.png', CAST(0x07B8276EAA541D390B AS DateTime2), NULL, NULL, NULL, 1, 1, NULL, 1, 0)
GO
INSERT [dbo].[HoardingHistory] ([HoadingHistoryID], [UserID], [HoardingMasterID], [FromDate], [ToDate], [Amount], [Status], [Type], [BannerName], [CreatedDate], [CreatedBy], [UpdatedBy], [UpdatedDate], [IsPermanent], [IsExpired], [IsRenewed], [IsActive], [IsDeleted]) VALUES (20, 1, 21, CAST(0x070000000000F4380B AS DateTime2), CAST(0x0700000000004F390B AS DateTime2), 15000.0000, NULL, N'permanent', N'20141012191955289.png', CAST(0x0738E2FE0AA21D390B AS DateTime2), NULL, NULL, NULL, 1, 1, NULL, 1, 0)
GO
INSERT [dbo].[HoardingHistory] ([HoadingHistoryID], [UserID], [HoardingMasterID], [FromDate], [ToDate], [Amount], [Status], [Type], [BannerName], [CreatedDate], [CreatedBy], [UpdatedBy], [UpdatedDate], [IsPermanent], [IsExpired], [IsRenewed], [IsActive], [IsDeleted]) VALUES (21, 2, 10, CAST(0x0700000000004A3A0B AS DateTime2), CAST(0x0700000000004F3A0B AS DateTime2), 10000.0000, NULL, N'permanent', N'20141012201151626.png', CAST(0x07B7F7814BA91D390B AS DateTime2), NULL, NULL, NULL, 1, 0, NULL, 1, 0)
GO
INSERT [dbo].[HoardingHistory] ([HoadingHistoryID], [UserID], [HoardingMasterID], [FromDate], [ToDate], [Amount], [Status], [Type], [BannerName], [CreatedDate], [CreatedBy], [UpdatedBy], [UpdatedDate], [IsPermanent], [IsExpired], [IsRenewed], [IsActive], [IsDeleted]) VALUES (22, 8, 20, CAST(0x0700000000001B390B AS DateTime2), CAST(0x07000000000034390B AS DateTime2), 4500.0000, NULL, N'permanent', N'20141013003937530.png', CAST(0x0752A51E89051E390B AS DateTime2), NULL, NULL, NULL, 1, 1, NULL, 1, 0)
GO
INSERT [dbo].[HoardingHistory] ([HoadingHistoryID], [UserID], [HoardingMasterID], [FromDate], [ToDate], [Amount], [Status], [Type], [BannerName], [CreatedDate], [CreatedBy], [UpdatedBy], [UpdatedDate], [IsPermanent], [IsExpired], [IsRenewed], [IsActive], [IsDeleted]) VALUES (23, 11, 14, CAST(0x07000000000023390B AS DateTime2), CAST(0x0700000000002D390B AS DateTime2), 50000.0000, NULL, N'permanent', N'20141020001229378.png', CAST(0x07A011ABBE0125390B AS DateTime2), NULL, NULL, CAST(0x074CA263D39B40390B AS DateTime2), 1, 1, NULL, 1, 0)
GO
INSERT [dbo].[HoardingHistory] ([HoadingHistoryID], [UserID], [HoardingMasterID], [FromDate], [ToDate], [Amount], [Status], [Type], [BannerName], [CreatedDate], [CreatedBy], [UpdatedBy], [UpdatedDate], [IsPermanent], [IsExpired], [IsRenewed], [IsActive], [IsDeleted]) VALUES (24, 10, 14, CAST(0x07000000000025390B AS DateTime2), CAST(0x0700000000002F390B AS DateTime2), 5000.0000, NULL, N'temporary', N'20141020014013352.png', CAST(0x07F4AAAC030E25390B AS DateTime2), NULL, NULL, NULL, 0, 1, NULL, 1, 0)
GO
INSERT [dbo].[HoardingHistory] ([HoadingHistoryID], [UserID], [HoardingMasterID], [FromDate], [ToDate], [Amount], [Status], [Type], [BannerName], [CreatedDate], [CreatedBy], [UpdatedBy], [UpdatedDate], [IsPermanent], [IsExpired], [IsRenewed], [IsActive], [IsDeleted]) VALUES (25, 6, 15, CAST(0x0700000000003C390B AS DateTime2), CAST(0x0700000000005A390B AS DateTime2), 5000.0000, NULL, N'permanent', N'20141112001824905.png', CAST(0x0703259392023C390B AS DateTime2), NULL, NULL, NULL, 1, 0, NULL, 1, 0)
GO
INSERT [dbo].[HoardingHistory] ([HoadingHistoryID], [UserID], [HoardingMasterID], [FromDate], [ToDate], [Amount], [Status], [Type], [BannerName], [CreatedDate], [CreatedBy], [UpdatedBy], [UpdatedDate], [IsPermanent], [IsExpired], [IsRenewed], [IsActive], [IsDeleted]) VALUES (26, 6, 14, CAST(0x07000000000031390B AS DateTime2), CAST(0x07000000000043390B AS DateTime2), 4100.0000, NULL, N'permanent', N'20141116183635222.JPG', CAST(0x07BDD343FC9B40390B AS DateTime2), NULL, NULL, CAST(0x07C061049E8254390B AS DateTime2), 1, 1, NULL, 1, 0)
GO
INSERT [dbo].[HoardingHistory] ([HoadingHistoryID], [UserID], [HoardingMasterID], [FromDate], [ToDate], [Amount], [Status], [Type], [BannerName], [CreatedDate], [CreatedBy], [UpdatedBy], [UpdatedDate], [IsPermanent], [IsExpired], [IsRenewed], [IsActive], [IsDeleted]) VALUES (1026, 6, 14, CAST(0x07000000000050390B AS DateTime2), CAST(0x07000000000051390B AS DateTime2), 5000.0000, NULL, N'permanent', N'20141206153810370.png', CAST(0x0716B9B20F8354390B AS DateTime2), NULL, NULL, CAST(0x07E6145B248354390B AS DateTime2), 1, 1, NULL, 1, 0)
GO
SET IDENTITY_INSERT [dbo].[HoardingHistory] OFF
GO
SET IDENTITY_INSERT [dbo].[HoardingMaster] ON 

GO
INSERT [dbo].[HoardingMaster] ([ID], [CityID], [AreaID], [SubAreaID], [HoardingNo], [HoardingSize], [IsActive], [IsDeleted]) VALUES (2, 2, 2, 2, 1, N'10 X 20', 1, 0)
GO
INSERT [dbo].[HoardingMaster] ([ID], [CityID], [AreaID], [SubAreaID], [HoardingNo], [HoardingSize], [IsActive], [IsDeleted]) VALUES (3, 2, 2, 2, 2, N'10 X 20', 1, 0)
GO
INSERT [dbo].[HoardingMaster] ([ID], [CityID], [AreaID], [SubAreaID], [HoardingNo], [HoardingSize], [IsActive], [IsDeleted]) VALUES (4, 2, 2, 2, 3, NULL, 1, 0)
GO
INSERT [dbo].[HoardingMaster] ([ID], [CityID], [AreaID], [SubAreaID], [HoardingNo], [HoardingSize], [IsActive], [IsDeleted]) VALUES (5, 2, 2, 2, 4, NULL, 1, 0)
GO
INSERT [dbo].[HoardingMaster] ([ID], [CityID], [AreaID], [SubAreaID], [HoardingNo], [HoardingSize], [IsActive], [IsDeleted]) VALUES (6, 2, 2, 1, 1, NULL, 1, 0)
GO
INSERT [dbo].[HoardingMaster] ([ID], [CityID], [AreaID], [SubAreaID], [HoardingNo], [HoardingSize], [IsActive], [IsDeleted]) VALUES (7, 2, 2, 1, 2, NULL, 1, 0)
GO
INSERT [dbo].[HoardingMaster] ([ID], [CityID], [AreaID], [SubAreaID], [HoardingNo], [HoardingSize], [IsActive], [IsDeleted]) VALUES (8, 2, 2, 4, 1, NULL, 1, 0)
GO
INSERT [dbo].[HoardingMaster] ([ID], [CityID], [AreaID], [SubAreaID], [HoardingNo], [HoardingSize], [IsActive], [IsDeleted]) VALUES (9, 2, 2, 5, 1, NULL, 1, 0)
GO
INSERT [dbo].[HoardingMaster] ([ID], [CityID], [AreaID], [SubAreaID], [HoardingNo], [HoardingSize], [IsActive], [IsDeleted]) VALUES (10, 2, 2, 5, 2, NULL, 1, 0)
GO
INSERT [dbo].[HoardingMaster] ([ID], [CityID], [AreaID], [SubAreaID], [HoardingNo], [HoardingSize], [IsActive], [IsDeleted]) VALUES (11, 2, 2, 5, 3, NULL, 1, 0)
GO
INSERT [dbo].[HoardingMaster] ([ID], [CityID], [AreaID], [SubAreaID], [HoardingNo], [HoardingSize], [IsActive], [IsDeleted]) VALUES (12, 2, 21, NULL, 1, NULL, 1, 0)
GO
INSERT [dbo].[HoardingMaster] ([ID], [CityID], [AreaID], [SubAreaID], [HoardingNo], [HoardingSize], [IsActive], [IsDeleted]) VALUES (13, 2, 21, NULL, 2, NULL, 1, 0)
GO
INSERT [dbo].[HoardingMaster] ([ID], [CityID], [AreaID], [SubAreaID], [HoardingNo], [HoardingSize], [IsActive], [IsDeleted]) VALUES (14, 2, 2, NULL, 3, NULL, 1, 0)
GO
INSERT [dbo].[HoardingMaster] ([ID], [CityID], [AreaID], [SubAreaID], [HoardingNo], [HoardingSize], [IsActive], [IsDeleted]) VALUES (15, 2, 2, NULL, 4, NULL, 1, 0)
GO
INSERT [dbo].[HoardingMaster] ([ID], [CityID], [AreaID], [SubAreaID], [HoardingNo], [HoardingSize], [IsActive], [IsDeleted]) VALUES (16, 2, 21, NULL, 3, NULL, 1, 0)
GO
INSERT [dbo].[HoardingMaster] ([ID], [CityID], [AreaID], [SubAreaID], [HoardingNo], [HoardingSize], [IsActive], [IsDeleted]) VALUES (17, 2, 21, NULL, 11, NULL, 1, 0)
GO
INSERT [dbo].[HoardingMaster] ([ID], [CityID], [AreaID], [SubAreaID], [HoardingNo], [HoardingSize], [IsActive], [IsDeleted]) VALUES (18, 2, 2, 3, 6, NULL, 1, 1)
GO
INSERT [dbo].[HoardingMaster] ([ID], [CityID], [AreaID], [SubAreaID], [HoardingNo], [HoardingSize], [IsActive], [IsDeleted]) VALUES (19, 2, 2, 3, 7, N'10 X 20', 1, 0)
GO
INSERT [dbo].[HoardingMaster] ([ID], [CityID], [AreaID], [SubAreaID], [HoardingNo], [HoardingSize], [IsActive], [IsDeleted]) VALUES (20, 2, 2, 3, 8, N'10 X 20', 1, 0)
GO
INSERT [dbo].[HoardingMaster] ([ID], [CityID], [AreaID], [SubAreaID], [HoardingNo], [HoardingSize], [IsActive], [IsDeleted]) VALUES (21, 2, 4, 15, 1, N'10 X 20', 1, 0)
GO
INSERT [dbo].[HoardingMaster] ([ID], [CityID], [AreaID], [SubAreaID], [HoardingNo], [HoardingSize], [IsActive], [IsDeleted]) VALUES (22, 2, 4, 15, 2, N'10 X 20', 1, 0)
GO
INSERT [dbo].[HoardingMaster] ([ID], [CityID], [AreaID], [SubAreaID], [HoardingNo], [HoardingSize], [IsActive], [IsDeleted]) VALUES (23, 2, 3, 20, 1, N'10 X 20', 1, 0)
GO
INSERT [dbo].[HoardingMaster] ([ID], [CityID], [AreaID], [SubAreaID], [HoardingNo], [HoardingSize], [IsActive], [IsDeleted]) VALUES (24, 2, 2, 21, 98, N'10 X 20', 1, 0)
GO
INSERT [dbo].[HoardingMaster] ([ID], [CityID], [AreaID], [SubAreaID], [HoardingNo], [HoardingSize], [IsActive], [IsDeleted]) VALUES (25, 2, 2, 2, 5, N'10 X 20', 1, 0)
GO
INSERT [dbo].[HoardingMaster] ([ID], [CityID], [AreaID], [SubAreaID], [HoardingNo], [HoardingSize], [IsActive], [IsDeleted]) VALUES (26, 2, 4, 15, 3, N'10 X 20', 1, 0)
GO
INSERT [dbo].[HoardingMaster] ([ID], [CityID], [AreaID], [SubAreaID], [HoardingNo], [HoardingSize], [IsActive], [IsDeleted]) VALUES (27, 2, 4, 15, 4, N'10 X 40', 1, 0)
GO
SET IDENTITY_INSERT [dbo].[HoardingMaster] OFF
GO
SET IDENTITY_INSERT [dbo].[SubAreaDetail] ON 

GO
INSERT [dbo].[SubAreaDetail] ([ID], [AreaID], [SubArea], [IsActive], [IsDeleted]) VALUES (1, 2, N'Aakashvani Dival', 1, 0)
GO
INSERT [dbo].[SubAreaDetail] ([ID], [AreaID], [SubArea], [IsActive], [IsDeleted]) VALUES (2, 2, N'Ground Dival', 1, 0)
GO
INSERT [dbo].[SubAreaDetail] ([ID], [AreaID], [SubArea], [IsActive], [IsDeleted]) VALUES (3, 2, N'Axis Bank', 1, 0)
GO
INSERT [dbo].[SubAreaDetail] ([ID], [AreaID], [SubArea], [IsActive], [IsDeleted]) VALUES (4, 2, N'DSP Dival', 1, 0)
GO
INSERT [dbo].[SubAreaDetail] ([ID], [AreaID], [SubArea], [IsActive], [IsDeleted]) VALUES (5, 2, N'DSP Dival Circle Same', 1, 0)
GO
INSERT [dbo].[SubAreaDetail] ([ID], [AreaID], [SubArea], [IsActive], [IsDeleted]) VALUES (6, 2, N'Union Bank Same', 1, 0)
GO
INSERT [dbo].[SubAreaDetail] ([ID], [AreaID], [SubArea], [IsActive], [IsDeleted]) VALUES (7, 3, N'Indirabai Park Dival', 1, 0)
GO
INSERT [dbo].[SubAreaDetail] ([ID], [AreaID], [SubArea], [IsActive], [IsDeleted]) VALUES (8, 3, N'Post Office Dival', 1, 0)
GO
INSERT [dbo].[SubAreaDetail] ([ID], [AreaID], [SubArea], [IsActive], [IsDeleted]) VALUES (9, 3, N'V D Gate ni same', 1, 0)
GO
INSERT [dbo].[SubAreaDetail] ([ID], [AreaID], [SubArea], [IsActive], [IsDeleted]) VALUES (10, 3, N'Matru Chhaya', 1, 0)
GO
INSERT [dbo].[SubAreaDetail] ([ID], [AreaID], [SubArea], [IsActive], [IsDeleted]) VALUES (11, 4, N'Petrol Pump  ni same', 1, 0)
GO
INSERT [dbo].[SubAreaDetail] ([ID], [AreaID], [SubArea], [IsActive], [IsDeleted]) VALUES (12, 4, N'Jaldeep  ni same', 1, 0)
GO
INSERT [dbo].[SubAreaDetail] ([ID], [AreaID], [SubArea], [IsActive], [IsDeleted]) VALUES (13, 4, N'National Cycle  ni same', 1, 0)
GO
INSERT [dbo].[SubAreaDetail] ([ID], [AreaID], [SubArea], [IsActive], [IsDeleted]) VALUES (14, 4, N'Bus Station same', 1, 0)
GO
INSERT [dbo].[SubAreaDetail] ([ID], [AreaID], [SubArea], [IsActive], [IsDeleted]) VALUES (15, 4, N'Gopi gola ni same', 1, 0)
GO
INSERT [dbo].[SubAreaDetail] ([ID], [AreaID], [SubArea], [IsActive], [IsDeleted]) VALUES (16, 4, N'Gopi gola ni Bajuma', 1, 0)
GO
INSERT [dbo].[SubAreaDetail] ([ID], [AreaID], [SubArea], [IsActive], [IsDeleted]) VALUES (17, 4, N'Lake view hotel', 1, 0)
GO
INSERT [dbo].[SubAreaDetail] ([ID], [AreaID], [SubArea], [IsActive], [IsDeleted]) VALUES (18, 4, N'Mangalam Hotel', 1, 0)
GO
INSERT [dbo].[SubAreaDetail] ([ID], [AreaID], [SubArea], [IsActive], [IsDeleted]) VALUES (19, 4, N'Commerce College', 1, 0)
GO
INSERT [dbo].[SubAreaDetail] ([ID], [AreaID], [SubArea], [IsActive], [IsDeleted]) VALUES (20, 3, N'kutch mitra circle', 1, 0)
GO
INSERT [dbo].[SubAreaDetail] ([ID], [AreaID], [SubArea], [IsActive], [IsDeleted]) VALUES (21, 2, N'k', 1, 1)
GO
SET IDENTITY_INSERT [dbo].[SubAreaDetail] OFF
GO
SET IDENTITY_INSERT [dbo].[UserDetail] ON 

GO
INSERT [dbo].[UserDetail] ([UserID], [CompanyName], [PersonName], [PhoneNo], [City], [CompanyAddress], [Email], [CreatedDate], [CreatedBy], [UpdatedDate], [UpdatedBy], [IsActive], [IsDeleted]) VALUES (1, N'test', N'test      ', N'0123456789', N'bhuj', N'testupdate', N'test@test.com', CAST(0x0791CD0C0F7846390B AS DateTime2), 1, NULL, NULL, 1, 0)
GO
INSERT [dbo].[UserDetail] ([UserID], [CompanyName], [PersonName], [PhoneNo], [City], [CompanyAddress], [Email], [CreatedDate], [CreatedBy], [UpdatedDate], [UpdatedBy], [IsActive], [IsDeleted]) VALUES (2, N'test1', N'test1     ', N'8758785785', N'bhuj', N'test1,jm', N'test1@test.com', CAST(0x07E4358ED3541D390B AS DateTime2), 1, NULL, NULL, 1, 0)
GO
INSERT [dbo].[UserDetail] ([UserID], [CompanyName], [PersonName], [PhoneNo], [City], [CompanyAddress], [Email], [CreatedDate], [CreatedBy], [UpdatedDate], [UpdatedBy], [IsActive], [IsDeleted]) VALUES (3, N'test3', N'test3     ', N'1234567890', N'bhuj', N'test3', N'jhj@test.com', CAST(0x07236B77A21D1B390B AS DateTime2), -1, NULL, NULL, 1, 1)
GO
INSERT [dbo].[UserDetail] ([UserID], [CompanyName], [PersonName], [PhoneNo], [City], [CompanyAddress], [Email], [CreatedDate], [CreatedBy], [UpdatedDate], [UpdatedBy], [IsActive], [IsDeleted]) VALUES (4, N't', N't         ', N'6767676767', N'bhuj', N't', N't@t.com', CAST(0x07AAC76D7F1F1B390B AS DateTime2), 1, NULL, NULL, 1, 1)
GO
INSERT [dbo].[UserDetail] ([UserID], [CompanyName], [PersonName], [PhoneNo], [City], [CompanyAddress], [Email], [CreatedDate], [CreatedBy], [UpdatedDate], [UpdatedBy], [IsActive], [IsDeleted]) VALUES (5, N'tt', N't         ', N'787878', N't', N'tt', N'', CAST(0x07F64FA9A31F1B390B AS DateTime2), 1, NULL, NULL, 1, 1)
GO
INSERT [dbo].[UserDetail] ([UserID], [CompanyName], [PersonName], [PhoneNo], [City], [CompanyAddress], [Email], [CreatedDate], [CreatedBy], [UpdatedDate], [UpdatedBy], [IsActive], [IsDeleted]) VALUES (6, N'uday test agency', N'test', N'8569858455', N'bhuj', N'test', N'utest@test.com', CAST(0x072C5E7DC8C61B390B AS DateTime2), 1, NULL, NULL, 1, 0)
GO
INSERT [dbo].[UserDetail] ([UserID], [CompanyName], [PersonName], [PhoneNo], [City], [CompanyAddress], [Email], [CreatedDate], [CreatedBy], [UpdatedDate], [UpdatedBy], [IsActive], [IsDeleted]) VALUES (7, N'test3', N'test3', N'939339393', N'bhuj', N'test3', N'test3@test3.com', CAST(0x07314A5CEA541D390B AS DateTime2), 1, NULL, NULL, 1, 0)
GO
INSERT [dbo].[UserDetail] ([UserID], [CompanyName], [PersonName], [PhoneNo], [City], [CompanyAddress], [Email], [CreatedDate], [CreatedBy], [UpdatedDate], [UpdatedBy], [IsActive], [IsDeleted]) VALUES (8, N'test31', N'te', N'2424324349', N'bhuj', N'cfwff', N'aaa@a.com', CAST(0x073245A5057846390B AS DateTime2), 1, NULL, NULL, 1, 0)
GO
INSERT [dbo].[UserDetail] ([UserID], [CompanyName], [PersonName], [PhoneNo], [City], [CompanyAddress], [Email], [CreatedDate], [CreatedBy], [UpdatedDate], [UpdatedBy], [IsActive], [IsDeleted]) VALUES (9, N'test3', N'test1 person', N'9858585858', N'bhuj', N'test', N'', CAST(0x074EE83CC99324390B AS DateTime2), 1, NULL, NULL, 1, 0)
GO
INSERT [dbo].[UserDetail] ([UserID], [CompanyName], [PersonName], [PhoneNo], [City], [CompanyAddress], [Email], [CreatedDate], [CreatedBy], [UpdatedDate], [UpdatedBy], [IsActive], [IsDeleted]) VALUES (10, N'uday', N'uday', N'8585985898', N'bhuj', N'uday agency', N'a@a.com', CAST(0x07DE64DBDC9424390B AS DateTime2), 1, NULL, NULL, 1, 0)
GO
INSERT [dbo].[UserDetail] ([UserID], [CompanyName], [PersonName], [PhoneNo], [City], [CompanyAddress], [Email], [CreatedDate], [CreatedBy], [UpdatedDate], [UpdatedBy], [IsActive], [IsDeleted]) VALUES (11, N'uday1', N'uday 1 CEO', N'938u948394', N'bhuj', N'uday1 address', N'a@a.com', CAST(0x074160C5E49524390B AS DateTime2), 1, NULL, NULL, 1, 0)
GO
INSERT [dbo].[UserDetail] ([UserID], [CompanyName], [PersonName], [PhoneNo], [City], [CompanyAddress], [Email], [CreatedDate], [CreatedBy], [UpdatedDate], [UpdatedBy], [IsActive], [IsDeleted]) VALUES (12, N'newuser', N'newuser', N'676767687687', N'bhuj', N'newuser', N'newuser@a.com', CAST(0x07EF24F6387846390B AS DateTime2), 1, NULL, NULL, 1, 1)
GO
SET IDENTITY_INSERT [dbo].[UserDetail] OFF
GO
ALTER TABLE [dbo].[AreaDetail]  WITH CHECK ADD  CONSTRAINT [FK_AreaDetail_CityDetail] FOREIGN KEY([CityID])
REFERENCES [dbo].[CityDetail] ([ID])
GO
ALTER TABLE [dbo].[AreaDetail] CHECK CONSTRAINT [FK_AreaDetail_CityDetail]
GO
ALTER TABLE [dbo].[HoardingHistory]  WITH CHECK ADD  CONSTRAINT [FK_HoardingHistory_HoardingMaster] FOREIGN KEY([HoardingMasterID])
REFERENCES [dbo].[HoardingMaster] ([ID])
GO
ALTER TABLE [dbo].[HoardingHistory] CHECK CONSTRAINT [FK_HoardingHistory_HoardingMaster]
GO
ALTER TABLE [dbo].[HoardingHistory]  WITH CHECK ADD  CONSTRAINT [FK_HoardingHistory_UserDetail] FOREIGN KEY([UserID])
REFERENCES [dbo].[UserDetail] ([UserID])
GO
ALTER TABLE [dbo].[HoardingHistory] CHECK CONSTRAINT [FK_HoardingHistory_UserDetail]
GO
ALTER TABLE [dbo].[HoardingMaster]  WITH CHECK ADD  CONSTRAINT [FK_HoardingMaster_AreaDetail] FOREIGN KEY([AreaID])
REFERENCES [dbo].[AreaDetail] ([ID])
GO
ALTER TABLE [dbo].[HoardingMaster] CHECK CONSTRAINT [FK_HoardingMaster_AreaDetail]
GO
ALTER TABLE [dbo].[HoardingMaster]  WITH CHECK ADD  CONSTRAINT [FK_HoardingMaster_CityDetail] FOREIGN KEY([CityID])
REFERENCES [dbo].[CityDetail] ([ID])
GO
ALTER TABLE [dbo].[HoardingMaster] CHECK CONSTRAINT [FK_HoardingMaster_CityDetail]
GO
ALTER TABLE [dbo].[SubAreaDetail]  WITH CHECK ADD  CONSTRAINT [FK_SubAreaDetail_AreaDetail] FOREIGN KEY([AreaID])
REFERENCES [dbo].[AreaDetail] ([ID])
GO
ALTER TABLE [dbo].[SubAreaDetail] CHECK CONSTRAINT [FK_SubAreaDetail_AreaDetail]
GO
USE [master]
GO
ALTER DATABASE [Parshva] SET  READ_WRITE 
GO
