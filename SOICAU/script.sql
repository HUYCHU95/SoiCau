USE [master]
GO
/****** Object:  Database [SC]    Script Date: 2/24/2024 12:03:58 AM ******/
CREATE DATABASE [SC]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'SC', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL15.SQLEXPRESS\MSSQL\DATA\SC.mdf' , SIZE = 8192KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'SC_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL15.SQLEXPRESS\MSSQL\DATA\SC_log.ldf' , SIZE = 8192KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
 WITH CATALOG_COLLATION = DATABASE_DEFAULT
GO
ALTER DATABASE [SC] SET COMPATIBILITY_LEVEL = 150
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [SC].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [SC] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [SC] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [SC] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [SC] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [SC] SET ARITHABORT OFF 
GO
ALTER DATABASE [SC] SET AUTO_CLOSE ON 
GO
ALTER DATABASE [SC] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [SC] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [SC] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [SC] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [SC] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [SC] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [SC] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [SC] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [SC] SET  ENABLE_BROKER 
GO
ALTER DATABASE [SC] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [SC] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [SC] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [SC] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [SC] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [SC] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [SC] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [SC] SET RECOVERY SIMPLE 
GO
ALTER DATABASE [SC] SET  MULTI_USER 
GO
ALTER DATABASE [SC] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [SC] SET DB_CHAINING OFF 
GO
ALTER DATABASE [SC] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [SC] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [SC] SET DELAYED_DURABILITY = DISABLED 
GO
ALTER DATABASE [SC] SET ACCELERATED_DATABASE_RECOVERY = OFF  
GO
ALTER DATABASE [SC] SET QUERY_STORE = OFF
GO
USE [SC]
GO
/****** Object:  Table [dbo].[ResultOfDay]    Script Date: 2/24/2024 12:03:59 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ResultOfDay](
	[Date] [date] NOT NULL,
	[DB] [nvarchar](50) NULL,
	[NHAT] [nvarchar](50) NULL,
	[NHI] [nvarchar](50) NULL,
	[BA] [nvarchar](50) NULL,
	[TU] [nvarchar](50) NULL,
	[NAM] [nvarchar](50) NULL,
	[SAU] [nvarchar](50) NULL,
	[BAY] [nvarchar](50) NULL,
 CONSTRAINT [PK_ResultOfDay] PRIMARY KEY CLUSTERED 
(
	[Date] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  View [dbo].[V_ResultOfDay_TaiXiu]    Script Date: 2/24/2024 12:03:59 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO













 CREATE view [dbo].[V_ResultOfDay_TaiXiu]
 AS 
  select top 200 DATE,DB, 
 case when   left( RIGHT(DB,2) ,1) %2!=0 THEN 'L' else 'C' end 
   --+case when    RIGHT(DB,1) %2!=0  THEN 'L' else 'C' end 

  AS tt  from [ResultOfDay]  
GO
/****** Object:  Table [dbo].[KENO]    Script Date: 2/24/2024 12:03:59 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[KENO](
	[periodCode] [nvarchar](50) NOT NULL,
	[periodTime] [datetime] NULL,
	[Num20] [int] NULL,
	[Num19] [int] NULL,
	[Num18] [int] NULL,
	[Num17] [int] NULL,
	[Num16] [int] NULL,
	[Num15] [int] NULL,
	[Num14] [int] NULL,
	[Num13] [int] NULL,
	[Num12] [int] NULL,
	[Num11] [int] NULL,
	[Num10] [int] NULL,
	[Num9] [int] NULL,
	[Num8] [int] NULL,
	[Num7] [int] NULL,
	[Num6] [int] NULL,
	[Num5] [int] NULL,
	[Num4] [int] NULL,
	[Num3] [int] NULL,
	[Num2] [int] NULL,
	[Num1] [int] NULL,
	[numOver] [int] NULL,
	[numUnder] [int] NULL,
	[numOdd] [int] NULL,
	[numEven] [int] NULL,
 CONSTRAINT [PK_KENO] PRIMARY KEY CLUSTERED 
(
	[periodCode] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  View [dbo].[V_KENO]    Script Date: 2/24/2024 12:03:59 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE view [dbo].[V_KENO]
AS
SELECT  periodCode,periodTime AS Date,bt,Giai
FROM   
   (
 SELECT   *  FROM SC.dbo.KENO ) p  
UNPIVOT  
   (BT FOR Giai IN   
      ([Num20]
      ,[Num19]
      ,[Num18]
      ,[Num17]
      ,[Num16]
      ,[Num15]
      ,[Num14]
      ,[Num13]
      ,[Num12]
      ,[Num11]
      ,[Num10]
      ,[Num9]
      ,[Num8]
      ,[Num7]
      ,[Num6]
      ,[Num5]
      ,[Num4]
      ,[Num3]
      ,[Num2]
      ,[Num1])  
)AS unpvt;  


 
GO
/****** Object:  Table [dbo].[DataNumber]    Script Date: 2/24/2024 12:03:59 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[DataNumber](
	[BT] [nvarchar](50) NULL
) ON [PRIMARY]
GO
/****** Object:  View [dbo].[V_DataNumber]    Script Date: 2/24/2024 12:03:59 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE view [dbo].[V_DataNumber]
AS
 SELECT [BT],   case when   left( RIGHT([BT],2) ,1) %2!=0 THEN 'L' else 'C' end
   +  case when RIGHT([BT],1) %2!=0  THEN 'L' else 'C' end 
 AS tt
  FROM [SC].[dbo].[DataNumber]
GO
/****** Object:  Table [dbo].[ResultOfDay2]    Script Date: 2/24/2024 12:03:59 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ResultOfDay2](
	[Date] [datetime] NOT NULL,
	[DB] [nvarchar](50) NULL,
	[NHAT] [nvarchar](50) NULL,
	[NHI] [nvarchar](50) NULL,
	[BA] [nvarchar](50) NULL,
	[TU] [nvarchar](50) NULL,
	[NAM] [nvarchar](50) NULL,
	[SAU] [nvarchar](50) NULL,
	[BAY] [nvarchar](50) NULL,
	[TAM] [nvarchar](50) NULL,
 CONSTRAINT [PK_ResultOfDay2] PRIMARY KEY CLUSTERED 
(
	[Date] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  View [dbo].[V_ResultOfDay2]    Script Date: 2/24/2024 12:03:59 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO








CREATE view [dbo].[V_ResultOfDay2]

as

select *,RIGHT(value,2) as BT,
RIGHT(value,3) as BT3,
giai+FORMAT(ROW_NUMBER() OVER(PARTITION BY DATE,giai ORDER BY DATE),'00')  AS STT
,

  case when   left( RIGHT(value,2) ,1) %2!=0 THEN 'L' else 'C' end 
 + case when    RIGHT(value,1) %2!=0  THEN 'L' else 'C' end 

  AS tt 
  ,ROW_NUMBER() over(partition by Note order by DATE) as RN
  
  from (  SELECT DATE, Employee giai, TRIM(Orders) Ketqua  ,1 as Note
FROM   
   (SELECT  * 
   FROM  [SC].[dbo].[ResultOfDay2]) p  
UNPIVOT  
   (Orders FOR Employee IN   
      ( [DB]
      ,[NHAT]
      ,[NHI]
      ,[BA]
      ,[TU]
      ,[NAM]
      ,[SAU]
      ,[BAY]
	  
      ,[TAM])  
)AS unpvt) t1     CROSS APPLY STRING_SPLIT(REPLACE(Ketqua,' ','-'), '-')

where value !=''
GO
/****** Object:  View [dbo].[V_ResultOfDay]    Script Date: 2/24/2024 12:03:59 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO





CREATE view [dbo].[V_ResultOfDay]

as

select *,RIGHT(value,2) as BT,
RIGHT(value,3) as BT3,
giai+FORMAT(ROW_NUMBER() OVER(PARTITION BY DATE,giai ORDER BY DATE),'00')  AS STT
,

  case when   left( RIGHT(value,2) ,1) %2!=0 THEN 'L' else 'C' end 
 + case when    RIGHT(value,1) %2!=0  THEN 'L' else 'C' end 

  AS tt 
  
  from (  SELECT DATE, Employee giai, TRIM(Orders) Ketqua  
FROM   
   (SELECT  * 
   FROM  [SC].[dbo].[ResultOfDay]) p  
UNPIVOT  
   (Orders FOR Employee IN   
      ( [DB]
      ,[NHAT]
      ,[NHI]
      ,[BA]
      ,[TU]
      ,[NAM]
      ,[SAU]
      ,[BAY])  
)AS unpvt) t1     CROSS APPLY STRING_SPLIT(REPLACE(Ketqua,' ','-'), '-')

where value !=''
GO
/****** Object:  View [dbo].[V_SoLanXuatHienTrongThang]    Script Date: 2/24/2024 12:03:59 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE  VIEW [dbo].[V_SoLanXuatHienTrongThang]
as
select * from (SELECT t1.BT,t2.Month,ISNULL(t2.CNT,0) as SoLanXuatHien FROM DATANUMBER T1 LEFT JOIN ( SELECT bt, FORMAT(DATE,'yyyyMM') as Month,count(*) AS CNT
       
  FROM [SC].[dbo].[V_ResultOfDay]      where FORMAT(DATE,'yyyyMM')  =FORMAT(GETDATE(),'yyyyMM')

  GROUP BY bt,FORMAT(DATE,'yyyyMM')   
) T2 ON T1.BT=T2.BT)
 a1  
GO
/****** Object:  View [dbo].[V_SoLanXuatHienTrongTuan]    Script Date: 2/24/2024 12:03:59 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO



CREATE  VIEW [dbo].[V_SoLanXuatHienTrongTuan]
as
select * from (SELECT t1.BT,t2.MinDate,ISNULL(t2.CNT,0) as SoLanXuatHien FROM DATANUMBER T1 LEFT JOIN ( SELECT bt, DATEADD(day,-7,GETDATE()) as MinDate,count(*) AS CNT
       
  FROM [SC].[dbo].[V_ResultOfDay]      where  date > DATEADD(day,-7,GETDATE())

  GROUP BY bt 
) T2 ON T1.BT=T2.BT)
 a1  
GO
/****** Object:  View [dbo].[V_SoLanXuatHienTrongTuanTruoc]    Script Date: 2/24/2024 12:03:59 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO




CREATE  VIEW [dbo].[V_SoLanXuatHienTrongTuanTruoc]
as
select * from (SELECT t1.BT,t2.MinDate,ISNULL(t2.CNT,0) as SoLanXuatHien FROM DATANUMBER T1 LEFT JOIN ( SELECT bt, DATEADD(day,-7,GETDATE()) as MinDate,count(*) AS CNT
       
  FROM [SC].[dbo].[V_ResultOfDay]      where  DATEADD(day,-7,GETDATE()) > date and date >= DATEADD(day,-14,GETDATE())

  GROUP BY bt 
) T2 ON T1.BT=T2.BT)
 a1  
GO
/****** Object:  Table [dbo].[DataNumber3]    Script Date: 2/24/2024 12:03:59 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[DataNumber3](
	[BT] [nvarchar](69) NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[KetQua]    Script Date: 2/24/2024 12:03:59 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[KetQua](
	[Date] [date] NULL,
	[Giai] [nvarchar](50) NULL,
	[KetQua] [nvarchar](50) NULL,
	[KhuVuc] [int] NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[KhuVuc]    Script Date: 2/24/2024 12:03:59 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[KhuVuc](
	[ID] [int] NULL,
	[KhuVuc] [nvarchar](50) NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[KUBET]    Script Date: 2/24/2024 12:03:59 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[KUBET](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[KQ] [nvarchar](2550) NULL,
	[Von] [float] NULL,
	[Lai] [float] NULL,
	[Max1Step] [float] NULL,
	[MaxLai] [float] NULL,
	[MinLai] [float] NULL,
	[UrlFile] [nvarchar](550) NULL,
	[DateCreated] [datetime] NOT NULL,
 CONSTRAINT [PK_KUBET] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
INSERT [dbo].[DataNumber] ([BT]) VALUES (N'1')
INSERT [dbo].[DataNumber] ([BT]) VALUES (N'2')
INSERT [dbo].[DataNumber] ([BT]) VALUES (N'3')
INSERT [dbo].[DataNumber] ([BT]) VALUES (N'4')
INSERT [dbo].[DataNumber] ([BT]) VALUES (N'5')
INSERT [dbo].[DataNumber] ([BT]) VALUES (N'6')
INSERT [dbo].[DataNumber] ([BT]) VALUES (N'7')
INSERT [dbo].[DataNumber] ([BT]) VALUES (N'8')
INSERT [dbo].[DataNumber] ([BT]) VALUES (N'9')
INSERT [dbo].[DataNumber] ([BT]) VALUES (N'10')
INSERT [dbo].[DataNumber] ([BT]) VALUES (N'11')
INSERT [dbo].[DataNumber] ([BT]) VALUES (N'12')
INSERT [dbo].[DataNumber] ([BT]) VALUES (N'13')
INSERT [dbo].[DataNumber] ([BT]) VALUES (N'14')
INSERT [dbo].[DataNumber] ([BT]) VALUES (N'15')
INSERT [dbo].[DataNumber] ([BT]) VALUES (N'16')
INSERT [dbo].[DataNumber] ([BT]) VALUES (N'17')
INSERT [dbo].[DataNumber] ([BT]) VALUES (N'18')
INSERT [dbo].[DataNumber] ([BT]) VALUES (N'19')
INSERT [dbo].[DataNumber] ([BT]) VALUES (N'20')
INSERT [dbo].[DataNumber] ([BT]) VALUES (N'21')
INSERT [dbo].[DataNumber] ([BT]) VALUES (N'22')
INSERT [dbo].[DataNumber] ([BT]) VALUES (N'23')
INSERT [dbo].[DataNumber] ([BT]) VALUES (N'24')
INSERT [dbo].[DataNumber] ([BT]) VALUES (N'25')
INSERT [dbo].[DataNumber] ([BT]) VALUES (N'26')
INSERT [dbo].[DataNumber] ([BT]) VALUES (N'27')
INSERT [dbo].[DataNumber] ([BT]) VALUES (N'28')
INSERT [dbo].[DataNumber] ([BT]) VALUES (N'29')
INSERT [dbo].[DataNumber] ([BT]) VALUES (N'30')
INSERT [dbo].[DataNumber] ([BT]) VALUES (N'31')
INSERT [dbo].[DataNumber] ([BT]) VALUES (N'32')
INSERT [dbo].[DataNumber] ([BT]) VALUES (N'33')
INSERT [dbo].[DataNumber] ([BT]) VALUES (N'34')
INSERT [dbo].[DataNumber] ([BT]) VALUES (N'35')
INSERT [dbo].[DataNumber] ([BT]) VALUES (N'36')
INSERT [dbo].[DataNumber] ([BT]) VALUES (N'37')
INSERT [dbo].[DataNumber] ([BT]) VALUES (N'38')
INSERT [dbo].[DataNumber] ([BT]) VALUES (N'39')
INSERT [dbo].[DataNumber] ([BT]) VALUES (N'40')
INSERT [dbo].[DataNumber] ([BT]) VALUES (N'41')
INSERT [dbo].[DataNumber] ([BT]) VALUES (N'42')
INSERT [dbo].[DataNumber] ([BT]) VALUES (N'43')
INSERT [dbo].[DataNumber] ([BT]) VALUES (N'44')
INSERT [dbo].[DataNumber] ([BT]) VALUES (N'45')
INSERT [dbo].[DataNumber] ([BT]) VALUES (N'46')
INSERT [dbo].[DataNumber] ([BT]) VALUES (N'47')
INSERT [dbo].[DataNumber] ([BT]) VALUES (N'48')
INSERT [dbo].[DataNumber] ([BT]) VALUES (N'49')
INSERT [dbo].[DataNumber] ([BT]) VALUES (N'50')
INSERT [dbo].[DataNumber] ([BT]) VALUES (N'51')
INSERT [dbo].[DataNumber] ([BT]) VALUES (N'52')
INSERT [dbo].[DataNumber] ([BT]) VALUES (N'53')
INSERT [dbo].[DataNumber] ([BT]) VALUES (N'54')
INSERT [dbo].[DataNumber] ([BT]) VALUES (N'55')
INSERT [dbo].[DataNumber] ([BT]) VALUES (N'56')
INSERT [dbo].[DataNumber] ([BT]) VALUES (N'57')
INSERT [dbo].[DataNumber] ([BT]) VALUES (N'58')
INSERT [dbo].[DataNumber] ([BT]) VALUES (N'59')
INSERT [dbo].[DataNumber] ([BT]) VALUES (N'60')
INSERT [dbo].[DataNumber] ([BT]) VALUES (N'61')
INSERT [dbo].[DataNumber] ([BT]) VALUES (N'62')
INSERT [dbo].[DataNumber] ([BT]) VALUES (N'63')
INSERT [dbo].[DataNumber] ([BT]) VALUES (N'64')
INSERT [dbo].[DataNumber] ([BT]) VALUES (N'65')
INSERT [dbo].[DataNumber] ([BT]) VALUES (N'66')
INSERT [dbo].[DataNumber] ([BT]) VALUES (N'67')
INSERT [dbo].[DataNumber] ([BT]) VALUES (N'68')
INSERT [dbo].[DataNumber] ([BT]) VALUES (N'69')
INSERT [dbo].[DataNumber] ([BT]) VALUES (N'70')
INSERT [dbo].[DataNumber] ([BT]) VALUES (N'71')
INSERT [dbo].[DataNumber] ([BT]) VALUES (N'72')
INSERT [dbo].[DataNumber] ([BT]) VALUES (N'73')
INSERT [dbo].[DataNumber] ([BT]) VALUES (N'74')
INSERT [dbo].[DataNumber] ([BT]) VALUES (N'75')
INSERT [dbo].[DataNumber] ([BT]) VALUES (N'76')
INSERT [dbo].[DataNumber] ([BT]) VALUES (N'77')
INSERT [dbo].[DataNumber] ([BT]) VALUES (N'78')
INSERT [dbo].[DataNumber] ([BT]) VALUES (N'79')
INSERT [dbo].[DataNumber] ([BT]) VALUES (N'80')
INSERT [dbo].[DataNumber] ([BT]) VALUES (N'81')
INSERT [dbo].[DataNumber] ([BT]) VALUES (N'82')
INSERT [dbo].[DataNumber] ([BT]) VALUES (N'83')
INSERT [dbo].[DataNumber] ([BT]) VALUES (N'84')
INSERT [dbo].[DataNumber] ([BT]) VALUES (N'85')
INSERT [dbo].[DataNumber] ([BT]) VALUES (N'86')
INSERT [dbo].[DataNumber] ([BT]) VALUES (N'87')
INSERT [dbo].[DataNumber] ([BT]) VALUES (N'88')
INSERT [dbo].[DataNumber] ([BT]) VALUES (N'89')
INSERT [dbo].[DataNumber] ([BT]) VALUES (N'90')
INSERT [dbo].[DataNumber] ([BT]) VALUES (N'91')
INSERT [dbo].[DataNumber] ([BT]) VALUES (N'92')
INSERT [dbo].[DataNumber] ([BT]) VALUES (N'93')
INSERT [dbo].[DataNumber] ([BT]) VALUES (N'94')
INSERT [dbo].[DataNumber] ([BT]) VALUES (N'95')
INSERT [dbo].[DataNumber] ([BT]) VALUES (N'96')
INSERT [dbo].[DataNumber] ([BT]) VALUES (N'97')
INSERT [dbo].[DataNumber] ([BT]) VALUES (N'98')
INSERT [dbo].[DataNumber] ([BT]) VALUES (N'99')
INSERT [dbo].[DataNumber] ([BT]) VALUES (N'0')
GO
INSERT [dbo].[DataNumber3] ([BT]) VALUES (N'1')
INSERT [dbo].[DataNumber3] ([BT]) VALUES (N'2')
INSERT [dbo].[DataNumber3] ([BT]) VALUES (N'3')
INSERT [dbo].[DataNumber3] ([BT]) VALUES (N'4')
INSERT [dbo].[DataNumber3] ([BT]) VALUES (N'5')
INSERT [dbo].[DataNumber3] ([BT]) VALUES (N'6')
INSERT [dbo].[DataNumber3] ([BT]) VALUES (N'7')
INSERT [dbo].[DataNumber3] ([BT]) VALUES (N'8')
INSERT [dbo].[DataNumber3] ([BT]) VALUES (N'9')
INSERT [dbo].[DataNumber3] ([BT]) VALUES (N'10')
INSERT [dbo].[DataNumber3] ([BT]) VALUES (N'11')
INSERT [dbo].[DataNumber3] ([BT]) VALUES (N'12')
INSERT [dbo].[DataNumber3] ([BT]) VALUES (N'13')
INSERT [dbo].[DataNumber3] ([BT]) VALUES (N'14')
INSERT [dbo].[DataNumber3] ([BT]) VALUES (N'15')
INSERT [dbo].[DataNumber3] ([BT]) VALUES (N'16')
INSERT [dbo].[DataNumber3] ([BT]) VALUES (N'17')
INSERT [dbo].[DataNumber3] ([BT]) VALUES (N'18')
INSERT [dbo].[DataNumber3] ([BT]) VALUES (N'19')
INSERT [dbo].[DataNumber3] ([BT]) VALUES (N'20')
INSERT [dbo].[DataNumber3] ([BT]) VALUES (N'21')
INSERT [dbo].[DataNumber3] ([BT]) VALUES (N'22')
INSERT [dbo].[DataNumber3] ([BT]) VALUES (N'23')
INSERT [dbo].[DataNumber3] ([BT]) VALUES (N'24')
INSERT [dbo].[DataNumber3] ([BT]) VALUES (N'25')
INSERT [dbo].[DataNumber3] ([BT]) VALUES (N'26')
INSERT [dbo].[DataNumber3] ([BT]) VALUES (N'27')
INSERT [dbo].[DataNumber3] ([BT]) VALUES (N'28')
INSERT [dbo].[DataNumber3] ([BT]) VALUES (N'29')
INSERT [dbo].[DataNumber3] ([BT]) VALUES (N'30')
INSERT [dbo].[DataNumber3] ([BT]) VALUES (N'31')
INSERT [dbo].[DataNumber3] ([BT]) VALUES (N'32')
INSERT [dbo].[DataNumber3] ([BT]) VALUES (N'33')
INSERT [dbo].[DataNumber3] ([BT]) VALUES (N'34')
INSERT [dbo].[DataNumber3] ([BT]) VALUES (N'35')
INSERT [dbo].[DataNumber3] ([BT]) VALUES (N'36')
INSERT [dbo].[DataNumber3] ([BT]) VALUES (N'37')
INSERT [dbo].[DataNumber3] ([BT]) VALUES (N'38')
INSERT [dbo].[DataNumber3] ([BT]) VALUES (N'39')
INSERT [dbo].[DataNumber3] ([BT]) VALUES (N'40')
INSERT [dbo].[DataNumber3] ([BT]) VALUES (N'41')
INSERT [dbo].[DataNumber3] ([BT]) VALUES (N'42')
INSERT [dbo].[DataNumber3] ([BT]) VALUES (N'43')
INSERT [dbo].[DataNumber3] ([BT]) VALUES (N'44')
INSERT [dbo].[DataNumber3] ([BT]) VALUES (N'45')
INSERT [dbo].[DataNumber3] ([BT]) VALUES (N'46')
INSERT [dbo].[DataNumber3] ([BT]) VALUES (N'47')
INSERT [dbo].[DataNumber3] ([BT]) VALUES (N'48')
INSERT [dbo].[DataNumber3] ([BT]) VALUES (N'49')
INSERT [dbo].[DataNumber3] ([BT]) VALUES (N'50')
INSERT [dbo].[DataNumber3] ([BT]) VALUES (N'51')
INSERT [dbo].[DataNumber3] ([BT]) VALUES (N'52')
INSERT [dbo].[DataNumber3] ([BT]) VALUES (N'53')
INSERT [dbo].[DataNumber3] ([BT]) VALUES (N'54')
INSERT [dbo].[DataNumber3] ([BT]) VALUES (N'55')
INSERT [dbo].[DataNumber3] ([BT]) VALUES (N'56')
INSERT [dbo].[DataNumber3] ([BT]) VALUES (N'57')
INSERT [dbo].[DataNumber3] ([BT]) VALUES (N'58')
INSERT [dbo].[DataNumber3] ([BT]) VALUES (N'59')
INSERT [dbo].[DataNumber3] ([BT]) VALUES (N'60')
INSERT [dbo].[DataNumber3] ([BT]) VALUES (N'61')
INSERT [dbo].[DataNumber3] ([BT]) VALUES (N'62')
INSERT [dbo].[DataNumber3] ([BT]) VALUES (N'63')
INSERT [dbo].[DataNumber3] ([BT]) VALUES (N'64')
INSERT [dbo].[DataNumber3] ([BT]) VALUES (N'65')
INSERT [dbo].[DataNumber3] ([BT]) VALUES (N'66')
INSERT [dbo].[DataNumber3] ([BT]) VALUES (N'67')
INSERT [dbo].[DataNumber3] ([BT]) VALUES (N'68')
INSERT [dbo].[DataNumber3] ([BT]) VALUES (N'69')
INSERT [dbo].[DataNumber3] ([BT]) VALUES (N'70')
INSERT [dbo].[DataNumber3] ([BT]) VALUES (N'71')
INSERT [dbo].[DataNumber3] ([BT]) VALUES (N'72')
INSERT [dbo].[DataNumber3] ([BT]) VALUES (N'73')
INSERT [dbo].[DataNumber3] ([BT]) VALUES (N'74')
INSERT [dbo].[DataNumber3] ([BT]) VALUES (N'75')
INSERT [dbo].[DataNumber3] ([BT]) VALUES (N'76')
INSERT [dbo].[DataNumber3] ([BT]) VALUES (N'77')
INSERT [dbo].[DataNumber3] ([BT]) VALUES (N'78')
INSERT [dbo].[DataNumber3] ([BT]) VALUES (N'79')
INSERT [dbo].[DataNumber3] ([BT]) VALUES (N'80')
INSERT [dbo].[DataNumber3] ([BT]) VALUES (N'81')
INSERT [dbo].[DataNumber3] ([BT]) VALUES (N'82')
INSERT [dbo].[DataNumber3] ([BT]) VALUES (N'83')
INSERT [dbo].[DataNumber3] ([BT]) VALUES (N'84')
INSERT [dbo].[DataNumber3] ([BT]) VALUES (N'85')
INSERT [dbo].[DataNumber3] ([BT]) VALUES (N'86')
INSERT [dbo].[DataNumber3] ([BT]) VALUES (N'87')
INSERT [dbo].[DataNumber3] ([BT]) VALUES (N'88')
INSERT [dbo].[DataNumber3] ([BT]) VALUES (N'89')
INSERT [dbo].[DataNumber3] ([BT]) VALUES (N'90')
INSERT [dbo].[DataNumber3] ([BT]) VALUES (N'91')
INSERT [dbo].[DataNumber3] ([BT]) VALUES (N'92')
INSERT [dbo].[DataNumber3] ([BT]) VALUES (N'93')
INSERT [dbo].[DataNumber3] ([BT]) VALUES (N'94')
INSERT [dbo].[DataNumber3] ([BT]) VALUES (N'95')
INSERT [dbo].[DataNumber3] ([BT]) VALUES (N'96')
INSERT [dbo].[DataNumber3] ([BT]) VALUES (N'97')
INSERT [dbo].[DataNumber3] ([BT]) VALUES (N'98')
INSERT [dbo].[DataNumber3] ([BT]) VALUES (N'99')
INSERT [dbo].[DataNumber3] ([BT]) VALUES (N'0')
GO
INSERT [dbo].[ResultOfDay] ([Date], [DB], [NHAT], [NHI], [BA], [TU], [NAM], [SAU], [BAY]) VALUES (CAST(N'2021-01-01' AS Date), N'78885', N'61981', N'32168 74990', N'52955 93657 43037  39539 82586 22866', N'9925 5333 1426 9023', N'4289 6576 5377  7039 4487 1675', N'145 565 210', N'81 14 08 11')
INSERT [dbo].[ResultOfDay] ([Date], [DB], [NHAT], [NHI], [BA], [TU], [NAM], [SAU], [BAY]) VALUES (CAST(N'2021-01-02' AS Date), N'20681', N'89427', N'32886 74910', N'46106 78936 81595  03204 82919 14732', N'6502 7613 7283 5855', N'3855 0496 1430  4451 4778 9023', N'567 057 083', N'68 19 29 12')
INSERT [dbo].[ResultOfDay] ([Date], [DB], [NHAT], [NHI], [BA], [TU], [NAM], [SAU], [BAY]) VALUES (CAST(N'2021-01-03' AS Date), N'43132', N'27110', N'95760 90752', N'95706 88054 51171  53041 78424 18868', N'9618 9587 0840 0372', N'4852 3728 0060  4514 8855 5704', N'597 493 131', N'16 59 91 25')
INSERT [dbo].[ResultOfDay] ([Date], [DB], [NHAT], [NHI], [BA], [TU], [NAM], [SAU], [BAY]) VALUES (CAST(N'2021-01-04' AS Date), N'42988', N'92795', N'19046 79580', N'87526 92979 11171  46875 96595 73614', N'7434 0809 5921 5509', N'1512 3716 3814  4143 8088 9851', N'880 797 927', N'39 14 63 71')
INSERT [dbo].[ResultOfDay] ([Date], [DB], [NHAT], [NHI], [BA], [TU], [NAM], [SAU], [BAY]) VALUES (CAST(N'2021-01-05' AS Date), N'19376', N'05036', N'43342 31276', N'86804 90617 49547  13368 07354 12554', N'4737 7623 5214 9688', N'0265 9596 2704  3998 3885 2430', N'257 166 198', N'09 24 70 83')
INSERT [dbo].[ResultOfDay] ([Date], [DB], [NHAT], [NHI], [BA], [TU], [NAM], [SAU], [BAY]) VALUES (CAST(N'2021-01-06' AS Date), N'90402', N'75947', N'74911 44677', N'73443 21480 97489  88629 59071 00881', N'2510 4621 6853 2119', N'7445 3419 6129  6096 9127 9897', N'467 040 049', N'12 08 46 32')
INSERT [dbo].[ResultOfDay] ([Date], [DB], [NHAT], [NHI], [BA], [TU], [NAM], [SAU], [BAY]) VALUES (CAST(N'2021-01-07' AS Date), N'09854', N'15562', N'28845 15681', N'21044 84466 56370  44614 39798 52457', N'6288 5987 4489 7646', N'4814 3518 3749  8784 0871 9809', N'040 284 841', N'62 93 15 34')
INSERT [dbo].[ResultOfDay] ([Date], [DB], [NHAT], [NHI], [BA], [TU], [NAM], [SAU], [BAY]) VALUES (CAST(N'2021-01-08' AS Date), N'00726', N'05627', N'70149 28426', N'80452 76037 93062  41786 56154 32772', N'4433 1343 3747 7960', N'0734 8998 7569  2665 0306 5171', N'694 303 562', N'30 00 77 61')
INSERT [dbo].[ResultOfDay] ([Date], [DB], [NHAT], [NHI], [BA], [TU], [NAM], [SAU], [BAY]) VALUES (CAST(N'2021-01-09' AS Date), N'82064', N'08356', N'61215 80388', N'89490 11130 17716  79887 06388 26929', N'2573 9123 3390 3611', N'9538 3684 3274  2415 2095 3665', N'751 900 277', N'54 40 02 17')
INSERT [dbo].[ResultOfDay] ([Date], [DB], [NHAT], [NHI], [BA], [TU], [NAM], [SAU], [BAY]) VALUES (CAST(N'2021-01-10' AS Date), N'48146', N'63172', N'06185 24165', N'21836 46147 12685  13714 82314 70690', N'7047 4115 7754 7409', N'1270 0970 5541  7163 0474 7764', N'817 092 108', N'54 95 68 29')
INSERT [dbo].[ResultOfDay] ([Date], [DB], [NHAT], [NHI], [BA], [TU], [NAM], [SAU], [BAY]) VALUES (CAST(N'2021-01-11' AS Date), N'05507', N'94780', N'28367 95448', N'92653 95189 81513  56865 21041 18375', N'1091 9317 9206 1383', N'2420 5010 7844  1730 3159 3577', N'917 708 040', N'41 07 60 35')
INSERT [dbo].[ResultOfDay] ([Date], [DB], [NHAT], [NHI], [BA], [TU], [NAM], [SAU], [BAY]) VALUES (CAST(N'2021-01-12' AS Date), N'16592', N'87355', N'93491 45401', N'68063 72753 35051  60748 57701 15172', N'3720 7082 8879 5916', N'7271 0472 4405  3653 0336 1701', N'411 379 906', N'92 77 82 56')
INSERT [dbo].[ResultOfDay] ([Date], [DB], [NHAT], [NHI], [BA], [TU], [NAM], [SAU], [BAY]) VALUES (CAST(N'2021-01-13' AS Date), N'02769', N'38216', N'11276 94309', N'64336 21172 87669  76214 95085 69947', N'7295 0029 4713 7354', N'8886 7271 3378  9059 4262 2858', N'188 146 460', N'13 35 71 99')
INSERT [dbo].[ResultOfDay] ([Date], [DB], [NHAT], [NHI], [BA], [TU], [NAM], [SAU], [BAY]) VALUES (CAST(N'2021-01-14' AS Date), N'51338', N'88232', N'52762 16210', N'01251 21080 30073  33311 23663 69008', N'0693 1495 1430 1770', N'5609 1482 3063  0817 0019 9350', N'142 448 562', N'60 04 10 95')
INSERT [dbo].[ResultOfDay] ([Date], [DB], [NHAT], [NHI], [BA], [TU], [NAM], [SAU], [BAY]) VALUES (CAST(N'2021-01-15' AS Date), N'68285', N'63497', N'51148 40526', N'21460 45322 08942  64777 99903 68603', N'9743 9831 2616 0548', N'0880 6314 8728  3229 3228 1896', N'300 505 685', N'13 33 47 58')
INSERT [dbo].[ResultOfDay] ([Date], [DB], [NHAT], [NHI], [BA], [TU], [NAM], [SAU], [BAY]) VALUES (CAST(N'2021-01-16' AS Date), N'12046', N'58127', N'13716 13938', N'97864 15467 16200  33137 19032 27560', N'4741 9668 7808 4797', N'5608 8792 4534  1448 0349 2861', N'968 825 724', N'15 76 85 71')
INSERT [dbo].[ResultOfDay] ([Date], [DB], [NHAT], [NHI], [BA], [TU], [NAM], [SAU], [BAY]) VALUES (CAST(N'2021-01-17' AS Date), N'55095', N'58464', N'65216 77011', N'19594 34767 57701  76863 70980 54862', N'8664 4091 1436 8925', N'5408 7165 1651  1712 1770 4474', N'002 600 566', N'43 98 97 87')
INSERT [dbo].[ResultOfDay] ([Date], [DB], [NHAT], [NHI], [BA], [TU], [NAM], [SAU], [BAY]) VALUES (CAST(N'2021-01-18' AS Date), N'92549', N'96884', N'06158 89877', N'24305 53638 12286  37720 42141 51253', N'8202 1717 2304 7338', N'0149 9697 0008  4535 1725 0195', N'494 321 078', N'59 13 69 23')
INSERT [dbo].[ResultOfDay] ([Date], [DB], [NHAT], [NHI], [BA], [TU], [NAM], [SAU], [BAY]) VALUES (CAST(N'2021-01-19' AS Date), N'23677', N'32856', N'88201 31483', N'31721 22939 19393  86338 94480 25520', N'6750 4933 2122 0719', N'8448 8313 5584  9527 1697 4703', N'248 646 116', N'67 96 55 52')
INSERT [dbo].[ResultOfDay] ([Date], [DB], [NHAT], [NHI], [BA], [TU], [NAM], [SAU], [BAY]) VALUES (CAST(N'2021-01-20' AS Date), N'60545', N'94248', N'55911 27740', N'12215 57381 44280  45333 60402 47070', N'3600 0336 3138 0575', N'9728 4755 8161  3499 7805 1981', N'070 167 361', N'68 37 41 91')
INSERT [dbo].[ResultOfDay] ([Date], [DB], [NHAT], [NHI], [BA], [TU], [NAM], [SAU], [BAY]) VALUES (CAST(N'2021-01-21' AS Date), N'21331', N'54409', N'06619 35655', N'75287 68137 56058  56979 67719 99740', N'9658 2580 7860 6652', N'7769 5852 9649  2524 9395 4084', N'924 125 959', N'78 07 44 66')
INSERT [dbo].[ResultOfDay] ([Date], [DB], [NHAT], [NHI], [BA], [TU], [NAM], [SAU], [BAY]) VALUES (CAST(N'2021-01-22' AS Date), N'09264', N'84081', N'02515 40551', N'50923 52161 94571  45049 22063 12002', N'2350 7495 3382 3957', N'4240 9067 6766  4874 6126 8781', N'975 649 138', N'99 66 79 86')
INSERT [dbo].[ResultOfDay] ([Date], [DB], [NHAT], [NHI], [BA], [TU], [NAM], [SAU], [BAY]) VALUES (CAST(N'2021-01-23' AS Date), N'57860', N'70031', N'56407 68115', N'30928 93562 53443  65324 88899 01181', N'3133 6718 0968 4542', N'4768 3530 9114  2694 2311 0920', N'146 648 511', N'30 22 81 96')
INSERT [dbo].[ResultOfDay] ([Date], [DB], [NHAT], [NHI], [BA], [TU], [NAM], [SAU], [BAY]) VALUES (CAST(N'2021-01-24' AS Date), N'45883', N'11884', N'06052 25341', N'13947 82242 73553  11471 63635 21620', N'7327 7779 4290 9307', N'1778 2827 1088  0949 2155 4264', N'501 314 381', N'56 53 26 74')
INSERT [dbo].[ResultOfDay] ([Date], [DB], [NHAT], [NHI], [BA], [TU], [NAM], [SAU], [BAY]) VALUES (CAST(N'2021-01-25' AS Date), N'00157', N'76628', N'49479 57764', N'98479 33581 30972  70416 42514 76196', N'1275 1438 1083 3981', N'7266 7787 7183  0098 3239 7914', N'836 179 033', N'19 05 88 55')
INSERT [dbo].[ResultOfDay] ([Date], [DB], [NHAT], [NHI], [BA], [TU], [NAM], [SAU], [BAY]) VALUES (CAST(N'2021-01-26' AS Date), N'33079', N'24509', N'50297 32684', N'14722 09617 06372  97642 83017 89131', N'0939 2418 0471 3505', N'1487 5532 3667  2075 1854 6904', N'481 024 838', N'09 13 76 49')
INSERT [dbo].[ResultOfDay] ([Date], [DB], [NHAT], [NHI], [BA], [TU], [NAM], [SAU], [BAY]) VALUES (CAST(N'2021-01-27' AS Date), N'45756', N'54147', N'75465 16811', N'52280 98471 49012  75714 63753 99450', N'2606 4588 9453 8418', N'0470 0355 7754  5675 6912 0783', N'176 511 964', N'92 07 08 29')
INSERT [dbo].[ResultOfDay] ([Date], [DB], [NHAT], [NHI], [BA], [TU], [NAM], [SAU], [BAY]) VALUES (CAST(N'2021-01-28' AS Date), N'92020', N'19071', N'14801 69525', N'11930 54073 82494  51002 65741 87841', N'6381 4938 9584 3714', N'1979 0248 7541  3685 9228 0715', N'908 678 850', N'96 65 22 41')
INSERT [dbo].[ResultOfDay] ([Date], [DB], [NHAT], [NHI], [BA], [TU], [NAM], [SAU], [BAY]) VALUES (CAST(N'2021-01-29' AS Date), N'40169', N'74085', N'03024 33253', N'95499 49160 46104  99338 97510 25548', N'1963 2870 8793 7261', N'9763 6916 4588  0608 9073 8742', N'867 115 321', N'76 56 98 90')
INSERT [dbo].[ResultOfDay] ([Date], [DB], [NHAT], [NHI], [BA], [TU], [NAM], [SAU], [BAY]) VALUES (CAST(N'2021-01-30' AS Date), N'71209', N'55959', N'82657 07301', N'18623 17282 66088  32910 19654 01902', N'3107 0795 1697 4453', N'6730 0486 4499  3196 8594 1108', N'120 521 068', N'40 53 29 16')
INSERT [dbo].[ResultOfDay] ([Date], [DB], [NHAT], [NHI], [BA], [TU], [NAM], [SAU], [BAY]) VALUES (CAST(N'2021-01-31' AS Date), N'17386', N'73899', N'44181 28727', N'27211 91255 90959  85632 88113 99621', N'5334 8136 5401 7740', N'6069 7378 7257  7983 9623 1174', N'421 821 898', N'80 28 30 81')
INSERT [dbo].[ResultOfDay] ([Date], [DB], [NHAT], [NHI], [BA], [TU], [NAM], [SAU], [BAY]) VALUES (CAST(N'2021-02-01' AS Date), N'54782', N'33824', N'75934 75198', N'07807 30817 30552  69643 25076 59338', N'2191 7292 9141 1441', N'8932 3954 3633  3436 2633 6364', N'016 077 438', N'81 08 84 33')
INSERT [dbo].[ResultOfDay] ([Date], [DB], [NHAT], [NHI], [BA], [TU], [NAM], [SAU], [BAY]) VALUES (CAST(N'2021-02-02' AS Date), N'15759', N'94632', N'87665 00106', N'93054 14050 89707  04762 30708 66993', N'3765 5489 8034 1676', N'5961 7441 2050  7148 3647 1867', N'570 945 490', N'30 27 89 66')
INSERT [dbo].[ResultOfDay] ([Date], [DB], [NHAT], [NHI], [BA], [TU], [NAM], [SAU], [BAY]) VALUES (CAST(N'2021-02-03' AS Date), N'76349', N'68400', N'16475 50706', N'33912 66566 22883  51676 45105 32182', N'0869 0360 0179 8405', N'2850 6272 4043  5386 6423 4231', N'287 865 292', N'97 26 42 33')
INSERT [dbo].[ResultOfDay] ([Date], [DB], [NHAT], [NHI], [BA], [TU], [NAM], [SAU], [BAY]) VALUES (CAST(N'2021-02-04' AS Date), N'48218', N'12833', N'42952 42457', N'35345 43691 68718  86132 52225 19869', N'5362 0911 3515 4807', N'9772 7833 5995  1267 4720 8940', N'496 169 543', N'32 71 44 45')
INSERT [dbo].[ResultOfDay] ([Date], [DB], [NHAT], [NHI], [BA], [TU], [NAM], [SAU], [BAY]) VALUES (CAST(N'2021-02-05' AS Date), N'48520', N'61417', N'61323 88532', N'05920 84407 66568  10425 96873 84798', N'7128 9292 4278 5915', N'2327 0821 0064  7717 4532 1681', N'444 718 268', N'70 88 39 14')
INSERT [dbo].[ResultOfDay] ([Date], [DB], [NHAT], [NHI], [BA], [TU], [NAM], [SAU], [BAY]) VALUES (CAST(N'2021-02-06' AS Date), N'37427', N'81178', N'95907 38690', N'18621 12168 88803  67809 18130 22678', N'9919 1306 9509 9899', N'1263 0129 5507  9846 3264 7385', N'111 924 870', N'11 39 87 13')
INSERT [dbo].[ResultOfDay] ([Date], [DB], [NHAT], [NHI], [BA], [TU], [NAM], [SAU], [BAY]) VALUES (CAST(N'2021-02-07' AS Date), N'25119', N'49164', N'03470 86957', N'49953 37171 16771  14352 20535 68525', N'1154 6529 1334 7407', N'5778 8055 2644  6342 4213 2274', N'065 977 877', N'10 80 14 93')
INSERT [dbo].[ResultOfDay] ([Date], [DB], [NHAT], [NHI], [BA], [TU], [NAM], [SAU], [BAY]) VALUES (CAST(N'2021-02-08' AS Date), N'42991', N'58433', N'63925 29882', N'41725 98391 04989  74828 74456 74215', N'3446 8914 4198 7999', N'4988 9858 9393  0705 7975 0412', N'979 976 314', N'18 80 38 92')
INSERT [dbo].[ResultOfDay] ([Date], [DB], [NHAT], [NHI], [BA], [TU], [NAM], [SAU], [BAY]) VALUES (CAST(N'2021-02-09' AS Date), N'38792', N'02990', N'56382 59467', N'16494 15952 87566  98018 61687 49689', N'3236 0158 0289 5532', N'8266 5050 3338  8384 1355 8984', N'328 663 971', N'12 62 47 36')
INSERT [dbo].[ResultOfDay] ([Date], [DB], [NHAT], [NHI], [BA], [TU], [NAM], [SAU], [BAY]) VALUES (CAST(N'2021-02-10' AS Date), N'04629', N'65961', N'20300 66822', N'31408 92936 91307  19268 99140 09912', N'9163 7289 5975 0162', N'6421 9478 1087  9581 9975 1939', N'344 833 564', N'34 04 32 10')
INSERT [dbo].[ResultOfDay] ([Date], [DB], [NHAT], [NHI], [BA], [TU], [NAM], [SAU], [BAY]) VALUES (CAST(N'2021-02-15' AS Date), N'56286', N'33164', N'94890 93914', N'09089 28684 83380  75841 16786 77493', N'7346 5935 9991 8558', N'5252 1682 7065  2061 4855 1915', N'363 541 782', N'88 41 96 94')
INSERT [dbo].[ResultOfDay] ([Date], [DB], [NHAT], [NHI], [BA], [TU], [NAM], [SAU], [BAY]) VALUES (CAST(N'2021-02-16' AS Date), N'11503', N'24958', N'42653 30557', N'24766 26094 92609  67516 91720 75444', N'7372 4889 3748 0586', N'8770 2923 1332  5875 0746 3009', N'385 619 251', N'00 22 41 17')
INSERT [dbo].[ResultOfDay] ([Date], [DB], [NHAT], [NHI], [BA], [TU], [NAM], [SAU], [BAY]) VALUES (CAST(N'2021-02-17' AS Date), N'05177', N'48772', N'45665 66608', N'63790 46832 73087  70582 20932 77527', N'9354 7816 7190 4799', N'4529 0268 0690  9457 9633 7264', N'838 264 069', N'08 85 65 58')
INSERT [dbo].[ResultOfDay] ([Date], [DB], [NHAT], [NHI], [BA], [TU], [NAM], [SAU], [BAY]) VALUES (CAST(N'2021-02-18' AS Date), N'81910', N'69529', N'30363 09808', N'75281 20408 41646  90334 29677 63460', N'4424 0347 6323 6026', N'3225 3782 2009  7834 9270 2433', N'899 380 869', N'75 47 06 89')
INSERT [dbo].[ResultOfDay] ([Date], [DB], [NHAT], [NHI], [BA], [TU], [NAM], [SAU], [BAY]) VALUES (CAST(N'2021-02-19' AS Date), N'11103', N'91506', N'14103 96867', N'43908 30333 05682  89923 46822 95324', N'6906 6085 5159 5226', N'0259 6908 8178  6533 9420 4716', N'464 135 554', N'03 43 20 18')
INSERT [dbo].[ResultOfDay] ([Date], [DB], [NHAT], [NHI], [BA], [TU], [NAM], [SAU], [BAY]) VALUES (CAST(N'2021-02-20' AS Date), N'70030', N'44389', N'90433 47790', N'16815 76167 85737  26969 17371 21586', N'8614 3339 7682 4643', N'0758 4488 0206  5484 2382 0709', N'047 209 578', N'49 47 37 44')
INSERT [dbo].[ResultOfDay] ([Date], [DB], [NHAT], [NHI], [BA], [TU], [NAM], [SAU], [BAY]) VALUES (CAST(N'2021-02-21' AS Date), N'57607', N'09740', N'59920 25777', N'77624 09513 00688  14994 48769 07498', N'5872 6569 5395 5305', N'8808 4120 7478  4849 9516 4310', N'527 740 449', N'50 19 82 08')
INSERT [dbo].[ResultOfDay] ([Date], [DB], [NHAT], [NHI], [BA], [TU], [NAM], [SAU], [BAY]) VALUES (CAST(N'2021-02-22' AS Date), N'77708', N'39543', N'90233 40768', N'85526 36698 75087  25643 46163 77825', N'6424 1416 0405 9483', N'3242 5032 8071  7329 7493 0875', N'718 462 025', N'67 18 32 16')
INSERT [dbo].[ResultOfDay] ([Date], [DB], [NHAT], [NHI], [BA], [TU], [NAM], [SAU], [BAY]) VALUES (CAST(N'2021-02-23' AS Date), N'17110', N'80128', N'97658 76413', N'85597 80481 92887  00464 54369 92065', N'6321 6491 5875 2498', N'7374 4158 9701  1117 6132 1301', N'983 606 343', N'26 08 59 86')
INSERT [dbo].[ResultOfDay] ([Date], [DB], [NHAT], [NHI], [BA], [TU], [NAM], [SAU], [BAY]) VALUES (CAST(N'2021-02-24' AS Date), N'93315', N'73168', N'22638 92974', N'52693 70286 16719  69491 29122 08843', N'4639 3060 0385 5877', N'3640 8917 8654  4150 4993 6847', N'185 609 564', N'32 78 02 68')
INSERT [dbo].[ResultOfDay] ([Date], [DB], [NHAT], [NHI], [BA], [TU], [NAM], [SAU], [BAY]) VALUES (CAST(N'2021-02-25' AS Date), N'35855', N'42177', N'20074 32589', N'86484 98975 32529  41999 83797 88245', N'2972 1141 5546 9411', N'7013 8211 8017  1160 4564 7055', N'631 833 406', N'69 98 05 73')
INSERT [dbo].[ResultOfDay] ([Date], [DB], [NHAT], [NHI], [BA], [TU], [NAM], [SAU], [BAY]) VALUES (CAST(N'2021-02-26' AS Date), N'55600', N'59302', N'78836 71711', N'57669 79931 24351  86322 54511 71826', N'6225 6043 3742 0666', N'0314 6945 0521  6066 8579 0910', N'203 330 633', N'04 70 40 37')
INSERT [dbo].[ResultOfDay] ([Date], [DB], [NHAT], [NHI], [BA], [TU], [NAM], [SAU], [BAY]) VALUES (CAST(N'2021-02-27' AS Date), N'26313', N'85377', N'05722 96218', N'33973 06118 42871  20486 40204 15775', N'9706 2583 3438 4088', N'5982 9727 6391  2386 8266 3383', N'078 988 279', N'67 54 42 21')
INSERT [dbo].[ResultOfDay] ([Date], [DB], [NHAT], [NHI], [BA], [TU], [NAM], [SAU], [BAY]) VALUES (CAST(N'2021-02-28' AS Date), N'30398', N'04743', N'50110 27282', N'28577 60852 29047  52445 01560 80255', N'8543 9909 5376 4337', N'6777 5032 3718  5740 9094 3035', N'875 242 975', N'44 10 04 43')
INSERT [dbo].[ResultOfDay] ([Date], [DB], [NHAT], [NHI], [BA], [TU], [NAM], [SAU], [BAY]) VALUES (CAST(N'2021-03-01' AS Date), N'91577', N'25687', N'04579 10568', N'52956 85641 10983  54311 60968 37476', N'0908 0118 8066 7712', N'6306 0487 3629  7788 5369 0349', N'293 346 179', N'91 86 88 99')
INSERT [dbo].[ResultOfDay] ([Date], [DB], [NHAT], [NHI], [BA], [TU], [NAM], [SAU], [BAY]) VALUES (CAST(N'2021-03-02' AS Date), N'87462', N'45915', N'16169 64606', N'90882 13897 53971  16595 90530 47644', N'7091 0350 6653 8444', N'5454 6352 0665  3277 8876 6220', N'988 868 811', N'68 54 33 53')
INSERT [dbo].[ResultOfDay] ([Date], [DB], [NHAT], [NHI], [BA], [TU], [NAM], [SAU], [BAY]) VALUES (CAST(N'2021-03-03' AS Date), N'63410', N'84221', N'24769 36622', N'68174 58379 03677  41070 65097 32670', N'6699 7395 0095 0326', N'8823 6842 7275  7496 3805 6910', N'746 846 202', N'98 97 44 73')
INSERT [dbo].[ResultOfDay] ([Date], [DB], [NHAT], [NHI], [BA], [TU], [NAM], [SAU], [BAY]) VALUES (CAST(N'2021-03-04' AS Date), N'96100', N'19162', N'39809 24663', N'55433 52194 27114  74980 33385 33113', N'2860 5190 3378 5910', N'0963 7658 5351  0135 2576 4252', N'527 640 880', N'88 60 37 69')
INSERT [dbo].[ResultOfDay] ([Date], [DB], [NHAT], [NHI], [BA], [TU], [NAM], [SAU], [BAY]) VALUES (CAST(N'2021-03-05' AS Date), N'66992', N'16935', N'68659 92257', N'86409 19336 52232  57170 72166 57740', N'9386 5211 1352 1440', N'3504 9774 7369  1318 2325 0278', N'071 914 922', N'70 84 40 11')
INSERT [dbo].[ResultOfDay] ([Date], [DB], [NHAT], [NHI], [BA], [TU], [NAM], [SAU], [BAY]) VALUES (CAST(N'2021-03-06' AS Date), N'61918', N'27134', N'95645 62513', N'32460 87555 92061  61625 14908 00998', N'9946 7782 0527 8668', N'9560 0411 8642  3718 9371 1501', N'264 940 890', N'57 47 37 30')
INSERT [dbo].[ResultOfDay] ([Date], [DB], [NHAT], [NHI], [BA], [TU], [NAM], [SAU], [BAY]) VALUES (CAST(N'2021-03-07' AS Date), N'38433', N'63732', N'42264 13340', N'88049 77803 97934  33925 27140 69168', N'0167 9845 4859 8093', N'0867 1261 8655  6600 9847 2143', N'355 915 266', N'14 39 57 75')
INSERT [dbo].[ResultOfDay] ([Date], [DB], [NHAT], [NHI], [BA], [TU], [NAM], [SAU], [BAY]) VALUES (CAST(N'2021-03-08' AS Date), N'20859', N'94188', N'93709 21638', N'57792 60347 61714  30836 44243 36984', N'0589 6444 0415 4512', N'2759 1767 4817  0580 5250 3644', N'546 175 031', N'09 17 65 75')
INSERT [dbo].[ResultOfDay] ([Date], [DB], [NHAT], [NHI], [BA], [TU], [NAM], [SAU], [BAY]) VALUES (CAST(N'2021-03-09' AS Date), N'97736', N'20562', N'27019 73169', N'79781 19377 63404  63177 04844 66570', N'0833 4362 9088 3597', N'8002 4075 1045  7278 9575 3695', N'942 836 525', N'09 45 69 26')
INSERT [dbo].[ResultOfDay] ([Date], [DB], [NHAT], [NHI], [BA], [TU], [NAM], [SAU], [BAY]) VALUES (CAST(N'2021-03-10' AS Date), N'61639', N'24142', N'11092 41976', N'73798 27267 11136  91454 79233 80885', N'4006 6559 1777 6720', N'3099 9110 5717  8799 9924 7762', N'993 311 470', N'94 75 42 95')
INSERT [dbo].[ResultOfDay] ([Date], [DB], [NHAT], [NHI], [BA], [TU], [NAM], [SAU], [BAY]) VALUES (CAST(N'2021-03-11' AS Date), N'47526', N'10974', N'99990 60827', N'47531 60984 67697  94993 73896 31181', N'6171 0525 7568 0543', N'0694 2666 7891  6413 3079 8373', N'537 416 661', N'18 72 16 38')
INSERT [dbo].[ResultOfDay] ([Date], [DB], [NHAT], [NHI], [BA], [TU], [NAM], [SAU], [BAY]) VALUES (CAST(N'2021-03-12' AS Date), N'85439', N'84075', N'78489 29688', N'31297 18684 63601  54663 65777 16129', N'2609 2739 8536 8966', N'3840 2898 8403  6303 1622 4893', N'083 841 689', N'15 70 38 84')
INSERT [dbo].[ResultOfDay] ([Date], [DB], [NHAT], [NHI], [BA], [TU], [NAM], [SAU], [BAY]) VALUES (CAST(N'2021-03-13' AS Date), N'95112', N'99964', N'03193 68084', N'28056 89233 14363  27047 63639 08420', N'3563 6980 6200 3558', N'8043 7832 6097  0462 5642 0871', N'590 922 609', N'16 34 02 28')
INSERT [dbo].[ResultOfDay] ([Date], [DB], [NHAT], [NHI], [BA], [TU], [NAM], [SAU], [BAY]) VALUES (CAST(N'2021-03-14' AS Date), N'45587', N'03881', N'53681 78181', N'26477 71139 83288  17391 44056 66838', N'6916 4858 9751 0071', N'1541 0960 4038  9733 0406 2704', N'764 932 902', N'29 85 93 90')
INSERT [dbo].[ResultOfDay] ([Date], [DB], [NHAT], [NHI], [BA], [TU], [NAM], [SAU], [BAY]) VALUES (CAST(N'2021-03-15' AS Date), N'61924', N'41098', N'87157 15729', N'76346 03367 69222  32487 89062 78379', N'3698 6631 3731 4702', N'9410 0045 7567  2187 5239 5783', N'241 440 245', N'28 29 25 56')
INSERT [dbo].[ResultOfDay] ([Date], [DB], [NHAT], [NHI], [BA], [TU], [NAM], [SAU], [BAY]) VALUES (CAST(N'2021-03-16' AS Date), N'60054', N'12253', N'02974 61732', N'63111 13564 43038  43486 46295 39933', N'6851 9112 5908 2766', N'3785 7116 6216  7614 7139 5333', N'614 483 910', N'58 06 14 66')
INSERT [dbo].[ResultOfDay] ([Date], [DB], [NHAT], [NHI], [BA], [TU], [NAM], [SAU], [BAY]) VALUES (CAST(N'2021-03-17' AS Date), N'72152', N'15227', N'32168 99294', N'49400 49053 48238  87416 21662 18889', N'8052 3470 4066 1672', N'1188 0816 2060  1329 9837 1633', N'929 899 252', N'01 07 02 24')
INSERT [dbo].[ResultOfDay] ([Date], [DB], [NHAT], [NHI], [BA], [TU], [NAM], [SAU], [BAY]) VALUES (CAST(N'2021-03-18' AS Date), N'37733', N'24313', N'59790 11746', N'29387 50506 22046  42826 01939 96189', N'0663 8451 6650 1786', N'3246 6876 2334  9242 8469 9584', N'538 324 284', N'66 26 17 31')
INSERT [dbo].[ResultOfDay] ([Date], [DB], [NHAT], [NHI], [BA], [TU], [NAM], [SAU], [BAY]) VALUES (CAST(N'2021-03-19' AS Date), N'55324', N'18908', N'70030 91699', N'90308 19045 75389  92951 91232 84593', N'2005 8178 1585 7805', N'7278 4100 2748  0506 2443 8326', N'820 818 350', N'08 93 24 14')
INSERT [dbo].[ResultOfDay] ([Date], [DB], [NHAT], [NHI], [BA], [TU], [NAM], [SAU], [BAY]) VALUES (CAST(N'2021-03-20' AS Date), N'97438', N'44237', N'60631 28008', N'34118 15472 33743  63920 20211 95572', N'4348 4838 1668 7448', N'9827 0689 5421  9339 0196 0659', N'905 348 884', N'49 76 66 51')
INSERT [dbo].[ResultOfDay] ([Date], [DB], [NHAT], [NHI], [BA], [TU], [NAM], [SAU], [BAY]) VALUES (CAST(N'2021-03-21' AS Date), N'68140', N'32393', N'93839 56403', N'65114 04662 27967  17866 80267 40765', N'3640 3582 0360 1661', N'3071 3782 5562  2884 7734 7633', N'556 562 535', N'05 17 02 51')
INSERT [dbo].[ResultOfDay] ([Date], [DB], [NHAT], [NHI], [BA], [TU], [NAM], [SAU], [BAY]) VALUES (CAST(N'2021-03-22' AS Date), N'54315', N'31746', N'44561 88751', N'11374 28144 68702  52836 24984 73255', N'4210 8981 9941 3086', N'0966 3268 5138  9249 4011 0526', N'209 205 919', N'55 78 59 37')
INSERT [dbo].[ResultOfDay] ([Date], [DB], [NHAT], [NHI], [BA], [TU], [NAM], [SAU], [BAY]) VALUES (CAST(N'2021-03-23' AS Date), N'85639', N'30063', N'95547 39052', N'94653 56116 35594  68298 18107 43978', N'7384 6503 9374 5817', N'4654 7854 8140  3821 5628 8489', N'166 489 122', N'78 29 57 41')
INSERT [dbo].[ResultOfDay] ([Date], [DB], [NHAT], [NHI], [BA], [TU], [NAM], [SAU], [BAY]) VALUES (CAST(N'2021-03-24' AS Date), N'66438', N'51768', N'94610 10009', N'41759 79404 04206  82740 54417 72007', N'6962 9851 8259 4138', N'6850 5788 2934  3969 5970 8902', N'461 121 060', N'27 91 25 02')
INSERT [dbo].[ResultOfDay] ([Date], [DB], [NHAT], [NHI], [BA], [TU], [NAM], [SAU], [BAY]) VALUES (CAST(N'2021-03-25' AS Date), N'44219', N'17263', N'51334 63993', N'88090 37457 15226  74880 18603 58173', N'8818 7907 7204 0127', N'4269 1805 1836  5259 8452 6811', N'888 890 213', N'24 06 22 91')
INSERT [dbo].[ResultOfDay] ([Date], [DB], [NHAT], [NHI], [BA], [TU], [NAM], [SAU], [BAY]) VALUES (CAST(N'2021-03-26' AS Date), N'72042', N'68063', N'25311 29971', N'83206 86522 85186  75709 65955 63349', N'6509 7975 0671 5763', N'4368 4718 7579  0026 5589 9488', N'338 783 541', N'59 57 29 76')
INSERT [dbo].[ResultOfDay] ([Date], [DB], [NHAT], [NHI], [BA], [TU], [NAM], [SAU], [BAY]) VALUES (CAST(N'2021-03-27' AS Date), N'54601', N'19860', N'88938 20323', N'48117 20172 64229  45932 08531 13792', N'8074 4492 5054 9894', N'0740 2383 7943  8343 3910 8738', N'105 231 364', N'41 56 54 45')
INSERT [dbo].[ResultOfDay] ([Date], [DB], [NHAT], [NHI], [BA], [TU], [NAM], [SAU], [BAY]) VALUES (CAST(N'2021-03-28' AS Date), N'31295', N'59812', N'31307 66685', N'76613 55369 44339  80508 61477 57903', N'6889 5598 6663 8480', N'2820 3105 1067  9742 9053 5754', N'383 080 449', N'28 55 35 70')
INSERT [dbo].[ResultOfDay] ([Date], [DB], [NHAT], [NHI], [BA], [TU], [NAM], [SAU], [BAY]) VALUES (CAST(N'2021-03-29' AS Date), N'03000', N'18982', N'14238 86862', N'55248 47663 90612  81990 83058 61270', N'9699 3403 0658 4672', N'4094 3499 2994  3125 2070 8140', N'557 201 856', N'62 89 08 73')
INSERT [dbo].[ResultOfDay] ([Date], [DB], [NHAT], [NHI], [BA], [TU], [NAM], [SAU], [BAY]) VALUES (CAST(N'2021-03-30' AS Date), N'49255', N'06649', N'23570 97897', N'17815 78585 28443  63237 25403 81764', N'0137 4313 4219 2492', N'5514 5159 5418  2343 9268 8470', N'089 068 072', N'64 50 81 58')
INSERT [dbo].[ResultOfDay] ([Date], [DB], [NHAT], [NHI], [BA], [TU], [NAM], [SAU], [BAY]) VALUES (CAST(N'2021-03-31' AS Date), N'06996', N'71928', N'98750 07368', N'91571 10665 00818  68013 49576 58931', N'2288 6440 4456 9463', N'3920 6744 4442  0492 7358 7055', N'578 779 351', N'16 39 03 54')
INSERT [dbo].[ResultOfDay] ([Date], [DB], [NHAT], [NHI], [BA], [TU], [NAM], [SAU], [BAY]) VALUES (CAST(N'2021-04-01' AS Date), N'50393', N'32377', N'57201 27882', N'05554 71829 21211  99596 51252 66003', N'8236 6787 8798 1677', N'8702 8801 3261  7137 7029 8319', N'105 622 618', N'65 72 07 23')
INSERT [dbo].[ResultOfDay] ([Date], [DB], [NHAT], [NHI], [BA], [TU], [NAM], [SAU], [BAY]) VALUES (CAST(N'2021-04-02' AS Date), N'01795', N'99808', N'58658 90819', N'54406 82291 94848  61086 13666 06582', N'6068 4967 7881 1343', N'5616 5817 9615  1888 6782 6750', N'933 952 851', N'10 15 43 45')
INSERT [dbo].[ResultOfDay] ([Date], [DB], [NHAT], [NHI], [BA], [TU], [NAM], [SAU], [BAY]) VALUES (CAST(N'2021-04-03' AS Date), N'44110', N'17391', N'84538 71325', N'62417 76030 75577  17381 07633 55283', N'5308 6513 4361 3366', N'6274 9435 6510  4763 6705 8537', N'391 286 595', N'03 28 67 75')
INSERT [dbo].[ResultOfDay] ([Date], [DB], [NHAT], [NHI], [BA], [TU], [NAM], [SAU], [BAY]) VALUES (CAST(N'2021-04-04' AS Date), N'16278', N'81109', N'23429 38390', N'32435 42574 99911  09241 21291 55658', N'4655 9197 2481 8641', N'4142 1733 4329  9404 6699 3373', N'914 344 224', N'54 37 36 65')
INSERT [dbo].[ResultOfDay] ([Date], [DB], [NHAT], [NHI], [BA], [TU], [NAM], [SAU], [BAY]) VALUES (CAST(N'2021-04-05' AS Date), N'06800', N'39251', N'67548 65874', N'16912 12006 71395  44182 32715 94059', N'8360 0691 7008 6286', N'8957 2843 8568  1042 3781 4361', N'826 667 396', N'56 25 87 11')
INSERT [dbo].[ResultOfDay] ([Date], [DB], [NHAT], [NHI], [BA], [TU], [NAM], [SAU], [BAY]) VALUES (CAST(N'2021-04-06' AS Date), N'94659', N'32768', N'30053 32214', N'82444 37646 05925  98134 53057 59774', N'3093 7900 9644 2848', N'4145 6351 2593  6611 6182 7360', N'947 201 559', N'44 45 01 74')
INSERT [dbo].[ResultOfDay] ([Date], [DB], [NHAT], [NHI], [BA], [TU], [NAM], [SAU], [BAY]) VALUES (CAST(N'2021-04-07' AS Date), N'97675', N'55528', N'55398 29818', N'54673 41639 66052  64142 06759 99796', N'2370 2784 4435 5716', N'5498 3510 4504  0800 2973 2388', N'693 603 533', N'13 70 81 56')
INSERT [dbo].[ResultOfDay] ([Date], [DB], [NHAT], [NHI], [BA], [TU], [NAM], [SAU], [BAY]) VALUES (CAST(N'2021-04-08' AS Date), N'63904', N'56240', N'48222 98507', N'32353 37133 28267  86742 62636 80484', N'9490 4218 8779 1522', N'0179 6710 1978  3940 9894 6237', N'307 084 531', N'11 03 47 86')
INSERT [dbo].[ResultOfDay] ([Date], [DB], [NHAT], [NHI], [BA], [TU], [NAM], [SAU], [BAY]) VALUES (CAST(N'2021-04-09' AS Date), N'52070', N'62954', N'37646 88703', N'04269 02791 35381  80397 16804 02753', N'0651 7692 1233 6875', N'7439 7249 5341  9918 3352 8215', N'262 484 531', N'93 83 95 71')
INSERT [dbo].[ResultOfDay] ([Date], [DB], [NHAT], [NHI], [BA], [TU], [NAM], [SAU], [BAY]) VALUES (CAST(N'2021-04-10' AS Date), N'85313', N'55176', N'79036 28577', N'94383 79058 53998  29626 30944 46987', N'4695 6882 5660 7075', N'5263 9971 5237  5381 3743 2306', N'452 292 746', N'86 54 27 64')
INSERT [dbo].[ResultOfDay] ([Date], [DB], [NHAT], [NHI], [BA], [TU], [NAM], [SAU], [BAY]) VALUES (CAST(N'2021-04-11' AS Date), N'29013', N'13305', N'66567 43230', N'99122 04949 71530  82148 72456 78719', N'5096 9766 4238 7800', N'7180 2825 0497  1488 4929 5621', N'821 034 271', N'87 80 83 23')
INSERT [dbo].[ResultOfDay] ([Date], [DB], [NHAT], [NHI], [BA], [TU], [NAM], [SAU], [BAY]) VALUES (CAST(N'2021-04-12' AS Date), N'86039', N'31145', N'18498 98082', N'98245 31416 10849  92752 30862 66716', N'8667 2436 7346 9819', N'3732 7416 9015  0599 7299 6184', N'120 072 542', N'70 97 16 88')
INSERT [dbo].[ResultOfDay] ([Date], [DB], [NHAT], [NHI], [BA], [TU], [NAM], [SAU], [BAY]) VALUES (CAST(N'2021-04-13' AS Date), N'29405', N'36317', N'91982 14199', N'88411 82665 10594  93756 08443 37852', N'0292 2980 7500 4753', N'0456 4980 7105  4130 3798 1607', N'287 955 847', N'97 74 36 21')
INSERT [dbo].[ResultOfDay] ([Date], [DB], [NHAT], [NHI], [BA], [TU], [NAM], [SAU], [BAY]) VALUES (CAST(N'2021-04-14' AS Date), N'74295', N'92214', N'85483 61076', N'72559 48815 40538  49532 49167 21320', N'4111 2072 6501 7996', N'9523 1051 5798  9184 3348 1405', N'135 132 102', N'39 80 82 38')
GO
INSERT [dbo].[ResultOfDay] ([Date], [DB], [NHAT], [NHI], [BA], [TU], [NAM], [SAU], [BAY]) VALUES (CAST(N'2021-04-15' AS Date), N'90982', N'05942', N'63537 27846', N'08216 97437 70544  95936 32700 64061', N'4137 0303 2119 8210', N'9246 4010 6842  6549 1334 5906', N'523 665 973', N'61 32 56 62')
INSERT [dbo].[ResultOfDay] ([Date], [DB], [NHAT], [NHI], [BA], [TU], [NAM], [SAU], [BAY]) VALUES (CAST(N'2021-04-16' AS Date), N'99789', N'61842', N'61345 45388', N'33740 22618 08822  57006 19388 34906', N'0127 8332 9708 8666', N'6417 5984 1399  9256 6349 7108', N'351 427 290', N'24 63 21 14')
INSERT [dbo].[ResultOfDay] ([Date], [DB], [NHAT], [NHI], [BA], [TU], [NAM], [SAU], [BAY]) VALUES (CAST(N'2021-04-17' AS Date), N'10780', N'90312', N'85282 37689', N'63252 45313 95705  84450 55399 24328', N'7215 2880 2797 8358', N'0429 5725 6738  0721 0729 7088', N'800 534 683', N'64 95 10 52')
INSERT [dbo].[ResultOfDay] ([Date], [DB], [NHAT], [NHI], [BA], [TU], [NAM], [SAU], [BAY]) VALUES (CAST(N'2021-04-18' AS Date), N'89500', N'28554', N'92570 49815', N'04952 62208 76847  37635 17270 72952', N'1889 1779 7211 6471', N'4106 7177 3220  6116 9816 1575', N'549 606 127', N'08 56 62 30')
INSERT [dbo].[ResultOfDay] ([Date], [DB], [NHAT], [NHI], [BA], [TU], [NAM], [SAU], [BAY]) VALUES (CAST(N'2021-04-19' AS Date), N'81365', N'37116', N'91280 35840', N'07090 54403 41109  10007 86098 89353', N'5851 1113 7837 9569', N'7119 2502 8400  7704 1188 6837', N'548 974 553', N'66 37 86 80')
INSERT [dbo].[ResultOfDay] ([Date], [DB], [NHAT], [NHI], [BA], [TU], [NAM], [SAU], [BAY]) VALUES (CAST(N'2021-04-20' AS Date), N'05475', N'08566', N'31533 85710', N'76648 51671 93211  16079 10046 91920', N'7051 8376 2365 8791', N'8164 8112 8188  5990 9948 9713', N'321 756 699', N'10 47 59 37')
INSERT [dbo].[ResultOfDay] ([Date], [DB], [NHAT], [NHI], [BA], [TU], [NAM], [SAU], [BAY]) VALUES (CAST(N'2021-04-21' AS Date), N'84355', N'78496', N'47869 79897', N'67143 91837 65450  63741 45899 03051', N'9447 8753 7436 4241', N'0135 6118 1641  5714 0577 6501', N'801 518 273', N'34 32 90 21')
INSERT [dbo].[ResultOfDay] ([Date], [DB], [NHAT], [NHI], [BA], [TU], [NAM], [SAU], [BAY]) VALUES (CAST(N'2021-04-22' AS Date), N'56292', N'85246', N'21395 18863', N'68342 11296 09277  15013 72016 79068', N'4629 4132 7928 3901', N'0848 3767 6767  9733 8337 0348', N'060 338 039', N'84 79 49 68')
INSERT [dbo].[ResultOfDay] ([Date], [DB], [NHAT], [NHI], [BA], [TU], [NAM], [SAU], [BAY]) VALUES (CAST(N'2021-04-23' AS Date), N'98860', N'08807', N'79035 36955', N'52152 13825 21632  50794 48684 45328', N'0241 6662 9586 2178', N'0468 2726 4326  8253 3124 5992', N'309 967 177', N'11 81 47 68')
INSERT [dbo].[ResultOfDay] ([Date], [DB], [NHAT], [NHI], [BA], [TU], [NAM], [SAU], [BAY]) VALUES (CAST(N'2021-04-24' AS Date), N'21177', N'55266', N'11744 71304', N'12322 12651 88889  47362 53738 93420', N'7323 0625 4947 9102', N'3879 9120 7797  3176 9363 5846', N'515 360 477', N'44 72 98 13')
INSERT [dbo].[ResultOfDay] ([Date], [DB], [NHAT], [NHI], [BA], [TU], [NAM], [SAU], [BAY]) VALUES (CAST(N'2021-04-25' AS Date), N'73278', N'29752', N'45407 84732', N'33840 31612 85993  13199 89957 35321', N'5788 0782 6501 6762', N'4864 5444 0604  4028 9450 9506', N'623 091 345', N'41 07 91 36')
INSERT [dbo].[ResultOfDay] ([Date], [DB], [NHAT], [NHI], [BA], [TU], [NAM], [SAU], [BAY]) VALUES (CAST(N'2021-04-26' AS Date), N'16252', N'93619', N'14175 95275', N'45786 92178 83910  83481 13536 42714', N'6312 3686 5694 4080', N'7455 9684 4723  5765 1302 2612', N'458 364 116', N'83 96 78 68')
INSERT [dbo].[ResultOfDay] ([Date], [DB], [NHAT], [NHI], [BA], [TU], [NAM], [SAU], [BAY]) VALUES (CAST(N'2021-04-27' AS Date), N'49333', N'97939', N'55311 56648', N'34925 46058 38462  67329 37199 11607', N'5602 8412 1759 1094', N'4069 2173 7609  7971 9456 0514', N'338 395 689', N'76 67 46 27')
INSERT [dbo].[ResultOfDay] ([Date], [DB], [NHAT], [NHI], [BA], [TU], [NAM], [SAU], [BAY]) VALUES (CAST(N'2021-04-28' AS Date), N'91213', N'60871', N'90650 63371', N'63445 44398 61559  11704 01360 29482', N'8343 0783 0930 3719', N'1317 9878 9400  8308 4796 5967', N'786 949 164', N'15 23 60 05')
INSERT [dbo].[ResultOfDay] ([Date], [DB], [NHAT], [NHI], [BA], [TU], [NAM], [SAU], [BAY]) VALUES (CAST(N'2021-04-29' AS Date), N'21916', N'03753', N'09292 74636', N'68417 68651 69171  90623 96858 69786', N'1854 5529 9484 8227', N'2826 3653 7621  0295 7590 9889', N'472 535 660', N'76 42 11 57')
INSERT [dbo].[ResultOfDay] ([Date], [DB], [NHAT], [NHI], [BA], [TU], [NAM], [SAU], [BAY]) VALUES (CAST(N'2021-04-30' AS Date), N'96736', N'00731', N'93389 43599', N'41521 57436 11921  95917 66854 33229', N'9188 7076 1306 7227', N'1773 7429 9108  6856 7119 3926', N'336 122 639', N'09 80 02 79')
INSERT [dbo].[ResultOfDay] ([Date], [DB], [NHAT], [NHI], [BA], [TU], [NAM], [SAU], [BAY]) VALUES (CAST(N'2021-05-01' AS Date), N'05365', N'60256', N'96537 26510', N'18728 36168 67052  44399 69293 48241', N'1981 7413 6040 3021', N'9589 9440 4767  5311 7420 7328', N'989 920 111', N'89 15 48 57')
INSERT [dbo].[ResultOfDay] ([Date], [DB], [NHAT], [NHI], [BA], [TU], [NAM], [SAU], [BAY]) VALUES (CAST(N'2021-05-02' AS Date), N'76578', N'89773', N'28086 08979', N'53310 84913 98859  08697 50033 62005', N'3088 3199 8452 0669', N'1769 7670 1743  3964 2101 2475', N'813 561 798', N'76 34 85 13')
INSERT [dbo].[ResultOfDay] ([Date], [DB], [NHAT], [NHI], [BA], [TU], [NAM], [SAU], [BAY]) VALUES (CAST(N'2021-05-03' AS Date), N'51925', N'70091', N'77216 24987', N'94756 47241 69203  19688 66872 85929', N'2181 6617 3168 0740', N'2128 4036 3437  7674 4166 9512', N'049 260 972', N'61 16 83 47')
INSERT [dbo].[ResultOfDay] ([Date], [DB], [NHAT], [NHI], [BA], [TU], [NAM], [SAU], [BAY]) VALUES (CAST(N'2021-05-04' AS Date), N'09580', N'29402', N'23008 94257', N'98910 37368 76637  04080 39226 74432', N'8593 2322 5745 7621', N'4996 3716 4054  1778 2133 4180', N'878 470 881', N'85 49 24 98')
INSERT [dbo].[ResultOfDay] ([Date], [DB], [NHAT], [NHI], [BA], [TU], [NAM], [SAU], [BAY]) VALUES (CAST(N'2021-05-05' AS Date), N'83866', N'51676', N'18736 24033', N'19388 26346 44869  64943 98136 16229', N'8844 1363 9702 3489', N'6572 9622 4979  9375 7631 6461', N'940 517 144', N'56 90 15 53')
INSERT [dbo].[ResultOfDay] ([Date], [DB], [NHAT], [NHI], [BA], [TU], [NAM], [SAU], [BAY]) VALUES (CAST(N'2021-05-06' AS Date), N'80359', N'19644', N'56866 23666', N'03810 90538 16724  99553 27566 67734', N'0584 9641 9608 6060', N'1335 6679 6784  1486 7013 1067', N'906 636 410', N'25 79 88 54')
INSERT [dbo].[ResultOfDay] ([Date], [DB], [NHAT], [NHI], [BA], [TU], [NAM], [SAU], [BAY]) VALUES (CAST(N'2021-05-07' AS Date), N'70447', N'30887', N'35120 87882', N'32452 68083 90768  49417 35327 45592', N'2495 1910 5938 5431', N'3356 4053 0586  9639 6345 4121', N'227 327 843', N'55 80 13 71')
INSERT [dbo].[ResultOfDay] ([Date], [DB], [NHAT], [NHI], [BA], [TU], [NAM], [SAU], [BAY]) VALUES (CAST(N'2021-05-08' AS Date), N'26493', N'54128', N'01818 98582', N'01507 93059 78338  90688 06793 50767', N'1368 2142 3396 9675', N'0800 1786 2056  1442 8078 0933', N'904 022 880', N'65 25 50 99')
INSERT [dbo].[ResultOfDay] ([Date], [DB], [NHAT], [NHI], [BA], [TU], [NAM], [SAU], [BAY]) VALUES (CAST(N'2021-05-09' AS Date), N'76369', N'77298', N'73046 17455', N'89049 72087 29566  01899 04804 83194', N'8511 0448 4346 7136', N'8342 1184 7406  4858 8972 9760', N'701 912 815', N'12 50 05 13')
INSERT [dbo].[ResultOfDay] ([Date], [DB], [NHAT], [NHI], [BA], [TU], [NAM], [SAU], [BAY]) VALUES (CAST(N'2021-05-10' AS Date), N'54247', N'69734', N'34677 20804', N'58238 22551 72439  91037 28917 04645', N'1787 9249 2002 3566', N'1046 0728 4516  3542 2857 0539', N'307 802 403', N'53 29 28 57')
INSERT [dbo].[ResultOfDay] ([Date], [DB], [NHAT], [NHI], [BA], [TU], [NAM], [SAU], [BAY]) VALUES (CAST(N'2021-05-11' AS Date), N'57470', N'46413', N'73469 30308', N'31583 38456 58820  47386 50654 84672', N'6636 4486 2882 4552', N'8818 0806 9150  5583 1613 2304', N'826 058 851', N'21 04 47 74')
INSERT [dbo].[ResultOfDay] ([Date], [DB], [NHAT], [NHI], [BA], [TU], [NAM], [SAU], [BAY]) VALUES (CAST(N'2021-05-12' AS Date), N'49650', N'06579', N'14342 12281', N'41247 66322 82113  01646 94819 44572', N'8517 1916 6068 4664', N'1402 7744 5242  9550 5712 2726', N'931 274 752', N'13 55 70 67')
INSERT [dbo].[ResultOfDay] ([Date], [DB], [NHAT], [NHI], [BA], [TU], [NAM], [SAU], [BAY]) VALUES (CAST(N'2021-05-13' AS Date), N'68664', N'81431', N'40720 22183', N'91639 33161 83447  46988 64519 25878', N'1896 1399 1212 5965', N'8505 4981 2318  7544 2891 0191', N'917 833 388', N'09 33 02 23')
INSERT [dbo].[ResultOfDay] ([Date], [DB], [NHAT], [NHI], [BA], [TU], [NAM], [SAU], [BAY]) VALUES (CAST(N'2021-05-14' AS Date), N'81047', N'91687', N'87624 88230', N'59985 32032 68527  94667 83229 11815', N'0131 0750 0166 4345', N'6055 0989 3003  2785 7579 1802', N'151 324 986', N'13 14 37 94')
INSERT [dbo].[ResultOfDay] ([Date], [DB], [NHAT], [NHI], [BA], [TU], [NAM], [SAU], [BAY]) VALUES (CAST(N'2021-05-15' AS Date), N'59925', N'41995', N'32104 99664', N'62977 31241 33408  92887 12145 51393', N'7548 9776 9558 0921', N'2315 6863 8680  6329 2377 6711', N'952 319 693', N'94 16 55 43')
INSERT [dbo].[ResultOfDay] ([Date], [DB], [NHAT], [NHI], [BA], [TU], [NAM], [SAU], [BAY]) VALUES (CAST(N'2021-05-16' AS Date), N'32965', N'91114', N'17932 99707', N'19569 47563 05093  59395 22044 59017', N'9951 5007 7194 3166', N'8698 1417 1058  9220 0385 8284', N'831 489 931', N'71 51 98 28')
INSERT [dbo].[ResultOfDay] ([Date], [DB], [NHAT], [NHI], [BA], [TU], [NAM], [SAU], [BAY]) VALUES (CAST(N'2021-05-17' AS Date), N'67626', N'81254', N'14436 47191', N'29054 59494 13547  49355 99221 17767', N'4541 0210 8059 9213', N'0335 4819 7263  1541 5344 3788', N'373 291 279', N'26 83 98 18')
INSERT [dbo].[ResultOfDay] ([Date], [DB], [NHAT], [NHI], [BA], [TU], [NAM], [SAU], [BAY]) VALUES (CAST(N'2021-05-18' AS Date), N'10448', N'01293', N'90453 43020', N'27989 01592 57247  57697 90951 93120', N'7809 0890 0029 9163', N'4228 5239 7168  7205 4788 5067', N'198 186 590', N'33 82 09 57')
INSERT [dbo].[ResultOfDay] ([Date], [DB], [NHAT], [NHI], [BA], [TU], [NAM], [SAU], [BAY]) VALUES (CAST(N'2021-05-19' AS Date), N'83572', N'70723', N'14308 09786', N'93904 01719 18292  24623 71671 11387', N'6970 4346 6358 0736', N'9739 4459 1481  5172 8040 9893', N'226 031 499', N'01 80 65 12')
INSERT [dbo].[ResultOfDay] ([Date], [DB], [NHAT], [NHI], [BA], [TU], [NAM], [SAU], [BAY]) VALUES (CAST(N'2021-05-20' AS Date), N'55967', N'54580', N'21026 67810', N'59504 89733 13811  43198 35906 15941', N'9745 1163 5539 6360', N'6440 4422 3437  9590 6182 9014', N'483 381 367', N'76 79 71 08')
INSERT [dbo].[ResultOfDay] ([Date], [DB], [NHAT], [NHI], [BA], [TU], [NAM], [SAU], [BAY]) VALUES (CAST(N'2021-05-21' AS Date), N'75723', N'20849', N'13091 49882', N'63075 07902 39553  01554 83889 83251', N'1937 0147 5809 0407', N'2800 7795 8792  8865 3667 4004', N'684 874 802', N'33 34 46 29')
INSERT [dbo].[ResultOfDay] ([Date], [DB], [NHAT], [NHI], [BA], [TU], [NAM], [SAU], [BAY]) VALUES (CAST(N'2021-05-22' AS Date), N'94325', N'23259', N'66640 23376', N'31105 72282 82200  63910 11030 94597', N'5287 3838 8246 6355', N'1337 8328 5374  8056 8762 8690', N'164 827 706', N'73 69 49 51')
INSERT [dbo].[ResultOfDay] ([Date], [DB], [NHAT], [NHI], [BA], [TU], [NAM], [SAU], [BAY]) VALUES (CAST(N'2021-05-23' AS Date), N'13529', N'97227', N'53510 42797', N'53949 33069 63064  87910 18832 78557', N'6853 3613 9966 7341', N'1374 1035 7645  0549 0435 8722', N'360 987 857', N'36 58 07 65')
INSERT [dbo].[ResultOfDay] ([Date], [DB], [NHAT], [NHI], [BA], [TU], [NAM], [SAU], [BAY]) VALUES (CAST(N'2021-05-24' AS Date), N'19685', N'80388', N'49059 33202', N'87712 17969 89009  33776 57779 44541', N'7683 6531 6962 8975', N'5515 6141 5851  7492 9185 6889', N'759 540 100', N'93 90 69 29')
INSERT [dbo].[ResultOfDay] ([Date], [DB], [NHAT], [NHI], [BA], [TU], [NAM], [SAU], [BAY]) VALUES (CAST(N'2021-05-25' AS Date), N'82871', N'94512', N'72720 81900', N'03961 28843 80120  28929 44449 82514', N'8544 5065 5483 3579', N'0266 4452 5162  1982 7783 1265', N'998 780 684', N'44 23 85 86')
INSERT [dbo].[ResultOfDay] ([Date], [DB], [NHAT], [NHI], [BA], [TU], [NAM], [SAU], [BAY]) VALUES (CAST(N'2021-05-26' AS Date), N'64904', N'78141', N'87901 10549', N'40403 40811 25962  62445 22778 37618', N'7535 1633 0138 1596', N'6261 6757 2697  2475 2708 6364', N'682 909 433', N'36 71 45 32')
INSERT [dbo].[ResultOfDay] ([Date], [DB], [NHAT], [NHI], [BA], [TU], [NAM], [SAU], [BAY]) VALUES (CAST(N'2021-05-27' AS Date), N'33003', N'35078', N'36509 95329', N'86347 84893 67695  31072 69847 46059', N'3531 6277 0781 6243', N'6902 5879 7220  0434 3640 7672', N'792 899 079', N'18 05 74 78')
INSERT [dbo].[ResultOfDay] ([Date], [DB], [NHAT], [NHI], [BA], [TU], [NAM], [SAU], [BAY]) VALUES (CAST(N'2021-05-28' AS Date), N'07076', N'67348', N'51380 77608', N'08075 99703 94167  46228 31744 45914', N'3311 3995 2876 3716', N'2474 3996 5550  9833 6195 0496', N'919 215 628', N'82 49 07 29')
INSERT [dbo].[ResultOfDay] ([Date], [DB], [NHAT], [NHI], [BA], [TU], [NAM], [SAU], [BAY]) VALUES (CAST(N'2021-05-29' AS Date), N'81687', N'54246', N'57450 34972', N'15044 72692 88895  87300 71232 92613', N'8087 8713 0896 6614', N'9840 1399 5564  5175 0873 2587', N'871 815 156', N'88 14 41 75')
INSERT [dbo].[ResultOfDay] ([Date], [DB], [NHAT], [NHI], [BA], [TU], [NAM], [SAU], [BAY]) VALUES (CAST(N'2021-05-30' AS Date), N'15553', N'28465', N'01790 77377', N'52873 70371 33873  61735 44650 87166', N'2999 5263 8397 4017', N'6573 2829 1106  5982 6397 2653', N'796 010 411', N'21 00 31 14')
INSERT [dbo].[ResultOfDay] ([Date], [DB], [NHAT], [NHI], [BA], [TU], [NAM], [SAU], [BAY]) VALUES (CAST(N'2021-05-31' AS Date), N'18650', N'10527', N'35074 62060', N'33310 58250 97160  34589 89241 24075', N'1062 5907 5201 9167', N'0859 1375 9280  0445 0606 1421', N'540 276 761', N'31 45 94 77')
INSERT [dbo].[ResultOfDay] ([Date], [DB], [NHAT], [NHI], [BA], [TU], [NAM], [SAU], [BAY]) VALUES (CAST(N'2021-06-01' AS Date), N'57266', N'97063', N'01547 03792', N'34380 55547 99473  04513 03577 43064', N'2595 6129 9793 8725', N'6616 4029 5105  0547 9482 4422', N'424 936 870', N'80 25 37 12')
INSERT [dbo].[ResultOfDay] ([Date], [DB], [NHAT], [NHI], [BA], [TU], [NAM], [SAU], [BAY]) VALUES (CAST(N'2021-06-02' AS Date), N'51714', N'07684', N'76377 65076', N'21826 74839 39404  33717 29053 27921', N'9279 4414 1107 0048', N'6942 4446 8703  0552 0203 2744', N'961 232 807', N'17 16 78 74')
INSERT [dbo].[ResultOfDay] ([Date], [DB], [NHAT], [NHI], [BA], [TU], [NAM], [SAU], [BAY]) VALUES (CAST(N'2023-01-01' AS Date), N'16705', N'76828', N'65067 99229', N'37479 43231 85530  21742 26053 25473', N'4250 7737 3949 9814', N'2879 2534 0977  9752 0363 5688', N'864 443 591', N'59 47 96 67')
INSERT [dbo].[ResultOfDay] ([Date], [DB], [NHAT], [NHI], [BA], [TU], [NAM], [SAU], [BAY]) VALUES (CAST(N'2023-01-02' AS Date), N'49265', N'43459', N'12407 10068', N'35934 71383 25973  92732 33938 09386', N'2697 9832 8291 0173', N'8813 7077 3452  5042 1616 8189', N'194 469 503', N'82 16 80 45')
INSERT [dbo].[ResultOfDay] ([Date], [DB], [NHAT], [NHI], [BA], [TU], [NAM], [SAU], [BAY]) VALUES (CAST(N'2023-01-03' AS Date), N'25649', N'31843', N'63776 30341', N'77026 52031 69174  10420 85248 47765', N'7724 9250 4978 1010', N'4455 2008 0620  7885 5565 4045', N'554 144 596', N'42 51 81 72')
INSERT [dbo].[ResultOfDay] ([Date], [DB], [NHAT], [NHI], [BA], [TU], [NAM], [SAU], [BAY]) VALUES (CAST(N'2023-01-04' AS Date), N'75757', N'40631', N'56326 49667', N'35179 50105 27248  59107 60082 12549', N'5039 3831 4690 7943', N'7094 3207 6892  7757 1132 8909', N'970 784 420', N'14 83 79 25')
INSERT [dbo].[ResultOfDay] ([Date], [DB], [NHAT], [NHI], [BA], [TU], [NAM], [SAU], [BAY]) VALUES (CAST(N'2023-01-05' AS Date), N'76191', N'12810', N'11458 74967', N'71235 86498 02353  79691 79635 03257', N'6925 4512 5726 7634', N'3778 8441 9916  1111 9597 6530', N'165 396 516', N'65 61 91 27')
INSERT [dbo].[ResultOfDay] ([Date], [DB], [NHAT], [NHI], [BA], [TU], [NAM], [SAU], [BAY]) VALUES (CAST(N'2023-01-06' AS Date), N'45370', N'05808', N'84879 98182', N'24293 04306 89635  00442 69931 82844', N'0554 4775 4677 9083', N'9984 2064 0832  5681 4616 1573', N'187 486 857', N'75 66 10 21')
INSERT [dbo].[ResultOfDay] ([Date], [DB], [NHAT], [NHI], [BA], [TU], [NAM], [SAU], [BAY]) VALUES (CAST(N'2023-01-07' AS Date), N'39597', N'20448', N'98375 45648', N'55850 97079 25197  01795 69588 07835', N'1913 8015 5241 3912', N'7722 5706 0051  1050 3377 4923', N'710 696 135', N'95 12 05 93')
INSERT [dbo].[ResultOfDay] ([Date], [DB], [NHAT], [NHI], [BA], [TU], [NAM], [SAU], [BAY]) VALUES (CAST(N'2023-01-08' AS Date), N'20040', N'76965', N'00725 96045', N'24055 40269 79722  76857 77039 09960', N'0127 1158 7977 9924', N'8164 3677 6511  3395 2012 1538', N'389 582 191', N'84 73 61 44')
INSERT [dbo].[ResultOfDay] ([Date], [DB], [NHAT], [NHI], [BA], [TU], [NAM], [SAU], [BAY]) VALUES (CAST(N'2023-01-09' AS Date), N'78014', N'16270', N'24159 26757', N'49767 38438 02952  13127 61711 61184', N'9459 2157 2326 3734', N'4225 7765 2017  6211 9689 0717', N'747 254 703', N'91 86 30 15')
INSERT [dbo].[ResultOfDay] ([Date], [DB], [NHAT], [NHI], [BA], [TU], [NAM], [SAU], [BAY]) VALUES (CAST(N'2023-01-10' AS Date), N'81191', N'88140', N'67096 63288', N'95651 44209 16651  57329 83066 30657', N'6386 5753 7345 3988', N'8146 2499 8664  9180 2900 7842', N'061 913 843', N'44 46 75 18')
INSERT [dbo].[ResultOfDay] ([Date], [DB], [NHAT], [NHI], [BA], [TU], [NAM], [SAU], [BAY]) VALUES (CAST(N'2023-01-11' AS Date), N'04942', N'31511', N'96915 35210', N'18352 34017 18642  36531 84392 83681', N'3310 7880 2041 5685', N'8549 1897 3789  6576 0560 7094', N'001 655 214', N'97 79 12 74')
INSERT [dbo].[ResultOfDay] ([Date], [DB], [NHAT], [NHI], [BA], [TU], [NAM], [SAU], [BAY]) VALUES (CAST(N'2023-01-12' AS Date), N'18452', N'99849', N'27621 91955', N'09319 34625 29740  28430 97779 44856', N'2502 3884 3118 5818', N'5434 7882 4474  0383 7694 3970', N'122 547 305', N'47 29 85 00')
INSERT [dbo].[ResultOfDay] ([Date], [DB], [NHAT], [NHI], [BA], [TU], [NAM], [SAU], [BAY]) VALUES (CAST(N'2023-01-13' AS Date), N'60762', N'70413', N'94856 73874', N'38562 54962 09294  88168 03998 21450', N'8234 7644 3492 0818', N'1114 2556 1891  8732 9010 4068', N'962 160 238', N'70 73 54 66')
INSERT [dbo].[ResultOfDay] ([Date], [DB], [NHAT], [NHI], [BA], [TU], [NAM], [SAU], [BAY]) VALUES (CAST(N'2023-01-14' AS Date), N'62940', N'27086', N'84830 42992', N'26177 28240 86842  54934 53016 11166', N'1213 7375 8375 1727', N'0737 3018 1279  2435 5696 5434', N'949 318 656', N'02 34 82 81')
INSERT [dbo].[ResultOfDay] ([Date], [DB], [NHAT], [NHI], [BA], [TU], [NAM], [SAU], [BAY]) VALUES (CAST(N'2023-01-15' AS Date), N'44221', N'25945', N'14590 57392', N'84792 14379 92716  86841 87280 96564', N'7401 4194 1991 5569', N'9333 9812 3708  3904 1078 2104', N'938 566 749', N'45 57 00 28')
INSERT [dbo].[ResultOfDay] ([Date], [DB], [NHAT], [NHI], [BA], [TU], [NAM], [SAU], [BAY]) VALUES (CAST(N'2023-01-16' AS Date), N'48260', N'83587', N'79324 24955', N'97698 03474 79118  27721 67766 60068', N'9999 2793 8423 8738', N'6232 7156 7587  1067 6779 6885', N'456 695 805', N'53 07 71 23')
INSERT [dbo].[ResultOfDay] ([Date], [DB], [NHAT], [NHI], [BA], [TU], [NAM], [SAU], [BAY]) VALUES (CAST(N'2023-01-17' AS Date), N'53363', N'01443', N'02569 17053', N'87586 46192 21006  19548 86539 33921', N'7295 3401 0582 6328', N'4443 2517 8199  7522 7936 3211', N'197 642 529', N'35 29 04 55')
INSERT [dbo].[ResultOfDay] ([Date], [DB], [NHAT], [NHI], [BA], [TU], [NAM], [SAU], [BAY]) VALUES (CAST(N'2023-01-18' AS Date), N'45282', N'76552', N'51893 50516', N'92764 68866 66740  51752 37335 04030', N'3342 4405 7005 3904', N'3556 7580 0501  2381 4260 3127', N'926 295 635', N'69 04 35 86')
INSERT [dbo].[ResultOfDay] ([Date], [DB], [NHAT], [NHI], [BA], [TU], [NAM], [SAU], [BAY]) VALUES (CAST(N'2023-01-19' AS Date), N'62857', N'24246', N'65122 22745', N'90440 33540 05110  78018 71497 53655', N'1463 1863 4482 5932', N'2342 9101 9125  9116 9435 9550', N'915 320 074', N'26 23 57 96')
INSERT [dbo].[ResultOfDay] ([Date], [DB], [NHAT], [NHI], [BA], [TU], [NAM], [SAU], [BAY]) VALUES (CAST(N'2023-01-20' AS Date), N'91869', N'62613', N'89561 17438', N'79710 68693 48902  08300 92038 67549', N'2455 1085 3800 5406', N'1138 8058 3367  2046 1602 0067', N'216 832 186', N'18 36 82 59')
INSERT [dbo].[ResultOfDay] ([Date], [DB], [NHAT], [NHI], [BA], [TU], [NAM], [SAU], [BAY]) VALUES (CAST(N'2023-01-25' AS Date), N'52371', N'45082', N'87473 55003', N'44656 18647 37207  71263 51955 58209', N'7943 2928 1910 4411', N'4148 0340 5084  5712 7654 1849', N'083 687 637', N'07 18 29 55')
INSERT [dbo].[ResultOfDay] ([Date], [DB], [NHAT], [NHI], [BA], [TU], [NAM], [SAU], [BAY]) VALUES (CAST(N'2023-01-26' AS Date), N'34164', N'21642', N'85331 53702', N'36678 49662 96488  70757 21183 72285', N'2204 4344 9025 9940', N'3753 4608 9088  7731 5934 6916', N'100 874 364', N'32 60 46 20')
INSERT [dbo].[ResultOfDay] ([Date], [DB], [NHAT], [NHI], [BA], [TU], [NAM], [SAU], [BAY]) VALUES (CAST(N'2023-01-27' AS Date), N'72859', N'84970', N'22948 27905', N'68839 72151 45870  16675 45622 30683', N'5687 8094 1582 5288', N'9289 6626 4652  3120 7508 5479', N'166 101 463', N'93 42 35 69')
INSERT [dbo].[ResultOfDay] ([Date], [DB], [NHAT], [NHI], [BA], [TU], [NAM], [SAU], [BAY]) VALUES (CAST(N'2023-01-28' AS Date), N'87219', N'88795', N'61887 71870', N'36399 99176 44895  48144 89665 83781', N'1226 3681 3051 3591', N'1368 8512 0613  9140 8974 7483', N'313 104 436', N'30 87 80 75')
INSERT [dbo].[ResultOfDay] ([Date], [DB], [NHAT], [NHI], [BA], [TU], [NAM], [SAU], [BAY]) VALUES (CAST(N'2023-01-29' AS Date), N'76479', N'25766', N'72194 11034', N'40098 29006 40715  61584 39911 24856', N'3454 3693 5723 7638', N'5842 0789 9534  0388 1327 2320', N'134 548 571', N'35 26 48 03')
INSERT [dbo].[ResultOfDay] ([Date], [DB], [NHAT], [NHI], [BA], [TU], [NAM], [SAU], [BAY]) VALUES (CAST(N'2023-01-30' AS Date), N'16179', N'12198', N'66824 97525', N'76829 01458 00678  04710 93846 11457', N'3440 5637 9612 9495', N'2099 6964 0572  7189 8620 3391', N'901 919 624', N'96 65 03 70')
INSERT [dbo].[ResultOfDay] ([Date], [DB], [NHAT], [NHI], [BA], [TU], [NAM], [SAU], [BAY]) VALUES (CAST(N'2023-01-31' AS Date), N'30061', N'21284', N'95201 18959', N'39371 85823 24941  22036 22477 18709', N'1081 8622 3216 0868', N'8908 5675 3757  0290 6421 3461', N'940 315 055', N'07 15 20 49')
INSERT [dbo].[ResultOfDay] ([Date], [DB], [NHAT], [NHI], [BA], [TU], [NAM], [SAU], [BAY]) VALUES (CAST(N'2023-02-01' AS Date), N'34838', N'29989', N'64285 65938', N'54835 94648 82384  40292 70918 01062', N'8441 1468 0916 5129', N'6463 5037 7184  2312 3165 6247', N'042 076 709', N'74 54 61 06')
INSERT [dbo].[ResultOfDay] ([Date], [DB], [NHAT], [NHI], [BA], [TU], [NAM], [SAU], [BAY]) VALUES (CAST(N'2023-02-02' AS Date), N'60755', N'35682', N'29934 63527', N'36869 93254 18961  79187 66574 51138', N'9942 3708 0879 3794', N'1300 9770 4034  6902 1730 9819', N'104 606 619', N'51 19 90 89')
INSERT [dbo].[ResultOfDay] ([Date], [DB], [NHAT], [NHI], [BA], [TU], [NAM], [SAU], [BAY]) VALUES (CAST(N'2023-02-03' AS Date), N'52766', N'79512', N'12874 00591', N'19739 53846 86931  48174 75976 36988', N'9591 7194 9590 7739', N'9894 3969 3811  5153 3349 3722', N'561 446 237', N'29 67 28 25')
INSERT [dbo].[ResultOfDay] ([Date], [DB], [NHAT], [NHI], [BA], [TU], [NAM], [SAU], [BAY]) VALUES (CAST(N'2023-02-04' AS Date), N'64948', N'04674', N'16883 77334', N'12795 68347 65312  09038 86560 22314', N'2746 8474 2057 3300', N'5264 2363 1877  0033 2488 9198', N'104 622 010', N'77 06 18 96')
INSERT [dbo].[ResultOfDay] ([Date], [DB], [NHAT], [NHI], [BA], [TU], [NAM], [SAU], [BAY]) VALUES (CAST(N'2023-02-05' AS Date), N'06194', N'41299', N'35133 39473', N'40420 29343 31064  66278 59129 16617', N'7037 9260 2809 5294', N'7690 7727 6959  0095 1920 7180', N'078 772 457', N'85 74 31 79')
INSERT [dbo].[ResultOfDay] ([Date], [DB], [NHAT], [NHI], [BA], [TU], [NAM], [SAU], [BAY]) VALUES (CAST(N'2023-02-06' AS Date), N'35492', N'27386', N'77331 13534', N'61892 81361 57325  19943 52187 55210', N'2014 6409 3258 8688', N'9374 4850 8320  7814 8710 0717', N'794 635 599', N'95 56 66 19')
INSERT [dbo].[ResultOfDay] ([Date], [DB], [NHAT], [NHI], [BA], [TU], [NAM], [SAU], [BAY]) VALUES (CAST(N'2023-02-07' AS Date), N'18198', N'71786', N'90306 05645', N'57283 23864 72211  62199 57365 40880', N'4417 4196 3901 5992', N'4003 5186 5049  2861 1761 7271', N'484 465 916', N'44 04 62 23')
INSERT [dbo].[ResultOfDay] ([Date], [DB], [NHAT], [NHI], [BA], [TU], [NAM], [SAU], [BAY]) VALUES (CAST(N'2023-02-08' AS Date), N'88864', N'58679', N'99604 51365', N'11054 21296 73693  94535 33878 20697', N'9292 0342 0933 1244', N'9592 5309 4376  1230 3835 6215', N'855 584 139', N'30 21 29 83')
INSERT [dbo].[ResultOfDay] ([Date], [DB], [NHAT], [NHI], [BA], [TU], [NAM], [SAU], [BAY]) VALUES (CAST(N'2023-02-09' AS Date), N'29337', N'79795', N'56690 48887', N'92901 77395 87205  44553 84555 79916', N'8589 6897 1079 1983', N'1236 9243 7934  4534 9730 5156', N'768 840 640', N'70 52 79 13')
INSERT [dbo].[ResultOfDay] ([Date], [DB], [NHAT], [NHI], [BA], [TU], [NAM], [SAU], [BAY]) VALUES (CAST(N'2023-02-10' AS Date), N'85120', N'58592', N'53011 52879', N'59444 00995 02540  80461 30788 27247', N'5157 8803 9017 4982', N'9964 4270 1599  4834 2452 3287', N'949 516 442', N'27 17 90 53')
INSERT [dbo].[ResultOfDay] ([Date], [DB], [NHAT], [NHI], [BA], [TU], [NAM], [SAU], [BAY]) VALUES (CAST(N'2023-02-11' AS Date), N'98713', N'18834', N'17460 78706', N'74043 63680 00185  61529 94039 45565', N'5543 1288 4007 4955', N'4040 0319 4862  5733 5162 8364', N'413 063 891', N'23 31 13 97')
INSERT [dbo].[ResultOfDay] ([Date], [DB], [NHAT], [NHI], [BA], [TU], [NAM], [SAU], [BAY]) VALUES (CAST(N'2023-02-12' AS Date), N'09841', N'45011', N'90809 72174', N'65283 75479 49179  37768 19980 20304', N'4317 8272 6686 8254', N'6216 2610 5272  7590 2067 7968', N'343 444 603', N'63 42 35 13')
INSERT [dbo].[ResultOfDay] ([Date], [DB], [NHAT], [NHI], [BA], [TU], [NAM], [SAU], [BAY]) VALUES (CAST(N'2023-02-13' AS Date), N'41916', N'08972', N'85731 59090', N'50333 10120 60151  67796 77837 14004', N'5708 6514 3119 3663', N'8008 1585 9460  8815 2619 0262', N'399 117 238', N'68 35 88 42')
INSERT [dbo].[ResultOfDay] ([Date], [DB], [NHAT], [NHI], [BA], [TU], [NAM], [SAU], [BAY]) VALUES (CAST(N'2023-02-14' AS Date), N'56141', N'73625', N'25591 26545', N'43417 13466 52501  00282 67148 52621', N'1613 9227 6862 9953', N'1582 1540 1568  5044 1304 2096', N'393 022 137', N'20 77 38 84')
INSERT [dbo].[ResultOfDay] ([Date], [DB], [NHAT], [NHI], [BA], [TU], [NAM], [SAU], [BAY]) VALUES (CAST(N'2023-02-15' AS Date), N'18158', N'68823', N'10621 87113', N'17280 05916 19414  79186 37611 59188', N'2841 8684 8318 5422', N'5366 0272 6247  2854 1045 5904', N'602 224 508', N'54 75 72 82')
INSERT [dbo].[ResultOfDay] ([Date], [DB], [NHAT], [NHI], [BA], [TU], [NAM], [SAU], [BAY]) VALUES (CAST(N'2023-02-16' AS Date), N'65243', N'02602', N'54187 54495', N'32956 53662 44891  90653 50511 74438', N'4653 4708 1539 8014', N'1805 6536 6568  2574 6732 4978', N'412 364 314', N'89 40 34 86')
INSERT [dbo].[ResultOfDay] ([Date], [DB], [NHAT], [NHI], [BA], [TU], [NAM], [SAU], [BAY]) VALUES (CAST(N'2023-02-17' AS Date), N'18435', N'11438', N'32855 13679', N'33342 76501 51568  92950 08510 60849', N'6599 0115 7637 7339', N'2498 6010 1656  5415 9788 4332', N'870 135 891', N'56 02 40 94')
INSERT [dbo].[ResultOfDay] ([Date], [DB], [NHAT], [NHI], [BA], [TU], [NAM], [SAU], [BAY]) VALUES (CAST(N'2023-02-18' AS Date), N'44971', N'76196', N'80204 83379', N'30910 56929 01406  78478 45245 15333', N'8607 9371 4039 2793', N'9602 4194 2098  5358 0609 0472', N'235 816 121', N'16 78 46 36')
INSERT [dbo].[ResultOfDay] ([Date], [DB], [NHAT], [NHI], [BA], [TU], [NAM], [SAU], [BAY]) VALUES (CAST(N'2023-02-19' AS Date), N'37264', N'91013', N'12898 74782', N'55545 21772 22607  84687 82142 07279', N'0761 3614 1563 8265', N'1344 6462 7435  1453 9110 8165', N'070 804 075', N'54 04 48 50')
INSERT [dbo].[ResultOfDay] ([Date], [DB], [NHAT], [NHI], [BA], [TU], [NAM], [SAU], [BAY]) VALUES (CAST(N'2023-02-20' AS Date), N'32775', N'01606', N'41854 66216', N'47885 14847 59176  85638 87409 86316', N'2432 6816 7273 9680', N'7248 6558 9717  9849 7663 2831', N'465 167 833', N'96 41 42 68')
INSERT [dbo].[ResultOfDay] ([Date], [DB], [NHAT], [NHI], [BA], [TU], [NAM], [SAU], [BAY]) VALUES (CAST(N'2023-02-21' AS Date), N'90781', N'00175', N'20889 90010', N'74017 54086 56167  99808 87482 43934', N'7062 0786 7592 5032', N'6017 3910 1657  0147 3943 0060', N'762 116 835', N'08 74 82 10')
INSERT [dbo].[ResultOfDay] ([Date], [DB], [NHAT], [NHI], [BA], [TU], [NAM], [SAU], [BAY]) VALUES (CAST(N'2023-02-22' AS Date), N'31357', N'31928', N'42898 40056', N'16601 78810 23130  09552 34978 72962', N'3230 0744 3062 2117', N'7711 5851 9109  5799 4779 0060', N'956 699 903', N'80 87 44 09')
INSERT [dbo].[ResultOfDay] ([Date], [DB], [NHAT], [NHI], [BA], [TU], [NAM], [SAU], [BAY]) VALUES (CAST(N'2023-02-23' AS Date), N'01964', N'74969', N'79479 90535', N'34518 53590 67179  35306 03818 38858', N'4855 9854 4747 8734', N'8282 4549 6537  4132 6678 8510', N'438 805 490', N'03 93 82 56')
INSERT [dbo].[ResultOfDay] ([Date], [DB], [NHAT], [NHI], [BA], [TU], [NAM], [SAU], [BAY]) VALUES (CAST(N'2023-02-24' AS Date), N'16979', N'09730', N'04515 27241', N'78758 04867 57566  51462 35054 16394', N'7083 8093 5365 1899', N'6917 9385 2795  5652 6575 5825', N'711 030 488', N'85 36 70 51')
GO
INSERT [dbo].[ResultOfDay] ([Date], [DB], [NHAT], [NHI], [BA], [TU], [NAM], [SAU], [BAY]) VALUES (CAST(N'2023-02-25' AS Date), N'30415', N'46223', N'32874 26964', N'77894 62144 22240  74314 60521 44090', N'0570 3424 1563 1970', N'3127 3664 5294  2775 0415 2860', N'967 705 404', N'68 40 91 77')
INSERT [dbo].[ResultOfDay] ([Date], [DB], [NHAT], [NHI], [BA], [TU], [NAM], [SAU], [BAY]) VALUES (CAST(N'2023-02-26' AS Date), N'67360', N'84040', N'06293 78613', N'24044 91197 69571  29604 00428 26260', N'4048 4141 7341 5700', N'7841 6441 1365  9604 4719 8308', N'797 374 706', N'41 71 90 63')
INSERT [dbo].[ResultOfDay] ([Date], [DB], [NHAT], [NHI], [BA], [TU], [NAM], [SAU], [BAY]) VALUES (CAST(N'2023-02-27' AS Date), N'93758', N'96434', N'10620 41971', N'97839 24382 48220  49467 28419 70861', N'7454 7809 8678 2897', N'0499 1466 2069  6655 0134 2993', N'915 894 598', N'24 00 65 16')
INSERT [dbo].[ResultOfDay] ([Date], [DB], [NHAT], [NHI], [BA], [TU], [NAM], [SAU], [BAY]) VALUES (CAST(N'2023-02-28' AS Date), N'55827', N'39977', N'20715 42892', N'88546 49558 01604  22589 44324 77100', N'5489 2390 8889 5750', N'3004 7160 0142  9604 4288 9465', N'590 700 105', N'36 60 58 11')
INSERT [dbo].[ResultOfDay] ([Date], [DB], [NHAT], [NHI], [BA], [TU], [NAM], [SAU], [BAY]) VALUES (CAST(N'2023-03-01' AS Date), N'76102', N'46493', N'52752 89477', N'83438 34418 05049  52159 74896 83492', N'9964 8534 9975 6493', N'0642 3097 7803  9391 3691 6359', N'750 265 946', N'55 92 70 12')
INSERT [dbo].[ResultOfDay] ([Date], [DB], [NHAT], [NHI], [BA], [TU], [NAM], [SAU], [BAY]) VALUES (CAST(N'2023-03-02' AS Date), N'47577', N'75833', N'93046 49671', N'61491 30540 32869  72026 84983 98857', N'5202 9315 8696 9581', N'1327 4598 9534  6720 2435 3282', N'854 189 175', N'09 96 23 53')
INSERT [dbo].[ResultOfDay] ([Date], [DB], [NHAT], [NHI], [BA], [TU], [NAM], [SAU], [BAY]) VALUES (CAST(N'2023-03-03' AS Date), N'37856', N'94473', N'55952 43597', N'50852 71048 33458  28076 63553 28692', N'7866 1039 5557 2822', N'9848 2486 5307  9392 0905 1663', N'768 839 057', N'53 35 77 97')
INSERT [dbo].[ResultOfDay] ([Date], [DB], [NHAT], [NHI], [BA], [TU], [NAM], [SAU], [BAY]) VALUES (CAST(N'2023-03-04' AS Date), N'06743', N'89246', N'53202 56726', N'17865 78228 68740  25838 07187 80970', N'6109 2529 0747 1139', N'8653 2345 9186  3799 9284 2745', N'717 825 425', N'96 47 10 23')
INSERT [dbo].[ResultOfDay] ([Date], [DB], [NHAT], [NHI], [BA], [TU], [NAM], [SAU], [BAY]) VALUES (CAST(N'2023-03-05' AS Date), N'58118', N'72226', N'98850 15773', N'71749 51632 31209  50187 40158 45441', N'5688 2460 5843 0309', N'4886 9358 5870  7416 4769 2711', N'963 478 989', N'55 01 37 62')
INSERT [dbo].[ResultOfDay] ([Date], [DB], [NHAT], [NHI], [BA], [TU], [NAM], [SAU], [BAY]) VALUES (CAST(N'2023-03-06' AS Date), N'39919', N'34271', N'89252 08794', N'57917 23934 04144  22358 90155 00374', N'7287 6916 3685 6225', N'7565 8826 2483  8057 3671 8416', N'746 208 679', N'47 73 97 23')
INSERT [dbo].[ResultOfDay] ([Date], [DB], [NHAT], [NHI], [BA], [TU], [NAM], [SAU], [BAY]) VALUES (CAST(N'2023-03-07' AS Date), N'75877', N'08692', N'87361 31241', N'06055 87073 97510  52584 52539 03248', N'9565 5285 8430 3314', N'4666 6378 7540  2000 6823 1143', N'444 841 655', N'00 04 38 45')
INSERT [dbo].[ResultOfDay] ([Date], [DB], [NHAT], [NHI], [BA], [TU], [NAM], [SAU], [BAY]) VALUES (CAST(N'2023-03-08' AS Date), N'73787', N'06261', N'48267 37696', N'25011 20381 31012  72359 95514 05128', N'8426 8924 7256 4224', N'9581 4713 2690  3000 8935 3073', N'905 189 094', N'81 62 59 02')
INSERT [dbo].[ResultOfDay] ([Date], [DB], [NHAT], [NHI], [BA], [TU], [NAM], [SAU], [BAY]) VALUES (CAST(N'2023-03-09' AS Date), N'68205', N'60388', N'32503 77792', N'69127 59764 69821  57609 39073 81374', N'5421 3336 3075 0339', N'0433 8377 5578  0355 0713 1038', N'147 834 427', N'51 56 78 37')
INSERT [dbo].[ResultOfDay] ([Date], [DB], [NHAT], [NHI], [BA], [TU], [NAM], [SAU], [BAY]) VALUES (CAST(N'2023-03-10' AS Date), N'24420', N'64647', N'92456 73117', N'43430 17679 18857  58788 06086 56612', N'6449 3646 0895 3184', N'9301 4549 8069  7225 3674 8235', N'810 645 849', N'97 07 58 81')
INSERT [dbo].[ResultOfDay] ([Date], [DB], [NHAT], [NHI], [BA], [TU], [NAM], [SAU], [BAY]) VALUES (CAST(N'2023-03-11' AS Date), N'47076', N'91911', N'68062 89887', N'97745 08606 90078  48492 59226 23122', N'1723 6001 7707 8139', N'9794 4226 2120  7005 9711 9405', N'880 643 489', N'08 68 94 48')
INSERT [dbo].[ResultOfDay] ([Date], [DB], [NHAT], [NHI], [BA], [TU], [NAM], [SAU], [BAY]) VALUES (CAST(N'2023-03-12' AS Date), N'56695', N'14685', N'86290 10847', N'34708 21368 14720  47299 88746 86664', N'7445 4972 3960 2366', N'5485 6833 4077  3698 4339 1046', N'108 993 097', N'03 96 19 08')
INSERT [dbo].[ResultOfDay] ([Date], [DB], [NHAT], [NHI], [BA], [TU], [NAM], [SAU], [BAY]) VALUES (CAST(N'2023-03-13' AS Date), N'17375', N'14288', N'47795 89010', N'20929 26532 57195  21787 86420 48111', N'6956 1055 0805 3323', N'1072 2589 1620  1450 8125 7411', N'103 269 494', N'80 74 83 51')
INSERT [dbo].[ResultOfDay] ([Date], [DB], [NHAT], [NHI], [BA], [TU], [NAM], [SAU], [BAY]) VALUES (CAST(N'2023-03-14' AS Date), N'67879', N'07811', N'56885 61063', N'64605 02010 94533  29538 20174 81544', N'7935 8490 0920 4677', N'6660 0349 9239  4622 5526 4141', N'561 858 133', N'76 78 40 09')
INSERT [dbo].[ResultOfDay] ([Date], [DB], [NHAT], [NHI], [BA], [TU], [NAM], [SAU], [BAY]) VALUES (CAST(N'2023-03-15' AS Date), N'67724', N'09458', N'42912 82249', N'32675 58785 80854  22192 66944 59826', N'3763 1746 8274 9210', N'9558 7603 8738  9949 1521 8486', N'600 528 250', N'35 83 26 41')
INSERT [dbo].[ResultOfDay] ([Date], [DB], [NHAT], [NHI], [BA], [TU], [NAM], [SAU], [BAY]) VALUES (CAST(N'2023-03-16' AS Date), N'89581', N'62172', N'16250 32921', N'86507 63642 18592  40723 78206 13297', N'4218 9856 9922 8734', N'4172 2783 9801  0431 9420 0537', N'945 195 212', N'92 44 89 04')
INSERT [dbo].[ResultOfDay] ([Date], [DB], [NHAT], [NHI], [BA], [TU], [NAM], [SAU], [BAY]) VALUES (CAST(N'2023-03-17' AS Date), N'59389', N'46086', N'47967 93279', N'62875 61643 80808  17950 83001 55132', N'7669 4211 2318 6993', N'7346 4111 6778  2763 2406 4847', N'006 958 919', N'09 05 65 60')
INSERT [dbo].[ResultOfDay] ([Date], [DB], [NHAT], [NHI], [BA], [TU], [NAM], [SAU], [BAY]) VALUES (CAST(N'2023-03-18' AS Date), N'57570', N'25444', N'05260 51308', N'14099 69326 17323  52596 06495 47274', N'1522 2679 3931 2502', N'2734 6503 6147  0437 5088 0227', N'897 979 581', N'44 97 13 93')
INSERT [dbo].[ResultOfDay] ([Date], [DB], [NHAT], [NHI], [BA], [TU], [NAM], [SAU], [BAY]) VALUES (CAST(N'2023-03-19' AS Date), N'86903', N'51904', N'86833 22870', N'85621 16256 18746  84156 68556 38891', N'3826 9033 6756 8348', N'9234 5163 4061  7108 1862 5943', N'562 892 334', N'04 72 23 96')
INSERT [dbo].[ResultOfDay] ([Date], [DB], [NHAT], [NHI], [BA], [TU], [NAM], [SAU], [BAY]) VALUES (CAST(N'2023-03-20' AS Date), N'24192', N'24877', N'69360 66583', N'07529 77038 85099  32290 94963 23842', N'6979 7304 7041 4748', N'6909 5405 4710  9722 2752 1632', N'617 012 182', N'29 54 10 42')
INSERT [dbo].[ResultOfDay] ([Date], [DB], [NHAT], [NHI], [BA], [TU], [NAM], [SAU], [BAY]) VALUES (CAST(N'2023-03-21' AS Date), N'81664', N'40033', N'18931 74834', N'84351 11200 19833  22886 94162 32936', N'2426 4054 2848 1715', N'7368 9863 8037  9985 1320 5112', N'657 518 832', N'61 09 39 59')
INSERT [dbo].[ResultOfDay] ([Date], [DB], [NHAT], [NHI], [BA], [TU], [NAM], [SAU], [BAY]) VALUES (CAST(N'2023-03-22' AS Date), N'08798', N'75337', N'28963 26229', N'39544 19950 42567  81097 15774 11622', N'1142 2860 5468 4869', N'8457 1226 2904  5946 4619 0294', N'613 479 357', N'16 56 29 44')
INSERT [dbo].[ResultOfDay] ([Date], [DB], [NHAT], [NHI], [BA], [TU], [NAM], [SAU], [BAY]) VALUES (CAST(N'2023-03-23' AS Date), N'45483', N'75836', N'51256 95469', N'48390 14974 09605  98957 76070 37554', N'0178 8464 7318 4497', N'4361 8794 1660  2984 2372 1407', N'191 984 646', N'46 34 28 91')
INSERT [dbo].[ResultOfDay] ([Date], [DB], [NHAT], [NHI], [BA], [TU], [NAM], [SAU], [BAY]) VALUES (CAST(N'2023-03-24' AS Date), N'48657', N'92279', N'26169 82385', N'98841 13954 79256  94604 99283 70785', N'1952 2895 1644 0040', N'0056 2149 4349  9152 6702 9706', N'946 859 135', N'72 04 96 01')
INSERT [dbo].[ResultOfDay] ([Date], [DB], [NHAT], [NHI], [BA], [TU], [NAM], [SAU], [BAY]) VALUES (CAST(N'2023-03-25' AS Date), N'32273', N'26774', N'47449 00099', N'42018 44879 34758  02573 53468 78759', N'1143 4584 9372 9795', N'3750 9885 2890  9364 0917 2156', N'114 430 214', N'74 22 98 97')
INSERT [dbo].[ResultOfDay] ([Date], [DB], [NHAT], [NHI], [BA], [TU], [NAM], [SAU], [BAY]) VALUES (CAST(N'2023-03-26' AS Date), N'57765', N'81664', N'81817 24222', N'29370 84409 04923  57889 07071 93934', N'4102 2973 6263 6666', N'8566 3378 2688  1310 3160 6446', N'895 560 344', N'30 52 63 13')
INSERT [dbo].[ResultOfDay] ([Date], [DB], [NHAT], [NHI], [BA], [TU], [NAM], [SAU], [BAY]) VALUES (CAST(N'2023-03-27' AS Date), N'83230', N'27431', N'64284 25717', N'00542 39074 03807  48505 81972 52585', N'3688 5158 4819 5996', N'1953 7838 0600  4430 1433 9408', N'989 736 316', N'91 85 30 55')
INSERT [dbo].[ResultOfDay] ([Date], [DB], [NHAT], [NHI], [BA], [TU], [NAM], [SAU], [BAY]) VALUES (CAST(N'2023-03-28' AS Date), N'66228', N'20468', N'52302 81938', N'80052 98632 60778  43904 23666 29291', N'9299 7599 3882 4937', N'8481 5974 4117  4744 3181 7043', N'520 126 567', N'30 22 92 01')
INSERT [dbo].[ResultOfDay] ([Date], [DB], [NHAT], [NHI], [BA], [TU], [NAM], [SAU], [BAY]) VALUES (CAST(N'2023-03-29' AS Date), N'86367', N'69313', N'57644 99117', N'57068 01410 71666  59756 37373 20474', N'6395 5291 5632 3556', N'2533 5880 4616  8998 7741 1916', N'961 316 203', N'60 85 39 71')
INSERT [dbo].[ResultOfDay] ([Date], [DB], [NHAT], [NHI], [BA], [TU], [NAM], [SAU], [BAY]) VALUES (CAST(N'2023-03-30' AS Date), N'11504', N'13132', N'43820 11937', N'91023 02686 33623  25816 44645 58918', N'9812 8664 1685 4375', N'6194 6939 9829  3640 4213 8870', N'374 236 642', N'17 95 41 89')
INSERT [dbo].[ResultOfDay] ([Date], [DB], [NHAT], [NHI], [BA], [TU], [NAM], [SAU], [BAY]) VALUES (CAST(N'2023-03-31' AS Date), N'59381', N'50062', N'41803 74247', N'29789 25048 78541  21351 15625 53386', N'8847 1248 2881 7647', N'3187 0628 3153  7468 8667 7883', N'834 295 592', N'42 08 22 16')
INSERT [dbo].[ResultOfDay] ([Date], [DB], [NHAT], [NHI], [BA], [TU], [NAM], [SAU], [BAY]) VALUES (CAST(N'2023-04-01' AS Date), N'70344', N'29158', N'24102 22255', N'23385 08995 78861  88142 93756 42929', N'0962 4828 0948 7865', N'5076 2309 1465  4650 5070 1375', N'549 093 772', N'09 18 34 91')
INSERT [dbo].[ResultOfDay] ([Date], [DB], [NHAT], [NHI], [BA], [TU], [NAM], [SAU], [BAY]) VALUES (CAST(N'2023-04-02' AS Date), N'01844', N'86587', N'43090 21057', N'57039 85367 50887  42799 15519 33621', N'2573 5217 1536 8939', N'2106 7124 5477  8497 6140 1356', N'057 954 095', N'96 07 70 77')
INSERT [dbo].[ResultOfDay] ([Date], [DB], [NHAT], [NHI], [BA], [TU], [NAM], [SAU], [BAY]) VALUES (CAST(N'2023-04-03' AS Date), N'52333', N'60129', N'20276 16945', N'79852 81184 82950  55742 41809 54881', N'7123 3025 2171 9384', N'5032 6746 5678  8084 0969 7357', N'116 932 199', N'65 89 71 53')
INSERT [dbo].[ResultOfDay] ([Date], [DB], [NHAT], [NHI], [BA], [TU], [NAM], [SAU], [BAY]) VALUES (CAST(N'2023-04-04' AS Date), N'75345', N'58033', N'53624 14990', N'65024 54180 48496  98824 68882 50488', N'1050 3793 9904 2976', N'6534 1659 3601  3421 3084 1283', N'615 045 950', N'44 38 59 88')
INSERT [dbo].[ResultOfDay] ([Date], [DB], [NHAT], [NHI], [BA], [TU], [NAM], [SAU], [BAY]) VALUES (CAST(N'2023-04-05' AS Date), N'96226', N'95972', N'01247 51881', N'41676 08715 40559  11220 01149 96249', N'4359 4886 1952 1114', N'6014 5500 7559  6213 7458 8014', N'379 127 366', N'85 26 25 55')
INSERT [dbo].[ResultOfDay] ([Date], [DB], [NHAT], [NHI], [BA], [TU], [NAM], [SAU], [BAY]) VALUES (CAST(N'2023-04-06' AS Date), N'89911', N'05742', N'50512 78149', N'88171 00910 17405  26389 88291 99363', N'7605 2631 8658 7044', N'8351 4521 5193  7433 2793 6406', N'436 412 634', N'60 25 68 65')
INSERT [dbo].[ResultOfDay] ([Date], [DB], [NHAT], [NHI], [BA], [TU], [NAM], [SAU], [BAY]) VALUES (CAST(N'2023-04-07' AS Date), N'49736', N'58224', N'65556 14147', N'58150 72738 43810  30812 33149 13629', N'8908 1830 7439 0764', N'6547 1958 9971  7786 2569 4304', N'463 465 406', N'00 44 72 22')
INSERT [dbo].[ResultOfDay] ([Date], [DB], [NHAT], [NHI], [BA], [TU], [NAM], [SAU], [BAY]) VALUES (CAST(N'2023-04-08' AS Date), N'29815', N'36073', N'85333 58920', N'97433 78280 03170  06858 88255 88818', N'2712 0016 1596 5386', N'0744 4503 9287  3859 3643 8366', N'075 849 001', N'12 54 73 22')
INSERT [dbo].[ResultOfDay] ([Date], [DB], [NHAT], [NHI], [BA], [TU], [NAM], [SAU], [BAY]) VALUES (CAST(N'2023-04-09' AS Date), N'10026', N'76693', N'66574 62714', N'54568 53998 95807  03990 50571 84713', N'1316 0902 7909 3442', N'3716 6641 4419  8431 3158 0433', N'469 923 443', N'02 73 58 12')
INSERT [dbo].[ResultOfDay] ([Date], [DB], [NHAT], [NHI], [BA], [TU], [NAM], [SAU], [BAY]) VALUES (CAST(N'2023-04-10' AS Date), N'06363', N'75304', N'29505 25800', N'33432 51472 46580  24161 76595 98352', N'7743 7403 1859 9221', N'3187 2855 8646  8584 0256 8458', N'352 139 219', N'13 54 34 96')
INSERT [dbo].[ResultOfDay] ([Date], [DB], [NHAT], [NHI], [BA], [TU], [NAM], [SAU], [BAY]) VALUES (CAST(N'2023-04-11' AS Date), N'16039', N'40045', N'88796 43516', N'95785 28723 74468  18671 71440 99436', N'8150 0958 7169 4771', N'1017 5415 7626  9898 1360 9496', N'489 632 860', N'22 64 26 84')
INSERT [dbo].[ResultOfDay] ([Date], [DB], [NHAT], [NHI], [BA], [TU], [NAM], [SAU], [BAY]) VALUES (CAST(N'2023-04-12' AS Date), N'37195', N'88982', N'91410 39454', N'68319 52423 13233  68277 21169 30216', N'0142 3462 5629 2596', N'5756 9121 6244  8253 6810 3857', N'309 404 166', N'97 54 39 28')
INSERT [dbo].[ResultOfDay] ([Date], [DB], [NHAT], [NHI], [BA], [TU], [NAM], [SAU], [BAY]) VALUES (CAST(N'2023-04-13' AS Date), N'44265', N'59509', N'68989 53011', N'99466 91198 56803  55404 06860 51761', N'5199 2649 9460 1408', N'5496 4857 9907  3867 9046 6692', N'919 860 899', N'63 35 38 12')
INSERT [dbo].[ResultOfDay] ([Date], [DB], [NHAT], [NHI], [BA], [TU], [NAM], [SAU], [BAY]) VALUES (CAST(N'2023-04-14' AS Date), N'57534', N'88770', N'05720 91578', N'03717 48451 94184  89449 05832 56081', N'4943 4300 4803 7938', N'2632 1938 4351  0270 7609 7302', N'029 457 562', N'88 23 60 79')
INSERT [dbo].[ResultOfDay] ([Date], [DB], [NHAT], [NHI], [BA], [TU], [NAM], [SAU], [BAY]) VALUES (CAST(N'2023-04-15' AS Date), N'27414', N'11010', N'41330 97277', N'74505 02583 25729  18319 80920 81572', N'1080 8991 4942 4123', N'9035 2575 9988  6255 7699 0135', N'777 921 304', N'11 53 81 27')
INSERT [dbo].[ResultOfDay] ([Date], [DB], [NHAT], [NHI], [BA], [TU], [NAM], [SAU], [BAY]) VALUES (CAST(N'2023-04-16' AS Date), N'41248', N'17827', N'73986 79480', N'41224 34610 25369  86403 80143 57669', N'1141 3622 2677 0520', N'1337 5356 2412  7235 8435 2100', N'803 944 321', N'26 28 70 72')
INSERT [dbo].[ResultOfDay] ([Date], [DB], [NHAT], [NHI], [BA], [TU], [NAM], [SAU], [BAY]) VALUES (CAST(N'2023-04-17' AS Date), N'65576', N'21834', N'98341 78733', N'68199 77368 98075  59580 47734 63176', N'9274 4850 5518 3111', N'7707 0739 1301  8058 5604 4191', N'013 523 323', N'07 12 63 92')
INSERT [dbo].[ResultOfDay] ([Date], [DB], [NHAT], [NHI], [BA], [TU], [NAM], [SAU], [BAY]) VALUES (CAST(N'2023-04-18' AS Date), N'71661', N'24615', N'03759 25581', N'31440 21532 47030  21563 46633 13680', N'4825 2001 6675 0958', N'9186 8717 4444  3440 5927 7853', N'474 516 418', N'02 44 69 34')
INSERT [dbo].[ResultOfDay] ([Date], [DB], [NHAT], [NHI], [BA], [TU], [NAM], [SAU], [BAY]) VALUES (CAST(N'2023-04-19' AS Date), N'46285', N'47600', N'89103 41915', N'35857 82917 07914  80475 55113 18084', N'6314 7550 9636 4717', N'9880 7949 0301  6813 5152 5895', N'877 990 348', N'99 88 52 04')
INSERT [dbo].[ResultOfDay] ([Date], [DB], [NHAT], [NHI], [BA], [TU], [NAM], [SAU], [BAY]) VALUES (CAST(N'2023-04-20' AS Date), N'24623', N'35847', N'45787 01860', N'60014 43972 03011  92939 16867 88829', N'9147 8938 7278 4241', N'5191 7286 3721  1848 9359 8717', N'331 135 823', N'00 46 30 93')
INSERT [dbo].[ResultOfDay] ([Date], [DB], [NHAT], [NHI], [BA], [TU], [NAM], [SAU], [BAY]) VALUES (CAST(N'2023-04-21' AS Date), N'47914', N'60797', N'59717 14501', N'34329 85460 96221  89853 40346 68305', N'3448 1189 9419 1707', N'4739 7719 4691  4875 9253 2716', N'562 636 836', N'94 07 65 97')
INSERT [dbo].[ResultOfDay] ([Date], [DB], [NHAT], [NHI], [BA], [TU], [NAM], [SAU], [BAY]) VALUES (CAST(N'2023-04-22' AS Date), N'64652', N'14539', N'92652 95297', N'95663 75831 78042  71169 20553 16952', N'1443 5271 6924 9301', N'1177 8032 9908  2351 6303 1361', N'261 724 234', N'23 97 41 22')
INSERT [dbo].[ResultOfDay] ([Date], [DB], [NHAT], [NHI], [BA], [TU], [NAM], [SAU], [BAY]) VALUES (CAST(N'2023-04-23' AS Date), N'71679', N'11948', N'89314 26195', N'31992 01338 97876  72042 28863 33582', N'6431 1496 3962 2888', N'4428 9325 3137  9739 8915 0551', N'388 551 461', N'06 16 53 35')
INSERT [dbo].[ResultOfDay] ([Date], [DB], [NHAT], [NHI], [BA], [TU], [NAM], [SAU], [BAY]) VALUES (CAST(N'2023-04-24' AS Date), N'42105', N'06909', N'54521 44002', N'05311 76581 98146  75329 02653 37386', N'8315 2375 1673 0403', N'2683 9581 3630  3726 0379 1451', N'347 874 370', N'48 86 10 63')
INSERT [dbo].[ResultOfDay] ([Date], [DB], [NHAT], [NHI], [BA], [TU], [NAM], [SAU], [BAY]) VALUES (CAST(N'2023-04-25' AS Date), N'85483', N'95809', N'40929 91988', N'44027 49981 53615  12157 65973 10644', N'6550 6342 6838 1286', N'6306 7235 4898  4217 4655 9170', N'711 370 029', N'06 58 25 66')
INSERT [dbo].[ResultOfDay] ([Date], [DB], [NHAT], [NHI], [BA], [TU], [NAM], [SAU], [BAY]) VALUES (CAST(N'2023-04-26' AS Date), N'89675', N'47122', N'87741 90868', N'67189 59356 20187  85300 27642 74897', N'4117 8648 2445 1811', N'3606 9255 9511  2703 6045 1826', N'148 330 095', N'17 60 41 90')
INSERT [dbo].[ResultOfDay] ([Date], [DB], [NHAT], [NHI], [BA], [TU], [NAM], [SAU], [BAY]) VALUES (CAST(N'2023-04-27' AS Date), N'80755', N'28579', N'97673 33524', N'85938 05886 47570  39895 91973 30964', N'5084 4957 4141 7474', N'2445 9443 4893  8832 2490 7827', N'068 670 765', N'74 02 50 16')
INSERT [dbo].[ResultOfDay] ([Date], [DB], [NHAT], [NHI], [BA], [TU], [NAM], [SAU], [BAY]) VALUES (CAST(N'2023-04-28' AS Date), N'13196', N'47757', N'75260 25528', N'62526 11485 39031  20967 51864 02270', N'8012 6085 1150 4819', N'0020 6500 1331  3462 5653 8899', N'993 308 910', N'24 38 96 66')
INSERT [dbo].[ResultOfDay] ([Date], [DB], [NHAT], [NHI], [BA], [TU], [NAM], [SAU], [BAY]) VALUES (CAST(N'2023-04-29' AS Date), N'54639', N'71291', N'41698 59064', N'63882 53656 95705  24224 25635 22662', N'8260 0406 4970 2455', N'1445 6930 6352  4790 5507 1824', N'123 603 919', N'91 31 29 21')
INSERT [dbo].[ResultOfDay] ([Date], [DB], [NHAT], [NHI], [BA], [TU], [NAM], [SAU], [BAY]) VALUES (CAST(N'2023-04-30' AS Date), N'90819', N'14462', N'46938 76537', N'64883 87706 17676  03683 13446 65386', N'6589 1038 8701 2478', N'2368 5706 7865  8484 1913 5540', N'027 311 663', N'50 70 88 22')
INSERT [dbo].[ResultOfDay] ([Date], [DB], [NHAT], [NHI], [BA], [TU], [NAM], [SAU], [BAY]) VALUES (CAST(N'2023-05-01' AS Date), N'61820', N'92980', N'75547 22089', N'48152 67318 78622  65301 40398 81980', N'3658 6406 0212 2988', N'4791 9748 1765  2248 3694 0371', N'389 974 716', N'84 00 14 58')
INSERT [dbo].[ResultOfDay] ([Date], [DB], [NHAT], [NHI], [BA], [TU], [NAM], [SAU], [BAY]) VALUES (CAST(N'2023-05-02' AS Date), N'00865', N'40456', N'42008 20843', N'65177 77430 46157  48808 12760 42502', N'2066 1981 7988 5669', N'1644 6108 7298  4086 4818 6593', N'473 470 221', N'70 61 52 02')
INSERT [dbo].[ResultOfDay] ([Date], [DB], [NHAT], [NHI], [BA], [TU], [NAM], [SAU], [BAY]) VALUES (CAST(N'2023-05-03' AS Date), N'85576', N'51335', N'81665 42261', N'02390 74032 02490  49728 77920 86355', N'6100 4962 8993 4459', N'5312 8561 7613  8129 8389 1776', N'880 237 406', N'67 28 41 12')
INSERT [dbo].[ResultOfDay] ([Date], [DB], [NHAT], [NHI], [BA], [TU], [NAM], [SAU], [BAY]) VALUES (CAST(N'2023-05-04' AS Date), N'81918', N'25824', N'12136 10697', N'61949 33310 79061  22400 85742 85067', N'1177 4922 6028 9883', N'4177 1011 8968  3260 7500 7006', N'561 096 553', N'87 35 49 42')
INSERT [dbo].[ResultOfDay] ([Date], [DB], [NHAT], [NHI], [BA], [TU], [NAM], [SAU], [BAY]) VALUES (CAST(N'2023-05-05' AS Date), N'82647', N'95546', N'39378 98658', N'97994 13760 07192  61645 91254 34455', N'5511 4527 0642 4236', N'0155 7861 2259  0242 1787 5726', N'432 624 534', N'16 14 72 39')
INSERT [dbo].[ResultOfDay] ([Date], [DB], [NHAT], [NHI], [BA], [TU], [NAM], [SAU], [BAY]) VALUES (CAST(N'2023-05-06' AS Date), N'02904', N'87627', N'84022 69837', N'43316 26074 17200  07162 44168 45606', N'6611 3858 7560 8625', N'7551 8919 0927  7435 4397 8312', N'438 142 508', N'16 26 19 62')
INSERT [dbo].[ResultOfDay] ([Date], [DB], [NHAT], [NHI], [BA], [TU], [NAM], [SAU], [BAY]) VALUES (CAST(N'2023-05-07' AS Date), N'88060', N'04143', N'28610 84265', N'13198 37540 14699  88940 74267 27235', N'3713 8736 2531 9024', N'3384 1936 9737  4003 8660 1216', N'887 368 121', N'95 86 64 42')
INSERT [dbo].[ResultOfDay] ([Date], [DB], [NHAT], [NHI], [BA], [TU], [NAM], [SAU], [BAY]) VALUES (CAST(N'2023-05-08' AS Date), N'44481', N'08861', N'02832 00516', N'79797 97171 25884  01962 05448 08284', N'6836 5645 2536 8583', N'3262 5900 6671  7555 0793 2640', N'441 909 144', N'21 92 26 62')
INSERT [dbo].[ResultOfDay] ([Date], [DB], [NHAT], [NHI], [BA], [TU], [NAM], [SAU], [BAY]) VALUES (CAST(N'2023-05-09' AS Date), N'58546', N'87138', N'70752 46168', N'96208 31488 86067  22183 37859 54970', N'5523 1471 7978 9994', N'2767 1142 9742  9327 1226 7965', N'921 554 160', N'30 25 64 14')
INSERT [dbo].[ResultOfDay] ([Date], [DB], [NHAT], [NHI], [BA], [TU], [NAM], [SAU], [BAY]) VALUES (CAST(N'2023-05-10' AS Date), N'97996', N'66184', N'81579 19025', N'25267 82002 34364  80746 09850 02979', N'5509 2451 3535 0484', N'9156 1859 0249  6927 7902 2659', N'556 891 491', N'05 43 19 84')
INSERT [dbo].[ResultOfDay] ([Date], [DB], [NHAT], [NHI], [BA], [TU], [NAM], [SAU], [BAY]) VALUES (CAST(N'2023-05-11' AS Date), N'63134', N'66488', N'83106 50659', N'64327 85253 06416  70969 92174 48990', N'8984 4436 1466 5849', N'8638 1964 7075  3741 1240 4458', N'860 897 971', N'55 78 73 80')
INSERT [dbo].[ResultOfDay] ([Date], [DB], [NHAT], [NHI], [BA], [TU], [NAM], [SAU], [BAY]) VALUES (CAST(N'2023-05-12' AS Date), N'84102', N'12141', N'03914 59392', N'89476 73718 53418  26470 04401 87540', N'9810 7384 5603 4657', N'1245 1444 2197  7581 5850 1090', N'531 230 371', N'43 75 65 00')
INSERT [dbo].[ResultOfDay] ([Date], [DB], [NHAT], [NHI], [BA], [TU], [NAM], [SAU], [BAY]) VALUES (CAST(N'2023-05-13' AS Date), N'19949', N'70603', N'83105 86922', N'04612 77933 98947  17393 21474 09615', N'4996 8991 7581 3443', N'2415 2468 9975  7844 5836 7768', N'209 521 997', N'68 90 08 10')
INSERT [dbo].[ResultOfDay] ([Date], [DB], [NHAT], [NHI], [BA], [TU], [NAM], [SAU], [BAY]) VALUES (CAST(N'2023-05-14' AS Date), N'67753', N'19470', N'84443 50523', N'48507 10048 72799  01556 83623 77648', N'4096 6164 8307 8743', N'6036 2853 0517  5167 2679 3096', N'454 812 208', N'76 52 85 51')
INSERT [dbo].[ResultOfDay] ([Date], [DB], [NHAT], [NHI], [BA], [TU], [NAM], [SAU], [BAY]) VALUES (CAST(N'2023-05-15' AS Date), N'90956', N'63262', N'56387 17280', N'55838 87861 81301  12200 75630 88618', N'2320 0344 4038 5493', N'1853 5302 2858  0332 3887 9106', N'107 095 442', N'53 71 80 05')
INSERT [dbo].[ResultOfDay] ([Date], [DB], [NHAT], [NHI], [BA], [TU], [NAM], [SAU], [BAY]) VALUES (CAST(N'2023-05-16' AS Date), N'19031', N'78859', N'78392 19184', N'08741 22539 53479  89302 45138 93780', N'6799 1870 9094 5813', N'5658 5031 1982  9514 0651 7630', N'208 378 741', N'63 37 82 49')
INSERT [dbo].[ResultOfDay] ([Date], [DB], [NHAT], [NHI], [BA], [TU], [NAM], [SAU], [BAY]) VALUES (CAST(N'2023-05-17' AS Date), N'67949', N'88636', N'86754 64824', N'05541 89700 53672  75653 39193 12213', N'8776 3400 4612 5452', N'9839 4330 3544  6841 1618 1628', N'979 049 813', N'26 42 38 28')
INSERT [dbo].[ResultOfDay] ([Date], [DB], [NHAT], [NHI], [BA], [TU], [NAM], [SAU], [BAY]) VALUES (CAST(N'2023-05-18' AS Date), N'22632', N'63943', N'01119 19532', N'76856 89482 64227  00562 01641 85632', N'7352 8616 7828 8053', N'5572 8328 8721  7637 2872 6281', N'990 054 631', N'18 67 99 70')
INSERT [dbo].[ResultOfDay] ([Date], [DB], [NHAT], [NHI], [BA], [TU], [NAM], [SAU], [BAY]) VALUES (CAST(N'2023-05-19' AS Date), N'22317', N'14150', N'33733 51891', N'82756 21657 15856  86311 41587 54889', N'4351 1152 9815 0486', N'4906 9531 2902  2863 2086 1971', N'187 478 712', N'56 36 66 29')
INSERT [dbo].[ResultOfDay] ([Date], [DB], [NHAT], [NHI], [BA], [TU], [NAM], [SAU], [BAY]) VALUES (CAST(N'2023-05-20' AS Date), N'70452', N'64077', N'44767 24888', N'25683 81997 59483  16534 45895 15457', N'0445 1674 9879 7857', N'1901 4137 7930  4334 1079 9162', N'956 370 377', N'99 33 04 27')
INSERT [dbo].[ResultOfDay] ([Date], [DB], [NHAT], [NHI], [BA], [TU], [NAM], [SAU], [BAY]) VALUES (CAST(N'2023-05-21' AS Date), N'45297', N'72064', N'86140 42405', N'12766 10977 02349  28754 38605 04496', N'2441 4197 6793 6975', N'2742 8421 5142  4290 9043 7521', N'733 013 729', N'39 70 76 50')
INSERT [dbo].[ResultOfDay] ([Date], [DB], [NHAT], [NHI], [BA], [TU], [NAM], [SAU], [BAY]) VALUES (CAST(N'2023-05-22' AS Date), N'32754', N'68161', N'72017 98904', N'94697 94740 93753  55459 01414 23607', N'5492 5227 1493 2338', N'9643 0709 9863  5784 8757 8109', N'890 019 282', N'50 34 15 65')
INSERT [dbo].[ResultOfDay] ([Date], [DB], [NHAT], [NHI], [BA], [TU], [NAM], [SAU], [BAY]) VALUES (CAST(N'2023-05-23' AS Date), N'95972', N'02366', N'43590 56621', N'19195 14216 52782  53347 92819 99789', N'0740 6907 5957 8967', N'4851 8691 5830  7301 6230 3908', N'882 890 258', N'61 27 17 44')
INSERT [dbo].[ResultOfDay] ([Date], [DB], [NHAT], [NHI], [BA], [TU], [NAM], [SAU], [BAY]) VALUES (CAST(N'2023-05-24' AS Date), N'19966', N'59476', N'65345 58041', N'20304 95694 17344  72216 32696 67352', N'1785 1474 3062 2264', N'5454 4067 9087  2101 9117 9472', N'073 840 164', N'80 87 95 63')
INSERT [dbo].[ResultOfDay] ([Date], [DB], [NHAT], [NHI], [BA], [TU], [NAM], [SAU], [BAY]) VALUES (CAST(N'2023-05-25' AS Date), N'20319', N'70232', N'29500 71249', N'16884 99881 28251  71786 97777 82108', N'7537 2802 9443 3856', N'2521 5532 2000  7987 9291 0000', N'369 815 984', N'67 74 96 89')
INSERT [dbo].[ResultOfDay] ([Date], [DB], [NHAT], [NHI], [BA], [TU], [NAM], [SAU], [BAY]) VALUES (CAST(N'2023-05-26' AS Date), N'36191', N'12247', N'74125 55916', N'50939 18172 11720  73339 73686 22536', N'1413 7656 2151 9010', N'3208 7195 4948  3210 9463 0955', N'188 203 342', N'53 31 11 03')
INSERT [dbo].[ResultOfDay] ([Date], [DB], [NHAT], [NHI], [BA], [TU], [NAM], [SAU], [BAY]) VALUES (CAST(N'2023-05-27' AS Date), N'96237', N'71344', N'42533 09954', N'96746 15579 95688  52419 28175 26519', N'6364 8867 3211 1681', N'1698 8940 8762  7901 5425 2843', N'849 191 024', N'76 31 54 45')
INSERT [dbo].[ResultOfDay] ([Date], [DB], [NHAT], [NHI], [BA], [TU], [NAM], [SAU], [BAY]) VALUES (CAST(N'2023-05-28' AS Date), N'79459', N'32985', N'36739 28089', N'00824 84828 31874  10126 29991 97383', N'9781 9537 5387 9377', N'7327 8876 8618  0448 3320 6967', N'972 313 256', N'71 50 32 80')
INSERT [dbo].[ResultOfDay] ([Date], [DB], [NHAT], [NHI], [BA], [TU], [NAM], [SAU], [BAY]) VALUES (CAST(N'2023-05-29' AS Date), N'85867', N'98338', N'10638 56467', N'71926 87565 57336  56415 07553 67042', N'6742 1749 8665 0992', N'0594 4871 7149  8937 3123 4242', N'948 191 615', N'78 91 21 34')
INSERT [dbo].[ResultOfDay] ([Date], [DB], [NHAT], [NHI], [BA], [TU], [NAM], [SAU], [BAY]) VALUES (CAST(N'2023-05-30' AS Date), N'20765', N'15037', N'35868 93065', N'57840 39646 93650  76407 80500 27833', N'7861 9818 7371 0560', N'7185 0130 9462  2951 0104 1993', N'287 387 650', N'96 60 37 21')
INSERT [dbo].[ResultOfDay] ([Date], [DB], [NHAT], [NHI], [BA], [TU], [NAM], [SAU], [BAY]) VALUES (CAST(N'2023-05-31' AS Date), N'88961', N'40956', N'31944 49287', N'19424 05612 78426  30296 38763 87816', N'9466 8678 4184 2567', N'7313 3260 1908  1779 7508 4262', N'169 307 843', N'87 02 22 91')
INSERT [dbo].[ResultOfDay] ([Date], [DB], [NHAT], [NHI], [BA], [TU], [NAM], [SAU], [BAY]) VALUES (CAST(N'2023-06-01' AS Date), N'95921', N'60072', N'60772 42018', N'90528 85129 93364  58075 83241 77085', N'6817 1204 2635 4543', N'3317 1198 1200  4091 1777 7879', N'188 582 598', N'81 27 71 20')
INSERT [dbo].[ResultOfDay] ([Date], [DB], [NHAT], [NHI], [BA], [TU], [NAM], [SAU], [BAY]) VALUES (CAST(N'2023-06-02' AS Date), N'71963', N'03825', N'76720 67605', N'83562 75355 08354  71442 30105 41776', N'0619 8323 0185 4008', N'2134 7958 9097  7851 7373 7684', N'307 353 763', N'16 34 19 29')
INSERT [dbo].[ResultOfDay] ([Date], [DB], [NHAT], [NHI], [BA], [TU], [NAM], [SAU], [BAY]) VALUES (CAST(N'2023-06-03' AS Date), N'00370', N'78005', N'16546 35426', N'15605 56082 31226  67812 04642 88608', N'2225 9739 3893 4075', N'4130 2099 9557  8041 9044 0883', N'679 741 845', N'08 65 40 83')
INSERT [dbo].[ResultOfDay] ([Date], [DB], [NHAT], [NHI], [BA], [TU], [NAM], [SAU], [BAY]) VALUES (CAST(N'2023-06-04' AS Date), N'04408', N'98155', N'29784 89293', N'39341 14393 11089  61352 00867 38422', N'2710 2069 7376 8015', N'2800 3282 3775  0197 7450 6606', N'870 440 693', N'64 73 67 90')
GO
INSERT [dbo].[ResultOfDay] ([Date], [DB], [NHAT], [NHI], [BA], [TU], [NAM], [SAU], [BAY]) VALUES (CAST(N'2023-06-05' AS Date), N'00081', N'01905', N'71137 44821', N'88844 27295 04627  95334 72220 93683', N'7165 3883 2157 8958', N'9446 1015 2351  7270 6125 8146', N'757 450 720', N'28 92 48 79')
INSERT [dbo].[ResultOfDay] ([Date], [DB], [NHAT], [NHI], [BA], [TU], [NAM], [SAU], [BAY]) VALUES (CAST(N'2023-06-06' AS Date), N'83079', N'15731', N'32457 82498', N'53158 75486 27217  33818 63859 80647', N'3761 3762 1876 5343', N'2168 2834 1420  3322 2013 4508', N'425 236 119', N'70 90 07 34')
INSERT [dbo].[ResultOfDay] ([Date], [DB], [NHAT], [NHI], [BA], [TU], [NAM], [SAU], [BAY]) VALUES (CAST(N'2023-06-07' AS Date), N'40357', N'11456', N'44223 10852', N'46358 34034 66918  95949 25795 45788', N'9566 6046 0716 3577', N'0763 3222 6881  2226 9182 0024', N'014 056 738', N'17 72 69 82')
INSERT [dbo].[ResultOfDay] ([Date], [DB], [NHAT], [NHI], [BA], [TU], [NAM], [SAU], [BAY]) VALUES (CAST(N'2023-06-08' AS Date), N'13437', N'01318', N'28445 82535', N'71477 39624 54759  25625 23113 63826', N'4472 8981 7954 0986', N'5344 9805 4411  8024 3303 3715', N'934 777 592', N'66 88 48 31')
INSERT [dbo].[ResultOfDay] ([Date], [DB], [NHAT], [NHI], [BA], [TU], [NAM], [SAU], [BAY]) VALUES (CAST(N'2023-06-09' AS Date), N'84288', N'04963', N'74125 38700', N'73140 26876 60883  12566 74298 52888', N'0391 5921 8049 3886', N'1500 2489 8181  3870 1998 2926', N'046 845 943', N'84 68 82 38')
INSERT [dbo].[ResultOfDay] ([Date], [DB], [NHAT], [NHI], [BA], [TU], [NAM], [SAU], [BAY]) VALUES (CAST(N'2023-06-10' AS Date), N'01936', N'55702', N'21837 13114', N'08654 54284 25038  62695 93652 66007', N'8658 7816 4181 5440', N'9502 0063 9147  3150 5628 3045', N'422 133 144', N'36 39 68 88')
INSERT [dbo].[ResultOfDay] ([Date], [DB], [NHAT], [NHI], [BA], [TU], [NAM], [SAU], [BAY]) VALUES (CAST(N'2023-06-11' AS Date), N'46260', N'22720', N'81504 02173', N'16658 20643 72434  05068 21857 41825', N'1921 6654 3727 7848', N'6263 0249 2221  9684 5345 4156', N'967 239 243', N'96 57 78 64')
INSERT [dbo].[ResultOfDay] ([Date], [DB], [NHAT], [NHI], [BA], [TU], [NAM], [SAU], [BAY]) VALUES (CAST(N'2023-06-12' AS Date), N'55442', N'33251', N'65623 42048', N'68726 89403 20511  62202 52994 94397', N'1802 7934 2963 1958', N'7198 5514 8294  7181 1766 9753', N'273 439 837', N'01 39 63 68')
INSERT [dbo].[ResultOfDay] ([Date], [DB], [NHAT], [NHI], [BA], [TU], [NAM], [SAU], [BAY]) VALUES (CAST(N'2023-06-13' AS Date), N'88661', N'71607', N'94150 94670', N'11530 33641 22483  01947 54186 71865', N'1544 3281 3871 3994', N'4647 4110 6011  4773 5905 5281', N'748 272 904', N'78 73 79 05')
INSERT [dbo].[ResultOfDay] ([Date], [DB], [NHAT], [NHI], [BA], [TU], [NAM], [SAU], [BAY]) VALUES (CAST(N'2023-06-14' AS Date), N'57854', N'34686', N'27752 68091', N'15266 04005 47339  36541 59037 27890', N'5866 4320 8636 6531', N'7548 4237 7577  1608 3000 3811', N'854 832 350', N'07 48 49 06')
INSERT [dbo].[ResultOfDay] ([Date], [DB], [NHAT], [NHI], [BA], [TU], [NAM], [SAU], [BAY]) VALUES (CAST(N'2023-06-15' AS Date), N'46904', N'84800', N'98348 12229', N'53861 52351 70551  34806 70498 95789', N'6537 3633 5213 4450', N'4072 1844 5044  2857 3142 3607', N'368 359 314', N'61 63 64 41')
INSERT [dbo].[ResultOfDay] ([Date], [DB], [NHAT], [NHI], [BA], [TU], [NAM], [SAU], [BAY]) VALUES (CAST(N'2023-06-16' AS Date), N'76830', N'13239', N'15720 13993', N'81372 54796 83888  74122 95035 42408', N'5949 5284 9319 0688', N'5407 7853 4409  6202 2997 3674', N'367 132 155', N'07 66 02 01')
INSERT [dbo].[ResultOfDay] ([Date], [DB], [NHAT], [NHI], [BA], [TU], [NAM], [SAU], [BAY]) VALUES (CAST(N'2023-06-17' AS Date), N'96361', N'07849', N'66045 88316', N'39464 33119 55398  70842 49488 59270', N'1677 8485 9518 9825', N'0798 1303 0406  0674 5295 0845', N'468 316 379', N'52 87 61 01')
INSERT [dbo].[ResultOfDay] ([Date], [DB], [NHAT], [NHI], [BA], [TU], [NAM], [SAU], [BAY]) VALUES (CAST(N'2023-06-18' AS Date), N'94351', N'86452', N'40375 70701', N'16826 73799 20523  29253 46513 59983', N'8752 1003 1258 0694', N'4692 6076 1357  2315 0639 0106', N'792 419 788', N'99 72 27 42')
INSERT [dbo].[ResultOfDay] ([Date], [DB], [NHAT], [NHI], [BA], [TU], [NAM], [SAU], [BAY]) VALUES (CAST(N'2023-06-19' AS Date), N'59915', N'92664', N'15899 32550', N'52470 29461 86414  90623 25179 91571', N'3463 9199 3287 6446', N'6391 0051 9358  8456 2066 6852', N'633 901 624', N'84 71 31 96')
INSERT [dbo].[ResultOfDay] ([Date], [DB], [NHAT], [NHI], [BA], [TU], [NAM], [SAU], [BAY]) VALUES (CAST(N'2023-06-20' AS Date), N'51232', N'37107', N'28488 15667', N'67829 95115 22549  94218 88276 22122', N'3666 3895 0482 2513', N'5562 3273 6925  2201 8508 5024', N'768 006 915', N'60 02 53 33')
INSERT [dbo].[ResultOfDay] ([Date], [DB], [NHAT], [NHI], [BA], [TU], [NAM], [SAU], [BAY]) VALUES (CAST(N'2023-06-21' AS Date), N'58534', N'47248', N'31378 24891', N'66224 32447 09625  20190 45955 79430', N'7401 4890 2121 4604', N'2913 7949 6502  5611 9775 5422', N'695 283 059', N'28 06 57 26')
INSERT [dbo].[ResultOfDay] ([Date], [DB], [NHAT], [NHI], [BA], [TU], [NAM], [SAU], [BAY]) VALUES (CAST(N'2023-06-22' AS Date), N'84267', N'02244', N'93702 67381', N'11966 10243 59342  89468 21046 34369', N'8713 5009 1257 6787', N'5544 3116 7782  9557 5042 6535', N'124 416 017', N'84 51 99 00')
INSERT [dbo].[ResultOfDay] ([Date], [DB], [NHAT], [NHI], [BA], [TU], [NAM], [SAU], [BAY]) VALUES (CAST(N'2023-06-23' AS Date), N'83660', N'29556', N'84109 08146', N'94501 89896 47585  80207 97187 00361', N'4205 2870 8205 0899', N'5152 3767 5317  5262 3839 5697', N'662 169 936', N'36 84 41 44')
INSERT [dbo].[ResultOfDay] ([Date], [DB], [NHAT], [NHI], [BA], [TU], [NAM], [SAU], [BAY]) VALUES (CAST(N'2023-06-24' AS Date), N'09870', N'73087', N'81633 72969', N'89847 26356 34405  84024 47303 24618', N'0872 6015 3948 9391', N'2205 4589 4261  9558 0773 6257', N'830 443 674', N'20 54 27 39')
INSERT [dbo].[ResultOfDay] ([Date], [DB], [NHAT], [NHI], [BA], [TU], [NAM], [SAU], [BAY]) VALUES (CAST(N'2023-06-25' AS Date), N'63634', N'89812', N'83546 02844', N'03095 31835 01834  53707 10733 27255', N'2684 8989 2268 5181', N'0406 8073 3678  8809 0787 7548', N'446 547 268', N'43 62 13 16')
INSERT [dbo].[ResultOfDay] ([Date], [DB], [NHAT], [NHI], [BA], [TU], [NAM], [SAU], [BAY]) VALUES (CAST(N'2023-06-26' AS Date), N'03493', N'78387', N'81896 44142', N'05378 90969 81654  54779 28751 19230', N'3278 6555 1402 1499', N'2550 5069 9460  9828 3893 9571', N'595 405 877', N'57 28 21 82')
INSERT [dbo].[ResultOfDay] ([Date], [DB], [NHAT], [NHI], [BA], [TU], [NAM], [SAU], [BAY]) VALUES (CAST(N'2023-06-27' AS Date), N'49195', N'69643', N'26181 62071', N'87839 47623 06396  11497 04474 84913', N'9536 6706 1662 5744', N'4329 4207 6959  4763 9892 4007', N'019 409 161', N'79 09 24 82')
INSERT [dbo].[ResultOfDay] ([Date], [DB], [NHAT], [NHI], [BA], [TU], [NAM], [SAU], [BAY]) VALUES (CAST(N'2023-06-28' AS Date), N'97495', N'12576', N'12020 52689', N'32283 74893 80249  63647 18732 04894', N'6498 9089 1696 6318', N'5906 9505 3506  4668 8182 9603', N'948 415 030', N'65 20 47 61')
INSERT [dbo].[ResultOfDay] ([Date], [DB], [NHAT], [NHI], [BA], [TU], [NAM], [SAU], [BAY]) VALUES (CAST(N'2023-06-29' AS Date), N'06920', N'56675', N'67716 70226', N'25883 78117 84401  10799 94060 69390', N'0144 9883 7643 6236', N'3976 0038 5573  0135 0392 6592', N'424 847 468', N'13 87 98 36')
INSERT [dbo].[ResultOfDay] ([Date], [DB], [NHAT], [NHI], [BA], [TU], [NAM], [SAU], [BAY]) VALUES (CAST(N'2023-06-30' AS Date), N'69851', N'88124', N'66159 11919', N'07922 80284 92702  43791 92613 53904', N'4262 5196 2479 4379', N'2466 8092 8630  6719 3089 6022', N'207 869 283', N'89 82 08 34')
INSERT [dbo].[ResultOfDay] ([Date], [DB], [NHAT], [NHI], [BA], [TU], [NAM], [SAU], [BAY]) VALUES (CAST(N'2023-07-01' AS Date), N'90746', N'08218', N'49755 48773', N'85978 76817 01272  70460 33373 84819', N'2816 7971 8278 5631', N'2252 0491 9252  7354 2482 8442', N'968 396 817', N'05 22 47 87')
INSERT [dbo].[ResultOfDay] ([Date], [DB], [NHAT], [NHI], [BA], [TU], [NAM], [SAU], [BAY]) VALUES (CAST(N'2023-07-02' AS Date), N'57123', N'20479', N'94195 90632', N'09599 24595 62714  10302 29610 84396', N'0499 8769 9271 1209', N'9426 1181 7561  1683 4179 0165', N'999 275 227', N'21 23 12 96')
INSERT [dbo].[ResultOfDay] ([Date], [DB], [NHAT], [NHI], [BA], [TU], [NAM], [SAU], [BAY]) VALUES (CAST(N'2023-07-03' AS Date), N'96894', N'03260', N'17064 71834', N'86082 55306 22767  85062 06138 27224', N'6983 2670 2483 7136', N'7354 5524 1596  1151 3202 4001', N'005 551 305', N'49 08 10 05')
INSERT [dbo].[ResultOfDay] ([Date], [DB], [NHAT], [NHI], [BA], [TU], [NAM], [SAU], [BAY]) VALUES (CAST(N'2023-07-04' AS Date), N'06883', N'50713', N'48058 74292', N'37720 15297 20477  30203 80621 91467', N'0689 1614 6370 0331', N'5062 9011 2825  8709 5494 2724', N'376 872 148', N'85 09 33 50')
INSERT [dbo].[ResultOfDay] ([Date], [DB], [NHAT], [NHI], [BA], [TU], [NAM], [SAU], [BAY]) VALUES (CAST(N'2023-07-05' AS Date), N'29397', N'03549', N'58203 74554', N'81540 48943 78444  49005 63573 24035', N'3287 0808 3898 9832', N'3029 0436 5367  7625 1862 0973', N'288 449 991', N'47 18 08 01')
INSERT [dbo].[ResultOfDay] ([Date], [DB], [NHAT], [NHI], [BA], [TU], [NAM], [SAU], [BAY]) VALUES (CAST(N'2023-07-06' AS Date), N'44798', N'94748', N'30095 36372', N'01428 55314 61653  45485 52116 52671', N'7701 1381 9393 4736', N'7019 1019 4066  2179 0283 8953', N'322 406 805', N'95 05 36 57')
INSERT [dbo].[ResultOfDay] ([Date], [DB], [NHAT], [NHI], [BA], [TU], [NAM], [SAU], [BAY]) VALUES (CAST(N'2023-07-07' AS Date), N'93076', N'94746', N'78078 12706', N'23849 92420 73292  31179 01655 13960', N'0155 7242 3503 7485', N'5440 4198 2074  7057 3193 7035', N'784 719 419', N'12 19 90 84')
INSERT [dbo].[ResultOfDay] ([Date], [DB], [NHAT], [NHI], [BA], [TU], [NAM], [SAU], [BAY]) VALUES (CAST(N'2023-07-08' AS Date), N'98215', N'82428', N'36753 21404', N'20556 64130 78489  02257 34419 12872', N'2467 8893 8792 5647', N'1537 3208 2426  5558 6380 0407', N'723 953 821', N'02 23 33 46')
INSERT [dbo].[ResultOfDay] ([Date], [DB], [NHAT], [NHI], [BA], [TU], [NAM], [SAU], [BAY]) VALUES (CAST(N'2023-07-09' AS Date), N'05408', N'68722', N'72072 36681', N'01296 98213 27176  41124 62013 23342', N'2637 8365 6432 2073', N'8201 2108 8851  5972 4691 9401', N'378 129 806', N'04 26 50 66')
INSERT [dbo].[ResultOfDay] ([Date], [DB], [NHAT], [NHI], [BA], [TU], [NAM], [SAU], [BAY]) VALUES (CAST(N'2023-07-10' AS Date), N'58222', N'29421', N'46895 15004', N'27829 66516 36514  41484 54733 23111', N'7367 9549 3143 0457', N'1272 6107 0431  2411 4662 9170', N'888 290 934', N'87 34 51 72')
INSERT [dbo].[ResultOfDay] ([Date], [DB], [NHAT], [NHI], [BA], [TU], [NAM], [SAU], [BAY]) VALUES (CAST(N'2023-07-11' AS Date), N'45631', N'13852', N'38923 22036', N'95463 53601 16942  82138 33639 16157', N'5535 4535 1683 0814', N'3850 8565 5513  5170 2452 1716', N'959 819 106', N'57 41 58 39')
INSERT [dbo].[ResultOfDay] ([Date], [DB], [NHAT], [NHI], [BA], [TU], [NAM], [SAU], [BAY]) VALUES (CAST(N'2023-07-12' AS Date), N'67115', N'67785', N'27064 04716', N'66804 23324 82424  04357 09864 14186', N'1010 5261 4023 2965', N'0673 8997 3795  5732 5147 5944', N'195 764 471', N'61 55 12 69')
INSERT [dbo].[ResultOfDay] ([Date], [DB], [NHAT], [NHI], [BA], [TU], [NAM], [SAU], [BAY]) VALUES (CAST(N'2023-07-13' AS Date), N'26902', N'17552', N'95496 22758', N'37039 85734 14296  42091 87038 08681', N'5105 0543 1386 5587', N'8739 4363 7301  7217 5264 8207', N'069 373 802', N'60 66 15 61')
INSERT [dbo].[ResultOfDay] ([Date], [DB], [NHAT], [NHI], [BA], [TU], [NAM], [SAU], [BAY]) VALUES (CAST(N'2023-07-14' AS Date), N'78668', N'82538', N'75699 31456', N'75013 86668 71819  33871 83628 63670', N'1258 2533 0428 2403', N'8900 7404 7012  5658 5092 3728', N'143 597 118', N'45 46 49 64')
INSERT [dbo].[ResultOfDay] ([Date], [DB], [NHAT], [NHI], [BA], [TU], [NAM], [SAU], [BAY]) VALUES (CAST(N'2023-07-15' AS Date), N'08897', N'14694', N'20247 56545', N'33540 12948 30368  70336 29535 33460', N'2226 1832 8430 5649', N'1289 0308 5192  6229 3061 5811', N'861 353 190', N'92 05 19 93')
INSERT [dbo].[ResultOfDay] ([Date], [DB], [NHAT], [NHI], [BA], [TU], [NAM], [SAU], [BAY]) VALUES (CAST(N'2023-07-16' AS Date), N'51351', N'45672', N'33664 34988', N'11840 80820 21070  94557 68550 68572', N'1294 6035 1137 1192', N'2972 8180 1346  0819 4068 4018', N'761 920 817', N'63 51 25 75')
INSERT [dbo].[ResultOfDay] ([Date], [DB], [NHAT], [NHI], [BA], [TU], [NAM], [SAU], [BAY]) VALUES (CAST(N'2023-07-17' AS Date), N'22406', N'98378', N'62092 98895', N'44175 08093 41093  00278 02310 43490', N'4322 0613 1804 8560', N'7791 2461 4860  6652 4403 8973', N'244 786 983', N'48 95 89 64')
INSERT [dbo].[ResultOfDay] ([Date], [DB], [NHAT], [NHI], [BA], [TU], [NAM], [SAU], [BAY]) VALUES (CAST(N'2023-07-18' AS Date), N'20080', N'11885', N'53633 37876', N'66155 22059 50224  53978 69419 40654', N'4282 7771 9721 9021', N'2850 1856 3174  9927 3166 6207', N'898 149 402', N'49 40 87 30')
INSERT [dbo].[ResultOfDay] ([Date], [DB], [NHAT], [NHI], [BA], [TU], [NAM], [SAU], [BAY]) VALUES (CAST(N'2023-07-19' AS Date), N'15339', N'01484', N'56243 07018', N'55493 89659 36430  09161 65005 78245', N'9215 9502 7666 9785', N'2848 4675 7953  9190 7116 0560', N'268 322 801', N'03 62 98 56')
INSERT [dbo].[ResultOfDay] ([Date], [DB], [NHAT], [NHI], [BA], [TU], [NAM], [SAU], [BAY]) VALUES (CAST(N'2023-07-20' AS Date), N'58286', N'59809', N'27214 91487', N'38808 27542 66389  67950 60208 71038', N'1808 6367 8712 0887', N'0502 4135 1080  9915 7284 0175', N'959 760 942', N'72 38 74 62')
INSERT [dbo].[ResultOfDay] ([Date], [DB], [NHAT], [NHI], [BA], [TU], [NAM], [SAU], [BAY]) VALUES (CAST(N'2023-07-21' AS Date), N'35944', N'72926', N'31283 67742', N'31166 69906 72537  72985 77782 07426', N'9318 8610 6324 3745', N'1283 3054 4145  9206 2509 7767', N'924 677 286', N'83 52 26 95')
INSERT [dbo].[ResultOfDay] ([Date], [DB], [NHAT], [NHI], [BA], [TU], [NAM], [SAU], [BAY]) VALUES (CAST(N'2023-07-22' AS Date), N'27433', N'16448', N'31955 68361', N'17436 28183 64926  05361 39669 80234', N'9122 2965 2867 2912', N'3969 8419 2592  7452 9252 2628', N'488 887 051', N'90 07 54 80')
INSERT [dbo].[ResultOfDay] ([Date], [DB], [NHAT], [NHI], [BA], [TU], [NAM], [SAU], [BAY]) VALUES (CAST(N'2023-07-23' AS Date), N'58062', N'16342', N'32714 32089', N'95921 89695 40569  92129 05613 50218', N'9346 4130 0937 3171', N'9242 5408 4964  4861 9460 1769', N'794 347 393', N'47 42 87 44')
INSERT [dbo].[ResultOfDay] ([Date], [DB], [NHAT], [NHI], [BA], [TU], [NAM], [SAU], [BAY]) VALUES (CAST(N'2023-07-24' AS Date), N'62442', N'52306', N'49059 47882', N'75962 13190 68936  80179 23389 25237', N'6004 4666 5453 1852', N'8379 2922 7226  0034 1830 3352', N'090 997 005', N'18 56 74 97')
INSERT [dbo].[ResultOfDay] ([Date], [DB], [NHAT], [NHI], [BA], [TU], [NAM], [SAU], [BAY]) VALUES (CAST(N'2023-07-25' AS Date), N'75659', N'75566', N'59023 67456', N'38964 55581 84603  12171 28352 65940', N'4360 4827 1343 7450', N'0218 6776 5159  9309 1260 1920', N'483 269 720', N'31 60 57 05')
INSERT [dbo].[ResultOfDay] ([Date], [DB], [NHAT], [NHI], [BA], [TU], [NAM], [SAU], [BAY]) VALUES (CAST(N'2023-07-26' AS Date), N'87929', N'75634', N'97192 60780', N'91837 73432 89201  03500 17989 38853', N'6924 2208 9694 8150', N'2455 2219 3159  5163 3656 1122', N'017 021 657', N'64 60 08 94')
INSERT [dbo].[ResultOfDay] ([Date], [DB], [NHAT], [NHI], [BA], [TU], [NAM], [SAU], [BAY]) VALUES (CAST(N'2023-07-27' AS Date), N'21171', N'85403', N'79840 71628', N'70421 53425 93257  67908 60129 24822', N'8442 5443 7734 2039', N'7288 5379 6926  4166 5022 1814', N'647 208 190', N'68 22 47 10')
INSERT [dbo].[ResultOfDay] ([Date], [DB], [NHAT], [NHI], [BA], [TU], [NAM], [SAU], [BAY]) VALUES (CAST(N'2023-07-28' AS Date), N'40915', N'79375', N'19984 99134', N'03439 03628 39226  09345 12556 43022', N'9679 5267 1544 2874', N'1183 4538 2948  6987 4178 1682', N'812 027 864', N'68 34 93 18')
INSERT [dbo].[ResultOfDay] ([Date], [DB], [NHAT], [NHI], [BA], [TU], [NAM], [SAU], [BAY]) VALUES (CAST(N'2023-07-29' AS Date), N'69358', N'70140', N'43060 37592', N'41352 06631 55503  36988 92978 82185', N'7446 9559 9798 2763', N'5360 6545 9000  7591 6824 4880', N'361 896 648', N'83 24 55 56')
INSERT [dbo].[ResultOfDay] ([Date], [DB], [NHAT], [NHI], [BA], [TU], [NAM], [SAU], [BAY]) VALUES (CAST(N'2023-07-30' AS Date), N'55741', N'43813', N'02309 00386', N'62033 45369 94823  71231 62175 14881', N'6227 7794 5254 8472', N'4335 0643 4241  7311 5926 4135', N'928 952 289', N'49 37 46 09')
INSERT [dbo].[ResultOfDay] ([Date], [DB], [NHAT], [NHI], [BA], [TU], [NAM], [SAU], [BAY]) VALUES (CAST(N'2023-07-31' AS Date), N'72615', N'73596', N'29471 16196', N'13165 43789 59867  86590 66461 38341', N'8590 7894 7401 6477', N'4560 1221 7202  7931 7306 9952', N'802 683 737', N'61 76 39 36')
INSERT [dbo].[ResultOfDay] ([Date], [DB], [NHAT], [NHI], [BA], [TU], [NAM], [SAU], [BAY]) VALUES (CAST(N'2023-08-01' AS Date), N'04430', N'18971', N'47120 00337', N'11167 95150 31425  22107 44661 79135', N'9009 8851 5221 3489', N'6446 9609 5128  7304 3140 7896', N'731 874 836', N'90 95 72 85')
INSERT [dbo].[ResultOfDay] ([Date], [DB], [NHAT], [NHI], [BA], [TU], [NAM], [SAU], [BAY]) VALUES (CAST(N'2023-08-02' AS Date), N'88137', N'71298', N'58086 00408', N'82480 28918 77455  05402 88005 43510', N'3480 4499 9705 7519', N'3243 9012 7570  6490 6252 6705', N'480 346 518', N'59 80 94 08')
INSERT [dbo].[ResultOfDay] ([Date], [DB], [NHAT], [NHI], [BA], [TU], [NAM], [SAU], [BAY]) VALUES (CAST(N'2023-08-03' AS Date), N'80288', N'61964', N'82402 90573', N'86917 81202 63682  32267 08872 45092', N'4562 0068 0287 9372', N'6857 2417 0553  7674 2108 0438', N'396 653 630', N'51 69 22 62')
INSERT [dbo].[ResultOfDay] ([Date], [DB], [NHAT], [NHI], [BA], [TU], [NAM], [SAU], [BAY]) VALUES (CAST(N'2023-08-04' AS Date), N'56177', N'48747', N'08038 37072', N'99486 05006 99927  68286 14345 93225', N'0919 1056 1782 9529', N'9766 6862 2021  4679 6637 8444', N'361 602 847', N'62 88 73 36')
INSERT [dbo].[ResultOfDay] ([Date], [DB], [NHAT], [NHI], [BA], [TU], [NAM], [SAU], [BAY]) VALUES (CAST(N'2023-08-05' AS Date), N'45710', N'36358', N'78767 34560', N'75294 38943 87647  64794 72375 35335', N'0010 3852 7829 5397', N'0448 4183 7389  3632 4307 4525', N'232 733 903', N'03 55 51 43')
INSERT [dbo].[ResultOfDay] ([Date], [DB], [NHAT], [NHI], [BA], [TU], [NAM], [SAU], [BAY]) VALUES (CAST(N'2023-08-06' AS Date), N'74923', N'73722', N'66542 12789', N'89253 71550 56856  87932 31738 21677', N'3447 9704 0494 1020', N'5465 0883 5728  6288 7256 4655', N'041 937 132', N'88 75 57 62')
INSERT [dbo].[ResultOfDay] ([Date], [DB], [NHAT], [NHI], [BA], [TU], [NAM], [SAU], [BAY]) VALUES (CAST(N'2023-08-07' AS Date), N'08672', N'20246', N'43830 65267', N'30196 09287 20041  85627 27167 55315', N'1341 7186 6137 2626', N'0177 6134 9942  5179 7704 0359', N'214 722 518', N'07 63 16 74')
INSERT [dbo].[ResultOfDay] ([Date], [DB], [NHAT], [NHI], [BA], [TU], [NAM], [SAU], [BAY]) VALUES (CAST(N'2023-08-08' AS Date), N'80766', N'27080', N'64096 60943', N'71174 97077 93957  19786 63087 56243', N'9054 7415 0167 2940', N'3214 9178 9878  6066 7076 5984', N'325 947 371', N'70 19 14 97')
INSERT [dbo].[ResultOfDay] ([Date], [DB], [NHAT], [NHI], [BA], [TU], [NAM], [SAU], [BAY]) VALUES (CAST(N'2023-08-09' AS Date), N'59261', N'27636', N'03647 95243', N'63184 46236 75761  98993 62356 29159', N'5510 4389 7219 3557', N'7130 7200 8613  7316 5508 7113', N'708 870 846', N'79 91 84 74')
INSERT [dbo].[ResultOfDay] ([Date], [DB], [NHAT], [NHI], [BA], [TU], [NAM], [SAU], [BAY]) VALUES (CAST(N'2023-08-10' AS Date), N'25102', N'39262', N'27262 60903', N'83745 39012 83875  12495 33809 23707', N'2471 5901 0523 5567', N'9000 0248 5132  6410 3979 1027', N'692 080 999', N'01 06 50 79')
INSERT [dbo].[ResultOfDay] ([Date], [DB], [NHAT], [NHI], [BA], [TU], [NAM], [SAU], [BAY]) VALUES (CAST(N'2023-08-11' AS Date), N'90299', N'36308', N'08284 74795', N'48467 07041 88636  57778 05762 44904', N'8380 3246 7656 5962', N'8251 0817 5831  1445 7577 3261', N'635 815 883', N'31 43 29 27')
INSERT [dbo].[ResultOfDay] ([Date], [DB], [NHAT], [NHI], [BA], [TU], [NAM], [SAU], [BAY]) VALUES (CAST(N'2023-08-12' AS Date), N'06848', N'28684', N'55972 09024', N'00431 45343 51704  24137 03665 07682', N'0332 5651 6580 9027', N'6391 2515 7524  1973 0152 2935', N'264 132 786', N'67 29 87 21')
INSERT [dbo].[ResultOfDay] ([Date], [DB], [NHAT], [NHI], [BA], [TU], [NAM], [SAU], [BAY]) VALUES (CAST(N'2023-08-13' AS Date), N'84528', N'96875', N'83636 11470', N'17608 65742 48426  85044 78834 64130', N'3346 9946 2325 2587', N'6922 6348 8028  4123 3955 7616', N'975 239 505', N'29 48 01 79')
INSERT [dbo].[ResultOfDay] ([Date], [DB], [NHAT], [NHI], [BA], [TU], [NAM], [SAU], [BAY]) VALUES (CAST(N'2023-08-14' AS Date), N'16893', N'11401', N'38329 41032', N'81013 74454 54995  37360 64318 00611', N'9319 7768 6180 0802', N'1673 6320 8538  2449 7878 7816', N'405 389 208', N'22 03 25 63')
INSERT [dbo].[ResultOfDay] ([Date], [DB], [NHAT], [NHI], [BA], [TU], [NAM], [SAU], [BAY]) VALUES (CAST(N'2023-08-15' AS Date), N'41861', N'12901', N'82868 76177', N'02959 47602 10678  55317 38306 53035', N'9975 1708 4300 1454', N'1897 4504 4626  2745 4562 0388', N'367 908 599', N'90 56 45 22')
INSERT [dbo].[ResultOfDay] ([Date], [DB], [NHAT], [NHI], [BA], [TU], [NAM], [SAU], [BAY]) VALUES (CAST(N'2023-08-16' AS Date), N'82019', N'43465', N'91437 12598', N'83059 00178 30317  20179 38840 16159', N'3508 8312 3501 8338', N'3555 4951 9028  0873 9468 0574', N'672 517 797', N'53 92 39 48')
INSERT [dbo].[ResultOfDay] ([Date], [DB], [NHAT], [NHI], [BA], [TU], [NAM], [SAU], [BAY]) VALUES (CAST(N'2023-08-17' AS Date), N'79186', N'32553', N'79391 52920', N'32912 94584 36898  31073 20915 87443', N'6367 7030 0053 1383', N'1857 3180 1684  1177 1109 8748', N'715 727 370', N'30 98 35 47')
INSERT [dbo].[ResultOfDay] ([Date], [DB], [NHAT], [NHI], [BA], [TU], [NAM], [SAU], [BAY]) VALUES (CAST(N'2023-08-18' AS Date), N'47887', N'39986', N'56065 51191', N'82359 53855 74736  59020 42647 64818', N'1199 2768 7762 8443', N'3913 6365 2559  9605 0489 5429', N'817 684 758', N'82 65 04 85')
INSERT [dbo].[ResultOfDay] ([Date], [DB], [NHAT], [NHI], [BA], [TU], [NAM], [SAU], [BAY]) VALUES (CAST(N'2023-08-19' AS Date), N'41830', N'58636', N'39233 73088', N'83499 22605 66773  03676 14024 53087', N'8251 9769 4793 3428', N'5831 8539 9311  2736 0545 8043', N'962 034 537', N'70 71 15 86')
INSERT [dbo].[ResultOfDay] ([Date], [DB], [NHAT], [NHI], [BA], [TU], [NAM], [SAU], [BAY]) VALUES (CAST(N'2023-08-20' AS Date), N'92009', N'83433', N'73249 22498', N'88300 82515 35780  46685 15696 01620', N'4914 8375 3112 7130', N'1530 2557 5432  3299 4793 9846', N'745 471 190', N'61 79 95 58')
INSERT [dbo].[ResultOfDay] ([Date], [DB], [NHAT], [NHI], [BA], [TU], [NAM], [SAU], [BAY]) VALUES (CAST(N'2023-08-21' AS Date), N'27221', N'79939', N'15978 22802', N'91318 15732 46289  25409 20500 06303', N'9630 2219 8757 8776', N'4602 3578 4652  0483 8462 8840', N'482 715 298', N'55 97 57 71')
INSERT [dbo].[ResultOfDay] ([Date], [DB], [NHAT], [NHI], [BA], [TU], [NAM], [SAU], [BAY]) VALUES (CAST(N'2023-08-22' AS Date), N'60279', N'20329', N'94862 06840', N'88389 54337 16232  44313 50186 72731', N'7872 6997 8983 0988', N'7843 2573 6406  2361 3755 8515', N'282 626 868', N'55 32 99 15')
INSERT [dbo].[ResultOfDay] ([Date], [DB], [NHAT], [NHI], [BA], [TU], [NAM], [SAU], [BAY]) VALUES (CAST(N'2023-08-23' AS Date), N'63734', N'45494', N'74300 57480', N'57250 51369 51721  60449 00331 55553', N'7387 8262 6972 9100', N'3563 9418 2317  8957 6724 9771', N'171 830 879', N'37 58 14 68')
INSERT [dbo].[ResultOfDay] ([Date], [DB], [NHAT], [NHI], [BA], [TU], [NAM], [SAU], [BAY]) VALUES (CAST(N'2023-08-24' AS Date), N'57973', N'56968', N'14617 65709', N'80552 37370 15250  20440 22904 77493', N'7257 1247 1466 9018', N'2216 9070 9700  0651 3860 3967', N'696 165 515', N'58 49 66 44')
INSERT [dbo].[ResultOfDay] ([Date], [DB], [NHAT], [NHI], [BA], [TU], [NAM], [SAU], [BAY]) VALUES (CAST(N'2023-08-25' AS Date), N'82843', N'23348', N'35123 01009', N'95487 27274 39984  74122 89308 11685', N'3680 4811 8994 5884', N'7430 2751 5603  5010 0572 4760', N'220 037 782', N'52 11 96 49')
INSERT [dbo].[ResultOfDay] ([Date], [DB], [NHAT], [NHI], [BA], [TU], [NAM], [SAU], [BAY]) VALUES (CAST(N'2023-08-26' AS Date), N'94958', N'14322', N'80180 84096', N'70572 36382 84142  28319 88165 18514', N'0285 0744 3575 6736', N'6297 5315 2962  6659 9097 4106', N'276 334 807', N'70 87 18 91')
INSERT [dbo].[ResultOfDay] ([Date], [DB], [NHAT], [NHI], [BA], [TU], [NAM], [SAU], [BAY]) VALUES (CAST(N'2023-08-27' AS Date), N'18448', N'73829', N'73174 57227', N'64570 10484 87444  72236 25998 89251', N'6646 2444 8189 0403', N'3250 0583 4468  3204 6188 6210', N'779 581 275', N'11 61 62 10')
INSERT [dbo].[ResultOfDay] ([Date], [DB], [NHAT], [NHI], [BA], [TU], [NAM], [SAU], [BAY]) VALUES (CAST(N'2023-08-28' AS Date), N'83185', N'32479', N'36313 38300', N'44306 18203 05711  38445 73969 29512', N'8530 6367 8245 0564', N'7212 5751 3688  3614 1843 5375', N'073 070 392', N'14 08 03 65')
INSERT [dbo].[ResultOfDay] ([Date], [DB], [NHAT], [NHI], [BA], [TU], [NAM], [SAU], [BAY]) VALUES (CAST(N'2023-08-29' AS Date), N'49278', N'26681', N'25277 61276', N'25040 04826 77227  44526 16626 06494', N'1586 5687 6866 2962', N'6617 6686 1073  9124 8961 3505', N'030 130 681', N'22 72 21 71')
INSERT [dbo].[ResultOfDay] ([Date], [DB], [NHAT], [NHI], [BA], [TU], [NAM], [SAU], [BAY]) VALUES (CAST(N'2023-08-30' AS Date), N'76551', N'15711', N'12428 67802', N'34939 72484 06815  67171 03982 08356', N'7737 0624 4241 6756', N'8203 1352 5226  3071 4097 1274', N'709 496 393', N'00 27 68 72')
INSERT [dbo].[ResultOfDay] ([Date], [DB], [NHAT], [NHI], [BA], [TU], [NAM], [SAU], [BAY]) VALUES (CAST(N'2023-08-31' AS Date), N'73040', N'49951', N'45966 86381', N'41593 00092 86954  84340 47439 63862', N'2848 7645 3439 0211', N'1304 4480 3555  3946 5126 3834', N'166 251 788', N'52 05 29 62')
INSERT [dbo].[ResultOfDay] ([Date], [DB], [NHAT], [NHI], [BA], [TU], [NAM], [SAU], [BAY]) VALUES (CAST(N'2023-09-01' AS Date), N'61379', N'79008', N'07854 80318', N'48527 90784 13121  89610 34437 47431', N'7099 6773 7723 6743', N'4050 1687 2692  4187 1868 4573', N'559 179 626', N'43 54 36 09')
INSERT [dbo].[ResultOfDay] ([Date], [DB], [NHAT], [NHI], [BA], [TU], [NAM], [SAU], [BAY]) VALUES (CAST(N'2023-09-02' AS Date), N'06380', N'98000', N'99597 53685', N'34586 78688 64779  57124 13835 11414', N'5991 0633 8196 3616', N'9491 9707 7686  3397 8542 6448', N'325 892 195', N'09 36 54 76')
INSERT [dbo].[ResultOfDay] ([Date], [DB], [NHAT], [NHI], [BA], [TU], [NAM], [SAU], [BAY]) VALUES (CAST(N'2023-09-03' AS Date), N'31186', N'04843', N'91474 14263', N'71382 56092 53921  86765 79000 44950', N'6310 9597 4434 5220', N'8407 8811 5408  5120 4332 2064', N'058 233 028', N'36 10 13 21')
INSERT [dbo].[ResultOfDay] ([Date], [DB], [NHAT], [NHI], [BA], [TU], [NAM], [SAU], [BAY]) VALUES (CAST(N'2023-09-04' AS Date), N'08811', N'37863', N'87846 28711', N'18824 07874 25822  50186 66056 41908', N'3781 1650 3560 7411', N'3315 3628 8407  0132 3485 5123', N'490 255 462', N'43 36 25 53')
INSERT [dbo].[ResultOfDay] ([Date], [DB], [NHAT], [NHI], [BA], [TU], [NAM], [SAU], [BAY]) VALUES (CAST(N'2023-09-05' AS Date), N'06367', N'75549', N'37897 86396', N'21049 38393 71943  84506 00776 95951', N'0309 1286 8450 4114', N'9424 1746 2855  0197 4572 4922', N'912 992 842', N'72 44 38 96')
INSERT [dbo].[ResultOfDay] ([Date], [DB], [NHAT], [NHI], [BA], [TU], [NAM], [SAU], [BAY]) VALUES (CAST(N'2023-09-06' AS Date), N'15269', N'98469', N'58959 81886', N'32925 78517 82116  72574 29546 87724', N'1861 3124 4876 0278', N'8305 8781 9304  5924 8293 4248', N'989 746 484', N'95 32 01 30')
INSERT [dbo].[ResultOfDay] ([Date], [DB], [NHAT], [NHI], [BA], [TU], [NAM], [SAU], [BAY]) VALUES (CAST(N'2023-09-07' AS Date), N'49956', N'86503', N'30149 91295', N'79898 88109 48412  53869 38343 84577', N'7509 5019 9362 1933', N'0559 2748 4246  4497 3950 1919', N'057 038 963', N'48 12 14 78')
INSERT [dbo].[ResultOfDay] ([Date], [DB], [NHAT], [NHI], [BA], [TU], [NAM], [SAU], [BAY]) VALUES (CAST(N'2023-09-08' AS Date), N'13676', N'24740', N'56012 32207', N'50515 81421 34783  31017 30582 37899', N'3520 0313 6597 2690', N'5491 7633 7787  7739 0294 9275', N'594 073 755', N'25 94 51 23')
INSERT [dbo].[ResultOfDay] ([Date], [DB], [NHAT], [NHI], [BA], [TU], [NAM], [SAU], [BAY]) VALUES (CAST(N'2023-09-09' AS Date), N'35252', N'16451', N'69969 18026', N'68810 96008 18951  03293 30814 22188', N'3595 6413 8291 8579', N'4729 1428 1299  1711 8069 5240', N'046 773 149', N'51 81 69 78')
INSERT [dbo].[ResultOfDay] ([Date], [DB], [NHAT], [NHI], [BA], [TU], [NAM], [SAU], [BAY]) VALUES (CAST(N'2023-09-10' AS Date), N'35902', N'31314', N'95602 40508', N'88800 91768 96669  72035 32840 02228', N'7304 9775 0393 2766', N'9414 1229 3791  2810 9720 9332', N'840 864 219', N'40 66 26 22')
INSERT [dbo].[ResultOfDay] ([Date], [DB], [NHAT], [NHI], [BA], [TU], [NAM], [SAU], [BAY]) VALUES (CAST(N'2023-09-11' AS Date), N'63768', N'07404', N'76409 96941', N'36081 69640 53912  46658 14279 54968', N'5802 8956 7809 3074', N'0262 5994 3823  7323 3169 7052', N'598 735 736', N'93 87 75 00')
INSERT [dbo].[ResultOfDay] ([Date], [DB], [NHAT], [NHI], [BA], [TU], [NAM], [SAU], [BAY]) VALUES (CAST(N'2023-09-12' AS Date), N'73132', N'07023', N'20680 11439', N'90823 34894 66864  31763 56916 32737', N'7532 1372 5554 4557', N'9339 3954 0197  9470 3478 3924', N'827 958 726', N'03 31 52 10')
GO
INSERT [dbo].[ResultOfDay] ([Date], [DB], [NHAT], [NHI], [BA], [TU], [NAM], [SAU], [BAY]) VALUES (CAST(N'2023-09-13' AS Date), N'56650', N'37406', N'50515 25911', N'41234 89462 16592  53472 18697 36227', N'3240 6790 0262 3750', N'3676 9266 7549  9781 1704 3680', N'405 446 442', N'49 45 59 21')
INSERT [dbo].[ResultOfDay] ([Date], [DB], [NHAT], [NHI], [BA], [TU], [NAM], [SAU], [BAY]) VALUES (CAST(N'2023-09-14' AS Date), N'59722', N'39954', N'82710 03209', N'78624 32001 43234  62757 70781 81883', N'8076 8791 9056 0768', N'6452 1096 3635  6305 6223 8703', N'457 589 380', N'92 33 70 38')
INSERT [dbo].[ResultOfDay] ([Date], [DB], [NHAT], [NHI], [BA], [TU], [NAM], [SAU], [BAY]) VALUES (CAST(N'2023-09-15' AS Date), N'13720', N'08293', N'39853 99463', N'40902 18299 67472  71197 09602 98672', N'6266 7877 7531 1382', N'8533 8041 0107  1775 2242 9568', N'692 139 713', N'00 90 14 61')
INSERT [dbo].[ResultOfDay] ([Date], [DB], [NHAT], [NHI], [BA], [TU], [NAM], [SAU], [BAY]) VALUES (CAST(N'2023-09-16' AS Date), N'11724', N'98298', N'19917 53982', N'09894 85689 21669  68513 50670 77330', N'1580 7154 6751 2983', N'7989 0174 4014  8953 5493 8885', N'459 607 700', N'95 97 40 99')
INSERT [dbo].[ResultOfDay] ([Date], [DB], [NHAT], [NHI], [BA], [TU], [NAM], [SAU], [BAY]) VALUES (CAST(N'2023-09-17' AS Date), N'22365', N'80585', N'51233 18206', N'96019 28041 33335  84405 47766 56983', N'0662 9764 3649 9731', N'9034 3966 3093  1775 7898 1925', N'266 316 572', N'97 50 53 24')
INSERT [dbo].[ResultOfDay] ([Date], [DB], [NHAT], [NHI], [BA], [TU], [NAM], [SAU], [BAY]) VALUES (CAST(N'2023-09-18' AS Date), N'43104', N'28261', N'94697 54948', N'94817 46842 80937  93431 84038 68623', N'9898 3566 9576 3523', N'2967 8407 0472  8087 2142 0254', N'564 906 826', N'92 19 52 44')
INSERT [dbo].[ResultOfDay] ([Date], [DB], [NHAT], [NHI], [BA], [TU], [NAM], [SAU], [BAY]) VALUES (CAST(N'2023-09-19' AS Date), N'50925', N'75781', N'95072 45895', N'41571 89042 12852  47456 00818 62562', N'8894 5615 3165 5278', N'1942 7055 3612  4780 5138 3630', N'212 766 598', N'41 28 85 40')
INSERT [dbo].[ResultOfDay] ([Date], [DB], [NHAT], [NHI], [BA], [TU], [NAM], [SAU], [BAY]) VALUES (CAST(N'2023-09-20' AS Date), N'40303', N'10239', N'54210 50718', N'43807 58233 34307  28734 80115 71208', N'5730 3813 6767 5531', N'0634 0364 2201  3711 5086 0814', N'393 729 536', N'22 23 91 75')
INSERT [dbo].[ResultOfDay] ([Date], [DB], [NHAT], [NHI], [BA], [TU], [NAM], [SAU], [BAY]) VALUES (CAST(N'2023-09-21' AS Date), N'52566', N'34841', N'51527 93225', N'11728 25151 80780  49217 55120 57854', N'0466 4980 0563 6846', N'6189 5380 9292  6703 4758 9247', N'104 794 694', N'64 63 21 91')
INSERT [dbo].[ResultOfDay] ([Date], [DB], [NHAT], [NHI], [BA], [TU], [NAM], [SAU], [BAY]) VALUES (CAST(N'2023-09-22' AS Date), N'22714', N'66480', N'36490 79715', N'56683 54921 79449  80550 24952 86607', N'8307 1435 0484 0941', N'1863 0675 5349  9969 1503 4197', N'826 983 510', N'80 00 67 31')
INSERT [dbo].[ResultOfDay] ([Date], [DB], [NHAT], [NHI], [BA], [TU], [NAM], [SAU], [BAY]) VALUES (CAST(N'2023-09-23' AS Date), N'76922', N'99878', N'60050 42231', N'70197 24029 17888  42024 71288 33727', N'5488 9596 2292 3714', N'9571 7953 2680  0653 6341 3334', N'075 832 375', N'92 42 40 10')
INSERT [dbo].[ResultOfDay] ([Date], [DB], [NHAT], [NHI], [BA], [TU], [NAM], [SAU], [BAY]) VALUES (CAST(N'2023-09-24' AS Date), N'62778', N'20839', N'29228 65528', N'22314 73466 17819  70905 97087 67176', N'8299 1202 0788 8971', N'5759 0216 3733  2360 8984 1505', N'067 617 701', N'40 44 30 51')
INSERT [dbo].[ResultOfDay] ([Date], [DB], [NHAT], [NHI], [BA], [TU], [NAM], [SAU], [BAY]) VALUES (CAST(N'2023-09-25' AS Date), N'68779', N'71548', N'82470 84221', N'03065 37527 36975  08761 59916 52871', N'9605 6005 9627 8751', N'2897 5156 0016  2707 3603 9705', N'665 493 022', N'83 14 68 77')
INSERT [dbo].[ResultOfDay] ([Date], [DB], [NHAT], [NHI], [BA], [TU], [NAM], [SAU], [BAY]) VALUES (CAST(N'2023-09-26' AS Date), N'45236', N'33099', N'92248 85832', N'19963 86594 04650  57903 51103 34001', N'9605 8174 8695 3932', N'1100 9835 6748  3452 5816 9380', N'003 883 109', N'34 77 84 81')
INSERT [dbo].[ResultOfDay] ([Date], [DB], [NHAT], [NHI], [BA], [TU], [NAM], [SAU], [BAY]) VALUES (CAST(N'2023-09-27' AS Date), N'93447', N'71106', N'67705 00384', N'67673 22611 18030  35885 62710 86306', N'7621 1221 9671 5497', N'2608 8234 3524  0541 6323 6518', N'043 466 205', N'56 28 22 74')
INSERT [dbo].[ResultOfDay] ([Date], [DB], [NHAT], [NHI], [BA], [TU], [NAM], [SAU], [BAY]) VALUES (CAST(N'2023-09-28' AS Date), N'11698', N'77996', N'44386 48900', N'50556 02023 73169  91188 39404 88068', N'2092 6143 0736 5575', N'9078 8697 7078  5622 3662 5048', N'924 443 417', N'61 16 20 84')
INSERT [dbo].[ResultOfDay] ([Date], [DB], [NHAT], [NHI], [BA], [TU], [NAM], [SAU], [BAY]) VALUES (CAST(N'2023-09-29' AS Date), N'07044', N'88675', N'45097 40581', N'45021 76164 14457  24067 57789 44804', N'7218 1041 6089 3633', N'8752 2066 9926  1433 2605 2330', N'109 055 432', N'79 88 59 19')
INSERT [dbo].[ResultOfDay] ([Date], [DB], [NHAT], [NHI], [BA], [TU], [NAM], [SAU], [BAY]) VALUES (CAST(N'2023-09-30' AS Date), N'19237', N'00802', N'69062 73744', N'28668 67174 14711  13617 46011 10279', N'6557 5429 6415 1454', N'4316 2144 6966  9860 8112 4610', N'104 844 320', N'79 71 38 53')
INSERT [dbo].[ResultOfDay] ([Date], [DB], [NHAT], [NHI], [BA], [TU], [NAM], [SAU], [BAY]) VALUES (CAST(N'2023-10-01' AS Date), N'07289', N'57908', N'18906 69144', N'51729 76652 54656  92756 68233 32508', N'0871 5315 5694 7563', N'0132 5407 0788  0333 0870 4833', N'359 623 838', N'03 74 25 87')
INSERT [dbo].[ResultOfDay] ([Date], [DB], [NHAT], [NHI], [BA], [TU], [NAM], [SAU], [BAY]) VALUES (CAST(N'2023-10-02' AS Date), N'80973', N'56435', N'74027 76063', N'78709 89573 24399  09969 75199 84560', N'5054 8832 4262 5291', N'7274 7381 9109  3809 9002 4784', N'450 400 279', N'64 69 11 59')
INSERT [dbo].[ResultOfDay] ([Date], [DB], [NHAT], [NHI], [BA], [TU], [NAM], [SAU], [BAY]) VALUES (CAST(N'2023-10-03' AS Date), N'34556', N'36657', N'57200 24205', N'36423 78163 58672  87355 94773 55715', N'1239 8305 0646 3939', N'5830 0800 2419  5057 3928 4018', N'773 025 899', N'32 47 56 53')
INSERT [dbo].[ResultOfDay] ([Date], [DB], [NHAT], [NHI], [BA], [TU], [NAM], [SAU], [BAY]) VALUES (CAST(N'2023-10-04' AS Date), N'53139', N'52986', N'41893 88329', N'58465 46331 10707  32100 67382 36166', N'5828 4164 7852 0816', N'2892 7438 5364  9277 9494 1229', N'973 436 080', N'27 86 49 11')
INSERT [dbo].[ResultOfDay] ([Date], [DB], [NHAT], [NHI], [BA], [TU], [NAM], [SAU], [BAY]) VALUES (CAST(N'2023-10-05' AS Date), N'88733', N'73302', N'24201 85392', N'28893 61757 56710  03791 06431 62727', N'8037 6603 9356 3574', N'5156 1747 7121  1657 2110 3407', N'487 227 763', N'79 14 25 44')
INSERT [dbo].[ResultOfDay] ([Date], [DB], [NHAT], [NHI], [BA], [TU], [NAM], [SAU], [BAY]) VALUES (CAST(N'2023-10-06' AS Date), N'73121', N'55217', N'58651 16695', N'33566 88641 33460  21508 56520 07750', N'1730 9916 2124 9960', N'6043 5427 0070  4002 6493 5809', N'332 983 794', N'64 68 07 56')
INSERT [dbo].[ResultOfDay] ([Date], [DB], [NHAT], [NHI], [BA], [TU], [NAM], [SAU], [BAY]) VALUES (CAST(N'2023-10-07' AS Date), N'26547', N'41670', N'43744 83152', N'10056 59638 27910  48711 37587 74483', N'3920 1318 3826 5229', N'7112 9706 6852  0530 3370 9649', N'482 573 168', N'38 13 79 35')
INSERT [dbo].[ResultOfDay] ([Date], [DB], [NHAT], [NHI], [BA], [TU], [NAM], [SAU], [BAY]) VALUES (CAST(N'2023-10-08' AS Date), N'75188', N'80266', N'52602 61671', N'43993 77200 47305  51189 11181 50779', N'9062 2622 7482 2405', N'5596 3273 5134  6369 8790 1351', N'920 046 064', N'14 18 68 60')
INSERT [dbo].[ResultOfDay] ([Date], [DB], [NHAT], [NHI], [BA], [TU], [NAM], [SAU], [BAY]) VALUES (CAST(N'2023-10-09' AS Date), N'91245', N'31903', N'84892 01956', N'06356 03876 36672  24111 26365 30725', N'0051 4351 6340 4970', N'7484 4228 9564  1750 7829 2650', N'690 719 504', N'35 30 17 68')
INSERT [dbo].[ResultOfDay] ([Date], [DB], [NHAT], [NHI], [BA], [TU], [NAM], [SAU], [BAY]) VALUES (CAST(N'2023-10-10' AS Date), N'84521', N'59398', N'06955 97174', N'76861 38679 96018  06578 53625 81976', N'9277 4822 0696 3467', N'5349 4865 9875  9623 2213 7340', N'604 563 431', N'93 92 27 19')
INSERT [dbo].[ResultOfDay] ([Date], [DB], [NHAT], [NHI], [BA], [TU], [NAM], [SAU], [BAY]) VALUES (CAST(N'2023-10-11' AS Date), N'49140', N'34659', N'55529 10478', N'30337 13749 64088  19673 97793 99511', N'0865 5620 5382 7544', N'1596 5137 8019  2565 3801 2606', N'138 522 101', N'77 60 19 89')
INSERT [dbo].[ResultOfDay] ([Date], [DB], [NHAT], [NHI], [BA], [TU], [NAM], [SAU], [BAY]) VALUES (CAST(N'2023-10-12' AS Date), N'50875', N'95632', N'39892 34582', N'50557 03012 38198  20971 13896 23153', N'0633 1981 2032 4676', N'7866 1480 9846  3202 1539 0475', N'884 935 151', N'25 65 20 03')
INSERT [dbo].[ResultOfDay] ([Date], [DB], [NHAT], [NHI], [BA], [TU], [NAM], [SAU], [BAY]) VALUES (CAST(N'2023-10-13' AS Date), N'40620', N'36972', N'97683 99909', N'08047 50255 63076  61617 76879 27383', N'6459 0224 5895 5108', N'1293 3744 8119  9435 2535 9742', N'794 879 397', N'86 35 84 68')
INSERT [dbo].[ResultOfDay] ([Date], [DB], [NHAT], [NHI], [BA], [TU], [NAM], [SAU], [BAY]) VALUES (CAST(N'2023-10-14' AS Date), N'59454', N'00486', N'02755 43379', N'99550 05287 68380  32640 94138 33448', N'6838 0361 7534 5331', N'6853 9553 6500  1359 6160 5750', N'481 321 424', N'03 39 81 58')
INSERT [dbo].[ResultOfDay] ([Date], [DB], [NHAT], [NHI], [BA], [TU], [NAM], [SAU], [BAY]) VALUES (CAST(N'2023-10-15' AS Date), N'15013', N'43153', N'40745 63082', N'64745 57226 04843  26387 03424 95773', N'2455 0971 5175 1254', N'8586 1190 6393  6972 4232 6650', N'999 997 294', N'29 60 79 77')
INSERT [dbo].[ResultOfDay] ([Date], [DB], [NHAT], [NHI], [BA], [TU], [NAM], [SAU], [BAY]) VALUES (CAST(N'2023-10-16' AS Date), N'94540', N'26829', N'84819 86465', N'00329 48532 96915  81516 96050 36616', N'1631 0574 3196 0906', N'0155 0029 7713  0339 8844 0000', N'176 285 680', N'77 22 47 59')
INSERT [dbo].[ResultOfDay] ([Date], [DB], [NHAT], [NHI], [BA], [TU], [NAM], [SAU], [BAY]) VALUES (CAST(N'2023-10-17' AS Date), N'70876', N'93617', N'26995 44394', N'64764 37837 38294  86656 55780 07378', N'5076 5525 3888 3630', N'5793 8371 2703  8983 5047 3767', N'707 310 747', N'67 06 07 91')
INSERT [dbo].[ResultOfDay] ([Date], [DB], [NHAT], [NHI], [BA], [TU], [NAM], [SAU], [BAY]) VALUES (CAST(N'2023-10-18' AS Date), N'28600', N'18127', N'34909 28078', N'30317 28608 41328  25052 35444 85291', N'8974 7622 0873 7804', N'2049 6000 8948  1898 9177 9935', N'088 749 372', N'56 39 42 29')
INSERT [dbo].[ResultOfDay] ([Date], [DB], [NHAT], [NHI], [BA], [TU], [NAM], [SAU], [BAY]) VALUES (CAST(N'2023-10-19' AS Date), N'45305', N'95559', N'38899 87603', N'92120 18127 36684  43785 76111 64948', N'8908 6904 4781 7686', N'2873 3167 4112  6695 8826 6672', N'924 485 836', N'46 06 62 42')
INSERT [dbo].[ResultOfDay] ([Date], [DB], [NHAT], [NHI], [BA], [TU], [NAM], [SAU], [BAY]) VALUES (CAST(N'2023-10-20' AS Date), N'42888', N'28038', N'66168 37238', N'34837 92816 31859  41351 87430 39622', N'0360 6703 8282 7240', N'9386 3538 0380  7089 0570 7341', N'515 213 302', N'41 60 43 79')
INSERT [dbo].[ResultOfDay] ([Date], [DB], [NHAT], [NHI], [BA], [TU], [NAM], [SAU], [BAY]) VALUES (CAST(N'2023-10-21' AS Date), N'57349', N'28088', N'05865 83567', N'76424 79903 37682  72540 89417 55043', N'6576 5402 0065 4215', N'9076 5387 4193  7233 0818 3906', N'110 455 727', N'84 94 54 56')
INSERT [dbo].[ResultOfDay] ([Date], [DB], [NHAT], [NHI], [BA], [TU], [NAM], [SAU], [BAY]) VALUES (CAST(N'2023-10-22' AS Date), N'91918', N'71417', N'88769 04327', N'51414 00736 72340  97988 72175 71832', N'6133 5179 2610 9379', N'5776 3154 1993  8030 4721 1483', N'740 282 296', N'92 25 24 11')
INSERT [dbo].[ResultOfDay] ([Date], [DB], [NHAT], [NHI], [BA], [TU], [NAM], [SAU], [BAY]) VALUES (CAST(N'2023-10-23' AS Date), N'45844', N'81410', N'39827 16925', N'90991 80983 17191  17602 25316 06849', N'6536 0204 2560 3746', N'0908 6717 3361  8500 8619 8362', N'244 890 441', N'88 11 81 35')
INSERT [dbo].[ResultOfDay] ([Date], [DB], [NHAT], [NHI], [BA], [TU], [NAM], [SAU], [BAY]) VALUES (CAST(N'2023-10-24' AS Date), N'91388', N'78862', N'77232 16765', N'83198 94073 76943  75283 42518 84151', N'2559 0557 2718 5845', N'9655 5887 7722  2876 6540 3629', N'908 426 722', N'09 29 59 16')
INSERT [dbo].[ResultOfDay] ([Date], [DB], [NHAT], [NHI], [BA], [TU], [NAM], [SAU], [BAY]) VALUES (CAST(N'2023-10-25' AS Date), N'61380', N'92842', N'86347 06283', N'71520 66446 66318  53849 86752 45942', N'1379 8549 4174 9293', N'1616 0652 4193  3554 1132 6619', N'685 553 936', N'62 73 71 49')
INSERT [dbo].[ResultOfDay] ([Date], [DB], [NHAT], [NHI], [BA], [TU], [NAM], [SAU], [BAY]) VALUES (CAST(N'2023-10-26' AS Date), N'26788', N'71079', N'79633 89149', N'55454 66176 86152  37472 21527 79572', N'0476 8838 1384 2211', N'5306 1110 8681  7368 0619 3206', N'623 382 600', N'94 00 43 95')
INSERT [dbo].[ResultOfDay] ([Date], [DB], [NHAT], [NHI], [BA], [TU], [NAM], [SAU], [BAY]) VALUES (CAST(N'2023-10-27' AS Date), N'74036', N'90111', N'31208 23123', N'80782 05550 11973  66709 94867 90198', N'2407 9772 9695 9048', N'1855 6641 8290  9698 2413 3207', N'913 820 360', N'02 14 49 41')
INSERT [dbo].[ResultOfDay] ([Date], [DB], [NHAT], [NHI], [BA], [TU], [NAM], [SAU], [BAY]) VALUES (CAST(N'2023-10-28' AS Date), N'07157', N'12258', N'78073 22472', N'15755 38656 08969  86598 42614 30508', N'6489 0925 6537 1677', N'5598 1977 7565  9877 6528 5059', N'598 063 808', N'93 74 83 97')
INSERT [dbo].[ResultOfDay] ([Date], [DB], [NHAT], [NHI], [BA], [TU], [NAM], [SAU], [BAY]) VALUES (CAST(N'2023-10-29' AS Date), N'38050', N'04168', N'83796 74143', N'46175 33024 87212  07984 99654 49740', N'4498 5248 3927 6097', N'9698 0861 8674  7422 8367 3774', N'521 297 393', N'20 26 73 53')
INSERT [dbo].[ResultOfDay] ([Date], [DB], [NHAT], [NHI], [BA], [TU], [NAM], [SAU], [BAY]) VALUES (CAST(N'2023-10-30' AS Date), N'34684', N'07449', N'68543 68556', N'25283 29519 54803  06974 65945 63081', N'7503 1183 6318 1975', N'2186 9701 6753  9487 4244 4899', N'401 623 609', N'36 22 50 83')
INSERT [dbo].[ResultOfDay] ([Date], [DB], [NHAT], [NHI], [BA], [TU], [NAM], [SAU], [BAY]) VALUES (CAST(N'2023-10-31' AS Date), N'39267', N'84582', N'62863 95065', N'79114 13107 79397  07772 73053 25712', N'2594 2141 3225 1854', N'5872 5613 5111  0222 9299 1476', N'340 709 936', N'06 08 98 70')
INSERT [dbo].[ResultOfDay] ([Date], [DB], [NHAT], [NHI], [BA], [TU], [NAM], [SAU], [BAY]) VALUES (CAST(N'2023-11-01' AS Date), N'20136', N'25965', N'01743 60565', N'96391 07899 49997  26194 23877 05086', N'5020 6049 2639 2265', N'6853 5224 2100  1430 0589 0661', N'398 055 005', N'48 16 35 43')
INSERT [dbo].[ResultOfDay] ([Date], [DB], [NHAT], [NHI], [BA], [TU], [NAM], [SAU], [BAY]) VALUES (CAST(N'2023-11-02' AS Date), N'93127', N'54327', N'25283 02829', N'30079 05452 64446  73945 16590 87922', N'2606 9611 1221 0026', N'0668 6940 7478  8435 1725 5577', N'276 183 585', N'14 12 69 84')
INSERT [dbo].[ResultOfDay] ([Date], [DB], [NHAT], [NHI], [BA], [TU], [NAM], [SAU], [BAY]) VALUES (CAST(N'2023-11-03' AS Date), N'65761', N'49344', N'82925 55230', N'10031 99488 24592  44193 01536 02935', N'9661 3443 1256 0653', N'2510 4208 3379  3936 7639 5952', N'932 355 850', N'87 62 24 69')
INSERT [dbo].[ResultOfDay] ([Date], [DB], [NHAT], [NHI], [BA], [TU], [NAM], [SAU], [BAY]) VALUES (CAST(N'2023-11-04' AS Date), N'55858', N'39587', N'14699 14801', N'69206 21577 79651  94155 83586 76878', N'7685 8485 6429 5975', N'2775 2220 9758  7880 4704 9335', N'407 429 044', N'71 72 28 08')
INSERT [dbo].[ResultOfDay] ([Date], [DB], [NHAT], [NHI], [BA], [TU], [NAM], [SAU], [BAY]) VALUES (CAST(N'2023-11-05' AS Date), N'13484', N'62472', N'97647 30290', N'96683 64645 65882  83382 20464 22682', N'6452 9102 3170 3977', N'7528 6996 3815  7783 1529 0445', N'698 485 457', N'02 44 33 77')
INSERT [dbo].[ResultOfDay] ([Date], [DB], [NHAT], [NHI], [BA], [TU], [NAM], [SAU], [BAY]) VALUES (CAST(N'2023-11-06' AS Date), N'91484', N'12495', N'39738 55566', N'41141 02296 53869  51007 60891 56212', N'5822 9346 8559 8819', N'6894 6444 7848  8799 0114 7238', N'514 305 030', N'01 82 52 88')
INSERT [dbo].[ResultOfDay] ([Date], [DB], [NHAT], [NHI], [BA], [TU], [NAM], [SAU], [BAY]) VALUES (CAST(N'2023-11-07' AS Date), N'10949', N'97813', N'40248 97258', N'17172 53726 16571  15018 50843 54542', N'2387 7105 7024 0996', N'8370 7910 5928  1004 2693 8577', N'045 513 973', N'27 90 24 03')
INSERT [dbo].[ResultOfDay] ([Date], [DB], [NHAT], [NHI], [BA], [TU], [NAM], [SAU], [BAY]) VALUES (CAST(N'2023-11-08' AS Date), N'98526', N'98288', N'98391 09260', N'71869 77840 71704  54410 26927 61167', N'9313 4352 7579 1270', N'1329 6820 0124  2423 5389 2356', N'071 033 989', N'93 82 15 95')
INSERT [dbo].[ResultOfDay] ([Date], [DB], [NHAT], [NHI], [BA], [TU], [NAM], [SAU], [BAY]) VALUES (CAST(N'2023-11-09' AS Date), N'34562', N'39661', N'67957 16661', N'06243 10409 80709  63247 33362 51297', N'7945 1349 1037 1650', N'4615 2896 3092  9154 8815 6908', N'744 249 840', N'22 44 97 09')
INSERT [dbo].[ResultOfDay] ([Date], [DB], [NHAT], [NHI], [BA], [TU], [NAM], [SAU], [BAY]) VALUES (CAST(N'2023-11-10' AS Date), N'94670', N'63617', N'06517 67183', N'73264 81508 35774  70740 13362 49497', N'6748 0376 3592 9574', N'7457 7387 2244  3441 9081 5173', N'578 528 643', N'02 10 21 35')
INSERT [dbo].[ResultOfDay] ([Date], [DB], [NHAT], [NHI], [BA], [TU], [NAM], [SAU], [BAY]) VALUES (CAST(N'2023-11-11' AS Date), N'08391', N'10466', N'98837 12660', N'32013 97782 99924  14855 36394 62547', N'2966 0980 7346 0935', N'5641 7824 5937  5096 1970 2117', N'033 357 377', N'54 60 31 99')
INSERT [dbo].[ResultOfDay] ([Date], [DB], [NHAT], [NHI], [BA], [TU], [NAM], [SAU], [BAY]) VALUES (CAST(N'2023-11-12' AS Date), N'98375', N'76516', N'96169 75327', N'43330 15764 27087  13704 97836 25835', N'9431 1962 5810 4897', N'9119 0490 7211  2058 3074 0453', N'290 942 079', N'29 03 05 28')
INSERT [dbo].[ResultOfDay] ([Date], [DB], [NHAT], [NHI], [BA], [TU], [NAM], [SAU], [BAY]) VALUES (CAST(N'2023-11-13' AS Date), N'19412', N'85667', N'26906 22710', N'09590 96248 53294  43395 49876 53705', N'0546 8664 1572 8719', N'5678 1599 1893  6844 0749 9130', N'503 719 868', N'31 11 43 35')
INSERT [dbo].[ResultOfDay] ([Date], [DB], [NHAT], [NHI], [BA], [TU], [NAM], [SAU], [BAY]) VALUES (CAST(N'2023-11-14' AS Date), N'85800', N'00197', N'42692 64848', N'29100 63052 36810  40639 42349 75155', N'3675 2498 3669 6507', N'9587 3898 3298  5302 4643 3914', N'066 614 953', N'36 97 41 57')
INSERT [dbo].[ResultOfDay] ([Date], [DB], [NHAT], [NHI], [BA], [TU], [NAM], [SAU], [BAY]) VALUES (CAST(N'2023-11-15' AS Date), N'33859', N'98585', N'15030 42515', N'42098 91871 50318  01855 83971 19248', N'4323 2947 9183 2296', N'3696 2554 2052  1479 5643 5271', N'174 207 624', N'56 62 32 72')
INSERT [dbo].[ResultOfDay] ([Date], [DB], [NHAT], [NHI], [BA], [TU], [NAM], [SAU], [BAY]) VALUES (CAST(N'2023-11-16' AS Date), N'54869', N'34677', N'80583 17410', N'12119 75379 69729  45196 06463 06180', N'9936 0565 5964 1109', N'7356 9273 1879  6015 4125 3336', N'959 344 804', N'36 20 73 21')
INSERT [dbo].[ResultOfDay] ([Date], [DB], [NHAT], [NHI], [BA], [TU], [NAM], [SAU], [BAY]) VALUES (CAST(N'2023-11-17' AS Date), N'95110', N'91230', N'25848 37352', N'46596 92391 75545  86395 28746 58992', N'7879 2244 9001 6647', N'4782 2335 0826  9117 2981 5762', N'366 704 757', N'38 44 68 52')
INSERT [dbo].[ResultOfDay] ([Date], [DB], [NHAT], [NHI], [BA], [TU], [NAM], [SAU], [BAY]) VALUES (CAST(N'2023-11-18' AS Date), N'98371', N'77855', N'10658 79326', N'08768 35389 63003  45013 25896 58159', N'7512 3573 6252 6597', N'1270 2234 9849  9414 4541 8794', N'558 262 712', N'84 59 90 82')
INSERT [dbo].[ResultOfDay] ([Date], [DB], [NHAT], [NHI], [BA], [TU], [NAM], [SAU], [BAY]) VALUES (CAST(N'2023-11-19' AS Date), N'38429', N'02633', N'37498 40297', N'14331 95638 82894  72723 51994 85732', N'1243 0254 8383 9997', N'2136 7389 6623  6224 6833 9192', N'062 766 980', N'28 19 90 64')
INSERT [dbo].[ResultOfDay] ([Date], [DB], [NHAT], [NHI], [BA], [TU], [NAM], [SAU], [BAY]) VALUES (CAST(N'2023-11-20' AS Date), N'49071', N'99401', N'21782 88421', N'20081 95632 13518  48191 49925 22550', N'6986 8728 3505 6493', N'2182 4299 3534  5389 7960 6436', N'260 949 169', N'92 67 88 72')
INSERT [dbo].[ResultOfDay] ([Date], [DB], [NHAT], [NHI], [BA], [TU], [NAM], [SAU], [BAY]) VALUES (CAST(N'2023-11-21' AS Date), N'17948', N'51570', N'91263 22132', N'00523 03627 43013  06575 30407 70045', N'4513 6199 8246 3789', N'8601 7285 1129  0145 0142 0079', N'926 913 865', N'55 66 29 16')
INSERT [dbo].[ResultOfDay] ([Date], [DB], [NHAT], [NHI], [BA], [TU], [NAM], [SAU], [BAY]) VALUES (CAST(N'2023-11-22' AS Date), N'14670', N'55598', N'48326 78511', N'51702 36362 08564  49572 30361 71728', N'8348 0098 3900 8870', N'6408 7473 4056  4050 8122 8486', N'295 832 718', N'53 06 14 52')
INSERT [dbo].[ResultOfDay] ([Date], [DB], [NHAT], [NHI], [BA], [TU], [NAM], [SAU], [BAY]) VALUES (CAST(N'2023-11-23' AS Date), N'57999', N'27345', N'57014 50063', N'32466 88975 22112  69463 62612 65221', N'2456 8073 1231 9668', N'0256 0729 5497  2958 5424 4777', N'068 473 251', N'01 62 16 10')
INSERT [dbo].[ResultOfDay] ([Date], [DB], [NHAT], [NHI], [BA], [TU], [NAM], [SAU], [BAY]) VALUES (CAST(N'2023-11-24' AS Date), N'20952', N'00044', N'09136 65520', N'37660 91974 35253  52186 26203 32691', N'4463 9632 9958 5680', N'6964 1362 2611  0203 6272 9010', N'327 990 476', N'81 09 40 61')
INSERT [dbo].[ResultOfDay] ([Date], [DB], [NHAT], [NHI], [BA], [TU], [NAM], [SAU], [BAY]) VALUES (CAST(N'2023-11-25' AS Date), N'08816', N'27324', N'11953 24697', N'69110 04565 34068  51050 01507 34991', N'6108 5491 7718 6815', N'0369 9606 8760  7104 5179 0112', N'833 331 214', N'44 73 63 26')
INSERT [dbo].[ResultOfDay] ([Date], [DB], [NHAT], [NHI], [BA], [TU], [NAM], [SAU], [BAY]) VALUES (CAST(N'2023-11-26' AS Date), N'11873', N'79812', N'47282 88599', N'70943 22982 59952  37117 45252 21860', N'1123 4002 3496 2068', N'4388 0945 3653  5957 2143 9067', N'706 799 886', N'20 53 07 84')
INSERT [dbo].[ResultOfDay] ([Date], [DB], [NHAT], [NHI], [BA], [TU], [NAM], [SAU], [BAY]) VALUES (CAST(N'2023-11-27' AS Date), N'84757', N'74703', N'11900 12554', N'19791 04270 46759  59547 46181 41018', N'6537 8278 2059 1059', N'3927 1272 4079  5403 1036 9546', N'292 100 737', N'77 10 86 17')
INSERT [dbo].[ResultOfDay] ([Date], [DB], [NHAT], [NHI], [BA], [TU], [NAM], [SAU], [BAY]) VALUES (CAST(N'2023-11-28' AS Date), N'11913', N'00010', N'45748 26907', N'21383 29212 36806  31583 06432 05215', N'5903 8499 5218 4870', N'2036 5201 1028  1171 6609 2730', N'782 009 902', N'01 54 99 39')
INSERT [dbo].[ResultOfDay] ([Date], [DB], [NHAT], [NHI], [BA], [TU], [NAM], [SAU], [BAY]) VALUES (CAST(N'2023-11-29' AS Date), N'03141', N'42683', N'33410 77553', N'40459 27342 45945  67889 05550 03883', N'5665 3065 3233 2570', N'8938 3480 2573  5139 2488 1808', N'378 618 017', N'05 90 42 87')
INSERT [dbo].[ResultOfDay] ([Date], [DB], [NHAT], [NHI], [BA], [TU], [NAM], [SAU], [BAY]) VALUES (CAST(N'2023-11-30' AS Date), N'07426', N'98379', N'36655 42158', N'20547 19426 60986  16887 53632 79116', N'8229 9619 1705 7002', N'2436 1281 6999  0144 7407 1184', N'391 898 713', N'73 07 13 43')
INSERT [dbo].[ResultOfDay] ([Date], [DB], [NHAT], [NHI], [BA], [TU], [NAM], [SAU], [BAY]) VALUES (CAST(N'2023-12-01' AS Date), N'12301', N'78982', N'02630 94374', N'19187 84917 12364  34641 35984 38101', N'0620 6862 5300 7618', N'0918 6025 9110  3749 0894 8079', N'074 487 042', N'28 43 32 42')
INSERT [dbo].[ResultOfDay] ([Date], [DB], [NHAT], [NHI], [BA], [TU], [NAM], [SAU], [BAY]) VALUES (CAST(N'2023-12-02' AS Date), N'87485', N'17336', N'51133 12554', N'07135 21522 53104  80826 94365 61619', N'1255 4461 1512 3977', N'7172 5165 4923  7678 2530 2804', N'427 937 452', N'85 25 07 17')
INSERT [dbo].[ResultOfDay] ([Date], [DB], [NHAT], [NHI], [BA], [TU], [NAM], [SAU], [BAY]) VALUES (CAST(N'2023-12-03' AS Date), N'01716', N'77561', N'47720 88355', N'58888 22091 21180  93030 49821 58663', N'5620 5047 0428 6339', N'7437 0630 4896  2937 8774 2334', N'663 164 416', N'13 07 17 19')
INSERT [dbo].[ResultOfDay] ([Date], [DB], [NHAT], [NHI], [BA], [TU], [NAM], [SAU], [BAY]) VALUES (CAST(N'2023-12-04' AS Date), N'87694', N'91575', N'75033 08536', N'46248 65031 61731  92459 68147 45722', N'8312 4054 7046 6146', N'2837 7020 5316  7905 4018 9921', N'708 554 392', N'25 23 55 19')
INSERT [dbo].[ResultOfDay] ([Date], [DB], [NHAT], [NHI], [BA], [TU], [NAM], [SAU], [BAY]) VALUES (CAST(N'2023-12-05' AS Date), N'47521', N'07540', N'75731 73475', N'91273 55144 86736  99900 82341 11775', N'4831 7851 5581 2662', N'4138 8878 7384  1966 7257 5976', N'206 459 399', N'66 61 51 07')
INSERT [dbo].[ResultOfDay] ([Date], [DB], [NHAT], [NHI], [BA], [TU], [NAM], [SAU], [BAY]) VALUES (CAST(N'2023-12-06' AS Date), N'93178', N'49592', N'64119 45960', N'32137 68827 28080  32189 58244 14627', N'7688 4100 2489 4062', N'0011 2061 5417  1645 3408 5727', N'258 412 013', N'08 11 61 34')
INSERT [dbo].[ResultOfDay] ([Date], [DB], [NHAT], [NHI], [BA], [TU], [NAM], [SAU], [BAY]) VALUES (CAST(N'2023-12-07' AS Date), N'35627', N'13260', N'96217 17317', N'28340 60873 47641  19296 93791 58846', N'1425 0878 0269 6048', N'4114 5973 7447  0951 0213 1899', N'568 558 529', N'44 24 37 61')
INSERT [dbo].[ResultOfDay] ([Date], [DB], [NHAT], [NHI], [BA], [TU], [NAM], [SAU], [BAY]) VALUES (CAST(N'2023-12-08' AS Date), N'38223', N'77286', N'90185 84473', N'08584 79697 95286  76506 43075 76662', N'7394 0605 4471 5963', N'1127 8186 4005  2106 8507 6915', N'706 481 999', N'06 39 93 97')
INSERT [dbo].[ResultOfDay] ([Date], [DB], [NHAT], [NHI], [BA], [TU], [NAM], [SAU], [BAY]) VALUES (CAST(N'2023-12-09' AS Date), N'57057', N'21341', N'46196 43234', N'70433 04847 22751  81225 23585 86601', N'5292 6921 1013 2912', N'2594 8296 6698  1779 3989 6487', N'499 353 222', N'52 24 00 04')
INSERT [dbo].[ResultOfDay] ([Date], [DB], [NHAT], [NHI], [BA], [TU], [NAM], [SAU], [BAY]) VALUES (CAST(N'2023-12-10' AS Date), N'87360', N'29463', N'59670 85173', N'59452 73572 10791  73037 30913 85255', N'4173 1112 3763 1888', N'1518 0392 8758  2218 4504 5669', N'163 177 086', N'95 45 08 63')
INSERT [dbo].[ResultOfDay] ([Date], [DB], [NHAT], [NHI], [BA], [TU], [NAM], [SAU], [BAY]) VALUES (CAST(N'2023-12-11' AS Date), N'38038', N'02475', N'03846 53934', N'90956 89781 13882  01561 73501 93779', N'8318 6981 8615 9513', N'8328 3837 0107  9532 9879 1742', N'729 766 938', N'85 12 33 48')
INSERT [dbo].[ResultOfDay] ([Date], [DB], [NHAT], [NHI], [BA], [TU], [NAM], [SAU], [BAY]) VALUES (CAST(N'2023-12-12' AS Date), N'62970', N'39467', N'40628 04048', N'85828 50051 17798  87941 64115 64474', N'6711 8324 0621 5607', N'1058 6146 6328  5593 5917 7918', N'954 545 397', N'63 29 28 51')
INSERT [dbo].[ResultOfDay] ([Date], [DB], [NHAT], [NHI], [BA], [TU], [NAM], [SAU], [BAY]) VALUES (CAST(N'2023-12-13' AS Date), N'91706', N'82736', N'43914 21410', N'62100 28841 54653  02003 00059 46346', N'3044 7942 3115 2346', N'2092 6475 3946  3685 3452 1207', N'346 956 814', N'55 83 76 44')
INSERT [dbo].[ResultOfDay] ([Date], [DB], [NHAT], [NHI], [BA], [TU], [NAM], [SAU], [BAY]) VALUES (CAST(N'2023-12-14' AS Date), N'06245', N'38517', N'40644 70647', N'81520 69703 11751  71184 82277 25595', N'7806 3861 3836 2974', N'8284 0885 1003  4565 1675 1006', N'364 482 020', N'15 86 76 49')
INSERT [dbo].[ResultOfDay] ([Date], [DB], [NHAT], [NHI], [BA], [TU], [NAM], [SAU], [BAY]) VALUES (CAST(N'2023-12-15' AS Date), N'36904', N'34735', N'42033 38294', N'20473 82204 45516  49864 93509 66033', N'8906 8147 9572 2463', N'0060 5312 8432  6273 8809 2106', N'133 594 076', N'56 13 20 39')
INSERT [dbo].[ResultOfDay] ([Date], [DB], [NHAT], [NHI], [BA], [TU], [NAM], [SAU], [BAY]) VALUES (CAST(N'2023-12-16' AS Date), N'74825', N'27434', N'06579 72188', N'23116 29833 95690  82114 32305 85706', N'7725 7756 1294 7069', N'5389 7771 7486  9371 8494 5009', N'478 396 881', N'89 67 42 62')
INSERT [dbo].[ResultOfDay] ([Date], [DB], [NHAT], [NHI], [BA], [TU], [NAM], [SAU], [BAY]) VALUES (CAST(N'2023-12-17' AS Date), N'03257', N'14988', N'21865 30155', N'62858 00770 81163  91066 32492 88398', N'6066 8357 7220 9032', N'5532 5899 2304  2862 4668 1049', N'347 930 724', N'90 59 43 61')
INSERT [dbo].[ResultOfDay] ([Date], [DB], [NHAT], [NHI], [BA], [TU], [NAM], [SAU], [BAY]) VALUES (CAST(N'2023-12-18' AS Date), N'56732', N'82355', N'29094 60755', N'55043 23651 13729  65784 06766 72289', N'9490 4407 1910 7277', N'2748 1704 2614  2267 7259 1637', N'758 160 919', N'88 89 65 94')
INSERT [dbo].[ResultOfDay] ([Date], [DB], [NHAT], [NHI], [BA], [TU], [NAM], [SAU], [BAY]) VALUES (CAST(N'2023-12-19' AS Date), N'14577', N'66388', N'72506 57508', N'00305 65882 84801  38647 30901 12566', N'2019 7061 7062 9014', N'1202 5718 9539  9204 5379 0370', N'308 532 193', N'40 82 90 57')
INSERT [dbo].[ResultOfDay] ([Date], [DB], [NHAT], [NHI], [BA], [TU], [NAM], [SAU], [BAY]) VALUES (CAST(N'2023-12-20' AS Date), N'64978', N'46676', N'26187 87330', N'27023 12499 01735  36355 27195 68410', N'9210 3977 6990 5236', N'3041 3863 7189  4047 6779 5495', N'419 782 193', N'13 21 90 50')
INSERT [dbo].[ResultOfDay] ([Date], [DB], [NHAT], [NHI], [BA], [TU], [NAM], [SAU], [BAY]) VALUES (CAST(N'2023-12-21' AS Date), N'88485', N'81423', N'48393 07890', N'51946 07983 63690  09200 68261 08586', N'8909 1980 4697 9087', N'9687 9617 6090  8526 3279 9866', N'403 775 949', N'83 21 41 81')
GO
INSERT [dbo].[ResultOfDay] ([Date], [DB], [NHAT], [NHI], [BA], [TU], [NAM], [SAU], [BAY]) VALUES (CAST(N'2023-12-22' AS Date), N'76711', N'52564', N'49212 38823', N'93262 07190 79116  44716 47391 84559', N'9818 2020 3376 8782', N'1832 9360 5435  0879 0951 8128', N'539 899 078', N'14 68 52 92')
INSERT [dbo].[ResultOfDay] ([Date], [DB], [NHAT], [NHI], [BA], [TU], [NAM], [SAU], [BAY]) VALUES (CAST(N'2023-12-23' AS Date), N'51416', N'85332', N'13364 46775', N'92641 78508 30249  10834 54932 63927', N'5847 1580 8587 8272', N'5195 8332 1395  9544 0506 7689', N'733 236 963', N'20 62 10 44')
INSERT [dbo].[ResultOfDay] ([Date], [DB], [NHAT], [NHI], [BA], [TU], [NAM], [SAU], [BAY]) VALUES (CAST(N'2023-12-24' AS Date), N'01243', N'37916', N'59482 35038', N'84947 66319 33665  08943 47178 78546', N'7854 3336 9083 7212', N'1120 8381 9628  5962 7004 3248', N'498 694 995', N'65 92 44 57')
INSERT [dbo].[ResultOfDay] ([Date], [DB], [NHAT], [NHI], [BA], [TU], [NAM], [SAU], [BAY]) VALUES (CAST(N'2023-12-25' AS Date), N'08225', N'66151', N'34859 56161', N'01662 81087 74454  48051 70005 40811', N'3581 1288 7240 1453', N'1667 6120 9163  7784 7119 2947', N'162 862 534', N'40 61 88 84')
INSERT [dbo].[ResultOfDay] ([Date], [DB], [NHAT], [NHI], [BA], [TU], [NAM], [SAU], [BAY]) VALUES (CAST(N'2023-12-26' AS Date), N'94636', N'47326', N'96142 87117', N'27903 60316 88517  90129 38052 18824', N'6196 3149 5598 6656', N'0120 2073 5725  9741 2775 6044', N'216 472 185', N'29 81 31 30')
INSERT [dbo].[ResultOfDay] ([Date], [DB], [NHAT], [NHI], [BA], [TU], [NAM], [SAU], [BAY]) VALUES (CAST(N'2023-12-27' AS Date), N'74817', N'34291', N'04124 07840', N'59324 21119 02648  37969 92032 72336', N'8327 6840 2090 5817', N'6421 4948 1917  7710 2618 5345', N'666 798 342', N'45 28 63 44')
INSERT [dbo].[ResultOfDay] ([Date], [DB], [NHAT], [NHI], [BA], [TU], [NAM], [SAU], [BAY]) VALUES (CAST(N'2023-12-28' AS Date), N'15131', N'17201', N'23972 59182', N'38568 83983 95738  34166 67038 60011', N'6923 1493 9579 2063', N'8051 6625 0511  4014 0525 6554', N'435 920 911', N'12 39 52 71')
INSERT [dbo].[ResultOfDay] ([Date], [DB], [NHAT], [NHI], [BA], [TU], [NAM], [SAU], [BAY]) VALUES (CAST(N'2023-12-29' AS Date), N'36120', N'01808', N'24143 89224', N'54587 09307 57960  57721 39016 39494', N'5586 6574 7750 5640', N'1559 8201 7221  9586 8938 6743', N'847 456 145', N'95 93 85 84')
INSERT [dbo].[ResultOfDay] ([Date], [DB], [NHAT], [NHI], [BA], [TU], [NAM], [SAU], [BAY]) VALUES (CAST(N'2023-12-30' AS Date), N'59380', N'24170', N'49908 46745', N'87619 76344 11483  19853 97310 05180', N'8176 5498 2068 1389', N'2264 7126 0265  3169 8803 5141', N'563 723 137', N'38 64 82 43')
INSERT [dbo].[ResultOfDay] ([Date], [DB], [NHAT], [NHI], [BA], [TU], [NAM], [SAU], [BAY]) VALUES (CAST(N'2023-12-31' AS Date), N'73758', N'80689', N'75152 42067', N'69905 79800 28338  29736 28168 24917', N'3277 9831 1686 1236', N'2848 6743 8909  8565 2489 7595', N'292 586 465', N'42 82 02 43')
INSERT [dbo].[ResultOfDay] ([Date], [DB], [NHAT], [NHI], [BA], [TU], [NAM], [SAU], [BAY]) VALUES (CAST(N'2024-01-01' AS Date), N'42932', N'66272', N'27370 68541', N'55788 04997 82222  02980 83746 18098', N'5667 8086 5934 0473', N'1851 1006 0384  6131 8065 5365', N'255 166 353', N'53 73 45 79')
INSERT [dbo].[ResultOfDay] ([Date], [DB], [NHAT], [NHI], [BA], [TU], [NAM], [SAU], [BAY]) VALUES (CAST(N'2024-01-02' AS Date), N'10956', N'44230', N'11435 21121', N'29001 29348 14423  05075 13469 49804', N'3705 3839 0998 9020', N'1408 5422 2848  4904 4073 2200', N'387 850 383', N'35 44 10 59')
INSERT [dbo].[ResultOfDay] ([Date], [DB], [NHAT], [NHI], [BA], [TU], [NAM], [SAU], [BAY]) VALUES (CAST(N'2024-01-03' AS Date), N'62495', N'61083', N'88825 25631', N'81244 41936 65835  18119 78762 30466', N'7275 3934 7969 3310', N'1198 2132 6734  7342 0172 3018', N'920 945 848', N'61 14 85 25')
INSERT [dbo].[ResultOfDay] ([Date], [DB], [NHAT], [NHI], [BA], [TU], [NAM], [SAU], [BAY]) VALUES (CAST(N'2024-01-04' AS Date), N'10240', N'34474', N'50418 44965', N'09694 12063 98849  11096 80662 43064', N'1261 9934 1267 7227', N'0113 5320 3130  4972 0271 6073', N'278 247 228', N'62 12 36 02')
INSERT [dbo].[ResultOfDay] ([Date], [DB], [NHAT], [NHI], [BA], [TU], [NAM], [SAU], [BAY]) VALUES (CAST(N'2024-01-05' AS Date), N'38267', N'08715', N'71363 28859', N'50469 00804 01569  47304 36547 91458', N'5367 6717 9652 1153', N'9201 2426 2161  8950 6793 5932', N'011 537 441', N'96 63 69 45')
INSERT [dbo].[ResultOfDay] ([Date], [DB], [NHAT], [NHI], [BA], [TU], [NAM], [SAU], [BAY]) VALUES (CAST(N'2024-01-06' AS Date), N'72794', N'84069', N'21604 16014', N'04012 40496 62097  07165 85606 43931', N'8124 4326 2175 2281', N'9781 2917 0303  9824 6836 6036', N'428 187 412', N'74 96 58 03')
INSERT [dbo].[ResultOfDay] ([Date], [DB], [NHAT], [NHI], [BA], [TU], [NAM], [SAU], [BAY]) VALUES (CAST(N'2024-01-07' AS Date), N'69618', N'77903', N'10601 27302', N'64369 67113 39541  91989 70398 06419', N'2465 5299 8705 5568', N'1279 2671 9902  2142 3112 6408', N'615 603 561', N'85 67 75 12')
INSERT [dbo].[ResultOfDay] ([Date], [DB], [NHAT], [NHI], [BA], [TU], [NAM], [SAU], [BAY]) VALUES (CAST(N'2024-01-08' AS Date), N'91089', N'52095', N'24298 86032', N'11702 12468 64339  84213 63964 15587', N'0375 1988 6675 2621', N'9023 5030 2454  6261 8831 2653', N'721 356 691', N'19 77 78 40')
INSERT [dbo].[ResultOfDay] ([Date], [DB], [NHAT], [NHI], [BA], [TU], [NAM], [SAU], [BAY]) VALUES (CAST(N'2024-01-09' AS Date), N'48877', N'34321', N'62959 65902', N'26683 31049 98561  68229 37571 53782', N'0360 5370 3054 4853', N'4143 7962 1775  2023 0455 3683', N'287 175 670', N'77 68 08 91')
INSERT [dbo].[ResultOfDay] ([Date], [DB], [NHAT], [NHI], [BA], [TU], [NAM], [SAU], [BAY]) VALUES (CAST(N'2024-01-10' AS Date), N'73732', N'50059', N'19807 73809', N'66964 33254 07140  58867 39737 18690', N'2491 3655 4882 4833', N'2714 2679 1364  4418 4801 4632', N'105 627 143', N'95 84 83 53')
INSERT [dbo].[ResultOfDay] ([Date], [DB], [NHAT], [NHI], [BA], [TU], [NAM], [SAU], [BAY]) VALUES (CAST(N'2024-01-11' AS Date), N'28285', N'45785', N'14065 97397', N'20245 50613 86575  83291 97109 29793', N'1447 8321 7343 5081', N'3322 1578 6731  2390 3687 3549', N'185 547 711', N'82 23 28 84')
INSERT [dbo].[ResultOfDay] ([Date], [DB], [NHAT], [NHI], [BA], [TU], [NAM], [SAU], [BAY]) VALUES (CAST(N'2024-01-12' AS Date), N'13113', N'39786', N'66200 15781', N'57716 05600 89058  37477 31125 85815', N'2872 4210 3055 7656', N'5975 9865 4483  4984 9833 9996', N'906 600 547', N'02 93 53 59')
INSERT [dbo].[ResultOfDay] ([Date], [DB], [NHAT], [NHI], [BA], [TU], [NAM], [SAU], [BAY]) VALUES (CAST(N'2024-01-13' AS Date), N'68586', N'68404', N'00715 37358', N'42487 35931 84669  00195 50191 47172', N'7115 9490 6813 5843', N'4317 2315 7929  3632 1844 6497', N'990 475 786', N'17 99 63 85')
INSERT [dbo].[ResultOfDay] ([Date], [DB], [NHAT], [NHI], [BA], [TU], [NAM], [SAU], [BAY]) VALUES (CAST(N'2024-01-14' AS Date), N'91138', N'42203', N'16727 62518', N'40212 38181 55475  98984 20314 05059', N'8841 4036 0947 9799', N'9576 2316 6534  0618 1125 2257', N'115 313 503', N'71 91 34 85')
INSERT [dbo].[ResultOfDay] ([Date], [DB], [NHAT], [NHI], [BA], [TU], [NAM], [SAU], [BAY]) VALUES (CAST(N'2024-01-15' AS Date), N'63261', N'52395', N'54221 54937', N'21642 72620 46915  40939 66975 95237', N'9526 9444 4855 6097', N'3145 6073 1774  9335 2193 0747', N'934 367 864', N'94 59 67 21')
INSERT [dbo].[ResultOfDay] ([Date], [DB], [NHAT], [NHI], [BA], [TU], [NAM], [SAU], [BAY]) VALUES (CAST(N'2024-01-16' AS Date), N'95539', N'74503', N'37428 62493', N'55215 62742 75409  13209 28223 02871', N'3363 5407 6781 8041', N'3501 3855 6093  3392 6002 4492', N'236 215 743', N'90 79 37 58')
INSERT [dbo].[ResultOfDay] ([Date], [DB], [NHAT], [NHI], [BA], [TU], [NAM], [SAU], [BAY]) VALUES (CAST(N'2024-01-17' AS Date), N'76553', N'07527', N'25937 28719', N'68694 85484 43187  37080 52543 51209', N'4630 6891 8515 2367', N'4217 6752 4070  4451 3126 6144', N'716 933 076', N'03 35 11 50')
INSERT [dbo].[ResultOfDay] ([Date], [DB], [NHAT], [NHI], [BA], [TU], [NAM], [SAU], [BAY]) VALUES (CAST(N'2024-01-18' AS Date), N'54998', N'54578', N'92914 81659', N'67486 76176 28243  25690 97325 27064', N'0717 5736 1747 7684', N'3998 8610 3999  4749 8700 9998', N'933 271 914', N'77 23 11 48')
INSERT [dbo].[ResultOfDay] ([Date], [DB], [NHAT], [NHI], [BA], [TU], [NAM], [SAU], [BAY]) VALUES (CAST(N'2024-01-19' AS Date), N'14609', N'36645', N'12735 35132', N'85646 63234 96221  05950 51526 75074', N'6682 9638 7631 3787', N'7833 7893 7435  8411 0155 6886', N'075 481 224', N'17 69 88 61')
INSERT [dbo].[ResultOfDay] ([Date], [DB], [NHAT], [NHI], [BA], [TU], [NAM], [SAU], [BAY]) VALUES (CAST(N'2024-01-20' AS Date), N'70964', N'63165', N'28516 01426', N'22000 81011 57868  69890 20338 75326', N'6639 6539 8347 8500', N'4844 2630 9577  0659 4915 6153', N'652 729 810', N'77 93 39 13')
INSERT [dbo].[ResultOfDay] ([Date], [DB], [NHAT], [NHI], [BA], [TU], [NAM], [SAU], [BAY]) VALUES (CAST(N'2024-01-21' AS Date), N'45819', N'88820', N'92317 88686', N'03064 58435 11519  64759 52956 88514', N'1349 0927 3528 0716', N'1179 1641 6637  9021 2311 1232', N'765 742 034', N'28 76 18 13')
INSERT [dbo].[ResultOfDay] ([Date], [DB], [NHAT], [NHI], [BA], [TU], [NAM], [SAU], [BAY]) VALUES (CAST(N'2024-01-22' AS Date), N'36910', N'79118', N'28263 37729', N'39344 36781 97614  33735 51836 41688', N'7547 3433 7982 3523', N'6779 9563 5686  2191 7374 3556', N'252 534 420', N'60 13 65 17')
INSERT [dbo].[ResultOfDay] ([Date], [DB], [NHAT], [NHI], [BA], [TU], [NAM], [SAU], [BAY]) VALUES (CAST(N'2024-01-23' AS Date), N'87441', N'45966', N'06221 88252', N'27745 45816 68217  41517 41912 32545', N'7691 4975 9911 6182', N'6097 1046 6006  2575 2298 6725', N'022 468 449', N'74 00 49 11')
INSERT [dbo].[ResultOfDay] ([Date], [DB], [NHAT], [NHI], [BA], [TU], [NAM], [SAU], [BAY]) VALUES (CAST(N'2024-01-24' AS Date), N'61661', N'38229', N'62307 85674', N'78595 93756 52006  58616 27202 51549', N'5803 5520 2836 8290', N'3309 6125 7243  4089 2338 8508', N'524 731 081', N'57 22 11 69')
INSERT [dbo].[ResultOfDay] ([Date], [DB], [NHAT], [NHI], [BA], [TU], [NAM], [SAU], [BAY]) VALUES (CAST(N'2024-01-25' AS Date), N'77375', N'14114', N'99404 53941', N'45239 92327 58366  84517 71158 13890', N'9479 8648 0493 9881', N'3961 3599 4206  2625 2201 8153', N'912 735 727', N'56 24 57 42')
INSERT [dbo].[ResultOfDay] ([Date], [DB], [NHAT], [NHI], [BA], [TU], [NAM], [SAU], [BAY]) VALUES (CAST(N'2024-01-26' AS Date), N'20347', N'29197', N'19218 63399', N'82560 80548 17544  73396 45107 10888', N'4359 6568 4811 1038', N'1823 8447 2579  2491 2352 8442', N'947 733 318', N'58 56 20 06')
INSERT [dbo].[ResultOfDay] ([Date], [DB], [NHAT], [NHI], [BA], [TU], [NAM], [SAU], [BAY]) VALUES (CAST(N'2024-01-27' AS Date), N'61579', N'32521', N'73337 11395', N'59715 94737 28391  77040 95480 36972', N'1670 3770 7223 0876', N'6094 5417 4724  5620 5716 3868', N'049 531 791', N'27 75 91 10')
INSERT [dbo].[ResultOfDay] ([Date], [DB], [NHAT], [NHI], [BA], [TU], [NAM], [SAU], [BAY]) VALUES (CAST(N'2024-01-28' AS Date), N'68274', N'93911', N'25484 47616', N'11003 93986 15302  61278 13916 23900', N'1710 1445 4678 9751', N'5496 0228 3343  5479 4126 8089', N'221 438 853', N'87 65 49 41')
INSERT [dbo].[ResultOfDay] ([Date], [DB], [NHAT], [NHI], [BA], [TU], [NAM], [SAU], [BAY]) VALUES (CAST(N'2024-01-29' AS Date), N'75346', N'98171', N'23541 90743', N'98189 71152 09412  86414 11035 95289', N'2771 3474 5314 0609', N'0912 7238 9154  8750 1011 0265', N'156 432 799', N'81 83 09 85')
INSERT [dbo].[ResultOfDay] ([Date], [DB], [NHAT], [NHI], [BA], [TU], [NAM], [SAU], [BAY]) VALUES (CAST(N'2024-01-30' AS Date), N'08524', N'80556', N'02056 55365', N'93363 16503 50553  55436 44146 19053', N'3556 7688 6096 0141', N'4932 4683 4211  6357 9871 5990', N'921 194 760', N'38 26 83 95')
INSERT [dbo].[ResultOfDay] ([Date], [DB], [NHAT], [NHI], [BA], [TU], [NAM], [SAU], [BAY]) VALUES (CAST(N'2024-01-31' AS Date), N'47666', N'58427', N'64931 25644', N'03576 08099 93000  05237 32951 82863', N'3767 5450 1997 6766', N'1336 0386 7369  1740 4840 8051', N'296 125 966', N'68 53 82 27')
INSERT [dbo].[ResultOfDay] ([Date], [DB], [NHAT], [NHI], [BA], [TU], [NAM], [SAU], [BAY]) VALUES (CAST(N'2024-02-01' AS Date), N'87444', N'41182', N'94959 51442', N'93301 62187 40592  47470 69528 79028', N'7292 4118 0777 5462', N'8254 4416 2280  9154 5079 9784', N'115 186 944', N'32 61 77 99')
INSERT [dbo].[ResultOfDay] ([Date], [DB], [NHAT], [NHI], [BA], [TU], [NAM], [SAU], [BAY]) VALUES (CAST(N'2024-02-02' AS Date), N'28174', N'06876', N'66471 38080', N'94163 33797 50042  94635 65908 04190', N'8084 7218 0384 3702', N'2551 4867 7331  8796 6677 5394', N'755 539 280', N'93 55 68 05')
INSERT [dbo].[ResultOfDay] ([Date], [DB], [NHAT], [NHI], [BA], [TU], [NAM], [SAU], [BAY]) VALUES (CAST(N'2024-02-03' AS Date), N'33389', N'80369', N'55380 69435', N'92942 94293 36365  34162 09641 10284', N'0221 1633 1716 6658', N'0122 2297 2514  8365 7192 3441', N'236 119 442', N'12 35 88 18')
INSERT [dbo].[ResultOfDay] ([Date], [DB], [NHAT], [NHI], [BA], [TU], [NAM], [SAU], [BAY]) VALUES (CAST(N'2024-02-04' AS Date), N'13300', N'06268', N'67798 98842', N'09251 37297 78533  05661 30866 26814', N'4278 1420 5112 9414', N'1534 1478 8664  1159 7081 3687', N'446 627 656', N'44 04 97 41')
INSERT [dbo].[ResultOfDay] ([Date], [DB], [NHAT], [NHI], [BA], [TU], [NAM], [SAU], [BAY]) VALUES (CAST(N'2024-02-05' AS Date), N'69876', N'47161', N'54779 83038', N'54035 40526 22723  04016 92542 30851', N'1932 1071 3559 6332', N'2140 4907 6780  8375 6102 2349', N'806 060 590', N'07 35 81 22')
INSERT [dbo].[ResultOfDay] ([Date], [DB], [NHAT], [NHI], [BA], [TU], [NAM], [SAU], [BAY]) VALUES (CAST(N'2024-02-06' AS Date), N'91267', N'65567', N'49583 27981', N'28941 63811 68505  68457 98492 31709', N'1990 1136 7461 6895', N'2312 4696 2846  0206 8873 3910', N'017 320 886', N'52 59 84 15')
INSERT [dbo].[ResultOfDay] ([Date], [DB], [NHAT], [NHI], [BA], [TU], [NAM], [SAU], [BAY]) VALUES (CAST(N'2024-02-07' AS Date), N'67384', N'41504', N'84043 71031', N'23490 95377 73674  51711 88162 69864', N'9296 1005 2278 5705', N'2043 7662 9506  3669 1073 3804', N'638 152 189', N'62 18 99 53')
INSERT [dbo].[ResultOfDay] ([Date], [DB], [NHAT], [NHI], [BA], [TU], [NAM], [SAU], [BAY]) VALUES (CAST(N'2024-02-08' AS Date), N'85852', N'17339', N'81504 61590', N'11923 39951 06845  01815 93739 55388', N'9488 7388 2208 9004', N'9570 5276 3461  7388 5303 6573', N'473 597 056', N'42 31 21 27')
INSERT [dbo].[ResultOfDay] ([Date], [DB], [NHAT], [NHI], [BA], [TU], [NAM], [SAU], [BAY]) VALUES (CAST(N'2024-02-13' AS Date), N'39100', N'22276', N'21547 14250', N'25123 77887 46966  34620 73311 14277', N'6749 3710 6705 8203', N'1050 0680 0240  0711 5203 7214', N'944 182 395', N'63 99 31 02')
INSERT [dbo].[ResultOfDay] ([Date], [DB], [NHAT], [NHI], [BA], [TU], [NAM], [SAU], [BAY]) VALUES (CAST(N'2024-02-14' AS Date), N'17670', N'67840', N'87976 05804', N'15037 87341 44090  35540 11601 11274', N'6083 0603 6674 3990', N'4637 1874 2362  2894 1326 2503', N'951 967 787', N'53 22 15 54')
INSERT [dbo].[ResultOfDay] ([Date], [DB], [NHAT], [NHI], [BA], [TU], [NAM], [SAU], [BAY]) VALUES (CAST(N'2024-02-15' AS Date), N'48331', N'33214', N'95565 75869', N'85035 50958 42526  30662 77408 94544', N'6513 1726 6179 2439', N'2241 5718 6452  7022 5061 7065', N'333 911 376', N'51 10 20 70')
INSERT [dbo].[ResultOfDay] ([Date], [DB], [NHAT], [NHI], [BA], [TU], [NAM], [SAU], [BAY]) VALUES (CAST(N'2024-02-16' AS Date), N'34864', N'00693', N'97331 18776', N'56995 55805 26599  22435 58098 35835', N'8683 1661 7450 8941', N'8695 2954 6320  0276 2666 1431', N'720 634 467', N'98 29 58 84')
INSERT [dbo].[ResultOfDay] ([Date], [DB], [NHAT], [NHI], [BA], [TU], [NAM], [SAU], [BAY]) VALUES (CAST(N'2024-02-17' AS Date), N'58294', N'03133', N'84216 14018', N'87942 42677 33889  80351 42249 29632', N'4666 5495 8905 6655', N'5821 1407 8445  7612 9721 1589', N'062 725 757', N'73 92 62 67')
INSERT [dbo].[ResultOfDay] ([Date], [DB], [NHAT], [NHI], [BA], [TU], [NAM], [SAU], [BAY]) VALUES (CAST(N'2024-02-18' AS Date), N'39903', N'64007', N'94691 49556', N'47851 91743 87428  63645 97610 97288', N'0270 5179 3109 4524', N'3849 9190 0418  6950 1098 3962', N'093 429 132', N'56 97 14 64')
INSERT [dbo].[ResultOfDay] ([Date], [DB], [NHAT], [NHI], [BA], [TU], [NAM], [SAU], [BAY]) VALUES (CAST(N'2024-02-19' AS Date), N'75801', N'19995', N'93219 56742', N'13459 21260 02582  01053 92502 27859', N'1440 1020 4024 9170', N'0057 6215 3858  8144 3559 8224', N'554 331 982', N'64 85 24 66')
INSERT [dbo].[ResultOfDay] ([Date], [DB], [NHAT], [NHI], [BA], [TU], [NAM], [SAU], [BAY]) VALUES (CAST(N'2024-02-20' AS Date), N'57406', N'97758', N'37216 24939', N'30032 78750 31430  43822 43341 22605', N'7939 8580 7131 0783', N'0866 9656 7260  4515 7573 3621', N'592 419 079', N'68 18 78 00')
INSERT [dbo].[ResultOfDay] ([Date], [DB], [NHAT], [NHI], [BA], [TU], [NAM], [SAU], [BAY]) VALUES (CAST(N'2024-02-21' AS Date), N'99937', N'73548', N'40187 24052', N'45049 69513 00318  99864 37934 67528', N'9969 4749 3131 7918', N'5983 3688 4919  7340 8836 1898', N'661 051 291', N'08 64 72 91')
INSERT [dbo].[ResultOfDay] ([Date], [DB], [NHAT], [NHI], [BA], [TU], [NAM], [SAU], [BAY]) VALUES (CAST(N'2024-02-22' AS Date), N'82488', N'52311', N'07072 42726', N'40481 49867 76166  29399 36193 63578', N'9404 2834 6012 1448', N'4126 1347 1048  7295 7820 8038', N'450 637 460', N'25 70 90 13')
INSERT [dbo].[ResultOfDay] ([Date], [DB], [NHAT], [NHI], [BA], [TU], [NAM], [SAU], [BAY]) VALUES (CAST(N'2024-02-23' AS Date), N'16053', N'88635', N'25337 63488', N'59775 29439 27290  24040 82530 67189', N'0547 6741 7941 7289', N'7824 5469 8625  7168 1204 5983', N'308 973 820', N'79 00 93 45')
GO
ALTER TABLE [dbo].[KUBET] ADD  CONSTRAINT [DF_KUBET_DateCreated]  DEFAULT (getdate()) FOR [DateCreated]
GO
/****** Object:  StoredProcedure [dbo].[sp_DaySoDep]    Script Date: 2/24/2024 12:03:59 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


















CREATE PROC [dbo].[sp_DaySoDep]
@date date
as
 

 select
  FORMAT(cast(SUM(CASE WHEN T2.BT IS NOT NULL THEN 1 ELSE 0 END) OVER(PARTITION BY 1 )  as float)
/COUNT(*) OVER(PARTITION BY 1 )* 100,'0.0') AS Tile,
 SUM(CASE WHEN T2.BT IS NOT NULL THEN 1 ELSE 0 END) OVER(PARTITION BY 1 ) AS OK
 ,COUNT(*) OVER(PARTITION BY 1 ) AS Total
 ,t1.*,t2.*
 ,t3.CNT as N'T3.CNT THÁNG'
  ,t4.DAY as N'T4.DB'
 ,t5.CNT as N'T5.HÔM QUA'
 ,t6.CNT as N'T6.HÔM KIA'
 ,t9.CNT as N'T9.HÔM KÌA'
  ,t7.CNT as N'T7.CNT TUẦN'
 ,T15.CNT as N'T15.CNT TUẦN TRƯỚC'
 ,t8.CNT as N'T8.3 NGÀY'
 ,T10.CNT AS N'T10.Đầu số hôm qua'
 ,T14.CNT AS N'T14.Đuôi số hôm qua'
 ,T11.CNT AS N'T11.Số ở  7  ngày hôm qua'
 ,T12.CNT AS N'T12.g.7 hôm qua'
  
   from DataNumber T1 
 
   LEFT JOIN  V_ResultOfDay T2 ON T1.BT =T2.BT  and date=@DATE  
 -- SỐ LẦN XUẤT HIỆN TRONG THÁNG
 LEFT JOIN (
 select  BT,COUNT(*) CNT  FROM  V_ResultOfDay WHERE date between  DATEADD(DAY,-30,@DATE)  and  DATEADD(DAY,-1,@DATE) 
 GROUP BY BT  ) T3 ON T1.BT =T3.BT
 -- NHỮNG SỐ ĐÃ TRÚNG GIẢI ĐẶC BIỆT
 LEFT JOIN (
SELECT BT,STRING_AGG(FORMAT(DATE,'dd/MM'),',') DAY  FROM [SC].[dbo].[V_ResultOfDay]    where date between  DATEADD(DAY,-30,@DATE)  and  DATEADD(DAY,-1,@DATE)     and giai in ('db' )
group by bt) T4 ON T1.BT= T4.BT
-- NHỮNG SỐ ĐÃ VỀ NGÀY HÔM QUA
 LEFT JOIN (
SELECT   BT,COUNT(*) CNT  FROM [SC].[dbo].[V_ResultOfDay]    where date =  DATEADD(DAY,-1,@DATE)    
group by bt) T5 ON T1.BT= T5.BT
 
-- NHỮNG SỐ ĐÃ VỀ NGÀY HÔM KIA
 LEFT JOIN (
SELECT   BT,COUNT(*) CNT  FROM [SC].[dbo].[V_ResultOfDay]    where date =  DATEADD(DAY,-2,@DATE)    
group by bt) T6 ON T1.BT= T6.BT
  -- SỐ LẦN XUẤT HIỆN TRONG TUẦN
 LEFT JOIN (
 select  BT,COUNT(*) CNT  FROM  V_ResultOfDay WHERE date between  DATEADD(DAY,-7,@DATE)  and  DATEADD(DAY,-1,@DATE) 
 GROUP BY BT  ) T7 ON T1.BT =T7.BT

   -- SỐ LẦN XUẤT HIỆN TRONG  3 NGÀY
 LEFT JOIN (
 select  BT,COUNT(*) CNT  FROM  V_ResultOfDay WHERE date between  DATEADD(DAY,-3,@DATE)  and  DATEADD(DAY,-1,@DATE) 
 GROUP BY BT  ) T8 ON T1.BT =T8.BT
 
 
-- NHỮNG SỐ ĐÃ VỀ NGÀY HÔM KÌA
 LEFT JOIN (
SELECT   BT,COUNT(*) CNT  FROM [SC].[dbo].[V_ResultOfDay]    where date =  DATEADD(DAY,-3,@DATE)    
group by bt) T9 ON T1.BT= T9.BT

-- Đầu số đã về bao nháy ngày hôm qua
 LEFT JOIN (
SELECT   LEFT(bt,1) BT,COUNT(*) CNT  FROM [SC].[dbo].[V_ResultOfDay]    where date  =  DATEADD(DAY,-1,@DATE)  
group by LEFT(bt,1)) T10 ON left(T1.BT,1)= T10.BT


-- Số ở giải 7 ngày hôm qua
 LEFT JOIN (
SELECT BT,COUNT(*) CNT  FROM [SC].[dbo].[V_ResultOfDay]    where  date between  DATEADD(DAY,-7,@DATE)  and  DATEADD(DAY,-1,@DATE)   and giai in('NHAT','db')
group by bt) T11 ON T1.BT= T11.BT


-- Số ở giải   hôm qua
 LEFT JOIN (
SELECT     BT,COUNT(*) CNT  FROM [SC].[dbo].[V_ResultOfDay]    where  date between  DATEADD(DAY,-7,@DATE)  and  DATEADD(DAY,-1,@DATE)   and giai='bay'
group by bt) T12 ON T1.BT= T12.BT
 
 -- Đầu số đã về bao nháy ngày hôm KIA
 LEFT JOIN (
SELECT   right(bt,1) BT,COUNT(*) CNT  FROM [SC].[dbo].[V_ResultOfDay]    where  date  =  DATEADD(DAY,-2,@DATE)  
group by right(bt,1)) T14 ON right(T1.BT,1)= T14.BT
   -- SỐ LẦN XUẤT HIỆN TUẦN TRƯỚC
 LEFT JOIN (
 select  BT,COUNT(*) CNT  FROM  V_ResultOfDay WHERE date between  DATEADD(DAY,-14,@DATE)  and  DATEADD(DAY,-7,@DATE) 
 GROUP BY BT  ) T15 ON T1.BT =T15.BT
 where 
 1=1
 
 AND T3.CNT BETWEEN 1 AND 10
 -- NẾU HÔM QUA VỀ RỒI THÌ HÔM NAY BỎ
  -- Nếu về giải đặc b	iệt 30 ngày cũng bỏ
 and T7.BT is    null
 --and T4.BT is    null
 --and T8.BT is    null
 --and T5.CNT is    null
 --and T9.CNT is    null
 ----
  --AND   T7.CNT <5
 -- AND   T14.CNT is not null
 --AND   T15.CNT is not null
 --AND   T12.CNT is   null
 AND  ISNULL(T15.CNT,0) <= 3
 AND  ISNULL(T5.CNT,0) <5
 AND  ISNULL(T6.CNT,0) <5
 AND  ISNULL(T9.CNT,0) <5
 AND  ISNULL(T14.CNT,0) <5
 AND  ISNULL(T10.CNT,0) <6

  ORDER BY t2.BT desc
GO
/****** Object:  StoredProcedure [dbo].[sp_DaySoDep_TrungGiai]    Script Date: 2/24/2024 12:03:59 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROC [dbo].[sp_DaySoDep_TrungGiai]
@date date
as
CREATE TABLE #Testing 
(
   BT NVARCHAR(10),
   
)

INSERT INTO #Testing 
 exec sp_DaySoDep  @date   =@date

   SELECT * FROM V_ResultOfDay WHERE DATE=DATEADD(DAY,1,@date) AND BT in (SELECT * FROM #Testing)
 --DROP TABLE #A2
  
 DROP TABLE  #Testing
GO
/****** Object:  StoredProcedure [dbo].[sp_TinhGiaiDB]    Script Date: 2/24/2024 12:03:59 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
 CREATE proc [dbo].[sp_TinhGiaiDB]
@DATE DATE  
as 
 select  
 COUNT(*) OVER(PARTITION BY 1 ) AS Total
 ,t1.*,t2.giai
 ,t3.CNT as N'T3.CNT THÁNG'
  ,t4.DAY as N'T4.DB'
 ,t5.CNT as N'T5.HÔM QUA'
 ,t6.CNT as N'T6.HÔM KIA'
 ,t9.CNT as N'T9.HÔM KÌA'
  ,t7.CNT as N'T7.CNT TUẦN'
 ,T15.CNT as N'T15.CNT TUẦN TRƯỚC'
 ,t8.CNT as N'T8.3 NGÀY'
 ,T10.CNT AS N'T10.Đầu số hôm qua'
 ,T14.CNT AS N'T14.Đuôi số hôm qua'
 ,T11.CNT AS N'T11.Số ở  7  ngày hôm qua'
 ,T12.CNT AS N'T12.g.7 hôm qua'
  
   from V_DataNumber T1 
 
   LEFT JOIN  V_ResultOfDay T2 ON T1.BT =T2.BT  and date=@DATE and t2.giai='DB'
 -- SỐ LẦN XUẤT HIỆN TRONG THÁNG
 LEFT JOIN (
 select  BT,COUNT(*) CNT  FROM  V_ResultOfDay WHERE date between  DATEADD(DAY,-30,@DATE)  and  DATEADD(DAY,-1,@DATE) 
 GROUP BY BT  ) T3 ON T1.BT =T3.BT
 -- NHỮNG SỐ ĐÃ TRÚNG GIẢI ĐẶC BIỆT
 LEFT JOIN (
SELECT BT,STRING_AGG(FORMAT(DATE,'dd/MM'),',') DAY  FROM [SC].[dbo].[V_ResultOfDay]    where

date between  DATEADD(DAY,-120,@DATE)  and  DATEADD(DAY,-1,@DATE)     and giai in ('db' )
group by bt) T4 ON T1.BT= T4.BT
-- NHỮNG SỐ ĐÃ VỀ NGÀY HÔM QUA
 LEFT JOIN (
SELECT   BT,COUNT(*) CNT  FROM [SC].[dbo].[V_ResultOfDay]    where date =  DATEADD(DAY,-1,@DATE)    
group by bt) T5 ON T1.BT= T5.BT
 
-- NHỮNG SỐ ĐÃ VỀ NGÀY HÔM KIA
 LEFT JOIN (
SELECT   BT,COUNT(*) CNT  FROM [SC].[dbo].[V_ResultOfDay]    where date =  DATEADD(DAY,-2,@DATE)    
group by bt) T6 ON T1.BT= T6.BT
  -- SỐ LẦN XUẤT HIỆN TRONG TUẦN
 LEFT JOIN (
 select  BT,COUNT(*) CNT  FROM  V_ResultOfDay WHERE date between  DATEADD(DAY,-7,@DATE)  and  DATEADD(DAY,-1,@DATE) 
 GROUP BY BT  ) T7 ON T1.BT =T7.BT

   -- SỐ LẦN XUẤT HIỆN TRONG  3 NGÀY
 LEFT JOIN (
 select  BT,COUNT(*) CNT  FROM  V_ResultOfDay WHERE date between  DATEADD(DAY,-3,@DATE)  and  DATEADD(DAY,-1,@DATE) 
 GROUP BY BT  ) T8 ON T1.BT =T8.BT
 
 
-- NHỮNG SỐ ĐÃ VỀ NGÀY HÔM KÌA
 LEFT JOIN (
SELECT   BT,COUNT(*) CNT  FROM [SC].[dbo].[V_ResultOfDay]    where date =  DATEADD(DAY,-3,@DATE)    
group by bt) T9 ON T1.BT= T9.BT

-- Đầu số đã về bao nháy ngày hôm qua
 LEFT JOIN (
SELECT   LEFT(bt,1) BT,COUNT(*) CNT  FROM [SC].[dbo].[V_ResultOfDay]    where date  =  DATEADD(DAY,-1,@DATE)  
group by LEFT(bt,1)) T10 ON left(T1.BT,1)= T10.BT


-- Số ở giải 7 ngày hôm qua
 LEFT JOIN (
SELECT BT,COUNT(*) CNT  FROM [SC].[dbo].[V_ResultOfDay]    where  date between  DATEADD(DAY,-7,@DATE)  and  DATEADD(DAY,-1,@DATE)   and giai in('NHAT','db')
group by bt) T11 ON T1.BT= T11.BT


-- Số ở giải   hôm qua
 LEFT JOIN (
SELECT     BT,COUNT(*) CNT  FROM [SC].[dbo].[V_ResultOfDay]    where  date between  DATEADD(DAY,-7,@DATE)  and  DATEADD(DAY,-1,@DATE)   and giai='bay'
group by bt) T12 ON T1.BT= T12.BT
 
 -- Đầu số đã về bao nháy ngày hôm KIA
 LEFT JOIN (
SELECT   right(bt,1) BT,COUNT(*) CNT  FROM [SC].[dbo].[V_ResultOfDay]    where  date  =  DATEADD(DAY,-2,@DATE)  
group by right(bt,1)) T14 ON right(T1.BT,1)= T14.BT
   -- SỐ LẦN XUẤT HIỆN TUẦN TRƯỚC
 LEFT JOIN (
 select  BT,COUNT(*) CNT  FROM  V_ResultOfDay WHERE date between  DATEADD(DAY,-14,@DATE)  and  DATEADD(DAY,-7,@DATE) 
 GROUP BY BT  ) T15 ON T1.BT =T15.BT
 
 where  1=1
 AND  T4.BT IS NOT   NULL 
 
-- AND T9.CNT IS   NULL 
--AND T15.CNT IS NOT   NULL  
-- and T15.CNT <4
-- and t3.CNT<15 AND T3.CNT>1

GO
/****** Object:  StoredProcedure [dbo].[sp_TinhGiaiDB_final]    Script Date: 2/24/2024 12:03:59 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO














 CREATE proc [dbo].[sp_TinhGiaiDB_final]
@DATE DATE  
as 
 select  
 FORMAT(cast(SUM(CASE WHEN T2.BT IS NOT NULL THEN 1 ELSE 0 END) OVER(PARTITION BY 1 )  as float)
/COUNT(*) OVER(PARTITION BY 1 )* 100,'0.0') AS Tile,
 SUM(CASE WHEN T2.BT IS NOT NULL THEN 1 ELSE 0 END) OVER(PARTITION BY 1 ) AS OK
 ,COUNT(*) OVER(PARTITION BY 1 ) AS Total
 ,t1.*,t2.*
 ,t3.CNT as N'T3.CNT THÁNG'
  ,t4.DAY as N'T4.DB'
 ,t5.CNT as N'T5.HÔM QUA'
 ,t6.CNT as N'T6.HÔM KIA'
 ,t9.CNT as N'T9.HÔM KÌA'
  ,t7.CNT as N'T7.CNT TUẦN'
 ,T15.CNT as N'T15.CNT TUẦN TRƯỚC'
 ,t8.CNT as N'T8.3 NGÀY'
 ,T10.CNT AS N'T10.Đầu số hôm qua'
 ,T14.CNT AS N'T14.Đuôi số hôm qua'
 ,T11.CNT AS N'T11.Số ở  7  ngày hôm qua'
 ,T12.CNT AS N'T12.g.7 hôm qua'
  
   from DataNumber T1 
 
   LEFT JOIN  V_ResultOfDay T2 ON T1.BT =T2.BT  and date=@DATE and t2.giai='DB'
 -- SỐ LẦN XUẤT HIỆN TRONG THÁNG
 LEFT JOIN (
 select  BT,COUNT(*) CNT  FROM  V_ResultOfDay WHERE date between  DATEADD(DAY,-30,@DATE)  and  DATEADD(DAY,-1,@DATE) 
 GROUP BY BT  ) T3 ON T1.BT =T3.BT
 -- NHỮNG SỐ ĐÃ TRÚNG GIẢI ĐẶC BIỆT
 LEFT JOIN (
SELECT BT,STRING_AGG(FORMAT(DATE,'dd/MM'),',') DAY  FROM [SC].[dbo].[V_ResultOfDay]    where date between  DATEADD(DAY,-30,@DATE)  and  DATEADD(DAY,-1,@DATE)     and giai in ('db' )
group by bt) T4 ON T1.BT= T4.BT
-- NHỮNG SỐ ĐÃ VỀ NGÀY HÔM QUA
 LEFT JOIN (
SELECT   BT,COUNT(*) CNT  FROM [SC].[dbo].[V_ResultOfDay]    where date =  DATEADD(DAY,-1,@DATE)    
group by bt) T5 ON T1.BT= T5.BT
 
-- NHỮNG SỐ ĐÃ VỀ NGÀY HÔM KIA
 LEFT JOIN (
SELECT   BT,COUNT(*) CNT  FROM [SC].[dbo].[V_ResultOfDay]    where date =  DATEADD(DAY,-2,@DATE)    
group by bt) T6 ON T1.BT= T6.BT
  -- SỐ LẦN XUẤT HIỆN TRONG TUẦN
 LEFT JOIN (
 select  BT,COUNT(*) CNT  FROM  V_ResultOfDay WHERE date between  DATEADD(DAY,-7,@DATE)  and  DATEADD(DAY,-1,@DATE) 
 GROUP BY BT  ) T7 ON T1.BT =T7.BT

   -- SỐ LẦN XUẤT HIỆN TRONG  3 NGÀY
 LEFT JOIN (
 select  BT,COUNT(*) CNT  FROM  V_ResultOfDay WHERE date between  DATEADD(DAY,-3,@DATE)  and  DATEADD(DAY,-1,@DATE) 
 GROUP BY BT  ) T8 ON T1.BT =T8.BT
 
 
-- NHỮNG SỐ ĐÃ VỀ NGÀY HÔM KÌA
 LEFT JOIN (
SELECT   BT,COUNT(*) CNT  FROM [SC].[dbo].[V_ResultOfDay]    where date =  DATEADD(DAY,-3,@DATE)    
group by bt) T9 ON T1.BT= T9.BT

-- Đầu số đã về bao nháy ngày hôm qua
 LEFT JOIN (
SELECT   LEFT(bt,1) BT,COUNT(*) CNT  FROM [SC].[dbo].[V_ResultOfDay]    where date  =  DATEADD(DAY,-1,@DATE)  
group by LEFT(bt,1)) T10 ON left(T1.BT,1)= T10.BT


-- Số ở giải 7 ngày hôm qua
 LEFT JOIN (
SELECT BT,COUNT(*) CNT  FROM [SC].[dbo].[V_ResultOfDay]    where  date between  DATEADD(DAY,-7,@DATE)  and  DATEADD(DAY,-1,@DATE)   and giai in('NHAT','db')
group by bt) T11 ON T1.BT= T11.BT


-- Số ở giải   hôm qua
 LEFT JOIN (
SELECT     BT,COUNT(*) CNT  FROM [SC].[dbo].[V_ResultOfDay]    where  date between  DATEADD(DAY,-7,@DATE)  and  DATEADD(DAY,-1,@DATE)   and giai='bay'
group by bt) T12 ON T1.BT= T12.BT
 
 -- Đầu số đã về bao nháy ngày hôm KIA
 LEFT JOIN (
SELECT   right(bt,1) BT,COUNT(*) CNT  FROM [SC].[dbo].[V_ResultOfDay]    where  date  =  DATEADD(DAY,-2,@DATE)  
group by right(bt,1)) T14 ON right(T1.BT,1)= T14.BT
   -- SỐ LẦN XUẤT HIỆN TUẦN TRƯỚC
 LEFT JOIN (
 select  BT,COUNT(*) CNT  FROM  V_ResultOfDay WHERE date between  DATEADD(DAY,-14,@DATE)  and  DATEADD(DAY,-7,@DATE) 
 GROUP BY BT  ) T15 ON T1.BT =T15.BT
 where 
 1=1


--AND T3.CNT BETWEEN 7 AND 10
 -- NẾU HÔM QUA VỀ RỒI THÌ HÔM NAY BỎ
  -- Nếu về giải đặc b	iệt 30 ngày cũng bỏ
  and T4.BT is not    null
 --and T3.CNT>4
 ----and t15.CNT is not null

 -- and t14.CNT is not null

 --and t5.CNT is null

GO
/****** Object:  StoredProcedure [dbo].[sp_TinhGiaiDB_LO]    Script Date: 2/24/2024 12:03:59 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO









 
 create  proc [dbo].[sp_TinhGiaiDB_LO]
@DATE DATEtime  
as
 
 
 select  
 COUNT(*) OVER(PARTITION BY 1 ) AS Total
 ,t1.*,t2.giai
  ,t6.BT
   from V_DataNumber T1 
 
   LEFT JOIN  V_ResultOfDay T2 ON T1.BT =T2.BT  and date=@DATE 
   --and t2.giai=	'DB'
    
 LEFT JOIN (
SELECT BT,STRING_AGG(FORMAT(DATE,'dd/MM'),',') DAY  FROM [SC].[dbo].[V_ResultOfDay]    where

date between  DATEADD(MINUTE,-50,@DATE)  and  DATEADD(MINUTE,-1,@DATE)     and giai in ('db' )
group by bt) T4 ON T1.BT= T4.BT
 
  LEFT JOIN (
  SELECT   BT   FROM [SC].[dbo].[V_ResultOfDay]    where date  in (select top 2 date from  (SELECT DATE FROM  [V_ResultOfDay2] GROUP BY DATE) A1 where date < @DATE order by DATE desc)

group by bt) T6 ON T1.BT= T6.BT
left join (
select top 3 * from (SELECT  TOP 6 BT 
  FROM [SC].[dbo].[V_ResultOfDay]  where date < @DATE group by BT ORDER BY count(*) desc ) x
  ) t7 on t1.BT=t7.BT
 where 
 --T4.BT is      null
 --and  
 t7.BT IS NOT  NULL
 
 
 ORDER BY T1.BT desc
GO
/****** Object:  StoredProcedure [dbo].[sp_TinhGiaiDB_MN]    Script Date: 2/24/2024 12:03:59 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO











































 CREATE proc [dbo].[sp_TinhGiaiDB_MN]
@DATE DATEtime  
as
 
  
 select  
 COUNT(*) OVER(PARTITION BY 1 ) AS Total
 ,t1.*,t2.giai
  ,t6.BT
   from V_DataNumber T1 
 
   LEFT JOIN  V_ResultOfDay2 T2 ON T1.BT =T2.BT  and date=@DATE and t2.giai='DB'
    
 LEFT JOIN (
SELECT BT,STRING_AGG(FORMAT(DATE,'dd/MM'),',') DAY  FROM [SC].[dbo].[V_ResultOfDay2]    where

date between  DATEADD(MINUTE,-50,@DATE)  and  DATEADD(MINUTE,-1,@DATE)     and giai in ('db' )
group by bt) T4 ON T1.BT= T4.BT
 
  LEFT JOIN (
  SELECT   BT   FROM [SC].[dbo].[V_ResultOfDay2]    where date  in (select top 3 date from  (SELECT DATE FROM  [V_ResultOfDay2] GROUP BY DATE) A1 where date < @DATE order by DATE desc)

group by bt) T6 ON T1.BT= T6.BT
 
 where     CONVERT(INT,RIGHT (T1.BT,1)) %2 =0 

 --and t6.BT is not null
 --AND T4.BT IS     NULL
-- and t1.BT not in (00,03,06,07,08,09,10,11,12,13
--,15,16,17,20,21,22,25,26,42,43
--,47,48,49,51,54,56,57,59,60,61
--,63,65,67,68,74,75,76,77,80,81
--,82,84,86,87,88,89,91,95,96)
 --AND CONVERT(INT,RIGHT (T1.BT,1)) %2 =0 
 --AND CONVERT(INT,right(T1.BT,1)) %2=0 
 --AND T1.BT not  IN (SELECT TOP 100  BT  FROM [V_ResultOfDay] WHERE giai='DB' AND DATE < @DATE  ORDER BY DATE DESC)
-- AND T1.BT  IN (select   bt   FROM [V_ResultOfDay2] WHERE  DATE IN  (select TOP 4  DATE  from (select date from V_ResultOfDay2 group by DATE) a WHERE DATE <@date ORDER BY DATE DESC ) )

 
 ORDER BY T2.giai desc
GO
/****** Object:  StoredProcedure [dbo].[sp_TinhGiaiDB_MN_LO]    Script Date: 2/24/2024 12:03:59 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO








 
 CREATE  proc [dbo].[sp_TinhGiaiDB_MN_LO]
@DATE DATEtime  
as
 
 
 select  
 COUNT(*) OVER(PARTITION BY 1 ) AS Total
 ,t1.*,t2.giai
  ,t6.BT
   from V_DataNumber T1 
 
   LEFT JOIN  V_ResultOfDay2 T2 ON T1.BT =T2.BT  and date=@DATE 
   --and t2.giai=	'DB'
    
 LEFT JOIN (
SELECT BT,STRING_AGG(FORMAT(DATE,'dd/MM'),',') DAY  FROM [SC].[dbo].[V_ResultOfDay2]    where

date between  DATEADD(MINUTE,-50,@DATE)  and  DATEADD(MINUTE,-1,@DATE)     and giai in ('db' )
group by bt) T4 ON T1.BT= T4.BT
 
  LEFT JOIN (
  SELECT   BT   FROM [SC].[dbo].[V_ResultOfDay2]    where date  in (select top 2 date from  (SELECT DATE FROM  [V_ResultOfDay2] GROUP BY DATE) A1 where date < @DATE order by DATE desc)

group by bt) T6 ON T1.BT= T6.BT
left join (
select top 3 * from (SELECT  TOP 6 BT 
  FROM [SC].[dbo].[V_ResultOfDay2]  where date < @DATE group by BT ORDER BY count(*) desc ) x
  ) t7 on t1.BT=t7.BT
 where 
 --T4.BT is      null
 --and  
 t7.BT IS NOT  NULL
 
 
 ORDER BY T1.BT desc
GO
/****** Object:  StoredProcedure [dbo].[sp_TinhGiaiDB_V2]    Script Date: 2/24/2024 12:03:59 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

  CREATE proc [dbo].[sp_TinhGiaiDB_V2]
@DATE DATE  
as 

declare @last nvarchar(10)= (SELECT top 1 value FROM V_ResultOfDay WHERE DATE=DATEADD(DAY,-1,@DATE)  AND giai='db' );
 
 select  
 FORMAT(cast(SUM(CASE WHEN T2.BT IS NOT NULL THEN 1 ELSE 0 END) OVER(PARTITION BY 1 )  as float)
/COUNT(*) OVER(PARTITION BY 1 )* 100,'0.0') AS Tile,
 SUM(CASE WHEN T2.BT IS NOT NULL THEN 1 ELSE 0 END) OVER(PARTITION BY 1 ) AS OK
 ,COUNT(*) OVER(PARTITION BY 1 ) AS Total
 ,t1.*,t2.*
 ,t3.CNT as N'T3.CNT THÁNG'
  ,t4.DAY as N'T4.DB'
 ,t5.CNT as N'T5.HÔM QUA'
 ,t6.CNT as N'T6.HÔM KIA'
 ,t9.CNT as N'T9.HÔM KÌA'
  ,t7.CNT as N'T7.CNT TUẦN'
 ,T15.CNT as N'T15.CNT TUẦN TRƯỚC'
 ,t8.CNT as N'T8.3 NGÀY'
 ,T10.CNT AS N'T10.Đầu số hôm qua'
 ,T14.CNT AS N'T14.Đuôi số hôm qua'
 ,T11.CNT AS N'T11.Số ở  7  ngày hôm qua'
 ,T12.CNT AS N'T12.g.7 hôm qua'
 ,T16.CNT AS N'T16.Đầu g.DB 3 ngày'
 ,T17.CNT AS N'T17.Đuôi g.DB 3 ngày'
 ,(CAST(left(T1.bt,1) AS INT)+CAST(right(T1.bt,1) AS INT)) AS Total
 ,(CAST(left(T1.bt,1) AS INT)+CAST(right(T1.bt,1) AS INT))
 +(CAST(left(T18.bt,1) AS INT)+CAST(right(T18.bt,1) AS INT)) 
 +(CAST(left(T19.bt,1) AS INT)+CAST(right(T19.bt,1) AS INT))
 AS Total3day
  , CAST(left(T1.bt,1) AS INT) 
 + CAST(left(T18.bt,1) AS INT) 
 + CAST(left(T19.bt,1) AS INT) 
 AS DauTotal3day
 


   from v_DataNumber T1 
 
   LEFT JOIN  V_ResultOfDay T2 ON T1.BT =T2.BT  and date=@DATE
   AND giai='DB'
 -- SỐ LẦN XUẤT HIỆN TRONG THÁNG
 LEFT JOIN (
 select  BT,COUNT(*) CNT  FROM  V_ResultOfDay WHERE date between  DATEADD(DAY,-30,@DATE)  and  DATEADD(DAY,-1,@DATE) 
 GROUP BY BT  ) T3 ON T1.BT =T3.BT
 -- NHỮNG SỐ ĐÃ TRÚNG GIẢI ĐẶC BIỆT
 LEFT JOIN (
SELECT BT,STRING_AGG(FORMAT(DATE,'dd/MM'),',') DAY  FROM [SC].[dbo].[V_ResultOfDay]    where date between  DATEADD(DAY,-30,@DATE)  and  DATEADD(DAY,-1,@DATE)     and giai in ('db' )
group by bt) T4 ON T1.BT= T4.BT
-- NHỮNG SỐ ĐÃ VỀ NGÀY HÔM QUA
 LEFT JOIN (
SELECT   BT,COUNT(*) CNT  FROM [SC].[dbo].[V_ResultOfDay]    where date =  DATEADD(DAY,-1,@DATE)    
group by bt) T5 ON T1.BT= T5.BT
 
-- NHỮNG SỐ ĐÃ VỀ NGÀY HÔM KIA
 LEFT JOIN (
SELECT   BT,COUNT(*) CNT  FROM [SC].[dbo].[V_ResultOfDay]    where date =  DATEADD(DAY,-2,@DATE)    
group by bt) T6 ON T1.BT= T6.BT
  -- SỐ LẦN XUẤT HIỆN TRONG TUẦN
 LEFT JOIN (
 select  BT,COUNT(*) CNT  FROM  V_ResultOfDay WHERE date between  DATEADD(DAY,-7,@DATE)  and  DATEADD(DAY,-1,@DATE) 
 GROUP BY BT  ) T7 ON T1.BT =T7.BT

   -- SỐ LẦN XUẤT HIỆN TRONG  3 NGÀY
 LEFT JOIN (
 select  BT,COUNT(*) CNT  FROM  V_ResultOfDay WHERE date between  DATEADD(DAY,-3,@DATE)  and  DATEADD(DAY,-1,@DATE) 
 GROUP BY BT  ) T8 ON T1.BT =T8.BT
 
 
-- NHỮNG SỐ ĐÃ VỀ NGÀY HÔM KÌA
 LEFT JOIN (
SELECT   BT,COUNT(*) CNT  FROM [SC].[dbo].[V_ResultOfDay]    where date =  DATEADD(DAY,-3,@DATE)    
group by bt) T9 ON T1.BT= T9.BT

-- Đầu số đã về bao nháy ngày hôm qua
 LEFT JOIN (
SELECT   LEFT(bt,1) BT,COUNT(*) CNT  FROM [SC].[dbo].[V_ResultOfDay]    where date  =  DATEADD(DAY,-1,@DATE)  
group by LEFT(bt,1)) T10 ON left(T1.BT,1)= T10.BT


-- Số ở giải 7 ngày hôm qua
 LEFT JOIN (
SELECT BT,COUNT(*) CNT  FROM [SC].[dbo].[V_ResultOfDay]    where  date between  DATEADD(DAY,-7,@DATE)  and  DATEADD(DAY,-1,@DATE)   and giai in('NHAT','db')
group by bt) T11 ON T1.BT= T11.BT


-- Số ở giải   hôm qua
 LEFT JOIN (
SELECT     BT,COUNT(*) CNT  FROM [SC].[dbo].[V_ResultOfDay]    where  date between  DATEADD(DAY,-7,@DATE)  and  DATEADD(DAY,-1,@DATE)   and giai='bay'
group by bt) T12 ON T1.BT= T12.BT
 
 -- Đầu số đã về bao nháy ngày hôm KIA
 LEFT JOIN (
SELECT   right(bt,1) BT,COUNT(*) CNT  FROM [SC].[dbo].[V_ResultOfDay]    where  date  =  DATEADD(DAY,-2,@DATE)  
group by right(bt,1)) T14 ON right(T1.BT,1)= T14.BT
   -- SỐ LẦN XUẤT HIỆN TUẦN TRƯỚC
 LEFT JOIN (
 select  BT,COUNT(*) CNT  FROM  V_ResultOfDay WHERE date between  DATEADD(DAY,-14,@DATE)  and  DATEADD(DAY,-7,@DATE) 
 GROUP BY BT  ) T15 ON T1.BT =T15.BT
  -- Đầu số đã về bao nháy ngày hôm KIA
 LEFT JOIN (
SELECT   LEFT(bt,1) BT,COUNT(*) CNT  FROM [SC].[dbo].[V_ResultOfDay]    where  date between  DATEADD(DAY,-1,@DATE)  and  DATEADD(DAY,-1,@DATE)   and giai='DB'  
group by LEFT(bt,1)) T16 ON LEFT(T1.BT,1)= T16.BT

 LEFT JOIN (
SELECT   right(bt,1) BT,COUNT(*) CNT  FROM [SC].[dbo].[V_ResultOfDay]    where  date between  DATEADD(DAY,-1,@DATE)  and  DATEADD(DAY,-1,@DATE)   and giai='DB'  
group by right(bt,1)) T17 ON right(T1.BT,1)= T17.BT

LEFT JOIN [V_ResultOfDay] T18 ON T18.DATE=DATEADD(DAY,-1,@DATE)   and T18.giai='DB'
LEFT JOIN [V_ResultOfDay] T19 ON T19.DATE=DATEADD(DAY,-2,@DATE)    and T19.giai='DB'
LEFT JOIN [V_ResultOfDay] T20 ON T20.DATE=DATEADD(DAY,-3,@DATE)    and T20.giai='DB'
LEFT JOIN [V_ResultOfDay] T21 ON T21.DATE=DATEADD(DAY,-4,@DATE)    and T21.giai='DB'
LEFT JOIN [V_ResultOfDay] T22 ON T22.DATE=DATEADD(DAY,-5,@DATE)    and T22.giai='DB'
LEFT JOIN [V_ResultOfDay] T23 ON T23.DATE=DATEADD(DAY,-6,@DATE)    and T23.giai='DB'
 

 where 
 1=1
 AND T4.BT IS   NULL
 AND T6.CNT IS NULL
 and t1.tt not in (select 
  case when   left( RIGHT(BT,2) ,1) %2!=0 THEN 'L' else 'C' end 
 + case when    RIGHT(BT,1) %2!=0  THEN 'L' else 'C' end  from [V_ResultOfDay] a1  where  a1.DATE=  DATEADD(DAY,-1,@DATE)    and  giai='DB')
GO
/****** Object:  StoredProcedure [dbo].[sp_TinhGiaiDB3C]    Script Date: 2/24/2024 12:03:59 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
















 CREATE proc [dbo].[sp_TinhGiaiDB3C]
@DATE DATE  
as 
 select  
 COUNT(*) OVER(PARTITION BY 1 ) AS Total
 ,t1.*,t2.giai
 ,t3.CNT as N'T3.CNT THÁNG'
  ,t4.DAY as N'T4.DB'
 ,t5.CNT as N'T5.HÔM QUA'
 ,t6.CNT as N'T6.HÔM KIA'
 ,t9.CNT as N'T9.HÔM KÌA'
  ,t7.CNT as N'T7.CNT TUẦN'
 ,T15.CNT as N'T15.CNT TUẦN TRƯỚC'
 ,t8.CNT as N'T8.3 NGÀY'
 ,T10.CNT AS N'T10.Đầu số hôm qua'
 ,T14.CNT AS N'T14.Đuôi số hôm qua'
 ,T11.CNT AS N'T11.Số ở  7  ngày hôm qua'
 ,T12.CNT AS N'T12.g.7 hôm qua'
  
   from DataNumber3 T1 
 
   LEFT JOIN  V_ResultOfDay T2 ON T1.BT =T2.bt3  and date=@DATE and t2.giai='DB'
 -- SỐ LẦN XUẤT HIỆN TRONG THÁNG
 LEFT JOIN (
 select  bt3,COUNT(*) CNT  FROM  V_ResultOfDay WHERE date between  DATEADD(DAY,-30,@DATE)  and  DATEADD(DAY,-1,@DATE) 
 GROUP BY bt3  ) T3 ON T1.BT =T3.bt3
 -- NHỮNG SỐ ĐÃ TRÚNG GIẢI ĐẶC BIỆT
 LEFT JOIN (
SELECT bt3,STRING_AGG(FORMAT(DATE,'dd/MM'),',') DAY  FROM [SC].[dbo].[V_ResultOfDay]    where

date between  DATEADD(DAY,-40,@DATE)  and  DATEADD(DAY,-1,@DATE)     and giai in ('db' )
group by bt3) T4 ON T1.BT= T4.bt3
-- NHỮNG SỐ ĐÃ VỀ NGÀY HÔM QUA
 LEFT JOIN (
SELECT   bt3,COUNT(*) CNT  FROM [SC].[dbo].[V_ResultOfDay]    where  date between  DATEADD(DAY,-7,@DATE)  and  DATEADD(DAY,-1,@DATE) 
group by bt3) T5 ON T1.BT= T5.bt3
 
-- NHỮNG SỐ ĐÃ VỀ NGÀY HÔM KIA
 LEFT JOIN (
SELECT   bt3,COUNT(*) CNT  FROM [SC].[dbo].[V_ResultOfDay]    where   date between  DATEADD(DAY,-14,@DATE)  and  DATEADD(DAY,-1,@DATE) 
group by bt3) T6 ON T1.BT= T6.bt3
  -- SỐ LẦN XUẤT HIỆN TRONG TUẦN
 LEFT JOIN (
 select  bt3,COUNT(*) CNT  FROM  V_ResultOfDay WHERE date between  DATEADD(DAY,-30,@DATE)  and  DATEADD(DAY,-1,@DATE) 
 GROUP BY bt3  ) T7 ON T1.BT =T7.bt3

   -- SỐ LẦN XUẤT HIỆN TRONG  3 NGÀY
 LEFT JOIN (
 select  bt3,COUNT(*) CNT  FROM  V_ResultOfDay WHERE date between  DATEADD(DAY,-3,@DATE)  and  DATEADD(DAY,-1,@DATE) 
 GROUP BY bt3  ) T8 ON T1.BT =T8.bt3
 
 
-- NHỮNG SỐ ĐÃ VỀ NGÀY HÔM KÌA
 LEFT JOIN (
SELECT   bt3,COUNT(*) CNT  FROM [SC].[dbo].[V_ResultOfDay]    where date =  DATEADD(DAY,-3,@DATE)    
group by bt3) T9 ON T1.BT= T9.bt3

-- Đầu số đã về bao nháy ngày hôm qua
 LEFT JOIN (
SELECT   LEFT(bt3,1) bt3,COUNT(*) CNT  FROM [SC].[dbo].[V_ResultOfDay]    where date  =  DATEADD(DAY,-1,@DATE)  
group by LEFT(bt3,1)) T10 ON left(T1.BT,1)= T10.bt3


-- Số ở giải 7 ngày hôm qua
 LEFT JOIN (
SELECT bt3,COUNT(*) CNT  FROM [SC].[dbo].[V_ResultOfDay]    where  date between  DATEADD(DAY,-7,@DATE)  and  DATEADD(DAY,-1,@DATE)   and giai in('NHAT','db')
group by bt3) T11 ON T1.BT= T11.bt3


-- Số ở giải   hôm qua
 LEFT JOIN (
SELECT     bt3,COUNT(*) CNT  FROM [SC].[dbo].[V_ResultOfDay]    where  date between  DATEADD(DAY,-7,@DATE)  and  DATEADD(DAY,-1,@DATE)   and giai='bay'
group by bt3) T12 ON T1.BT= T12.bt3
 
 -- Đầu số đã về bao nháy ngày hôm KIA
 LEFT JOIN (
SELECT   right(bt3,1) bt3,COUNT(*) CNT  FROM [SC].[dbo].[V_ResultOfDay]    where  date  =  DATEADD(DAY,-2,@DATE)  
group by right(bt3,1)) T14 ON right(T1.BT,1)= T14.bt3
   -- SỐ LẦN XUẤT HIỆN TUẦN TRƯỚC
 LEFT JOIN (
 select  bt3,COUNT(*) CNT  FROM  V_ResultOfDay WHERE date between  DATEADD(DAY,-14,@DATE)  and  DATEADD(DAY,-7,@DATE) 
 GROUP BY bt3  ) T15 ON T1.BT =T15.bt3
 
 where  1=1

 AND T4.BT3 IS    NULL
 AND T5.CNT IS      NULL
  AND T6.CNT IS      NULL
  AND T7.CNT IS  not    NULL

  and ISNULL(t3.CNT,0) <=1
    
 and ISNULL(t15.CNT,0) =0
 and ISNULL(t8.CNT,0) =0
   AND  ISNULL(T14.CNT,0) <=6
      and 
  (
  CHARINDEX(SUBSTRING(t1.BT,1,1),isnull((SELECT  value FROM V_ResultOfDay WHERE DATE=DATEADD(DAY,-1,@DATE)  AND giai='db'),'') )  =0
 AND   CHARINDEX(SUBSTRING(t1.BT,3,1),isnull((SELECT  value FROM V_ResultOfDay WHERE DATE=DATEADD(DAY,-1,@DATE)  AND giai='db'),'') )  =0
 AND   CHARINDEX(SUBSTRING(t1.BT,2,1),isnull((SELECT  value FROM V_ResultOfDay WHERE DATE=DATEADD(DAY,-1,@DATE)  AND giai='db'),'') ) =0
  )
 
 
GO
/****** Object:  StoredProcedure [dbo].[sp_TinhGiaiKENO]    Script Date: 2/24/2024 12:03:59 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


 

 CREATE proc [dbo].[sp_TinhGiaiKENO]
@DATE DATETIME  
as  
 select   @DATE as txtdate,
 FORMAT(cast(SUM(CASE WHEN T2.BT IS NOT NULL THEN 1 ELSE 0 END) OVER(PARTITION BY 1 )  as float)
/COUNT(*) OVER(PARTITION BY 1 )* 100,'0.0') AS Tile,
 SUM(CASE WHEN T2.BT IS NOT NULL THEN 1 ELSE 0 END) OVER(PARTITION BY 1 ) AS OK
 ,COUNT(*) OVER(PARTITION BY 1 ) AS Total
 ,t1.*,t2.*
 ,t3.CNT as N'T3.CNT THÁNG'
  ,t5.CNT as N'T5.HÔM QUA'
 ,t6.CNT as N'T6.HÔM KIA'
 ,t9.CNT as N'T9.HÔM KÌA'
  ,t7.CNT as N'T7.CNT TUẦN'
 ,T15.CNT as N'T15.CNT TUẦN TRƯỚC'
 ,t8.CNT as N'T8.3 NGÀY'
 ,T10.CNT AS N'T10.Đầu số hôm qua'
 ,T14.CNT AS N'T14.Đuôi số hôm qua'
 ,T11.CNT AS N'T11.Số ở  7  ngày hôm qua'
 ,T12.CNT AS N'T12.g.7 hôm qua'
  
   from DataNumber T1 
 
   LEFT JOIN  V_KENO T2 ON T1.BT =T2.BT  and date=@DATE
 -- SỐ LẦN XUẤT HIỆN TRONG THÁNG
 LEFT JOIN (
 select  BT,COUNT(*) CNT  FROM  V_KENO WHERE date between  DATEADD(MINUTE,-30,@DATE)  and  DATEADD(MINUTE,-10,@DATE) 
 GROUP BY BT  ) T3 ON T1.BT =T3.BT
 
-- NHỮNG SỐ ĐÃ VỀ NGÀY HÔM QUA
 LEFT JOIN (
SELECT   BT,COUNT(*) CNT  FROM [SC].[dbo].[V_KENO]    where date =  DATEADD(MINUTE,-10,@DATE) 
group by bt) T5 ON T1.BT= T5.BT
 
-- NHỮNG SỐ ĐÃ VỀ NGÀY HÔM KIA
 LEFT JOIN (
SELECT   BT,COUNT(*) CNT  FROM [SC].[dbo].[V_KENO]    where date = DATEADD(MINUTE,-20,@DATE) 
group by bt) T6 ON T1.BT= T6.BT
  -- SỐ LẦN XUẤT HIỆN TRONG TUẦN
 LEFT JOIN (
 select  BT,COUNT(*) CNT  FROM  V_KENO WHERE date between   DATEADD(MINUTE,-70,@DATE)   and  DATEADD(MINUTE,-10,@DATE) 
 GROUP BY BT  ) T7 ON T1.BT =T7.BT

   -- SỐ LẦN XUẤT HIỆN TRONG  3 NGÀY
 LEFT JOIN (
 select  BT,COUNT(*) CNT  FROM  V_KENO WHERE date between  DATEADD(MINUTE,-30,@DATE)   and   DATEADD(MINUTE,-10,@DATE) 
 GROUP BY BT  ) T8 ON T1.BT =T8.BT
 
 
-- NHỮNG SỐ ĐÃ VỀ NGÀY HÔM KÌA
 LEFT JOIN (
SELECT   BT,COUNT(*) CNT  FROM [SC].[dbo].[V_KENO]    where date =  DATEADD(MINUTE,-30,@DATE) 
group by bt) T9 ON T1.BT= T9.BT

-- Đầu số đã về bao nháy ngày hôm qua
 LEFT JOIN (
SELECT   LEFT(bt,1) BT,COUNT(*) CNT  FROM [SC].[dbo].[V_KENO]    where date  =  DATEADD(MINUTE,-10,@DATE) 
group by LEFT(bt,1)) T10 ON left(T1.BT,1)= T10.BT


-- Số ở giải 7 ngày hôm qua
 LEFT JOIN (
SELECT BT,COUNT(*) CNT  FROM [SC].[dbo].[V_KENO]    where  date between   DATEADD(MINUTE,-70,@DATE)   and   DATEADD(MINUTE,-10,@DATE)    and giai in('NHAT','db')
group by bt) T11 ON T1.BT= T11.BT


-- Số ở giải   hôm qua
 LEFT JOIN (
SELECT     BT,COUNT(*) CNT  FROM [SC].[dbo].[V_KENO]    where  date between   DATEADD(MINUTE,-70,@DATE)   and DATEADD(MINUTE,-10,@DATE)    and giai='bay'
group by bt) T12 ON T1.BT= T12.BT
 
 -- Đầu số đã về bao nháy ngày hôm KIA
 LEFT JOIN (
SELECT   right(bt,1) BT,COUNT(*) CNT  FROM [SC].[dbo].[V_KENO]    where  date  =   DATEADD(MINUTE,-20,@DATE) 
group by right(bt,1)) T14 ON right(T1.BT,1)= T14.BT
   -- SỐ LẦN XUẤT HIỆN TUẦN TRƯỚC
 LEFT JOIN (
 select  BT,COUNT(*) CNT  FROM  V_KENO WHERE date between   DATEADD(MINUTE,-140,@DATE)   and  DATEADD(MINUTE,-70,@DATE) 
 GROUP BY BT  ) T15 ON T1.BT =T15.BT
 where 
 1=1


 

 --AND T3.CNT is null 
 AND T1.BT<=80 AND T1.BT >0
---- -- NẾU HÔM QUA VỀ RỒI THÌ HÔM NAY BỎ
----  -- Nếu về giải đặc b	iệt 30 ngày cũng bỏ
 --and T8.CNT 	IS NULL
 --and T10.BT is not   null
---- and T4.BT is     null
  --and T8.BT is     null
 and T5.CNT is     null
 --and T7.CNT is  NOT   null
 --and T6.CNT is      null
 and T9.CNT is    null
--   AND   T7.CNT <4
----  AND   T14.CNT is not null
 
---- AND   T12.CNT is      null
-- AND  ISNULL(T15.CNT,0) <= 3
-- AND  ISNULL(T5.CNT,0) <5
-- AND  ISNULL(T6.CNT,0) <5
-- AND  ISNULL(T9.CNT,0) <5
-- AND  ISNULL(T14.CNT,0) <5
-- AND  ISNULL(T10.CNT,0) <6


 ORDER BY T2.Giai DESC
 

GO
/****** Object:  StoredProcedure [dbo].[sp_TinhLo]    Script Date: 2/24/2024 12:03:59 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO



















 CREATE proc [dbo].[sp_TinhLo]
@DATE DATE  
as 
 select  
 COUNT(*) OVER(PARTITION BY 1 ) AS Total
 ,t1.*,t2.giai 
 ,t3.CNT as N'T3.CNT THÁNG'
  ,t4.DAY as N'T4.DB'
 ,t5.CNT as N'T5.HÔM QUA'
 ,t6.CNT as N'T6.HÔM KIA'
 ,t9.CNT as N'T9.HÔM KÌA'
  ,t7.CNT as N'T7.CNT TUẦN'
 ,T15.CNT as N'T15.CNT TUẦN TRƯỚC'
 ,t8.CNT as N'T8.3 NGÀY'
 ,T10.CNT AS N'T10.Đầu số hôm qua'
 ,T14.CNT AS N'T14.Đuôi số hôm qua'
 ,T11.CNT AS N'T11.Số ở  7  ngày hôm qua'
 ,T12.CNT AS N'T12.g.7 hôm qua'
  
   from DataNumber T1 
 
   LEFT JOIN  V_ResultOfDay T2 ON T1.BT =T2.BT  and date=@DATE 
 -- SỐ LẦN XUẤT HIỆN TRONG THÁNG
 LEFT JOIN (
 select  BT,COUNT(*) CNT  FROM  V_ResultOfDay WHERE date between  DATEADD(DAY,-30,@DATE)  and  DATEADD(DAY,-1,@DATE) 
 GROUP BY BT  ) T3 ON T1.BT =T3.BT
 -- NHỮNG SỐ ĐÃ TRÚNG GIẢI ĐẶC BIỆT
 LEFT JOIN (
SELECT BT,STRING_AGG(FORMAT(DATE,'dd/MM'),',') DAY  FROM [SC].[dbo].[V_ResultOfDay]    where

date between  DATEADD(DAY,-30,@DATE)  and  DATEADD(DAY,-1,@DATE)     and giai in ('db' )
group by bt) T4 ON T1.BT= T4.BT
-- NHỮNG SỐ ĐÃ VỀ NGÀY HÔM QUA
 LEFT JOIN (
SELECT   BT,COUNT(*) CNT  FROM [SC].[dbo].[V_ResultOfDay]    where date =  DATEADD(DAY,-1,@DATE)    
group by bt) T5 ON T1.BT= T5.BT
 
-- NHỮNG SỐ ĐÃ VỀ NGÀY HÔM KIA
 LEFT JOIN (
SELECT   BT,COUNT(*) CNT  FROM [SC].[dbo].[V_ResultOfDay]    where date =  DATEADD(DAY,-2,@DATE)    
group by bt) T6 ON T1.BT= T6.BT
  -- SỐ LẦN XUẤT HIỆN TRONG TUẦN
 LEFT JOIN (
 select  BT,COUNT(*) CNT  FROM  V_ResultOfDay WHERE date between  DATEADD(DAY,-7,@DATE)  and  DATEADD(DAY,-1,@DATE) 
 GROUP BY BT  ) T7 ON T1.BT =T7.BT

   -- SỐ LẦN XUẤT HIỆN TRONG  3 NGÀY
 LEFT JOIN (
 select  BT,COUNT(*) CNT  FROM  V_ResultOfDay WHERE date between  DATEADD(DAY,-3,@DATE)  and  DATEADD(DAY,-1,@DATE) 
 GROUP BY BT  ) T8 ON T1.BT =T8.BT
 
 
-- NHỮNG SỐ ĐÃ VỀ NGÀY HÔM KÌA
 LEFT JOIN (
SELECT   BT,COUNT(*) CNT  FROM [SC].[dbo].[V_ResultOfDay]    where date =  DATEADD(DAY,-3,@DATE)    
group by bt) T9 ON T1.BT= T9.BT

-- Đầu số đã về bao nháy ngày hôm qua
 LEFT JOIN (
SELECT   LEFT(bt,1) BT,COUNT(*) CNT  FROM [SC].[dbo].[V_ResultOfDay]    where date  =  DATEADD(DAY,-1,@DATE)  
group by LEFT(bt,1)) T10 ON left(T1.BT,1)= T10.BT


-- Số ở giải 7 ngày hôm qua
 LEFT JOIN (
SELECT BT,COUNT(*) CNT  FROM [SC].[dbo].[V_ResultOfDay]    where  date between  DATEADD(DAY,-7,@DATE)  and  DATEADD(DAY,-1,@DATE)   and giai in('NHAT','db')
group by bt) T11 ON T1.BT= T11.BT


-- Số ở giải   hôm qua
 LEFT JOIN (
SELECT     BT,COUNT(*) CNT  FROM [SC].[dbo].[V_ResultOfDay]    where  date between  DATEADD(DAY,-7,@DATE)  and  DATEADD(DAY,-1,@DATE)   and giai='bay'
group by bt) T12 ON T1.BT= T12.BT
 
 -- Đầu số đã về bao nháy ngày hôm KIA
 LEFT JOIN (
SELECT   right(bt,1) BT,COUNT(*) CNT  FROM [SC].[dbo].[V_ResultOfDay]    where  date  =  DATEADD(DAY,-2,@DATE)  
group by right(bt,1)) T14 ON right(T1.BT,1)= T14.BT
   -- SỐ LẦN XUẤT HIỆN TUẦN TRƯỚC
 LEFT JOIN (
 select  BT,COUNT(*) CNT  FROM  V_ResultOfDay WHERE date between  DATEADD(DAY,-14,@DATE)  and  DATEADD(DAY,-7,@DATE) 
 GROUP BY BT  ) T15 ON T1.BT =T15.BT
 
 where  1=1
AND  
   T4.BT IS NULL 
  AND T8.CNT IS   NULL
  AND T9.CNT IS   NULL 
 
GO
/****** Object:  StoredProcedure [dbo].[sp_TinhTiLeLapLaiTrong5ngay]    Script Date: 2/24/2024 12:03:59 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[sp_TinhTiLeLapLaiTrong5ngay]

as
declare @date date =convert(date,getdate());
WITH A1 AS (
select  DATE,
(
SELECT COUNT(*) CNT FROM (
select distinct   BT  from V_ResultOfDay t2 where t1.DATE=t2.DATE
union 
select distinct   BT  from V_ResultOfDay t3 where t1.DATE=DATEADD(day, 1,t3.DATE)
union 
select distinct   BT  from V_ResultOfDay t4 where t1.DATE=DATEADD(day, 2,t4.DATE)
union 
select distinct   BT  from V_ResultOfDay t5 where t1.DATE=DATEADD(day,3,t5.DATE)
union 
select distinct   BT  from V_ResultOfDay t6 where t1.DATE=DATEADD(day,-5,t6.DATE)
union 
select distinct   BT  from V_ResultOfDay t7 where t1.DATE=DATEADD(day,-6,t7.DATE)
union 
select distinct   BT  from V_ResultOfDay t8 where t1.DATE=DATEADD(day,-7,t8.DATE)

) A1
) as qty

from V_ResultOfDay t1 
 WHERE DATE=@date
GROUP BY  DATE 
)
,a2 as (


select   qty,count(date) as SL,27*7 as TOTAL from a1  group by qty

)

select *,cast(qty as float)/cast(TOTAL as float)*100  AS TILE from a2 ORDER BY qty
GO
/****** Object:  StoredProcedure [dbo].[sp_TinhX2]    Script Date: 2/24/2024 12:03:59 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO








  
CREATE proc [dbo].[sp_TinhX2]
@DATE DATE  
as 


WITH A1 AS (select  * from (
 select  

  t1.*,t2.giai,t2.value
 ,t3.CNT as  T3_CNT_Thang
  ,t4.DAY as N'T4.DB'
 ,t5.CNT as N'T5.HÔM QUA'
 ,t6.CNT as N'T6.HÔM KIA'
 ,t9.CNT as N'T9.HÔM KÌA'
  ,t7.CNT as N'T7.CNT TUẦN'
 ,T15.CNT as N'T15.CNT TUẦN TRƯỚC'
 ,t8.CNT as N'T8.3 NGÀY'
 ,T10.CNT AS N'T10.Đầu số hôm qua'
 ,T14.CNT AS N'T14.Đuôi số hôm qua'
 ,T11.CNT AS N'T11.Số ở  7  ngày hôm qua'
 ,T12.CNT AS N'T12.g.7 hôm qua'
    from DataNumber T1 
 
   LEFT JOIN  V_ResultOfDay T2 ON T1.BT =T2.BT  and date=@DATE
 -- SỐ LẦN XUẤT HIỆN TRONG THÁNG
 LEFT JOIN (
 select  BT,COUNT(*) CNT  FROM  V_ResultOfDay WHERE date between  DATEADD(DAY,-30,@DATE)  and  DATEADD(DAY,-1,@DATE) 
 GROUP BY BT  ) T3 ON T1.BT =T3.BT
 -- NHỮNG SỐ ĐÃ TRÚNG GIẢI ĐẶC BIỆT
 LEFT JOIN (
SELECT BT,STRING_AGG(FORMAT(DATE,'dd/MM'),',') DAY  FROM [SC].[dbo].[V_ResultOfDay]    where date between  DATEADD(DAY,-30,@DATE)  and  DATEADD(DAY,-1,@DATE)     and giai in ('db' )
group by bt) T4 ON T1.BT= T4.BT
-- NHỮNG SỐ ĐÃ VỀ NGÀY HÔM QUA
 LEFT JOIN (
SELECT   BT,COUNT(*) CNT  FROM [SC].[dbo].[V_ResultOfDay]    where date =  DATEADD(DAY,-1,@DATE)    
group by bt) T5 ON T1.BT= T5.BT
 
-- NHỮNG SỐ ĐÃ VỀ NGÀY HÔM KIA
 LEFT JOIN (
SELECT   BT,COUNT(*) CNT  FROM [SC].[dbo].[V_ResultOfDay]    where date =  DATEADD(DAY,-2,@DATE)    
group by bt) T6 ON T1.BT= T6.BT
  -- SỐ LẦN XUẤT HIỆN TRONG TUẦN
 LEFT JOIN (
 select  BT,COUNT(*) CNT  FROM  V_ResultOfDay WHERE date between  DATEADD(DAY,-7,@DATE)  and  DATEADD(DAY,-1,@DATE) 
 GROUP BY BT  ) T7 ON T1.BT =T7.BT

   -- SỐ LẦN XUẤT HIỆN TRONG  3 NGÀY
 LEFT JOIN (
 select  BT,COUNT(*) CNT  FROM  V_ResultOfDay WHERE date between  DATEADD(DAY,-3,@DATE)  and  DATEADD(DAY,-1,@DATE) 
 GROUP BY BT  ) T8 ON T1.BT =T8.BT
 
 
-- NHỮNG SỐ ĐÃ VỀ NGÀY HÔM KÌA
 LEFT JOIN (
SELECT   BT,COUNT(*) CNT  FROM [SC].[dbo].[V_ResultOfDay]    where date =  DATEADD(DAY,-3,@DATE)    
group by bt) T9 ON T1.BT= T9.BT

-- Đầu số đã về bao nháy ngày hôm qua
 LEFT JOIN (
SELECT   LEFT(bt,1) BT,COUNT(*) CNT  FROM [SC].[dbo].[V_ResultOfDay]    where date  =  DATEADD(DAY,-1,@DATE)  
group by LEFT(bt,1)) T10 ON left(T1.BT,1)= T10.BT


-- Số ở giải 7 ngày hôm qua
 LEFT JOIN (
SELECT BT,COUNT(*) CNT  FROM [SC].[dbo].[V_ResultOfDay]    where  date between  DATEADD(DAY,-7,@DATE)  and  DATEADD(DAY,-1,@DATE)   and giai in('NHAT','db')
group by bt) T11 ON T1.BT= T11.BT


-- Số ở giải   hôm qua
 LEFT JOIN (
SELECT     BT,COUNT(*) CNT  FROM [SC].[dbo].[V_ResultOfDay]    where  date between  DATEADD(DAY,-7,@DATE)  and  DATEADD(DAY,-1,@DATE)   and giai='bay'
group by bt) T12 ON T1.BT= T12.BT
 
 -- Đầu số đã về bao nháy ngày hôm KIA
 LEFT JOIN (
SELECT   right(bt,1) BT,COUNT(*) CNT  FROM [SC].[dbo].[V_ResultOfDay]    where  date  =  DATEADD(DAY,-2,@DATE)  
group by right(bt,1)) T14 ON right(T1.BT,1)= T14.BT
   -- SỐ LẦN XUẤT HIỆN TUẦN TRƯỚC
 LEFT JOIN (
 select  BT,COUNT(*) CNT  FROM  V_ResultOfDay WHERE date between  DATEADD(DAY,-14,@DATE)  and  DATEADD(DAY,-7,@DATE) 
 GROUP BY BT  ) T15 ON T1.BT =T15.BT
 where 
 1=1
   --AND T3.CNT BETWEEN 7 AND 13
 
 ---- NẾU HÔM QUA VỀ RỒI THÌ HÔM NAY BỎ
 and t5.CNT is NOT  null
 ---- Nếu về giải đặc biệt 30 ngày cũng bỏ
  and t4.BT is  NOT  null
 ----and t5.BT is   null
 --and t15.BT is    null
 --and t12.BT is    null
 ----
 --AND   T7.CNT is not null
 ----AND  ISNULL(T15.CNT,0) <=5
 ----AND  ISNULL(T10.CNT,0) <=5
 ---- AND  ISNULL(T14.CNT,0) <5
 --     AND T14.CNT  >1
	--  AND T15.CNT  >1
 -- AND T12.BT IS NULL
 --and t11.BT is null
 -- AND (T4.BT IS NOT NULL OR ISNULL(T12.BT,0)<=1)
 --   AND T15.BT IS NOT NULL
	--  and t10.CNT is not null
	--  and t3.CNT<=10
) a1 
 )

 SELECT  FORMAT(cast(SUM(CASE WHEN  giai IS NOT NULL THEN 1 ELSE 0 END) OVER(PARTITION BY 1 )  as float)
/COUNT(*) OVER(PARTITION BY 1 )* 100,'0.0') AS Tile,
 SUM(CASE WHEN giai IS NOT NULL THEN 1 ELSE 0 END) OVER(PARTITION BY 1 ) AS OK
 ,COUNT(*) OVER(PARTITION BY 1 ) AS Total
 
 ,* FROM A1   
 --where T3_CNT_Thang in (select  top 2   * from (select T3_CNT_Thang from a1 group by T3_CNT_Thang) a2) 

  ORDER BY  BT desc
GO
/****** Object:  StoredProcedure [dbo].[sp_TinhX2_DB]    Script Date: 2/24/2024 12:03:59 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


  
CREATE proc [dbo].[sp_TinhX2_DB]
@DATE DATE  
as 



 select  
 FORMAT(cast(SUM(CASE WHEN T2.BT IS NOT NULL THEN 1 ELSE 0 END) OVER(PARTITION BY 1 )  as float)
/COUNT(*) OVER(PARTITION BY 1 )* 100,'0.0') AS Tile,
 SUM(CASE WHEN T2.BT IS NOT NULL THEN 1 ELSE 0 END) OVER(PARTITION BY 1 ) AS OK
 ,COUNT(*) OVER(PARTITION BY 1 ) AS Total
 ,t1.*,t2.*
 ,t3.CNT as N'T3.CNT THÁNG'
  ,t4.DAY as N'T4.DB'
 ,t5.CNT as N'T5.HÔM QUA'
 ,t6.CNT as N'T6.HÔM KIA'
 ,t9.CNT as N'T9.HÔM KÌA'
  ,t7.CNT as N'T7.CNT TUẦN'
 ,T15.CNT as N'T15.CNT TUẦN TRƯỚC'
 ,t8.CNT as N'T8.3 NGÀY'
 ,T10.CNT AS N'T10.Đầu số hôm qua'
 ,T14.CNT AS N'T14.Đuôi số hôm qua'
 ,T11.CNT AS N'T11.Số ở  7  ngày hôm qua'
 ,T12.CNT AS N'T12.g.7 hôm qua'
  
   from DataNumber T1 
 
   LEFT JOIN  V_ResultOfDay T2 ON T1.BT =T2.BT  and date=@DATE
 -- SỐ LẦN XUẤT HIỆN TRONG THÁNG
 LEFT JOIN (
 select  BT,COUNT(*) CNT  FROM  V_ResultOfDay WHERE date between  DATEADD(DAY,-30,@DATE)  and  DATEADD(DAY,-1,@DATE) 
 GROUP BY BT  ) T3 ON T1.BT =T3.BT
 -- NHỮNG SỐ ĐÃ TRÚNG GIẢI ĐẶC BIỆT
 LEFT JOIN (
SELECT BT,STRING_AGG(FORMAT(DATE,'dd/MM'),',') DAY  FROM [SC].[dbo].[V_ResultOfDay]    where date between  DATEADD(DAY,-30,@DATE)  and  DATEADD(DAY,-1,@DATE)     and giai in ('db' )
group by bt) T4 ON T1.BT= T4.BT
-- NHỮNG SỐ ĐÃ VỀ NGÀY HÔM QUA
 LEFT JOIN (
SELECT   BT,COUNT(*) CNT  FROM [SC].[dbo].[V_ResultOfDay]    where date =  DATEADD(DAY,-1,@DATE)    
group by bt) T5 ON T1.BT= T5.BT
 
-- NHỮNG SỐ ĐÃ VỀ NGÀY HÔM KIA
 LEFT JOIN (
SELECT   BT,COUNT(*) CNT  FROM [SC].[dbo].[V_ResultOfDay]    where date =  DATEADD(DAY,-2,@DATE)    
group by bt) T6 ON T1.BT= T6.BT
  -- SỐ LẦN XUẤT HIỆN TRONG TUẦN
 LEFT JOIN (
 select  BT,COUNT(*) CNT  FROM  V_ResultOfDay WHERE date between  DATEADD(DAY,-7,@DATE)  and  DATEADD(DAY,-1,@DATE) 
 GROUP BY BT  ) T7 ON T1.BT =T7.BT

   -- SỐ LẦN XUẤT HIỆN TRONG  3 NGÀY
 LEFT JOIN (
 select  BT,COUNT(*) CNT  FROM  V_ResultOfDay WHERE date between  DATEADD(DAY,-3,@DATE)  and  DATEADD(DAY,-1,@DATE) 
 GROUP BY BT  ) T8 ON T1.BT =T8.BT
 
 
-- NHỮNG SỐ ĐÃ VỀ NGÀY HÔM KÌA
 LEFT JOIN (
SELECT   BT,COUNT(*) CNT  FROM [SC].[dbo].[V_ResultOfDay]    where date =  DATEADD(DAY,-3,@DATE)    
group by bt) T9 ON T1.BT= T9.BT

-- Đầu số đã về bao nháy ngày hôm qua
 LEFT JOIN (
SELECT   LEFT(bt,1) BT,COUNT(*) CNT  FROM [SC].[dbo].[V_ResultOfDay]    where date  =  DATEADD(DAY,-1,@DATE)  
group by LEFT(bt,1)) T10 ON left(T1.BT,1)= T10.BT


-- Số ở giải 7 ngày hôm qua
 LEFT JOIN (
SELECT BT,COUNT(*) CNT  FROM [SC].[dbo].[V_ResultOfDay]    where  date between  DATEADD(DAY,-7,@DATE)  and  DATEADD(DAY,-1,@DATE)   and giai in('NHAT','db')
group by bt) T11 ON T1.BT= T11.BT


-- Số ở giải   hôm qua
 LEFT JOIN (
SELECT     BT,COUNT(*) CNT  FROM [SC].[dbo].[V_ResultOfDay]    where  date between  DATEADD(DAY,-7,@DATE)  and  DATEADD(DAY,-1,@DATE)   and giai='bay'
group by bt) T12 ON T1.BT= T12.BT
 
 -- Đầu số đã về bao nháy ngày hôm KIA
 LEFT JOIN (
SELECT   right(bt,1) BT,COUNT(*) CNT  FROM [SC].[dbo].[V_ResultOfDay]    where  date  =  DATEADD(DAY,-2,@DATE)  
group by right(bt,1)) T14 ON right(T1.BT,1)= T14.BT
   -- SỐ LẦN XUẤT HIỆN TUẦN TRƯỚC
 LEFT JOIN (
 select  BT,COUNT(*) CNT  FROM  V_ResultOfDay WHERE date between  DATEADD(DAY,-14,@DATE)  and  DATEADD(DAY,-7,@DATE) 
 GROUP BY BT  ) T15 ON T1.BT =T15.BT
 where 
 giai='DB'
 ORDER BY DATE DESC
 
GO
/****** Object:  StoredProcedure [dbo].[sp_TinhX2_TEMP]    Script Date: 2/24/2024 12:03:59 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
















 
CREATE proc [dbo].[sp_TinhX2_TEMP]
@DATE DATE  
as 
WITH A1 AS (select  * from (
 select  

  t1.*,t2.giai,t2.value
 ,t3.CNT as  T3_CNT_Thang
  ,t4.DAY as N'T4.DB'
 ,t5.CNT as N'T5.HÔM QUA'
 ,t6.CNT as N'T6.HÔM KIA'
 ,t9.CNT as N'T9.HÔM KÌA'
  ,t7.CNT as N'T7.CNT TUẦN'
 ,T15.CNT as N'T15.CNT TUẦN TRƯỚC'
 ,t8.CNT as N'T8.3 NGÀY'
 ,T10.CNT AS N'T10.Đầu số hôm qua'
 ,T14.CNT AS N'T14.Đuôi số hôm qua'
 ,T11.CNT AS N'T11.Số ở  7  ngày hôm qua'
 ,T12.CNT AS N'T12.g.7 hôm qua'
    from DataNumber T1 
 
   LEFT JOIN  V_ResultOfDay T2 ON T1.BT =T2.BT  and date=@DATE
 -- SỐ LẦN XUẤT HIỆN TRONG THÁNG
 LEFT JOIN (
 select  BT,COUNT(*) CNT  FROM  V_ResultOfDay WHERE date between  DATEADD(DAY,-30,@DATE)  and  DATEADD(DAY,-1,@DATE) 
 GROUP BY BT  ) T3 ON T1.BT =T3.BT
 -- NHỮNG SỐ ĐÃ TRÚNG GIẢI ĐẶC BIỆT
 LEFT JOIN (
SELECT BT,STRING_AGG(FORMAT(DATE,'dd/MM'),',') DAY  FROM [SC].[dbo].[V_ResultOfDay]    where date between  DATEADD(DAY,-30,@DATE)  and  DATEADD(DAY,-1,@DATE)     and giai in ('db' )
group by bt) T4 ON T1.BT= T4.BT
-- NHỮNG SỐ ĐÃ VỀ NGÀY HÔM QUA
 LEFT JOIN (
SELECT   BT,COUNT(*) CNT  FROM [SC].[dbo].[V_ResultOfDay]    where date =  DATEADD(DAY,-1,@DATE)    
group by bt) T5 ON T1.BT= T5.BT
 
-- NHỮNG SỐ ĐÃ VỀ NGÀY HÔM KIA
 LEFT JOIN (
SELECT   BT,COUNT(*) CNT  FROM [SC].[dbo].[V_ResultOfDay]    where date =  DATEADD(DAY,-2,@DATE)    
group by bt) T6 ON T1.BT= T6.BT
  -- SỐ LẦN XUẤT HIỆN TRONG TUẦN
 LEFT JOIN (
 select  BT,COUNT(*) CNT  FROM  V_ResultOfDay WHERE date between  DATEADD(DAY,-7,@DATE)  and  DATEADD(DAY,-1,@DATE) 
 GROUP BY BT  ) T7 ON T1.BT =T7.BT

   -- SỐ LẦN XUẤT HIỆN TRONG  3 NGÀY
 LEFT JOIN (
 select  BT,COUNT(*) CNT  FROM  V_ResultOfDay WHERE date between  DATEADD(DAY,-3,@DATE)  and  DATEADD(DAY,-1,@DATE) 
 GROUP BY BT  ) T8 ON T1.BT =T8.BT
 
 
-- NHỮNG SỐ ĐÃ VỀ NGÀY HÔM KÌA
 LEFT JOIN (
SELECT   BT,COUNT(*) CNT  FROM [SC].[dbo].[V_ResultOfDay]    where date =  DATEADD(DAY,-3,@DATE)    
group by bt) T9 ON T1.BT= T9.BT

-- Đầu số đã về bao nháy ngày hôm qua
 LEFT JOIN (
SELECT   LEFT(bt,1) BT,COUNT(*) CNT  FROM [SC].[dbo].[V_ResultOfDay]    where date  =  DATEADD(DAY,-1,@DATE)  
group by LEFT(bt,1)) T10 ON left(T1.BT,1)= T10.BT


-- Số ở giải 7 ngày hôm qua
 LEFT JOIN (
SELECT BT,COUNT(*) CNT  FROM [SC].[dbo].[V_ResultOfDay]    where  date between  DATEADD(DAY,-7,@DATE)  and  DATEADD(DAY,-1,@DATE)   and giai in('NHAT','db')
group by bt) T11 ON T1.BT= T11.BT


-- Số ở giải   hôm qua
 LEFT JOIN (
SELECT     BT,COUNT(*) CNT  FROM [SC].[dbo].[V_ResultOfDay]    where  date between  DATEADD(DAY,-7,@DATE)  and  DATEADD(DAY,-1,@DATE)   and giai='bay'
group by bt) T12 ON T1.BT= T12.BT
 
 -- Đầu số đã về bao nháy ngày hôm KIA
 LEFT JOIN (
SELECT   right(bt,1) BT,COUNT(*) CNT  FROM [SC].[dbo].[V_ResultOfDay]    where  date  =  DATEADD(DAY,-2,@DATE)  
group by right(bt,1)) T14 ON right(T1.BT,1)= T14.BT
   -- SỐ LẦN XUẤT HIỆN TUẦN TRƯỚC
 LEFT JOIN (
 select  BT,COUNT(*) CNT  FROM  V_ResultOfDay WHERE date between  DATEADD(DAY,-14,@DATE)  and  DATEADD(DAY,-7,@DATE) 
 GROUP BY BT  ) T15 ON T1.BT =T15.BT
 where 
 1=1
   AND T3.CNT BETWEEN 7 AND 13
 
 -- NẾU HÔM QUA VỀ RỒI THÌ HÔM NAY BỎ
 and t8.CNT is   null
 -- Nếu về giải đặc biệt 30 ngày cũng bỏ
 and t4.BT is   null
 --
 AND   T7.CNT is not null
 --AND  ISNULL(T15.CNT,0) <=5
 --AND  ISNULL(T10.CNT,0) <=5
 -- AND  ISNULL(T14.CNT,0) <5
      AND T14.CNT  >1
	  AND T15.CNT  >1
  AND T12.BT IS NULL
 and t11.BT is null
  AND (T4.BT IS NOT NULL OR ISNULL(T12.BT,0)<=1)
    AND T15.BT IS NOT NULL
	  and t10.CNT is not null
	  and t3.CNT<=10
) a1 
 )

 SELECT  FORMAT(cast(SUM(CASE WHEN  giai IS NOT NULL THEN 1 ELSE 0 END) OVER(PARTITION BY 1 )  as float)
/COUNT(*) OVER(PARTITION BY 1 )* 100,'0.0') AS Tile,
 SUM(CASE WHEN giai IS NOT NULL THEN 1 ELSE 0 END) OVER(PARTITION BY 1 ) AS OK
 ,COUNT(*) OVER(PARTITION BY 1 ) AS Total
 
 ,* FROM A1   
 --where T3_CNT_Thang in (select  top 2   * from (select T3_CNT_Thang from a1 group by T3_CNT_Thang) a2) 

  ORDER BY  BT desc
GO
/****** Object:  StoredProcedure [dbo].[sp_TinhX2_v0]    Script Date: 2/24/2024 12:03:59 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO








CREATE PROC [dbo].[sp_TinhX2_v0] 
@date date
as
 
 select  t1.*,t2.*
 ,t3.CNT as N'T3.CNT THÁNG'
  ,t4.DAY as N'T4.DB'
 ,t5.CNT as N'T5.HÔM QUA'
 ,t6.CNT as N'T6.HÔM KIA'
 ,t9.CNT as N'T9.HÔM KÌA'
  ,t7.CNT as N'T7.CNT TUẦN'
 ,T15.CNT as N'T15.CNT TUẦN TRƯỚC'
 ,t8.CNT as N'T8.3 NGÀY'
 ,T10.CNT AS N'T10.Đầu số hôm qua'
 ,T14.CNT AS N'T14.Đuôi số hôm qua'
 ,T11.CNT AS N'T11.Số ở  7  ngày hôm qua'
 ,T12.CNT AS N'T12.g.7 hôm qua'
  
   from DataNumber T1 
 
   LEFT JOIN  V_ResultOfDay T2 ON T1.BT =T2.BT  and date=@DATE
 -- SỐ LẦN XUẤT HIỆN TRONG THÁNG
 LEFT JOIN (
 select  BT,COUNT(*) CNT  FROM  V_ResultOfDay WHERE date between  DATEADD(DAY,-30,@DATE)  and  DATEADD(DAY,-1,@DATE) 
 GROUP BY BT  ) T3 ON T1.BT =T3.BT
 -- NHỮNG SỐ ĐÃ TRÚNG GIẢI ĐẶC BIỆT
 LEFT JOIN (
SELECT BT,STRING_AGG(FORMAT(DATE,'dd/MM'),',') DAY  FROM [SC].[dbo].[V_ResultOfDay]    where date between  DATEADD(DAY,-30,@DATE)  and  DATEADD(DAY,-1,@DATE)     and giai in ('db' )
group by bt) T4 ON T1.BT= T4.BT
-- NHỮNG SỐ ĐÃ VỀ NGÀY HÔM QUA
 LEFT JOIN (
SELECT   BT,COUNT(*) CNT  FROM [SC].[dbo].[V_ResultOfDay]    where date =  DATEADD(DAY,-1,@DATE)    
group by bt) T5 ON T1.BT= T5.BT
 
-- NHỮNG SỐ ĐÃ VỀ NGÀY HÔM KIA
 LEFT JOIN (
SELECT   BT,COUNT(*) CNT  FROM [SC].[dbo].[V_ResultOfDay]    where date =  DATEADD(DAY,-2,@DATE)    
group by bt) T6 ON T1.BT= T6.BT
  -- SỐ LẦN XUẤT HIỆN TRONG TUẦN
 LEFT JOIN (
 select  BT,COUNT(*) CNT  FROM  V_ResultOfDay WHERE date between  DATEADD(DAY,-7,@DATE)  and  DATEADD(DAY,-1,@DATE) 
 GROUP BY BT  ) T7 ON T1.BT =T7.BT

   -- SỐ LẦN XUẤT HIỆN TRONG  3 NGÀY
 LEFT JOIN (
 select  BT,COUNT(*) CNT  FROM  V_ResultOfDay WHERE date between  DATEADD(DAY,-3,@DATE)  and  DATEADD(DAY,-1,@DATE) 
 GROUP BY BT  ) T8 ON T1.BT =T8.BT
 
 
-- NHỮNG SỐ ĐÃ VỀ NGÀY HÔM KÌA
 LEFT JOIN (
SELECT   BT,COUNT(*) CNT  FROM [SC].[dbo].[V_ResultOfDay]    where date =  DATEADD(DAY,-3,@DATE)    
group by bt) T9 ON T1.BT= T9.BT

-- Đầu số đã về bao nháy ngày hôm qua
 LEFT JOIN (
SELECT   LEFT(bt,1) BT,COUNT(*) CNT  FROM [SC].[dbo].[V_ResultOfDay]    where date  =  DATEADD(DAY,-1,@DATE)  
group by LEFT(bt,1)) T10 ON left(T1.BT,1)= T10.BT


-- Số ở giải 7 ngày hôm qua
 LEFT JOIN (
SELECT BT,COUNT(*) CNT  FROM [SC].[dbo].[V_ResultOfDay]    where  date between  DATEADD(DAY,-7,@DATE)  and  DATEADD(DAY,-1,@DATE)   and giai in('NHAT','db')
group by bt) T11 ON T1.BT= T11.BT


-- Số ở giải   hôm qua
 LEFT JOIN (
SELECT     BT,COUNT(*) CNT  FROM [SC].[dbo].[V_ResultOfDay]    where  date between  DATEADD(DAY,-7,@DATE)  and  DATEADD(DAY,-1,@DATE)   and giai='bay'
group by bt) T12 ON T1.BT= T12.BT
 
 -- Đầu số đã về bao nháy ngày hôm KIA
 LEFT JOIN (
SELECT   right(bt,1) BT,COUNT(*) CNT  FROM [SC].[dbo].[V_ResultOfDay]    where  date  =  DATEADD(DAY,-2,@DATE)  
group by right(bt,1)) T14 ON right(T1.BT,1)= T14.BT
   -- SỐ LẦN XUẤT HIỆN TUẦN TRƯỚC
 LEFT JOIN (
 select  BT,COUNT(*) CNT  FROM  V_ResultOfDay WHERE date between  DATEADD(DAY,-14,@DATE)  and  DATEADD(DAY,-7,@DATE) 
 GROUP BY BT  ) T15 ON T1.BT =T15.BT
 where 
 1=1
  -- đã từng về trong tuần
 and T7.bt is   null
 
 
  ORDER BY t2.BT desc
 
GO
/****** Object:  StoredProcedure [dbo].[sp_TinhX2_v2]    Script Date: 2/24/2024 12:03:59 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO




















CREATE proc [dbo].[sp_TinhX2_v2]
@DATE DATE  
as
 

select  *  from DataNumber T1 LEFT JOIN  (select  bt,DATE,STRING_AGG(giai,',') as giai from V_ResultOfDay group by bt,DATE) T2 ON T1.BT =T2.BT  and date=@DATE

where 
--1. bỏ những số đã về trong 3 ngày
T1.bt not in (
select  bt from V_ResultOfDay A1  where A1.DATE between  DATEADD(DAY,-2,@DATE)  and  DATEADD(DAY,-1,@DATE) 
)
 --2. chỉ lấy những số đã về trong vòng 7 ngày
  and  T1.bt   in (
select  bt from V_ResultOfDay  A1 where A1.DATE between  DATEADD(DAY,-7,@DATE)  and  DATEADD(DAY,-1,@DATE)  
)

--3. Số nào trong tuần mà về <2 lần cũng bỏ
  
   and  T1.bt   not in (

 SELECT  [BT]
     
  FROM (select * from (SELECT t1.BT,t2.MinDate,ISNULL(t2.CNT,0) as SoLanXuatHien FROM DATANUMBER T1 LEFT JOIN ( SELECT bt, DATEADD(day,-7,@DATE) as MinDate,count(*) AS CNT
       
  FROM [SC].[dbo].[V_ResultOfDay]  A1    where A1.DATE BETWEEN   DATEADD(day,-7,@DATE)   AND  DATEADD(DAY, -1,@DATE)  

  GROUP BY bt 
) T2 ON T1.BT=T2.BT)
 a1  ) t1
 
 where SoLanXuatHien <1
  
  )

GO
/****** Object:  StoredProcedure [dbo].[sp_TinhX2_v3]    Script Date: 2/24/2024 12:03:59 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
































 
CREATE proc [dbo].[sp_TinhX2_v3]
@DATE DATE  
as 



 select  
 FORMAT(cast(SUM(CASE WHEN T2.BT IS NOT NULL THEN 1 ELSE 0 END) OVER(PARTITION BY 1 )  as float)
/COUNT(*) OVER(PARTITION BY 1 )* 100,'0.0') AS Tile,
 SUM(CASE WHEN T2.BT IS NOT NULL THEN 1 ELSE 0 END) OVER(PARTITION BY 1 ) AS OK
 ,COUNT(*) OVER(PARTITION BY 1 ) AS Total
 ,t1.*,t2.*
 ,t3.CNT as N'T3.CNT THÁNG'
  ,t4.DAY as N'T4.DB'
 ,t5.CNT as N'T5.HÔM QUA'
 ,t6.CNT as N'T6.HÔM KIA'
 ,t9.CNT as N'T9.HÔM KÌA'
  ,t7.CNT as N'T7.CNT TUẦN'
 ,T15.CNT as N'T15.CNT TUẦN TRƯỚC'
 ,t8.CNT as N'T8.3 NGÀY'
 ,T10.CNT AS N'T10.Đầu số hôm qua'
 ,T14.CNT AS N'T14.Đuôi số hôm qua'
 ,T11.CNT AS N'T11.Số ở  7  ngày hôm qua'
 ,T12.CNT AS N'T12.g.7 hôm qua'
  
   from DataNumber T1 
 
   LEFT JOIN  V_ResultOfDay T2 ON T1.BT =T2.BT  and date=@DATE
 -- SỐ LẦN XUẤT HIỆN TRONG THÁNG
 LEFT JOIN (
 select  BT,COUNT(*) CNT  FROM  V_ResultOfDay WHERE date between  DATEADD(DAY,-30,@DATE)  and  DATEADD(DAY,-1,@DATE) 
 GROUP BY BT  ) T3 ON T1.BT =T3.BT
 -- NHỮNG SỐ ĐÃ TRÚNG GIẢI ĐẶC BIỆT
 LEFT JOIN (
SELECT BT,STRING_AGG(FORMAT(DATE,'dd/MM'),',') DAY  FROM [SC].[dbo].[V_ResultOfDay]    where date between  DATEADD(DAY,-30,@DATE)  and  DATEADD(DAY,-1,@DATE)     and giai in ('db' )
group by bt) T4 ON T1.BT= T4.BT
-- NHỮNG SỐ ĐÃ VỀ NGÀY HÔM QUA
 LEFT JOIN (
SELECT   BT,COUNT(*) CNT  FROM [SC].[dbo].[V_ResultOfDay]    where date =  DATEADD(DAY,-1,@DATE)    
group by bt) T5 ON T1.BT= T5.BT
 
-- NHỮNG SỐ ĐÃ VỀ NGÀY HÔM KIA
 LEFT JOIN (
SELECT   BT,COUNT(*) CNT  FROM [SC].[dbo].[V_ResultOfDay]    where date =  DATEADD(DAY,-2,@DATE)    
group by bt) T6 ON T1.BT= T6.BT
  -- SỐ LẦN XUẤT HIỆN TRONG TUẦN
 LEFT JOIN (
 select  BT,COUNT(*) CNT  FROM  V_ResultOfDay WHERE date between  DATEADD(DAY,-7,@DATE)  and  DATEADD(DAY,-1,@DATE) 
 GROUP BY BT  ) T7 ON T1.BT =T7.BT

   -- SỐ LẦN XUẤT HIỆN TRONG  3 NGÀY
 LEFT JOIN (
 select  BT,COUNT(*) CNT  FROM  V_ResultOfDay WHERE date between  DATEADD(DAY,-3,@DATE)  and  DATEADD(DAY,-1,@DATE) 
 GROUP BY BT  ) T8 ON T1.BT =T8.BT
 
 
-- NHỮNG SỐ ĐÃ VỀ NGÀY HÔM KÌA
 LEFT JOIN (
SELECT   BT,COUNT(*) CNT  FROM [SC].[dbo].[V_ResultOfDay]    where date =  DATEADD(DAY,-3,@DATE)    
group by bt) T9 ON T1.BT= T9.BT

-- Đầu số đã về bao nháy ngày hôm qua
 LEFT JOIN (
SELECT   LEFT(bt,1) BT,COUNT(*) CNT  FROM [SC].[dbo].[V_ResultOfDay]    where date  =  DATEADD(DAY,-1,@DATE)  
group by LEFT(bt,1)) T10 ON left(T1.BT,1)= T10.BT


-- Số ở giải 7 ngày hôm qua
 LEFT JOIN (
SELECT BT,COUNT(*) CNT  FROM [SC].[dbo].[V_ResultOfDay]    where  date between  DATEADD(DAY,-7,@DATE)  and  DATEADD(DAY,-1,@DATE)   and giai in('NHAT','db')
group by bt) T11 ON T1.BT= T11.BT


-- Số ở giải   hôm qua
 LEFT JOIN (
SELECT     BT,COUNT(*) CNT  FROM [SC].[dbo].[V_ResultOfDay]    where  date between  DATEADD(DAY,-7,@DATE)  and  DATEADD(DAY,-1,@DATE)   and giai='bay'
group by bt) T12 ON T1.BT= T12.BT
 
 -- Đầu số đã về bao nháy ngày hôm KIA
 LEFT JOIN (
SELECT   right(bt,1) BT,COUNT(*) CNT  FROM [SC].[dbo].[V_ResultOfDay]    where  date  =  DATEADD(DAY,-2,@DATE)  
group by right(bt,1)) T14 ON right(T1.BT,1)= T14.BT
   -- SỐ LẦN XUẤT HIỆN TUẦN TRƯỚC
 LEFT JOIN (
 select  BT,COUNT(*) CNT  FROM  V_ResultOfDay WHERE date between  DATEADD(DAY,-14,@DATE)  and  DATEADD(DAY,-7,@DATE) 
 GROUP BY BT  ) T15 ON T1.BT =T15.BT
 where 
 1=1



 
 AND T3.CNT BETWEEN 1 AND 10
 -- NẾU HÔM QUA VỀ RỒI THÌ HÔM NAY BỎ
  -- Nếu về giải đặc b	iệt 30 ngày cũng bỏ
 and T7.BT is    null
 --and T8.BT is    null
 --and T5.CNT is    null
 --and T9.CNT is    null
 ------
 -- --AND   T7.CNT <5
 -- AND   T14.CNT is not null
 -- --AND   T15.CNT is not null
 --AND   T12.CNT is   null
 AND  ISNULL(T15.CNT,0) <= 3
 AND  ISNULL(T5.CNT,0) <5
 AND  ISNULL(T6.CNT,0) <5
 AND  ISNULL(T9.CNT,0) <5
 AND  ISNULL(T14.CNT,0) <5
 AND  ISNULL(T10.CNT,0) <6

GO
USE [master]
GO
ALTER DATABASE [SC] SET  READ_WRITE 
GO
