USE [SC]
GO

/****** Object:  Table [dbo].[KUBET]    Script Date: 3/1/2021 7:14:11 PM ******/
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

ALTER TABLE [dbo].[KUBET] ADD  CONSTRAINT [DF_KUBET_DateCreated]  DEFAULT (getdate()) FOR [DateCreated]
GO


