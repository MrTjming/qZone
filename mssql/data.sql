USE [master]
GO
/****** Object:  Database [qZone]    Script Date: 2017/11/19 15:56:50 ******/
CREATE DATABASE [qZone]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'qZone', FILENAME = N'D:\Microsoft sql server\MSSQL11.MSSQLSERVER\MSSQL\DATA\qZone.mdf' , SIZE = 5120KB , MAXSIZE = UNLIMITED, FILEGROWTH = 1024KB )
 LOG ON 
( NAME = N'qZone_log', FILENAME = N'D:\Microsoft sql server\MSSQL11.MSSQLSERVER\MSSQL\DATA\qZone_log.ldf' , SIZE = 2048KB , MAXSIZE = 2048GB , FILEGROWTH = 10%)
GO
ALTER DATABASE [qZone] SET COMPATIBILITY_LEVEL = 110
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [qZone].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [qZone] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [qZone] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [qZone] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [qZone] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [qZone] SET ARITHABORT OFF 
GO
ALTER DATABASE [qZone] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [qZone] SET AUTO_CREATE_STATISTICS ON 
GO
ALTER DATABASE [qZone] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [qZone] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [qZone] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [qZone] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [qZone] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [qZone] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [qZone] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [qZone] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [qZone] SET  DISABLE_BROKER 
GO
ALTER DATABASE [qZone] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [qZone] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [qZone] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [qZone] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [qZone] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [qZone] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [qZone] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [qZone] SET RECOVERY FULL 
GO
ALTER DATABASE [qZone] SET  MULTI_USER 
GO
ALTER DATABASE [qZone] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [qZone] SET DB_CHAINING OFF 
GO
ALTER DATABASE [qZone] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [qZone] SET TARGET_RECOVERY_TIME = 0 SECONDS 
GO
EXEC sys.sp_db_vardecimal_storage_format N'qZone', N'ON'
GO
USE [qZone]
GO
/****** Object:  Table [dbo].[applyFriend]    Script Date: 2017/11/19 15:56:50 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[applyFriend](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[fromwho] [int] NOT NULL,
	[towho] [int] NOT NULL,
	[time] [int] NULL,
 CONSTRAINT [PK_applyFriend] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[friends]    Script Date: 2017/11/19 15:56:50 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[friends](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[user1] [int] NOT NULL,
	[user2] [int] NOT NULL,
	[time] [nchar](10) NOT NULL,
 CONSTRAINT [PK_friends] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[journal]    Script Date: 2017/11/19 15:56:50 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[journal](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[whose] [int] NOT NULL,
	[type] [nchar](10) NOT NULL,
	[time] [nchar](10) NOT NULL,
	[text] [nchar](10) NOT NULL,
 CONSTRAINT [PK_journal] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[msgBoard]    Script Date: 2017/11/19 15:56:50 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[msgBoard](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[fromwho] [int] NOT NULL,
	[towho] [int] NOT NULL,
	[text] [nchar](10) NOT NULL,
 CONSTRAINT [PK_msgBoard] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[news]    Script Date: 2017/11/19 15:56:50 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[news](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[time] [nchar](10) NULL,
	[type] [nchar](10) NULL,
	[which] [nchar](10) NULL,
 CONSTRAINT [PK_Table_1] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[twitter]    Script Date: 2017/11/19 15:56:50 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[twitter](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[whose] [int] NOT NULL,
	[time] [nchar](10) NOT NULL,
	[text] [nchar](10) NOT NULL,
 CONSTRAINT [PK_twitter] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[userInfo]    Script Date: 2017/11/19 15:56:50 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[userInfo](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[userid] [int] NOT NULL,
	[sex] [nvarchar](4) NULL,
	[age] [nvarchar](10) NULL,
	[birthday] [nvarchar](10) NULL,
	[constellationInfo] [nchar](10) NULL,
	[liveInfo] [nchar](10) NULL,
	[marrageInfo] [nchar](10) NULL,
	[bloodTypeInfo] [nchar](10) NULL,
	[hometownInfo] [nchar](10) NULL,
	[workInfo] [nchar](10) NULL,
	[companyName] [nchar](10) NULL,
	[companyPlace] [nchar](10) NULL,
	[addressInfo] [nchar](10) NULL,
 CONSTRAINT [PK_userInfo] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[users]    Script Date: 2017/11/19 15:56:50 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[users](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[name] [varchar](25) NOT NULL,
	[pwd] [varchar](32) NOT NULL,
	[quesid] [int] NOT NULL,
	[ans] [varchar](25) NOT NULL,
	[type] [nchar](10) NOT NULL,
	[checkcode] [varchar](40) NULL,
	[nickname] [nchar](10) NULL,
	[sex] [nchar](10) NULL,
	[age] [nchar](10) NULL,
	[introduce] [nchar](10) NULL,
 CONSTRAINT [PK_users] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
SET IDENTITY_INSERT [dbo].[applyFriend] ON 

INSERT [dbo].[applyFriend] ([id], [fromwho], [towho], [time]) VALUES (2, 2, 2, NULL)
INSERT [dbo].[applyFriend] ([id], [fromwho], [towho], [time]) VALUES (3, 2, 7, NULL)
SET IDENTITY_INSERT [dbo].[applyFriend] OFF
SET IDENTITY_INSERT [dbo].[userInfo] ON 

INSERT [dbo].[userInfo] ([id], [userid], [sex], [age], [birthday], [constellationInfo], [liveInfo], [marrageInfo], [bloodTypeInfo], [hometownInfo], [workInfo], [companyName], [companyPlace], [addressInfo]) VALUES (1, 10, N'保密', N'保密', N'保密', N'保密        ', N'保密        ', N'保密        ', N'保密        ', N'保密        ', N'保密        ', N'保密        ', N'保密        ', N'保密        ')
SET IDENTITY_INSERT [dbo].[userInfo] OFF
SET IDENTITY_INSERT [dbo].[users] ON 

INSERT [dbo].[users] ([id], [name], [pwd], [quesid], [ans], [type], [checkcode], [nickname], [sex], [age], [introduce]) VALUES (2, N'12345678', N'd13ae83b67077d0a2fa53e66d9411ba3', 0, N'asd', N'0         ', N'efd83a25-0b6a-4114-9b9c-6462f8f48724', NULL, NULL, NULL, NULL)
INSERT [dbo].[users] ([id], [name], [pwd], [quesid], [ans], [type], [checkcode], [nickname], [sex], [age], [introduce]) VALUES (7, N'23456789', N'd13ae83b67077d0a2fa53e66d9411ba3', 0, N'gdssgd', N'0         ', NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[users] ([id], [name], [pwd], [quesid], [ans], [type], [checkcode], [nickname], [sex], [age], [introduce]) VALUES (9, N'34567890', N'd13ae83b67077d0a2fa53e66d9411ba3', 0, N'dg', N'0         ', NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[users] ([id], [name], [pwd], [quesid], [ans], [type], [checkcode], [nickname], [sex], [age], [introduce]) VALUES (10, N'mingming', N'd13ae83b67077d0a2fa53e66d9411ba3', 0, N'123', N'0         ', N'dd9549a7-1240-483c-bca6-addaed2feadc', N'保密        ', N'保密        ', N'保密        ', N'保密        ')
SET IDENTITY_INSERT [dbo].[users] OFF
ALTER TABLE [dbo].[userInfo] ADD  CONSTRAINT [DF_userInfo_sex]  DEFAULT (N'保密') FOR [sex]
GO
ALTER TABLE [dbo].[userInfo] ADD  CONSTRAINT [DF_userInfo_age]  DEFAULT (N'保密') FOR [age]
GO
ALTER TABLE [dbo].[userInfo] ADD  CONSTRAINT [DF_userInfo_birthday]  DEFAULT (N'保密') FOR [birthday]
GO
ALTER TABLE [dbo].[userInfo] ADD  CONSTRAINT [DF_userInfo_constellationInfo]  DEFAULT (N'保密') FOR [constellationInfo]
GO
ALTER TABLE [dbo].[userInfo] ADD  CONSTRAINT [DF_userInfo_liveInfo]  DEFAULT (N'保密') FOR [liveInfo]
GO
ALTER TABLE [dbo].[userInfo] ADD  CONSTRAINT [DF_userInfo_marrageInfo]  DEFAULT (N'保密') FOR [marrageInfo]
GO
ALTER TABLE [dbo].[userInfo] ADD  CONSTRAINT [DF_userInfo_bloodTypeInfo]  DEFAULT (N'保密') FOR [bloodTypeInfo]
GO
ALTER TABLE [dbo].[userInfo] ADD  CONSTRAINT [DF_userInfo_hometownInfo]  DEFAULT (N'保密') FOR [hometownInfo]
GO
ALTER TABLE [dbo].[userInfo] ADD  CONSTRAINT [DF_userInfo_workInfo]  DEFAULT (N'保密') FOR [workInfo]
GO
ALTER TABLE [dbo].[userInfo] ADD  CONSTRAINT [DF_userInfo_companyName]  DEFAULT (N'保密') FOR [companyName]
GO
ALTER TABLE [dbo].[userInfo] ADD  CONSTRAINT [DF_userInfo_companyPlace]  DEFAULT (N'保密') FOR [companyPlace]
GO
ALTER TABLE [dbo].[userInfo] ADD  CONSTRAINT [DF_userInfo_addressInfo]  DEFAULT (N'保密') FOR [addressInfo]
GO
ALTER TABLE [dbo].[applyFriend]  WITH CHECK ADD  CONSTRAINT [发出申请的人] FOREIGN KEY([fromwho])
REFERENCES [dbo].[users] ([id])
GO
ALTER TABLE [dbo].[applyFriend] CHECK CONSTRAINT [发出申请的人]
GO
ALTER TABLE [dbo].[applyFriend]  WITH CHECK ADD  CONSTRAINT [申请添加的对象] FOREIGN KEY([towho])
REFERENCES [dbo].[users] ([id])
GO
ALTER TABLE [dbo].[applyFriend] CHECK CONSTRAINT [申请添加的对象]
GO
ALTER TABLE [dbo].[friends]  WITH CHECK ADD  CONSTRAINT [对象1] FOREIGN KEY([user1])
REFERENCES [dbo].[users] ([id])
GO
ALTER TABLE [dbo].[friends] CHECK CONSTRAINT [对象1]
GO
ALTER TABLE [dbo].[friends]  WITH CHECK ADD  CONSTRAINT [对象2] FOREIGN KEY([user2])
REFERENCES [dbo].[users] ([id])
GO
ALTER TABLE [dbo].[friends] CHECK CONSTRAINT [对象2]
GO
ALTER TABLE [dbo].[twitter]  WITH CHECK ADD  CONSTRAINT [发说说的人] FOREIGN KEY([whose])
REFERENCES [dbo].[users] ([id])
GO
ALTER TABLE [dbo].[twitter] CHECK CONSTRAINT [发说说的人]
GO
ALTER TABLE [dbo].[userInfo]  WITH CHECK ADD  CONSTRAINT [谁的信息] FOREIGN KEY([userid])
REFERENCES [dbo].[users] ([id])
GO
ALTER TABLE [dbo].[userInfo] CHECK CONSTRAINT [谁的信息]
GO
USE [master]
GO
ALTER DATABASE [qZone] SET  READ_WRITE 
GO
