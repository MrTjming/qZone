USE [master]
GO
/****** Object:  Database [qZone]    Script Date: 2017/12/10 22:15:17 ******/
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
/****** Object:  Table [dbo].[applyFriend]    Script Date: 2017/12/10 22:15:17 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[applyFriend](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[fromwho] [int] NOT NULL,
	[towho] [int] NOT NULL,
	[time] [datetime] NOT NULL,
	[fromname] [nvarchar](20) NOT NULL,
 CONSTRAINT [PK_applyFriend] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[friends]    Script Date: 2017/12/10 22:15:17 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[friends](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[user1] [int] NOT NULL,
	[user2] [int] NOT NULL,
	[time] [datetime] NOT NULL,
 CONSTRAINT [PK_friends] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[journal]    Script Date: 2017/12/10 22:15:17 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[journal](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[whose] [int] NOT NULL,
	[type] [int] NOT NULL,
	[time] [datetime] NOT NULL,
	[text] [nvarchar](max) NOT NULL,
	[title] [nvarchar](64) NOT NULL,
	[visual] [int] NULL,
 CONSTRAINT [PK_journal] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[msgBoard]    Script Date: 2017/12/10 22:15:17 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[msgBoard](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[fromwho] [int] NOT NULL,
	[towho] [int] NOT NULL,
	[text] [nvarchar](500) NOT NULL,
	[time] [datetime] NOT NULL,
 CONSTRAINT [PK_msgBoard] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[news]    Script Date: 2017/12/10 22:15:17 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[news](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[time] [datetime] NOT NULL,
	[type] [nvarchar](8) NOT NULL,
	[whose] [int] NOT NULL,
	[display] [int] NOT NULL,
	[extra] [nvarchar](140) NOT NULL,
	[which] [int] NOT NULL,
	[extra2] [varchar](50) NULL,
 CONSTRAINT [PK_Table_1] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[photo]    Script Date: 2017/12/10 22:15:17 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[photo](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[whose] [int] NOT NULL,
	[whichgroup] [int] NOT NULL,
	[address] [nvarchar](50) NOT NULL,
	[name] [nvarchar](20) NULL,
	[introduce] [nvarchar](100) NULL,
	[time] [datetime] NOT NULL,
 CONSTRAINT [PK_photo] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[reply]    Script Date: 2017/12/10 22:15:17 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[reply](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[type] [nvarchar](8) NOT NULL,
	[text] [nvarchar](200) NOT NULL,
	[whose] [int] NOT NULL,
	[towhich] [int] NOT NULL,
	[time] [datetime] NOT NULL,
 CONSTRAINT [PK_reply] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[thumbsUp]    Script Date: 2017/12/10 22:15:17 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[thumbsUp](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[which] [int] NOT NULL,
	[type] [nvarchar](8) NOT NULL,
	[whoid] [nvarchar](max) NULL,
	[whonickname] [nvarchar](max) NULL,
	[num] [int] NULL,
 CONSTRAINT [PK_thumbsUp] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[twitter]    Script Date: 2017/12/10 22:15:17 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[twitter](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[whose] [int] NOT NULL,
	[time] [datetime] NOT NULL,
	[text] [nvarchar](140) NOT NULL,
	[visual] [int] NOT NULL,
 CONSTRAINT [PK_twitter] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[usergroup]    Script Date: 2017/12/10 22:15:17 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[usergroup](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[whose] [int] NULL,
	[name] [nvarchar](20) NULL,
	[visual] [nvarchar](max) NULL,
	[grouptype] [nvarchar](8) NULL,
	[extra] [varchar](55) NULL,
	[introduce] [nvarchar](100) NULL,
	[addtional] [varchar](25) NULL,
 CONSTRAINT [PK_zu] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[userInfo]    Script Date: 2017/12/10 22:15:17 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[userInfo](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[userid] [int] NOT NULL,
	[sex] [nvarchar](2) NULL,
	[age] [int] NULL,
	[birthday] [nvarchar](10) NULL,
	[constellationInfo] [nvarchar](3) NULL,
	[livecountry] [nvarchar](2) NULL,
	[liveprovince] [nvarchar](10) NULL,
	[livecity] [nvarchar](10) NULL,
	[marrageInfo] [nvarchar](3) NULL,
	[bloodTypeInfo] [nvarchar](2) NULL,
	[hometowncountry] [nvarchar](2) NULL,
	[hometownprovince] [nvarchar](10) NULL,
	[hometowncity] [nvarchar](10) NULL,
	[workInfo] [nvarchar](20) NULL,
	[companyName] [nvarchar](20) NULL,
	[companycountry] [nvarchar](2) NULL,
	[companyprovince] [nvarchar](50) NULL,
	[companycity] [nvarchar](50) NULL,
	[addressInfo] [nvarchar](50) NULL,
	[zoneName] [nvarchar](10) NULL,
	[zoneIntroduce] [nvarchar](50) NULL,
	[hostSay] [nvarchar](200) NULL,
 CONSTRAINT [PK_userInfo] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[users]    Script Date: 2017/12/10 22:15:17 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[users](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[name] [nvarchar](20) NOT NULL,
	[pwd] [nvarchar](32) NOT NULL,
	[quesid] [int] NOT NULL,
	[ans] [nvarchar](50) NOT NULL,
	[checkcode] [nvarchar](36) NULL,
	[nickname] [nvarchar](20) NOT NULL,
	[visual] [int] NULL,
	[visualtype] [nvarchar](8) NULL,
 CONSTRAINT [PK_users] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  View [dbo].[friendView1]    Script Date: 2017/12/10 22:15:17 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[friendView1]
AS
SELECT   dbo.friends.user1 AS id, dbo.users.nickname, dbo.friends.user2
FROM      dbo.friends INNER JOIN
                dbo.users ON dbo.friends.user1 = dbo.users.id

GO
/****** Object:  View [dbo].[friendView2]    Script Date: 2017/12/10 22:15:17 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[friendView2]
AS
SELECT   dbo.friends.user1, dbo.friends.user2 AS id, dbo.users.nickname
FROM      dbo.friends INNER JOIN
                dbo.users ON dbo.friends.user2 = dbo.users.id

GO
/****** Object:  View [dbo].[messageBoard]    Script Date: 2017/12/10 22:15:17 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[messageBoard]
AS
SELECT   dbo.msgBoard.id, dbo.msgBoard.fromwho, dbo.msgBoard.towho, dbo.msgBoard.text, dbo.msgBoard.time, 
                dbo.users.id AS Expr1, dbo.users.nickname
FROM      dbo.msgBoard INNER JOIN
                dbo.users ON dbo.msgBoard.fromwho = dbo.users.id

GO
/****** Object:  View [dbo].[newsView]    Script Date: 2017/12/10 22:15:17 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[newsView]
AS
SELECT   dbo.news.whose, dbo.users.nickname, dbo.news.time, dbo.news.type, dbo.news.display, dbo.news.extra, dbo.news.id, 
                dbo.news.which, dbo.news.extra2
FROM      dbo.users INNER JOIN
                dbo.news ON dbo.users.id = dbo.news.whose

GO
/****** Object:  View [dbo].[replyView]    Script Date: 2017/12/10 22:15:17 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[replyView]
AS
SELECT   dbo.reply.id, dbo.reply.type, dbo.reply.text, dbo.reply.whose, dbo.reply.towhich, dbo.reply.time, dbo.users.id AS Expr1, 
                dbo.users.nickname
FROM      dbo.reply INNER JOIN
                dbo.users ON dbo.reply.whose = dbo.users.id

GO
/****** Object:  View [dbo].[twitterView]    Script Date: 2017/12/10 22:15:17 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[twitterView]
AS
SELECT   dbo.users.nickname, dbo.twitter.id, dbo.twitter.whose, dbo.twitter.text, dbo.twitter.time, dbo.twitter.visual
FROM      dbo.twitter INNER JOIN
                dbo.users ON dbo.twitter.whose = dbo.users.id

GO
/****** Object:  View [dbo].[userInfoView]    Script Date: 2017/12/10 22:15:17 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[userInfoView]
AS
SELECT   dbo.userInfo.userid, dbo.users.id, dbo.users.name, dbo.users.nickname, dbo.userInfo.sex, dbo.userInfo.age, 
                dbo.userInfo.birthday, dbo.userInfo.marrageInfo
FROM      dbo.users INNER JOIN
                dbo.userInfo ON dbo.users.id = dbo.userInfo.userid

GO
/****** Object:  View [dbo].[View_2]    Script Date: 2017/12/10 22:15:17 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[View_2]
AS
SELECT   dbo.friends.user1, dbo.friends.time, dbo.friends.id, dbo.users.nickname, dbo.friends.user2
FROM      dbo.friends INNER JOIN
                dbo.users ON dbo.friends.user1 = dbo.users.id

GO
SET IDENTITY_INSERT [dbo].[applyFriend] ON 

INSERT [dbo].[applyFriend] ([id], [fromwho], [towho], [time], [fromname]) VALUES (4, 23, 21, CAST(0x0000A8440172A208 AS DateTime), N'小花')
SET IDENTITY_INSERT [dbo].[applyFriend] OFF
SET IDENTITY_INSERT [dbo].[friends] ON 

INSERT [dbo].[friends] ([id], [user1], [user2], [time]) VALUES (24, 21, 22, CAST(0x0000A844016E2A48 AS DateTime))
INSERT [dbo].[friends] ([id], [user1], [user2], [time]) VALUES (25, 23, 22, CAST(0x0000A8440172ADC0 AS DateTime))
SET IDENTITY_INSERT [dbo].[friends] OFF
SET IDENTITY_INSERT [dbo].[journal] ON 

INSERT [dbo].[journal] ([id], [whose], [type], [time], [text], [title], [visual]) VALUES (45, 21, 63, CAST(0x0000A84401708A7C AS DateTime), N'<p><span style="text-decoration: underline;"><strong><em>十大发</em></strong></span></p><p><span style="text-decoration: underline;"><strong><em>违反</em></strong></span></p><p><span style="text-decoration: underline;"><strong><em>&nbsp;王菲</em></strong></span></p><p><span style="text-decoration: underline;"><strong><em>为</em></strong></span></p>', N'tr 地方', 64)
INSERT [dbo].[journal] ([id], [whose], [type], [time], [text], [title], [visual]) VALUES (46, 23, 67, CAST(0x0000A8440173160C AS DateTime), N'<p>ET R WY TR Y</p>', N'FG H', 69)
INSERT [dbo].[journal] ([id], [whose], [type], [time], [text], [title], [visual]) VALUES (47, 23, 70, CAST(0x0000A84401734F78 AS DateTime), N'<p><span style="text-decoration: underline;"><em><strong>dfah&nbsp;</strong></em></span></p><p><span style="text-decoration: underline;"><em><strong>fg fgh&nbsp;</strong></em></span></p>', N'aaaaaaaaa', 71)
INSERT [dbo].[journal] ([id], [whose], [type], [time], [text], [title], [visual]) VALUES (48, 22, 55, CAST(0x0000A8450165141C AS DateTime), N'<p>煽风点火时都会<br/></p>', N'发的', 83)
SET IDENTITY_INSERT [dbo].[journal] OFF
SET IDENTITY_INSERT [dbo].[msgBoard] ON 

INSERT [dbo].[msgBoard] ([id], [fromwho], [towho], [text], [time]) VALUES (4, 22, 22, N'发个', CAST(0x0000A8440164B8B4 AS DateTime))
INSERT [dbo].[msgBoard] ([id], [fromwho], [towho], [text], [time]) VALUES (5, 22, 21, N'个发', CAST(0x0000A8440165A314 AS DateTime))
SET IDENTITY_INSERT [dbo].[msgBoard] OFF
SET IDENTITY_INSERT [dbo].[news] ON 

INSERT [dbo].[news] ([id], [time], [type], [whose], [display], [extra], [which], [extra2]) VALUES (96, CAST(0x0000A84400C25DD0 AS DateTime), N'twitter', 22, 47, N'我加了qq空间啦........', 6, NULL)
INSERT [dbo].[news] ([id], [time], [type], [whose], [display], [extra], [which], [extra2]) VALUES (97, CAST(0x0000A8440158F04C AS DateTime), N'photo', 22, 47, N'啦啦啦啦', 7, NULL)
INSERT [dbo].[news] ([id], [time], [type], [whose], [display], [extra], [which], [extra2]) VALUES (114, CAST(0x0000A845015D2EA0 AS DateTime), N'photo', 22, 47, N'上传了新照片到--<123>', 49, N'Photos/22/计算机导论动图.gif')
INSERT [dbo].[news] ([id], [time], [type], [whose], [display], [extra], [which], [extra2]) VALUES (115, CAST(0x0000A845015D347C AS DateTime), N'photo', 22, 47, N'上传了新照片到--<123>', 50, N'Photos/22/计算机导论动图.gif')
INSERT [dbo].[news] ([id], [time], [type], [whose], [display], [extra], [which], [extra2]) VALUES (116, CAST(0x0000A845015F13C8 AS DateTime), N'photo', 22, 47, N'上传了新照片到--<123>', 51, N'Photos/22/考试时间.png')
INSERT [dbo].[news] ([id], [time], [type], [whose], [display], [extra], [which], [extra2]) VALUES (117, CAST(0x0000A845015F1878 AS DateTime), N'photo', 22, 47, N'上传了新照片到--<123>', 52, N'Photos/22/数据结构.png')
INSERT [dbo].[news] ([id], [time], [type], [whose], [display], [extra], [which], [extra2]) VALUES (118, CAST(0x0000A84501620FD8 AS DateTime), N'photo', 22, 47, N'上传了新照片到--<42>', 53, N'Photos/22/考试时间.png')
INSERT [dbo].[news] ([id], [time], [type], [whose], [display], [extra], [which], [extra2]) VALUES (119, CAST(0x0000A84501621488 AS DateTime), N'photo', 22, 47, N'上传了新照片到--<42>', 54, N'Photos/22/数据结构.png')
INSERT [dbo].[news] ([id], [time], [type], [whose], [display], [extra], [which], [extra2]) VALUES (120, CAST(0x0000A8450165141C AS DateTime), N'journal', 22, 83, N'发表了日志--发的', 48, NULL)
SET IDENTITY_INSERT [dbo].[news] OFF
SET IDENTITY_INSERT [dbo].[photo] ON 

INSERT [dbo].[photo] ([id], [whose], [whichgroup], [address], [name], [introduce], [time]) VALUES (53, 22, 82, N'Photos/22/考试时间.png', N'45', N'524', CAST(0x0000A84501620FD8 AS DateTime))
INSERT [dbo].[photo] ([id], [whose], [whichgroup], [address], [name], [introduce], [time]) VALUES (54, 22, 82, N'Photos/22/数据结构.png', N'45', N'524', CAST(0x0000A84501621488 AS DateTime))
SET IDENTITY_INSERT [dbo].[photo] OFF
SET IDENTITY_INSERT [dbo].[reply] ON 

INSERT [dbo].[reply] ([id], [type], [text], [whose], [towhich], [time]) VALUES (35, N'twitter', N'是的发', 22, 6, CAST(0x0000A844015AC764 AS DateTime))
INSERT [dbo].[reply] ([id], [type], [text], [whose], [towhich], [time]) VALUES (36, N'photo', N'发的', 22, 45, CAST(0x0000A844015DBD98 AS DateTime))
INSERT [dbo].[reply] ([id], [type], [text], [whose], [towhich], [time]) VALUES (37, N'photo', N'的是否', 22, 45, CAST(0x0000A844015DDE68 AS DateTime))
INSERT [dbo].[reply] ([id], [type], [text], [whose], [towhich], [time]) VALUES (38, N'msgboard', N'个', 22, 4, CAST(0x0000A8440164BB0C AS DateTime))
INSERT [dbo].[reply] ([id], [type], [text], [whose], [towhich], [time]) VALUES (39, N'journal', N'F ', 22, 45, CAST(0x0000A84401714728 AS DateTime))
INSERT [dbo].[reply] ([id], [type], [text], [whose], [towhich], [time]) VALUES (40, N'journal', N'好撒地方', 22, 45, CAST(0x0000A84500FB895C AS DateTime))
INSERT [dbo].[reply] ([id], [type], [text], [whose], [towhich], [time]) VALUES (41, N'journal', N'发个', 22, 39, CAST(0x0000A84500FB9AF0 AS DateTime))
INSERT [dbo].[reply] ([id], [type], [text], [whose], [towhich], [time]) VALUES (42, N'photo', N'啦啦啦', 22, 46, CAST(0x0000A84501572744 AS DateTime))
INSERT [dbo].[reply] ([id], [type], [text], [whose], [towhich], [time]) VALUES (45, N'journal', N'优惠价', 22, 48, CAST(0x0000A8450165E5E0 AS DateTime))
INSERT [dbo].[reply] ([id], [type], [text], [whose], [towhich], [time]) VALUES (46, N'journal', N'范甘迪', 22, 48, CAST(0x0000A84501661718 AS DateTime))
INSERT [dbo].[reply] ([id], [type], [text], [whose], [towhich], [time]) VALUES (47, N'msgboard', N'2', 22, 4, CAST(0x0000A8450166A3B8 AS DateTime))
INSERT [dbo].[reply] ([id], [type], [text], [whose], [towhich], [time]) VALUES (48, N'twitter', N'2', 22, 6, CAST(0x0000A8450166B1C8 AS DateTime))
INSERT [dbo].[reply] ([id], [type], [text], [whose], [towhich], [time]) VALUES (49, N'msgboard', N'&lt;讲话稿&gt;', 22, 4, CAST(0x0000A84501678968 AS DateTime))
INSERT [dbo].[reply] ([id], [type], [text], [whose], [towhich], [time]) VALUES (50, N'msgboard', N'&lt;sdf&gt;', 22, 4, CAST(0x0000A84501678F44 AS DateTime))
INSERT [dbo].[reply] ([id], [type], [text], [whose], [towhich], [time]) VALUES (51, N'journal', N'个', 22, 48, CAST(0x0000A8450168B310 AS DateTime))
INSERT [dbo].[reply] ([id], [type], [text], [whose], [towhich], [time]) VALUES (52, N'photo', N'12', 22, 53, CAST(0x0000A845016AD3FC AS DateTime))
INSERT [dbo].[reply] ([id], [type], [text], [whose], [towhich], [time]) VALUES (53, N'photo', N'465456', 22, 53, CAST(0x0000A845016AFAA8 AS DateTime))
INSERT [dbo].[reply] ([id], [type], [text], [whose], [towhich], [time]) VALUES (54, N'photo', N'24', 22, 54, CAST(0x0000A845016C04AC AS DateTime))
INSERT [dbo].[reply] ([id], [type], [text], [whose], [towhich], [time]) VALUES (55, N'photo', N'5', 22, 54, CAST(0x0000A845016C1514 AS DateTime))
INSERT [dbo].[reply] ([id], [type], [text], [whose], [towhich], [time]) VALUES (56, N'photo', N'啦啦', 22, 54, CAST(0x0000A845016C2450 AS DateTime))
INSERT [dbo].[reply] ([id], [type], [text], [whose], [towhich], [time]) VALUES (57, N'journal', N'420', 22, 51, CAST(0x0000A845016C5330 AS DateTime))
SET IDENTITY_INSERT [dbo].[reply] OFF
SET IDENTITY_INSERT [dbo].[thumbsUp] ON 

INSERT [dbo].[thumbsUp] ([id], [which], [type], [whoid], [whonickname], [num]) VALUES (3, 9, N'userinfo', N',22,,21,', N' 小明  小明 ', 2)
INSERT [dbo].[thumbsUp] ([id], [which], [type], [whoid], [whonickname], [num]) VALUES (4, 10, N'userinfo', NULL, NULL, 0)
INSERT [dbo].[thumbsUp] ([id], [which], [type], [whoid], [whonickname], [num]) VALUES (5, 6, N'twitter', N',21,', N' 小明 ', 1)
INSERT [dbo].[thumbsUp] ([id], [which], [type], [whoid], [whonickname], [num]) VALUES (6, 7, N'photo', N'', N'', 0)
INSERT [dbo].[thumbsUp] ([id], [which], [type], [whoid], [whonickname], [num]) VALUES (7, 44, N'journal', N'', N'', 0)
INSERT [dbo].[thumbsUp] ([id], [which], [type], [whoid], [whonickname], [num]) VALUES (8, 45, N'photo', N',22,', N' 小明 ', 1)
INSERT [dbo].[thumbsUp] ([id], [which], [type], [whoid], [whonickname], [num]) VALUES (9, 45, N'journal', N'', N'', 0)
INSERT [dbo].[thumbsUp] ([id], [which], [type], [whoid], [whonickname], [num]) VALUES (10, 11, N'userinfo', NULL, NULL, 0)
INSERT [dbo].[thumbsUp] ([id], [which], [type], [whoid], [whonickname], [num]) VALUES (11, 8, N'twitter', N'', N'', 0)
INSERT [dbo].[thumbsUp] ([id], [which], [type], [whoid], [whonickname], [num]) VALUES (12, 46, N'journal', N'', N'', 0)
INSERT [dbo].[thumbsUp] ([id], [which], [type], [whoid], [whonickname], [num]) VALUES (13, 47, N'journal', NULL, NULL, 0)
INSERT [dbo].[thumbsUp] ([id], [which], [type], [whoid], [whonickname], [num]) VALUES (14, 46, N'photo', N',22,', N' 小明 ', 1)
INSERT [dbo].[thumbsUp] ([id], [which], [type], [whoid], [whonickname], [num]) VALUES (15, 47, N'photo', NULL, NULL, 0)
INSERT [dbo].[thumbsUp] ([id], [which], [type], [whoid], [whonickname], [num]) VALUES (16, 48, N'photo', NULL, NULL, 0)
INSERT [dbo].[thumbsUp] ([id], [which], [type], [whoid], [whonickname], [num]) VALUES (17, 49, N'photo', NULL, NULL, 0)
INSERT [dbo].[thumbsUp] ([id], [which], [type], [whoid], [whonickname], [num]) VALUES (18, 50, N'photo', NULL, NULL, 0)
INSERT [dbo].[thumbsUp] ([id], [which], [type], [whoid], [whonickname], [num]) VALUES (19, 51, N'photo', NULL, NULL, 0)
INSERT [dbo].[thumbsUp] ([id], [which], [type], [whoid], [whonickname], [num]) VALUES (20, 52, N'photo', NULL, NULL, 0)
INSERT [dbo].[thumbsUp] ([id], [which], [type], [whoid], [whonickname], [num]) VALUES (21, 53, N'photo', NULL, NULL, 0)
INSERT [dbo].[thumbsUp] ([id], [which], [type], [whoid], [whonickname], [num]) VALUES (22, 54, N'photo', N'', N'', 0)
INSERT [dbo].[thumbsUp] ([id], [which], [type], [whoid], [whonickname], [num]) VALUES (23, 48, N'journal', N'', N'', 0)
SET IDENTITY_INSERT [dbo].[thumbsUp] OFF
SET IDENTITY_INSERT [dbo].[twitter] ON 

INSERT [dbo].[twitter] ([id], [whose], [time], [text], [visual]) VALUES (6, 22, CAST(0x0000A84400C25DD0 AS DateTime), N'我加了qq空间啦........', 47)
INSERT [dbo].[twitter] ([id], [whose], [time], [text], [visual]) VALUES (8, 23, CAST(0x0000A844017209B0 AS DateTime), N'我加了qq空间啦........', 66)
SET IDENTITY_INSERT [dbo].[twitter] OFF
SET IDENTITY_INSERT [dbo].[usergroup] ON 

INSERT [dbo].[usergroup] ([id], [whose], [name], [visual], [grouptype], [extra], [introduce], [addtional]) VALUES (44, 21, NULL, N',21,,22,', N'allpower', NULL, NULL, NULL)
INSERT [dbo].[usergroup] ([id], [whose], [name], [visual], [grouptype], [extra], [introduce], [addtional]) VALUES (45, 21, N'个人日记', N'44', N'journal', NULL, NULL, NULL)
INSERT [dbo].[usergroup] ([id], [whose], [name], [visual], [grouptype], [extra], [introduce], [addtional]) VALUES (46, 21, N'我的相册', N'44', N'album', N'Photos/nophoto.png', NULL, NULL)
INSERT [dbo].[usergroup] ([id], [whose], [name], [visual], [grouptype], [extra], [introduce], [addtional]) VALUES (47, 22, NULL, N',22,,21,,23,', N'allpower', NULL, NULL, NULL)
INSERT [dbo].[usergroup] ([id], [whose], [name], [visual], [grouptype], [extra], [introduce], [addtional]) VALUES (50, 22, NULL, N',22,', N'power', NULL, NULL, NULL)
INSERT [dbo].[usergroup] ([id], [whose], [name], [visual], [grouptype], [extra], [introduce], [addtional]) VALUES (51, 22, NULL, N',22,', N'power', NULL, NULL, NULL)
INSERT [dbo].[usergroup] ([id], [whose], [name], [visual], [grouptype], [extra], [introduce], [addtional]) VALUES (55, 22, N'as是个个', NULL, N'journal', NULL, NULL, NULL)
INSERT [dbo].[usergroup] ([id], [whose], [name], [visual], [grouptype], [extra], [introduce], [addtional]) VALUES (56, 22, N'as是发', NULL, N'journal', NULL, NULL, NULL)
INSERT [dbo].[usergroup] ([id], [whose], [name], [visual], [grouptype], [extra], [introduce], [addtional]) VALUES (58, 22, NULL, N',22,,21,,23,', N'allpower', NULL, NULL, NULL)
INSERT [dbo].[usergroup] ([id], [whose], [name], [visual], [grouptype], [extra], [introduce], [addtional]) VALUES (59, 22, NULL, N',22,', N'power', NULL, NULL, NULL)
INSERT [dbo].[usergroup] ([id], [whose], [name], [visual], [grouptype], [extra], [introduce], [addtional]) VALUES (60, 22, NULL, N',22,', N'power', NULL, NULL, NULL)
INSERT [dbo].[usergroup] ([id], [whose], [name], [visual], [grouptype], [extra], [introduce], [addtional]) VALUES (61, 22, NULL, N',21,,22,', N'power', NULL, NULL, NULL)
INSERT [dbo].[usergroup] ([id], [whose], [name], [visual], [grouptype], [extra], [introduce], [addtional]) VALUES (63, 21, N'个人日记gf g', NULL, N'journal', NULL, NULL, NULL)
INSERT [dbo].[usergroup] ([id], [whose], [name], [visual], [grouptype], [extra], [introduce], [addtional]) VALUES (64, 21, NULL, N',21,,22,', N'power', NULL, NULL, NULL)
INSERT [dbo].[usergroup] ([id], [whose], [name], [visual], [grouptype], [extra], [introduce], [addtional]) VALUES (65, 21, NULL, N',21,,22,', N'allpower', NULL, NULL, NULL)
INSERT [dbo].[usergroup] ([id], [whose], [name], [visual], [grouptype], [extra], [introduce], [addtional]) VALUES (66, 23, NULL, N',23,,22,,2,', N'allpower', NULL, NULL, NULL)
INSERT [dbo].[usergroup] ([id], [whose], [name], [visual], [grouptype], [extra], [introduce], [addtional]) VALUES (67, 23, N'个人日记', N'66', N'journal', NULL, NULL, NULL)
INSERT [dbo].[usergroup] ([id], [whose], [name], [visual], [grouptype], [extra], [introduce], [addtional]) VALUES (68, 23, N'我的相册', N'79', N'album', N'Photos/nophoto.png', NULL, NULL)
INSERT [dbo].[usergroup] ([id], [whose], [name], [visual], [grouptype], [extra], [introduce], [addtional]) VALUES (69, 23, NULL, N',23,,22,,2,', N'power', NULL, NULL, NULL)
INSERT [dbo].[usergroup] ([id], [whose], [name], [visual], [grouptype], [extra], [introduce], [addtional]) VALUES (70, 23, N'个人日记FD ', NULL, N'journal', NULL, NULL, NULL)
INSERT [dbo].[usergroup] ([id], [whose], [name], [visual], [grouptype], [extra], [introduce], [addtional]) VALUES (71, 23, NULL, N',23,', N'power', NULL, NULL, NULL)
INSERT [dbo].[usergroup] ([id], [whose], [name], [visual], [grouptype], [extra], [introduce], [addtional]) VALUES (72, NULL, NULL, N',23,', N'power', NULL, NULL, NULL)
INSERT [dbo].[usergroup] ([id], [whose], [name], [visual], [grouptype], [extra], [introduce], [addtional]) VALUES (73, NULL, NULL, N',22,,23,', N'power', NULL, NULL, NULL)
INSERT [dbo].[usergroup] ([id], [whose], [name], [visual], [grouptype], [extra], [introduce], [addtional]) VALUES (74, NULL, NULL, N',22,,23,', N'power', NULL, NULL, NULL)
INSERT [dbo].[usergroup] ([id], [whose], [name], [visual], [grouptype], [extra], [introduce], [addtional]) VALUES (75, 23, N'我的相册111', N'66', N'album', N'Photos/nophoto.png', NULL, NULL)
INSERT [dbo].[usergroup] ([id], [whose], [name], [visual], [grouptype], [extra], [introduce], [addtional]) VALUES (76, NULL, NULL, N',22,,23,', N'power', NULL, NULL, NULL)
INSERT [dbo].[usergroup] ([id], [whose], [name], [visual], [grouptype], [extra], [introduce], [addtional]) VALUES (77, NULL, NULL, N',22,,23,', N'power', NULL, NULL, NULL)
INSERT [dbo].[usergroup] ([id], [whose], [name], [visual], [grouptype], [extra], [introduce], [addtional]) VALUES (78, NULL, NULL, N',22,,23,', N'power', NULL, NULL, NULL)
INSERT [dbo].[usergroup] ([id], [whose], [name], [visual], [grouptype], [extra], [introduce], [addtional]) VALUES (79, 23, NULL, N',22,,23,', N'power', NULL, NULL, NULL)
INSERT [dbo].[usergroup] ([id], [whose], [name], [visual], [grouptype], [extra], [introduce], [addtional]) VALUES (82, 22, N'42', N'47', N'album', N'Photos/22/考试时间.png', NULL, NULL)
INSERT [dbo].[usergroup] ([id], [whose], [name], [visual], [grouptype], [extra], [introduce], [addtional]) VALUES (83, 22, NULL, N',22,,21,,23,', N'power', NULL, NULL, NULL)
SET IDENTITY_INSERT [dbo].[usergroup] OFF
SET IDENTITY_INSERT [dbo].[userInfo] ON 

INSERT [dbo].[userInfo] ([id], [userid], [sex], [age], [birthday], [constellationInfo], [livecountry], [liveprovince], [livecity], [marrageInfo], [bloodTypeInfo], [hometowncountry], [hometownprovince], [hometowncity], [workInfo], [companyName], [companycountry], [companyprovince], [companycity], [addressInfo], [zoneName], [zoneIntroduce], [hostSay]) VALUES (9, 21, N'女', 0, N'保密', N'保密', N'中国', N'省份', N'城市', N'保密', N'B', N'中国', N'省份', N'城市', N'保密', N'保密', N'中国', N'省份', N'城市', N'保密', NULL, NULL, N'主人还没有写寄语呢')
INSERT [dbo].[userInfo] ([id], [userid], [sex], [age], [birthday], [constellationInfo], [livecountry], [liveprovince], [livecity], [marrageInfo], [bloodTypeInfo], [hometowncountry], [hometownprovince], [hometowncity], [workInfo], [companyName], [companycountry], [companyprovince], [companycity], [addressInfo], [zoneName], [zoneIntroduce], [hostSay]) VALUES (10, 22, N'保密', 0, N'保密', N'保密', N'中国', N'省份', N'城市', N'保密', N'保密', N'中国', N'省份', N'城市', N'保密', N'保密', N'中国', N'省份', N'城市', N'保密', N'qq空间', N'欢迎来到我的空间啊', N'啊第三方')
INSERT [dbo].[userInfo] ([id], [userid], [sex], [age], [birthday], [constellationInfo], [livecountry], [liveprovince], [livecity], [marrageInfo], [bloodTypeInfo], [hometowncountry], [hometownprovince], [hometowncity], [workInfo], [companyName], [companycountry], [companyprovince], [companycity], [addressInfo], [zoneName], [zoneIntroduce], [hostSay]) VALUES (11, 23, N'保密', 0, N'保密', N'保密', N'中国', N'省份', N'城市', N'保密', N'保密', N'中国', N'省份', N'城市', N'保密', N'保密', N'中国', N'省份', N'城市', N'保密', N'qq空间', N'欢迎来到我的空间', N'主人还没有写寄语呢')
SET IDENTITY_INSERT [dbo].[userInfo] OFF
SET IDENTITY_INSERT [dbo].[users] ON 

INSERT [dbo].[users] ([id], [name], [pwd], [quesid], [ans], [checkcode], [nickname], [visual], [visualtype]) VALUES (21, N'user01', N'34b928ad3aa1973dac8cb1d1836cb973', 0, N'小华', N'd6788df1-c86f-4bd6-97eb-bfa7c2c7ac25', N'小明', 65, N'allpower')
INSERT [dbo].[users] ([id], [name], [pwd], [quesid], [ans], [checkcode], [nickname], [visual], [visualtype]) VALUES (22, N'user02', N'34b928ad3aa1973dac8cb1d1836cb973', 0, N'小华', N'0f41cd03-92e3-4392-8446-7fb9ded5ad8a', N'小明', 61, N'point')
INSERT [dbo].[users] ([id], [name], [pwd], [quesid], [ans], [checkcode], [nickname], [visual], [visualtype]) VALUES (23, N'user03', N'34b928ad3aa1973dac8cb1d1836cb973', 0, N'852', N'f1a661fd-4d5a-4bc9-8e37-84ae7efec618', N'小花', NULL, N'all')
SET IDENTITY_INSERT [dbo].[users] OFF
ALTER TABLE [dbo].[thumbsUp] ADD  CONSTRAINT [DF_thumbsUp_num]  DEFAULT ((0)) FOR [num]
GO
ALTER TABLE [dbo].[userInfo] ADD  CONSTRAINT [DF_userInfo_sex]  DEFAULT (N'保密') FOR [sex]
GO
ALTER TABLE [dbo].[userInfo] ADD  CONSTRAINT [DF_userInfo_age]  DEFAULT ((0)) FOR [age]
GO
ALTER TABLE [dbo].[userInfo] ADD  CONSTRAINT [DF_userInfo_birthday]  DEFAULT (N'保密') FOR [birthday]
GO
ALTER TABLE [dbo].[userInfo] ADD  CONSTRAINT [DF_userInfo_constellationInfo]  DEFAULT (N'保密') FOR [constellationInfo]
GO
ALTER TABLE [dbo].[userInfo] ADD  CONSTRAINT [DF_userInfo_livecountry]  DEFAULT (N'中国') FOR [livecountry]
GO
ALTER TABLE [dbo].[userInfo] ADD  CONSTRAINT [DF_userInfo_liveprovince]  DEFAULT (N'省份') FOR [liveprovince]
GO
ALTER TABLE [dbo].[userInfo] ADD  CONSTRAINT [DF_userInfo_livecity]  DEFAULT (N'城市') FOR [livecity]
GO
ALTER TABLE [dbo].[userInfo] ADD  CONSTRAINT [DF_userInfo_marrageInfo]  DEFAULT (N'保密') FOR [marrageInfo]
GO
ALTER TABLE [dbo].[userInfo] ADD  CONSTRAINT [DF_userInfo_bloodTypeInfo]  DEFAULT (N'保密') FOR [bloodTypeInfo]
GO
ALTER TABLE [dbo].[userInfo] ADD  CONSTRAINT [DF_userInfo_hometowncountry]  DEFAULT (N'中国') FOR [hometowncountry]
GO
ALTER TABLE [dbo].[userInfo] ADD  CONSTRAINT [DF_userInfo_hometownprovince]  DEFAULT (N'省份') FOR [hometownprovince]
GO
ALTER TABLE [dbo].[userInfo] ADD  CONSTRAINT [DF_userInfo_hometowncity]  DEFAULT (N'城市') FOR [hometowncity]
GO
ALTER TABLE [dbo].[userInfo] ADD  CONSTRAINT [DF_userInfo_workInfo]  DEFAULT (N'保密') FOR [workInfo]
GO
ALTER TABLE [dbo].[userInfo] ADD  CONSTRAINT [DF_userInfo_companyName]  DEFAULT (N'保密') FOR [companyName]
GO
ALTER TABLE [dbo].[userInfo] ADD  CONSTRAINT [DF_userInfo_companycountry]  DEFAULT (N'中国') FOR [companycountry]
GO
ALTER TABLE [dbo].[userInfo] ADD  CONSTRAINT [DF_userInfo_companyprovince]  DEFAULT (N'省份') FOR [companyprovince]
GO
ALTER TABLE [dbo].[userInfo] ADD  CONSTRAINT [DF_userInfo_companycity]  DEFAULT (N'城市') FOR [companycity]
GO
ALTER TABLE [dbo].[userInfo] ADD  CONSTRAINT [DF_userInfo_addressInfo]  DEFAULT (N'保密') FOR [addressInfo]
GO
ALTER TABLE [dbo].[userInfo] ADD  CONSTRAINT [DF_userInfo_zoneName]  DEFAULT (N'qq空间') FOR [zoneName]
GO
ALTER TABLE [dbo].[userInfo] ADD  CONSTRAINT [DF_userInfo_zoneIntroduce]  DEFAULT (N'欢迎来到我的空间') FOR [zoneIntroduce]
GO
ALTER TABLE [dbo].[userInfo] ADD  CONSTRAINT [DF_userInfo_hostSay]  DEFAULT (N'主人还没有写寄语呢') FOR [hostSay]
GO
ALTER TABLE [dbo].[users] ADD  CONSTRAINT [DF_users_visualtype]  DEFAULT (N'all') FOR [visualtype]
GO
ALTER TABLE [dbo].[applyFriend]  WITH CHECK ADD  CONSTRAINT [发出申请的人] FOREIGN KEY([fromwho])
REFERENCES [dbo].[users] ([id])
GO
ALTER TABLE [dbo].[applyFriend] CHECK CONSTRAINT [发出申请的人]
GO
ALTER TABLE [dbo].[applyFriend]  WITH NOCHECK ADD  CONSTRAINT [申请人的昵称] FOREIGN KEY([id])
REFERENCES [dbo].[applyFriend] ([id])
GO
ALTER TABLE [dbo].[applyFriend] CHECK CONSTRAINT [申请人的昵称]
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
ALTER TABLE [dbo].[journal]  WITH CHECK ADD  CONSTRAINT [可见权限表] FOREIGN KEY([visual])
REFERENCES [dbo].[usergroup] ([id])
GO
ALTER TABLE [dbo].[journal] CHECK CONSTRAINT [可见权限表]
GO
ALTER TABLE [dbo].[journal]  WITH CHECK ADD  CONSTRAINT [日志的主人] FOREIGN KEY([whose])
REFERENCES [dbo].[users] ([id])
GO
ALTER TABLE [dbo].[journal] CHECK CONSTRAINT [日志的主人]
GO
ALTER TABLE [dbo].[journal]  WITH CHECK ADD  CONSTRAINT [日志所在分类] FOREIGN KEY([type])
REFERENCES [dbo].[usergroup] ([id])
GO
ALTER TABLE [dbo].[journal] CHECK CONSTRAINT [日志所在分类]
GO
ALTER TABLE [dbo].[msgBoard]  WITH CHECK ADD  CONSTRAINT [留言的对象] FOREIGN KEY([towho])
REFERENCES [dbo].[users] ([id])
GO
ALTER TABLE [dbo].[msgBoard] CHECK CONSTRAINT [留言的对象]
GO
ALTER TABLE [dbo].[msgBoard]  WITH CHECK ADD  CONSTRAINT [写留言的人] FOREIGN KEY([fromwho])
REFERENCES [dbo].[users] ([id])
GO
ALTER TABLE [dbo].[msgBoard] CHECK CONSTRAINT [写留言的人]
GO
ALTER TABLE [dbo].[news]  WITH CHECK ADD  CONSTRAINT [发动态的人] FOREIGN KEY([whose])
REFERENCES [dbo].[users] ([id])
GO
ALTER TABLE [dbo].[news] CHECK CONSTRAINT [发动态的人]
GO
ALTER TABLE [dbo].[news]  WITH CHECK ADD  CONSTRAINT [可见的用户] FOREIGN KEY([display])
REFERENCES [dbo].[usergroup] ([id])
GO
ALTER TABLE [dbo].[news] CHECK CONSTRAINT [可见的用户]
GO
ALTER TABLE [dbo].[photo]  WITH CHECK ADD  CONSTRAINT [照片的主人] FOREIGN KEY([whose])
REFERENCES [dbo].[users] ([id])
GO
ALTER TABLE [dbo].[photo] CHECK CONSTRAINT [照片的主人]
GO
ALTER TABLE [dbo].[photo]  WITH CHECK ADD  CONSTRAINT [照片所在的相册] FOREIGN KEY([whichgroup])
REFERENCES [dbo].[usergroup] ([id])
GO
ALTER TABLE [dbo].[photo] CHECK CONSTRAINT [照片所在的相册]
GO
ALTER TABLE [dbo].[reply]  WITH CHECK ADD  CONSTRAINT [写回复的人] FOREIGN KEY([whose])
REFERENCES [dbo].[users] ([id])
GO
ALTER TABLE [dbo].[reply] CHECK CONSTRAINT [写回复的人]
GO
ALTER TABLE [dbo].[twitter]  WITH CHECK ADD  CONSTRAINT [发说说的人] FOREIGN KEY([whose])
REFERENCES [dbo].[users] ([id])
GO
ALTER TABLE [dbo].[twitter] CHECK CONSTRAINT [发说说的人]
GO
ALTER TABLE [dbo].[twitter]  WITH CHECK ADD  CONSTRAINT [可见的用户列表] FOREIGN KEY([visual])
REFERENCES [dbo].[usergroup] ([id])
GO
ALTER TABLE [dbo].[twitter] CHECK CONSTRAINT [可见的用户列表]
GO
ALTER TABLE [dbo].[userInfo]  WITH CHECK ADD  CONSTRAINT [谁的信息] FOREIGN KEY([userid])
REFERENCES [dbo].[users] ([id])
GO
ALTER TABLE [dbo].[userInfo] CHECK CONSTRAINT [谁的信息]
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane1', @value=N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[40] 4[20] 2[20] 3) )"
      End
      Begin PaneConfiguration = 1
         NumPanes = 3
         Configuration = "(H (1 [50] 4 [25] 3))"
      End
      Begin PaneConfiguration = 2
         NumPanes = 3
         Configuration = "(H (1 [50] 2 [25] 3))"
      End
      Begin PaneConfiguration = 3
         NumPanes = 3
         Configuration = "(H (4 [30] 2 [40] 3))"
      End
      Begin PaneConfiguration = 4
         NumPanes = 2
         Configuration = "(H (1 [56] 3))"
      End
      Begin PaneConfiguration = 5
         NumPanes = 2
         Configuration = "(H (2 [66] 3))"
      End
      Begin PaneConfiguration = 6
         NumPanes = 2
         Configuration = "(H (4 [50] 3))"
      End
      Begin PaneConfiguration = 7
         NumPanes = 1
         Configuration = "(V (3))"
      End
      Begin PaneConfiguration = 8
         NumPanes = 3
         Configuration = "(H (1[56] 4[18] 2) )"
      End
      Begin PaneConfiguration = 9
         NumPanes = 2
         Configuration = "(H (1 [75] 4))"
      End
      Begin PaneConfiguration = 10
         NumPanes = 2
         Configuration = "(H (1[66] 2) )"
      End
      Begin PaneConfiguration = 11
         NumPanes = 2
         Configuration = "(H (4 [60] 2))"
      End
      Begin PaneConfiguration = 12
         NumPanes = 1
         Configuration = "(H (1) )"
      End
      Begin PaneConfiguration = 13
         NumPanes = 1
         Configuration = "(V (4))"
      End
      Begin PaneConfiguration = 14
         NumPanes = 1
         Configuration = "(V (2))"
      End
      ActivePaneConfig = 0
   End
   Begin DiagramPane = 
      Begin Origin = 
         Top = 0
         Left = 0
      End
      Begin Tables = 
         Begin Table = "friends"
            Begin Extent = 
               Top = 6
               Left = 38
               Bottom = 252
               Right = 180
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "users"
            Begin Extent = 
               Top = 0
               Left = 325
               Bottom = 251
               Right = 694
            End
            DisplayFlags = 280
            TopColumn = 0
         End
      End
   End
   Begin SQLPane = 
   End
   Begin DataPane = 
      Begin ParameterDefaults = ""
      End
   End
   Begin CriteriaPane = 
      Begin ColumnWidths = 11
         Column = 1440
         Alias = 900
         Table = 1170
         Output = 720
         Append = 1400
         NewValue = 1170
         SortType = 1350
         SortOrder = 1410
         GroupBy = 1350
         Filter = 1350
         Or = 1350
         Or = 1350
         Or = 1350
      End
   End
End
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'friendView1'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'friendView1'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane1', @value=N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[40] 4[20] 2[20] 3) )"
      End
      Begin PaneConfiguration = 1
         NumPanes = 3
         Configuration = "(H (1 [50] 4 [25] 3))"
      End
      Begin PaneConfiguration = 2
         NumPanes = 3
         Configuration = "(H (1 [50] 2 [25] 3))"
      End
      Begin PaneConfiguration = 3
         NumPanes = 3
         Configuration = "(H (4 [30] 2 [40] 3))"
      End
      Begin PaneConfiguration = 4
         NumPanes = 2
         Configuration = "(H (1 [56] 3))"
      End
      Begin PaneConfiguration = 5
         NumPanes = 2
         Configuration = "(H (2 [66] 3))"
      End
      Begin PaneConfiguration = 6
         NumPanes = 2
         Configuration = "(H (4 [50] 3))"
      End
      Begin PaneConfiguration = 7
         NumPanes = 1
         Configuration = "(V (3))"
      End
      Begin PaneConfiguration = 8
         NumPanes = 3
         Configuration = "(H (1[56] 4[18] 2) )"
      End
      Begin PaneConfiguration = 9
         NumPanes = 2
         Configuration = "(H (1 [75] 4))"
      End
      Begin PaneConfiguration = 10
         NumPanes = 2
         Configuration = "(H (1[66] 2) )"
      End
      Begin PaneConfiguration = 11
         NumPanes = 2
         Configuration = "(H (4 [60] 2))"
      End
      Begin PaneConfiguration = 12
         NumPanes = 1
         Configuration = "(H (1) )"
      End
      Begin PaneConfiguration = 13
         NumPanes = 1
         Configuration = "(V (4))"
      End
      Begin PaneConfiguration = 14
         NumPanes = 1
         Configuration = "(V (2))"
      End
      ActivePaneConfig = 0
   End
   Begin DiagramPane = 
      Begin Origin = 
         Top = 0
         Left = 0
      End
      Begin Tables = 
         Begin Table = "friends"
            Begin Extent = 
               Top = 6
               Left = 38
               Bottom = 146
               Right = 180
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "users"
            Begin Extent = 
               Top = 34
               Left = 374
               Bottom = 268
               Right = 705
            End
            DisplayFlags = 280
            TopColumn = 0
         End
      End
   End
   Begin SQLPane = 
   End
   Begin DataPane = 
      Begin ParameterDefaults = ""
      End
   End
   Begin CriteriaPane = 
      Begin ColumnWidths = 11
         Column = 1440
         Alias = 900
         Table = 1170
         Output = 720
         Append = 1400
         NewValue = 1170
         SortType = 1350
         SortOrder = 1410
         GroupBy = 1350
         Filter = 1350
         Or = 1350
         Or = 1350
         Or = 1350
      End
   End
End
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'friendView2'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'friendView2'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane1', @value=N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[40] 4[20] 2[20] 3) )"
      End
      Begin PaneConfiguration = 1
         NumPanes = 3
         Configuration = "(H (1 [50] 4 [25] 3))"
      End
      Begin PaneConfiguration = 2
         NumPanes = 3
         Configuration = "(H (1 [50] 2 [25] 3))"
      End
      Begin PaneConfiguration = 3
         NumPanes = 3
         Configuration = "(H (4 [30] 2 [40] 3))"
      End
      Begin PaneConfiguration = 4
         NumPanes = 2
         Configuration = "(H (1 [56] 3))"
      End
      Begin PaneConfiguration = 5
         NumPanes = 2
         Configuration = "(H (2 [66] 3))"
      End
      Begin PaneConfiguration = 6
         NumPanes = 2
         Configuration = "(H (4 [50] 3))"
      End
      Begin PaneConfiguration = 7
         NumPanes = 1
         Configuration = "(V (3))"
      End
      Begin PaneConfiguration = 8
         NumPanes = 3
         Configuration = "(H (1[56] 4[18] 2) )"
      End
      Begin PaneConfiguration = 9
         NumPanes = 2
         Configuration = "(H (1 [75] 4))"
      End
      Begin PaneConfiguration = 10
         NumPanes = 2
         Configuration = "(H (1[66] 2) )"
      End
      Begin PaneConfiguration = 11
         NumPanes = 2
         Configuration = "(H (4 [60] 2))"
      End
      Begin PaneConfiguration = 12
         NumPanes = 1
         Configuration = "(H (1) )"
      End
      Begin PaneConfiguration = 13
         NumPanes = 1
         Configuration = "(V (4))"
      End
      Begin PaneConfiguration = 14
         NumPanes = 1
         Configuration = "(V (2))"
      End
      ActivePaneConfig = 0
   End
   Begin DiagramPane = 
      Begin Origin = 
         Top = 0
         Left = 0
      End
      Begin Tables = 
         Begin Table = "msgBoard"
            Begin Extent = 
               Top = 22
               Left = 45
               Bottom = 221
               Right = 247
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "users"
            Begin Extent = 
               Top = 22
               Left = 565
               Bottom = 248
               Right = 768
            End
            DisplayFlags = 280
            TopColumn = 0
         End
      End
   End
   Begin SQLPane = 
   End
   Begin DataPane = 
      Begin ParameterDefaults = ""
      End
   End
   Begin CriteriaPane = 
      Begin ColumnWidths = 11
         Column = 1440
         Alias = 900
         Table = 1170
         Output = 720
         Append = 1400
         NewValue = 1170
         SortType = 1350
         SortOrder = 1410
         GroupBy = 1350
         Filter = 1350
         Or = 1350
         Or = 1350
         Or = 1350
      End
   End
End
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'messageBoard'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'messageBoard'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane1', @value=N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[40] 4[20] 2[20] 3) )"
      End
      Begin PaneConfiguration = 1
         NumPanes = 3
         Configuration = "(H (1 [50] 4 [25] 3))"
      End
      Begin PaneConfiguration = 2
         NumPanes = 3
         Configuration = "(H (1 [50] 2 [25] 3))"
      End
      Begin PaneConfiguration = 3
         NumPanes = 3
         Configuration = "(H (4 [30] 2 [40] 3))"
      End
      Begin PaneConfiguration = 4
         NumPanes = 2
         Configuration = "(H (1 [56] 3))"
      End
      Begin PaneConfiguration = 5
         NumPanes = 2
         Configuration = "(H (2 [66] 3))"
      End
      Begin PaneConfiguration = 6
         NumPanes = 2
         Configuration = "(H (4 [50] 3))"
      End
      Begin PaneConfiguration = 7
         NumPanes = 1
         Configuration = "(V (3))"
      End
      Begin PaneConfiguration = 8
         NumPanes = 3
         Configuration = "(H (1[56] 4[18] 2) )"
      End
      Begin PaneConfiguration = 9
         NumPanes = 2
         Configuration = "(H (1 [75] 4))"
      End
      Begin PaneConfiguration = 10
         NumPanes = 2
         Configuration = "(H (1[66] 2) )"
      End
      Begin PaneConfiguration = 11
         NumPanes = 2
         Configuration = "(H (4 [60] 2))"
      End
      Begin PaneConfiguration = 12
         NumPanes = 1
         Configuration = "(H (1) )"
      End
      Begin PaneConfiguration = 13
         NumPanes = 1
         Configuration = "(V (4))"
      End
      Begin PaneConfiguration = 14
         NumPanes = 1
         Configuration = "(V (2))"
      End
      ActivePaneConfig = 0
   End
   Begin DiagramPane = 
      Begin Origin = 
         Top = 0
         Left = 0
      End
      Begin Tables = 
         Begin Table = "users"
            Begin Extent = 
               Top = 6
               Left = 38
               Bottom = 232
               Right = 189
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "news"
            Begin Extent = 
               Top = 6
               Left = 227
               Bottom = 250
               Right = 420
            End
            DisplayFlags = 280
            TopColumn = 0
         End
      End
   End
   Begin SQLPane = 
   End
   Begin DataPane = 
      Begin ParameterDefaults = ""
      End
   End
   Begin CriteriaPane = 
      Begin ColumnWidths = 11
         Column = 4095
         Alias = 900
         Table = 1170
         Output = 720
         Append = 1400
         NewValue = 1170
         SortType = 1350
         SortOrder = 1410
         GroupBy = 1350
         Filter = 1350
         Or = 1350
         Or = 1350
         Or = 1350
      End
   End
End
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'newsView'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'newsView'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane1', @value=N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[40] 4[20] 2[20] 3) )"
      End
      Begin PaneConfiguration = 1
         NumPanes = 3
         Configuration = "(H (1 [50] 4 [25] 3))"
      End
      Begin PaneConfiguration = 2
         NumPanes = 3
         Configuration = "(H (1 [50] 2 [25] 3))"
      End
      Begin PaneConfiguration = 3
         NumPanes = 3
         Configuration = "(H (4 [30] 2 [40] 3))"
      End
      Begin PaneConfiguration = 4
         NumPanes = 2
         Configuration = "(H (1 [56] 3))"
      End
      Begin PaneConfiguration = 5
         NumPanes = 2
         Configuration = "(H (2 [66] 3))"
      End
      Begin PaneConfiguration = 6
         NumPanes = 2
         Configuration = "(H (4 [50] 3))"
      End
      Begin PaneConfiguration = 7
         NumPanes = 1
         Configuration = "(V (3))"
      End
      Begin PaneConfiguration = 8
         NumPanes = 3
         Configuration = "(H (1[56] 4[18] 2) )"
      End
      Begin PaneConfiguration = 9
         NumPanes = 2
         Configuration = "(H (1 [75] 4))"
      End
      Begin PaneConfiguration = 10
         NumPanes = 2
         Configuration = "(H (1[66] 2) )"
      End
      Begin PaneConfiguration = 11
         NumPanes = 2
         Configuration = "(H (4 [60] 2))"
      End
      Begin PaneConfiguration = 12
         NumPanes = 1
         Configuration = "(H (1) )"
      End
      Begin PaneConfiguration = 13
         NumPanes = 1
         Configuration = "(V (4))"
      End
      Begin PaneConfiguration = 14
         NumPanes = 1
         Configuration = "(V (2))"
      End
      ActivePaneConfig = 0
   End
   Begin DiagramPane = 
      Begin Origin = 
         Top = 0
         Left = 0
      End
      Begin Tables = 
         Begin Table = "reply"
            Begin Extent = 
               Top = 6
               Left = 38
               Bottom = 223
               Right = 180
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "users"
            Begin Extent = 
               Top = 6
               Left = 218
               Bottom = 215
               Right = 602
            End
            DisplayFlags = 280
            TopColumn = 1
         End
      End
   End
   Begin SQLPane = 
   End
   Begin DataPane = 
      Begin ParameterDefaults = ""
      End
   End
   Begin CriteriaPane = 
      Begin ColumnWidths = 11
         Column = 1440
         Alias = 900
         Table = 1170
         Output = 720
         Append = 1400
         NewValue = 1170
         SortType = 1350
         SortOrder = 1410
         GroupBy = 1350
         Filter = 1350
         Or = 1350
         Or = 1350
         Or = 1350
      End
   End
End
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'replyView'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'replyView'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane1', @value=N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[40] 4[20] 2[20] 3) )"
      End
      Begin PaneConfiguration = 1
         NumPanes = 3
         Configuration = "(H (1 [50] 4 [25] 3))"
      End
      Begin PaneConfiguration = 2
         NumPanes = 3
         Configuration = "(H (1 [50] 2 [25] 3))"
      End
      Begin PaneConfiguration = 3
         NumPanes = 3
         Configuration = "(H (4 [30] 2 [40] 3))"
      End
      Begin PaneConfiguration = 4
         NumPanes = 2
         Configuration = "(H (1 [56] 3))"
      End
      Begin PaneConfiguration = 5
         NumPanes = 2
         Configuration = "(H (2 [66] 3))"
      End
      Begin PaneConfiguration = 6
         NumPanes = 2
         Configuration = "(H (4 [50] 3))"
      End
      Begin PaneConfiguration = 7
         NumPanes = 1
         Configuration = "(V (3))"
      End
      Begin PaneConfiguration = 8
         NumPanes = 3
         Configuration = "(H (1[56] 4[18] 2) )"
      End
      Begin PaneConfiguration = 9
         NumPanes = 2
         Configuration = "(H (1 [75] 4))"
      End
      Begin PaneConfiguration = 10
         NumPanes = 2
         Configuration = "(H (1[66] 2) )"
      End
      Begin PaneConfiguration = 11
         NumPanes = 2
         Configuration = "(H (4 [60] 2))"
      End
      Begin PaneConfiguration = 12
         NumPanes = 1
         Configuration = "(H (1) )"
      End
      Begin PaneConfiguration = 13
         NumPanes = 1
         Configuration = "(V (4))"
      End
      Begin PaneConfiguration = 14
         NumPanes = 1
         Configuration = "(V (2))"
      End
      ActivePaneConfig = 0
   End
   Begin DiagramPane = 
      Begin Origin = 
         Top = 0
         Left = 0
      End
      Begin Tables = 
         Begin Table = "twitter"
            Begin Extent = 
               Top = 6
               Left = 0
               Bottom = 229
               Right = 180
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "users"
            Begin Extent = 
               Top = 6
               Left = 218
               Bottom = 257
               Right = 902
            End
            DisplayFlags = 280
            TopColumn = 0
         End
      End
   End
   Begin SQLPane = 
   End
   Begin DataPane = 
      Begin ParameterDefaults = ""
      End
   End
   Begin CriteriaPane = 
      Begin ColumnWidths = 11
         Column = 1440
         Alias = 900
         Table = 1170
         Output = 720
         Append = 1400
         NewValue = 1170
         SortType = 1350
         SortOrder = 1410
         GroupBy = 1350
         Filter = 1350
         Or = 1350
         Or = 1350
         Or = 1350
      End
   End
End
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'twitterView'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'twitterView'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane1', @value=N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[40] 4[20] 2[20] 3) )"
      End
      Begin PaneConfiguration = 1
         NumPanes = 3
         Configuration = "(H (1 [50] 4 [25] 3))"
      End
      Begin PaneConfiguration = 2
         NumPanes = 3
         Configuration = "(H (1 [50] 2 [25] 3))"
      End
      Begin PaneConfiguration = 3
         NumPanes = 3
         Configuration = "(H (4 [30] 2 [40] 3))"
      End
      Begin PaneConfiguration = 4
         NumPanes = 2
         Configuration = "(H (1 [56] 3))"
      End
      Begin PaneConfiguration = 5
         NumPanes = 2
         Configuration = "(H (2 [66] 3))"
      End
      Begin PaneConfiguration = 6
         NumPanes = 2
         Configuration = "(H (4 [50] 3))"
      End
      Begin PaneConfiguration = 7
         NumPanes = 1
         Configuration = "(V (3))"
      End
      Begin PaneConfiguration = 8
         NumPanes = 3
         Configuration = "(H (1[56] 4[18] 2) )"
      End
      Begin PaneConfiguration = 9
         NumPanes = 2
         Configuration = "(H (1 [75] 4))"
      End
      Begin PaneConfiguration = 10
         NumPanes = 2
         Configuration = "(H (1[66] 2) )"
      End
      Begin PaneConfiguration = 11
         NumPanes = 2
         Configuration = "(H (4 [60] 2))"
      End
      Begin PaneConfiguration = 12
         NumPanes = 1
         Configuration = "(H (1) )"
      End
      Begin PaneConfiguration = 13
         NumPanes = 1
         Configuration = "(V (4))"
      End
      Begin PaneConfiguration = 14
         NumPanes = 1
         Configuration = "(V (2))"
      End
      ActivePaneConfig = 0
   End
   Begin DiagramPane = 
      Begin Origin = 
         Top = 0
         Left = 0
      End
      Begin Tables = 
         Begin Table = "users"
            Begin Extent = 
               Top = 6
               Left = 38
               Bottom = 246
               Right = 189
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "userInfo"
            Begin Extent = 
               Top = 0
               Left = 355
               Bottom = 251
               Right = 736
            End
            DisplayFlags = 280
            TopColumn = 0
         End
      End
   End
   Begin SQLPane = 
   End
   Begin DataPane = 
      Begin ParameterDefaults = ""
      End
   End
   Begin CriteriaPane = 
      Begin ColumnWidths = 11
         Column = 1440
         Alias = 900
         Table = 1170
         Output = 720
         Append = 1400
         NewValue = 1170
         SortType = 1350
         SortOrder = 1410
         GroupBy = 1350
         Filter = 1350
         Or = 1350
         Or = 1350
         Or = 1350
      End
   End
End
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'userInfoView'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'userInfoView'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane1', @value=N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[52] 4[10] 2[20] 3) )"
      End
      Begin PaneConfiguration = 1
         NumPanes = 3
         Configuration = "(H (1 [50] 4 [25] 3))"
      End
      Begin PaneConfiguration = 2
         NumPanes = 3
         Configuration = "(H (1 [50] 2 [25] 3))"
      End
      Begin PaneConfiguration = 3
         NumPanes = 3
         Configuration = "(H (4 [30] 2 [40] 3))"
      End
      Begin PaneConfiguration = 4
         NumPanes = 2
         Configuration = "(H (1 [56] 3))"
      End
      Begin PaneConfiguration = 5
         NumPanes = 2
         Configuration = "(H (2 [66] 3))"
      End
      Begin PaneConfiguration = 6
         NumPanes = 2
         Configuration = "(H (4 [50] 3))"
      End
      Begin PaneConfiguration = 7
         NumPanes = 1
         Configuration = "(V (3))"
      End
      Begin PaneConfiguration = 8
         NumPanes = 3
         Configuration = "(H (1[56] 4[18] 2) )"
      End
      Begin PaneConfiguration = 9
         NumPanes = 2
         Configuration = "(H (1 [75] 4))"
      End
      Begin PaneConfiguration = 10
         NumPanes = 2
         Configuration = "(H (1[66] 2) )"
      End
      Begin PaneConfiguration = 11
         NumPanes = 2
         Configuration = "(H (4 [60] 2))"
      End
      Begin PaneConfiguration = 12
         NumPanes = 1
         Configuration = "(H (1) )"
      End
      Begin PaneConfiguration = 13
         NumPanes = 1
         Configuration = "(V (4))"
      End
      Begin PaneConfiguration = 14
         NumPanes = 1
         Configuration = "(V (2))"
      End
      ActivePaneConfig = 0
   End
   Begin DiagramPane = 
      Begin Origin = 
         Top = 0
         Left = 0
      End
      Begin Tables = 
         Begin Table = "friends"
            Begin Extent = 
               Top = 6
               Left = 38
               Bottom = 246
               Right = 180
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "users"
            Begin Extent = 
               Top = 14
               Left = 280
               Bottom = 251
               Right = 489
            End
            DisplayFlags = 280
            TopColumn = 0
         End
      End
   End
   Begin SQLPane = 
   End
   Begin DataPane = 
      Begin ParameterDefaults = ""
      End
   End
   Begin CriteriaPane = 
      Begin ColumnWidths = 11
         Column = 1440
         Alias = 900
         Table = 1170
         Output = 720
         Append = 1400
         NewValue = 1170
         SortType = 1350
         SortOrder = 1410
         GroupBy = 1350
         Filter = 1350
         Or = 1350
         Or = 1350
         Or = 1350
      End
   End
End
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'View_2'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'View_2'
GO
USE [master]
GO
ALTER DATABASE [qZone] SET  READ_WRITE 
GO
