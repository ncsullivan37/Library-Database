USE [master]
GO
/****** Object:  Database [Library]    Script Date: 3/5/2017 9:46:02 PM ******/
CREATE DATABASE [Library]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'Library', FILENAME = N'c:\Program Files\Microsoft SQL Server\MSSQL11.MSSQLSERVER\MSSQL\DATA\Library.mdf' , SIZE = 4096KB , MAXSIZE = UNLIMITED, FILEGROWTH = 1024KB )
 LOG ON 
( NAME = N'Library_log', FILENAME = N'c:\Program Files\Microsoft SQL Server\MSSQL11.MSSQLSERVER\MSSQL\DATA\Library_log.ldf' , SIZE = 1024KB , MAXSIZE = 2048GB , FILEGROWTH = 10%)
GO
ALTER DATABASE [Library] SET COMPATIBILITY_LEVEL = 110
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [Library].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [Library] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [Library] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [Library] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [Library] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [Library] SET ARITHABORT OFF 
GO
ALTER DATABASE [Library] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [Library] SET AUTO_CREATE_STATISTICS ON 
GO
ALTER DATABASE [Library] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [Library] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [Library] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [Library] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [Library] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [Library] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [Library] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [Library] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [Library] SET  DISABLE_BROKER 
GO
ALTER DATABASE [Library] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [Library] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [Library] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [Library] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [Library] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [Library] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [Library] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [Library] SET RECOVERY SIMPLE 
GO
ALTER DATABASE [Library] SET  MULTI_USER 
GO
ALTER DATABASE [Library] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [Library] SET DB_CHAINING OFF 
GO
ALTER DATABASE [Library] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [Library] SET TARGET_RECOVERY_TIME = 0 SECONDS 
GO
USE [Library]
GO
/****** Object:  Schema [LibraryAssignment]    Script Date: 3/5/2017 9:46:03 PM ******/
CREATE SCHEMA [LibraryAssignment]
GO
/****** Object:  StoredProcedure [dbo].[CopiesByAuthorAndTitle]    Script Date: 3/5/2017 9:46:03 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[CopiesByAuthorAndTitle]
@AuthorName varchar (50), 
@BranchName varchar (30)
AS
SELECT BOOK_COPIES.No_of_Copies, LIBRARY_BRANCH.BranchName, BOOK.Title, BOOK_AUTHORS.AuthorName
FROM BOOK_AUTHORS 
INNER JOIN
BOOK 
ON BOOK_AUTHORS.BookID = BOOK.BookID 
INNER JOIN
BOOK_COPIES 
ON BOOK_AUTHORS.BookID = BOOK_COPIES.BookID 
CROSS JOIN
LIBRARY_BRANCH
WHERE AuthorName=@AuthorName AND
BranchName=@BranchName

	

GO
/****** Object:  Table [dbo].[BOOK]    Script Date: 3/5/2017 9:46:03 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[BOOK](
	[BookID] [int] NOT NULL,
	[Title] [varchar](30) NOT NULL,
	[PublisherName] [varchar](50) NOT NULL
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[BOOK_AUTHORS]    Script Date: 3/5/2017 9:46:03 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[BOOK_AUTHORS](
	[BookID] [int] NOT NULL,
	[AuthorName] [varchar](50) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[BookID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[BOOK_COPIES]    Script Date: 3/5/2017 9:46:03 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[BOOK_COPIES](
	[BookID] [int] NULL,
	[BranchID] [nvarchar](42) NULL,
	[No_of_Copies] [int] NULL
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[BOOK_LOANS]    Script Date: 3/5/2017 9:46:03 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[BOOK_LOANS](
	[BookID] [int] NULL,
	[BranchID] [int] NULL,
	[CardNo] [varchar](20) NULL,
	[DateOut] [varchar](20) NULL,
	[DueDate] [varchar](20) NULL
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[BORROWER]    Script Date: 3/5/2017 9:46:03 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[BORROWER](
	[CardNo] [varchar](20) NOT NULL,
	[Name] [varchar](50) NULL,
	[Address] [varchar](30) NULL,
	[Phone] [varchar](10) NULL,
 CONSTRAINT [PK__BORROWER__55FF25F1171E3D76] PRIMARY KEY CLUSTERED 
(
	[CardNo] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[LIBRARY_BRANCH]    Script Date: 3/5/2017 9:46:03 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[LIBRARY_BRANCH](
	[BranchID] [int] NOT NULL,
	[BranchName] [varchar](50) NOT NULL,
	[Address] [varchar](30) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[BranchID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[PUBLISHER]    Script Date: 3/5/2017 9:46:03 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[PUBLISHER](
	[Name] [varchar](50) NULL,
	[Address] [varchar](75) NULL,
	[Phone] [varchar](15) NULL
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
INSERT [dbo].[BOOK] ([BookID], [Title], [PublisherName]) VALUES (1, N'The Lost Tribe', N'ABC Publishing Co,')
INSERT [dbo].[BOOK] ([BookID], [Title], [PublisherName]) VALUES (2, N'It', N'Dell')
INSERT [dbo].[BOOK] ([BookID], [Title], [PublisherName]) VALUES (3, N'13 Hours', N'XYX Publishing Co.')
INSERT [dbo].[BOOK] ([BookID], [Title], [PublisherName]) VALUES (4, N'Get Rid of Him', N'Balboa Press')
INSERT [dbo].[BOOK] ([BookID], [Title], [PublisherName]) VALUES (5, N'Math 123', N'Houghton Mifflin')
INSERT [dbo].[BOOK] ([BookID], [Title], [PublisherName]) VALUES (6, N'Ghost Wars', N'ABC Publishing Co.')
INSERT [dbo].[BOOK] ([BookID], [Title], [PublisherName]) VALUES (7, N'Think Like A Programmer', N'Spraul')
INSERT [dbo].[BOOK] ([BookID], [Title], [PublisherName]) VALUES (8, N'Phonics Grade 1', N'Houghton Mifflin')
INSERT [dbo].[BOOK] ([BookID], [Title], [PublisherName]) VALUES (9, N'Pasta Sauces', N'XYZ Publishing Co.')
INSERT [dbo].[BOOK] ([BookID], [Title], [PublisherName]) VALUES (10, N'You Can Change Your Life', N'Bantam')
INSERT [dbo].[BOOK] ([BookID], [Title], [PublisherName]) VALUES (11, N'The Mousetrap', N'Mystery Publishers')
INSERT [dbo].[BOOK] ([BookID], [Title], [PublisherName]) VALUES (12, N'The Road Less Traveled', N'Oceanworks')
INSERT [dbo].[BOOK] ([BookID], [Title], [PublisherName]) VALUES (13, N'Tom Sawyer', N'EFG Publishing Co.')
INSERT [dbo].[BOOK] ([BookID], [Title], [PublisherName]) VALUES (14, N'The Scarlet Letter', N'PrintingPress')
INSERT [dbo].[BOOK] ([BookID], [Title], [PublisherName]) VALUES (15, N'Gone With the Wind', N'Hay House')
INSERT [dbo].[BOOK] ([BookID], [Title], [PublisherName]) VALUES (16, N'Building A Dollhouse', N'HobbyLobby Co.')
INSERT [dbo].[BOOK] ([BookID], [Title], [PublisherName]) VALUES (17, N'Fifty Shades of Grey', N'Hamilton Publishers')
INSERT [dbo].[BOOK] ([BookID], [Title], [PublisherName]) VALUES (18, N'World History', N'EduPress')
INSERT [dbo].[BOOK] ([BookID], [Title], [PublisherName]) VALUES (19, N'To Kill A Mockingbird', N'Hay House')
INSERT [dbo].[BOOK] ([BookID], [Title], [PublisherName]) VALUES (20, N'The Secrets of the Unadilla', N'KH Publishers')
INSERT [dbo].[BOOK] ([BookID], [Title], [PublisherName]) VALUES (1, N'The Lost Tribe', N'ABC Publishing Co,')
INSERT [dbo].[BOOK] ([BookID], [Title], [PublisherName]) VALUES (2, N'It', N'Dell')
INSERT [dbo].[BOOK] ([BookID], [Title], [PublisherName]) VALUES (3, N'13 Hours', N'XYX Publishing Co.')
INSERT [dbo].[BOOK] ([BookID], [Title], [PublisherName]) VALUES (4, N'Get Rid of Him', N'Balboa Press')
INSERT [dbo].[BOOK] ([BookID], [Title], [PublisherName]) VALUES (5, N'Math 123', N'Houghton Mifflin')
INSERT [dbo].[BOOK] ([BookID], [Title], [PublisherName]) VALUES (6, N'Ghost Wars', N'ABC Publishing Co.')
INSERT [dbo].[BOOK] ([BookID], [Title], [PublisherName]) VALUES (7, N'Think Like A Programmer', N'Spraul')
INSERT [dbo].[BOOK] ([BookID], [Title], [PublisherName]) VALUES (8, N'Phonics Grade 1', N'Houghton Mifflin')
INSERT [dbo].[BOOK] ([BookID], [Title], [PublisherName]) VALUES (9, N'Pasta Sauces', N'XYZ Publishing Co.')
INSERT [dbo].[BOOK] ([BookID], [Title], [PublisherName]) VALUES (10, N'You Can Change Your Life', N'Bantam')
INSERT [dbo].[BOOK] ([BookID], [Title], [PublisherName]) VALUES (11, N'The Mousetrap', N'Mystery Publishers')
INSERT [dbo].[BOOK] ([BookID], [Title], [PublisherName]) VALUES (12, N'The Road Less Traveled', N'Oceanworks')
INSERT [dbo].[BOOK] ([BookID], [Title], [PublisherName]) VALUES (13, N'Tom Sawyer', N'EFG Publishing Co.')
INSERT [dbo].[BOOK] ([BookID], [Title], [PublisherName]) VALUES (14, N'The Scarlet Letter', N'PrintingPress')
INSERT [dbo].[BOOK] ([BookID], [Title], [PublisherName]) VALUES (15, N'Gone With the Wind', N'Hay House')
INSERT [dbo].[BOOK] ([BookID], [Title], [PublisherName]) VALUES (16, N'Building A Dollhouse', N'HobbyLobby Co.')
INSERT [dbo].[BOOK] ([BookID], [Title], [PublisherName]) VALUES (17, N'Fifty Shades of Grey', N'Hamilton Publishers')
INSERT [dbo].[BOOK] ([BookID], [Title], [PublisherName]) VALUES (18, N'World History', N'EduPress')
INSERT [dbo].[BOOK] ([BookID], [Title], [PublisherName]) VALUES (19, N'To Kill A Mockingbird', N'Hay House')
INSERT [dbo].[BOOK] ([BookID], [Title], [PublisherName]) VALUES (20, N'The Secrets of the Unadilla', N'KH Publishers')
INSERT [dbo].[BOOK_AUTHORS] ([BookID], [AuthorName]) VALUES (1, N'Mark Lee')
INSERT [dbo].[BOOK_AUTHORS] ([BookID], [AuthorName]) VALUES (2, N'Stephen King')
INSERT [dbo].[BOOK_AUTHORS] ([BookID], [AuthorName]) VALUES (3, N'Mitchell Zuckoff')
INSERT [dbo].[BOOK_AUTHORS] ([BookID], [AuthorName]) VALUES (4, N'Joyce L. Vedral')
INSERT [dbo].[BOOK_AUTHORS] ([BookID], [AuthorName]) VALUES (5, N'Max Math')
INSERT [dbo].[BOOK_AUTHORS] ([BookID], [AuthorName]) VALUES (6, N'Steve Coll')
INSERT [dbo].[BOOK_AUTHORS] ([BookID], [AuthorName]) VALUES (7, N'V. Anton Spraul')
INSERT [dbo].[BOOK_AUTHORS] ([BookID], [AuthorName]) VALUES (8, N'Alice Word')
INSERT [dbo].[BOOK_AUTHORS] ([BookID], [AuthorName]) VALUES (9, N'Sofia Petrizzini')
INSERT [dbo].[BOOK_AUTHORS] ([BookID], [AuthorName]) VALUES (10, N'Tim Laurence')
INSERT [dbo].[BOOK_AUTHORS] ([BookID], [AuthorName]) VALUES (11, N'Agatha Christie')
INSERT [dbo].[BOOK_AUTHORS] ([BookID], [AuthorName]) VALUES (12, N'Scott M. Peck')
INSERT [dbo].[BOOK_AUTHORS] ([BookID], [AuthorName]) VALUES (13, N'Mark Twain')
INSERT [dbo].[BOOK_AUTHORS] ([BookID], [AuthorName]) VALUES (14, N'Nathaniel Hawthorne')
INSERT [dbo].[BOOK_AUTHORS] ([BookID], [AuthorName]) VALUES (15, N'Margaret Mitchell')
INSERT [dbo].[BOOK_AUTHORS] ([BookID], [AuthorName]) VALUES (16, N'Henry Wood')
INSERT [dbo].[BOOK_AUTHORS] ([BookID], [AuthorName]) VALUES (17, N'E.L. James')
INSERT [dbo].[BOOK_AUTHORS] ([BookID], [AuthorName]) VALUES (18, N'Mira Preci')
INSERT [dbo].[BOOK_AUTHORS] ([BookID], [AuthorName]) VALUES (19, N'Harper Lee')
INSERT [dbo].[BOOK_AUTHORS] ([BookID], [AuthorName]) VALUES (20, N'Richard Sullivan')
INSERT [dbo].[BOOK_COPIES] ([BookID], [BranchID], [No_of_Copies]) VALUES (1, N'3', 2)
INSERT [dbo].[BOOK_COPIES] ([BookID], [BranchID], [No_of_Copies]) VALUES (2, N'2', 4)
INSERT [dbo].[BOOK_COPIES] ([BookID], [BranchID], [No_of_Copies]) VALUES (3, N'2', 4)
INSERT [dbo].[BOOK_COPIES] ([BookID], [BranchID], [No_of_Copies]) VALUES (4, N'1', 3)
INSERT [dbo].[BOOK_COPIES] ([BookID], [BranchID], [No_of_Copies]) VALUES (5, N'4', 2)
INSERT [dbo].[BOOK_COPIES] ([BookID], [BranchID], [No_of_Copies]) VALUES (6, N'4', 5)
INSERT [dbo].[BOOK_COPIES] ([BookID], [BranchID], [No_of_Copies]) VALUES (7, N'5', 3)
INSERT [dbo].[BOOK_COPIES] ([BookID], [BranchID], [No_of_Copies]) VALUES (8, N'3', 4)
INSERT [dbo].[BOOK_COPIES] ([BookID], [BranchID], [No_of_Copies]) VALUES (9, N'1', 2)
INSERT [dbo].[BOOK_COPIES] ([BookID], [BranchID], [No_of_Copies]) VALUES (10, N'5', 3)
INSERT [dbo].[BOOK_COPIES] ([BookID], [BranchID], [No_of_Copies]) VALUES (11, N'1', 5)
INSERT [dbo].[BOOK_COPIES] ([BookID], [BranchID], [No_of_Copies]) VALUES (12, N'2', 3)
INSERT [dbo].[BOOK_COPIES] ([BookID], [BranchID], [No_of_Copies]) VALUES (13, N'3', 2)
INSERT [dbo].[BOOK_COPIES] ([BookID], [BranchID], [No_of_Copies]) VALUES (14, N'4', 5)
INSERT [dbo].[BOOK_COPIES] ([BookID], [BranchID], [No_of_Copies]) VALUES (15, N'5', 4)
INSERT [dbo].[BOOK_COPIES] ([BookID], [BranchID], [No_of_Copies]) VALUES (16, N'1', 4)
INSERT [dbo].[BOOK_COPIES] ([BookID], [BranchID], [No_of_Copies]) VALUES (17, N'2', 3)
INSERT [dbo].[BOOK_COPIES] ([BookID], [BranchID], [No_of_Copies]) VALUES (18, N'3', 2)
INSERT [dbo].[BOOK_COPIES] ([BookID], [BranchID], [No_of_Copies]) VALUES (19, N'4', 5)
INSERT [dbo].[BOOK_COPIES] ([BookID], [BranchID], [No_of_Copies]) VALUES (20, N'5', 3)
INSERT [dbo].[BOOK_COPIES] ([BookID], [BranchID], [No_of_Copies]) VALUES (21, N'1', 2)
INSERT [dbo].[BOOK_COPIES] ([BookID], [BranchID], [No_of_Copies]) VALUES (22, N'2', 3)
INSERT [dbo].[BOOK_COPIES] ([BookID], [BranchID], [No_of_Copies]) VALUES (23, N'3', 3)
INSERT [dbo].[BOOK_COPIES] ([BookID], [BranchID], [No_of_Copies]) VALUES (24, N'3', 2)
INSERT [dbo].[BOOK_COPIES] ([BookID], [BranchID], [No_of_Copies]) VALUES (25, N'4', 3)
INSERT [dbo].[BOOK_COPIES] ([BookID], [BranchID], [No_of_Copies]) VALUES (26, N'5', 3)
INSERT [dbo].[BOOK_COPIES] ([BookID], [BranchID], [No_of_Copies]) VALUES (27, N'1', 2)
INSERT [dbo].[BOOK_COPIES] ([BookID], [BranchID], [No_of_Copies]) VALUES (28, N'2', 4)
INSERT [dbo].[BOOK_COPIES] ([BookID], [BranchID], [No_of_Copies]) VALUES (29, N'4', 5)
INSERT [dbo].[BOOK_COPIES] ([BookID], [BranchID], [No_of_Copies]) VALUES (30, N'5', 2)
INSERT [dbo].[BOOK_COPIES] ([BookID], [BranchID], [No_of_Copies]) VALUES (31, N'1', 2)
INSERT [dbo].[BOOK_COPIES] ([BookID], [BranchID], [No_of_Copies]) VALUES (32, N'2', 4)
INSERT [dbo].[BOOK_COPIES] ([BookID], [BranchID], [No_of_Copies]) VALUES (33, N'3', 3)
INSERT [dbo].[BOOK_COPIES] ([BookID], [BranchID], [No_of_Copies]) VALUES (34, N'4', 5)
INSERT [dbo].[BOOK_COPIES] ([BookID], [BranchID], [No_of_Copies]) VALUES (35, N'5', 4)
INSERT [dbo].[BOOK_COPIES] ([BookID], [BranchID], [No_of_Copies]) VALUES (36, N'1', 2)
INSERT [dbo].[BOOK_COPIES] ([BookID], [BranchID], [No_of_Copies]) VALUES (37, N'2', 2)
INSERT [dbo].[BOOK_COPIES] ([BookID], [BranchID], [No_of_Copies]) VALUES (38, N'3', 2)
INSERT [dbo].[BOOK_COPIES] ([BookID], [BranchID], [No_of_Copies]) VALUES (39, N'4', 3)
INSERT [dbo].[BOOK_COPIES] ([BookID], [BranchID], [No_of_Copies]) VALUES (40, N'5', 4)
INSERT [dbo].[BOOK_COPIES] ([BookID], [BranchID], [No_of_Copies]) VALUES (41, N'1', 2)
INSERT [dbo].[BOOK_COPIES] ([BookID], [BranchID], [No_of_Copies]) VALUES (42, N'2', 5)
INSERT [dbo].[BOOK_COPIES] ([BookID], [BranchID], [No_of_Copies]) VALUES (43, N'3', 2)
INSERT [dbo].[BOOK_COPIES] ([BookID], [BranchID], [No_of_Copies]) VALUES (44, N'4', 5)
INSERT [dbo].[BOOK_COPIES] ([BookID], [BranchID], [No_of_Copies]) VALUES (45, N'5', 4)
INSERT [dbo].[BOOK_COPIES] ([BookID], [BranchID], [No_of_Copies]) VALUES (46, N'1', 3)
INSERT [dbo].[BOOK_COPIES] ([BookID], [BranchID], [No_of_Copies]) VALUES (47, N'2', 4)
INSERT [dbo].[BOOK_COPIES] ([BookID], [BranchID], [No_of_Copies]) VALUES (48, N'3', 2)
INSERT [dbo].[BOOK_COPIES] ([BookID], [BranchID], [No_of_Copies]) VALUES (49, N'4', 5)
INSERT [dbo].[BOOK_COPIES] ([BookID], [BranchID], [No_of_Copies]) VALUES (50, N'5', 4)
INSERT [dbo].[BOOK_COPIES] ([BookID], [BranchID], [No_of_Copies]) VALUES (1, N'3', 2)
INSERT [dbo].[BOOK_COPIES] ([BookID], [BranchID], [No_of_Copies]) VALUES (2, N'2', 4)
INSERT [dbo].[BOOK_COPIES] ([BookID], [BranchID], [No_of_Copies]) VALUES (3, N'2', 4)
INSERT [dbo].[BOOK_COPIES] ([BookID], [BranchID], [No_of_Copies]) VALUES (4, N'1', 3)
INSERT [dbo].[BOOK_COPIES] ([BookID], [BranchID], [No_of_Copies]) VALUES (5, N'4', 2)
INSERT [dbo].[BOOK_COPIES] ([BookID], [BranchID], [No_of_Copies]) VALUES (6, N'4', 5)
INSERT [dbo].[BOOK_COPIES] ([BookID], [BranchID], [No_of_Copies]) VALUES (7, N'5', 3)
INSERT [dbo].[BOOK_COPIES] ([BookID], [BranchID], [No_of_Copies]) VALUES (8, N'3', 4)
INSERT [dbo].[BOOK_COPIES] ([BookID], [BranchID], [No_of_Copies]) VALUES (9, N'1', 2)
INSERT [dbo].[BOOK_COPIES] ([BookID], [BranchID], [No_of_Copies]) VALUES (10, N'5', 3)
INSERT [dbo].[BOOK_COPIES] ([BookID], [BranchID], [No_of_Copies]) VALUES (11, N'1', 5)
INSERT [dbo].[BOOK_COPIES] ([BookID], [BranchID], [No_of_Copies]) VALUES (12, N'2', 3)
INSERT [dbo].[BOOK_COPIES] ([BookID], [BranchID], [No_of_Copies]) VALUES (13, N'3', 2)
INSERT [dbo].[BOOK_COPIES] ([BookID], [BranchID], [No_of_Copies]) VALUES (14, N'4', 5)
INSERT [dbo].[BOOK_COPIES] ([BookID], [BranchID], [No_of_Copies]) VALUES (15, N'5', 4)
INSERT [dbo].[BOOK_COPIES] ([BookID], [BranchID], [No_of_Copies]) VALUES (16, N'1', 4)
INSERT [dbo].[BOOK_COPIES] ([BookID], [BranchID], [No_of_Copies]) VALUES (17, N'2', 3)
INSERT [dbo].[BOOK_COPIES] ([BookID], [BranchID], [No_of_Copies]) VALUES (18, N'3', 2)
INSERT [dbo].[BOOK_COPIES] ([BookID], [BranchID], [No_of_Copies]) VALUES (19, N'4', 5)
INSERT [dbo].[BOOK_COPIES] ([BookID], [BranchID], [No_of_Copies]) VALUES (20, N'5', 3)
INSERT [dbo].[BOOK_COPIES] ([BookID], [BranchID], [No_of_Copies]) VALUES (21, N'1', 2)
INSERT [dbo].[BOOK_COPIES] ([BookID], [BranchID], [No_of_Copies]) VALUES (22, N'2', 3)
INSERT [dbo].[BOOK_COPIES] ([BookID], [BranchID], [No_of_Copies]) VALUES (23, N'3', 3)
INSERT [dbo].[BOOK_COPIES] ([BookID], [BranchID], [No_of_Copies]) VALUES (24, N'3', 2)
INSERT [dbo].[BOOK_COPIES] ([BookID], [BranchID], [No_of_Copies]) VALUES (25, N'4', 3)
INSERT [dbo].[BOOK_COPIES] ([BookID], [BranchID], [No_of_Copies]) VALUES (26, N'5', 3)
INSERT [dbo].[BOOK_COPIES] ([BookID], [BranchID], [No_of_Copies]) VALUES (27, N'1', 2)
INSERT [dbo].[BOOK_COPIES] ([BookID], [BranchID], [No_of_Copies]) VALUES (28, N'2', 4)
INSERT [dbo].[BOOK_COPIES] ([BookID], [BranchID], [No_of_Copies]) VALUES (29, N'4', 5)
INSERT [dbo].[BOOK_COPIES] ([BookID], [BranchID], [No_of_Copies]) VALUES (30, N'5', 2)
INSERT [dbo].[BOOK_COPIES] ([BookID], [BranchID], [No_of_Copies]) VALUES (31, N'1', 2)
INSERT [dbo].[BOOK_COPIES] ([BookID], [BranchID], [No_of_Copies]) VALUES (32, N'2', 4)
INSERT [dbo].[BOOK_COPIES] ([BookID], [BranchID], [No_of_Copies]) VALUES (33, N'3', 3)
INSERT [dbo].[BOOK_COPIES] ([BookID], [BranchID], [No_of_Copies]) VALUES (34, N'4', 5)
INSERT [dbo].[BOOK_COPIES] ([BookID], [BranchID], [No_of_Copies]) VALUES (35, N'5', 4)
INSERT [dbo].[BOOK_COPIES] ([BookID], [BranchID], [No_of_Copies]) VALUES (36, N'1', 2)
INSERT [dbo].[BOOK_COPIES] ([BookID], [BranchID], [No_of_Copies]) VALUES (37, N'2', 2)
INSERT [dbo].[BOOK_COPIES] ([BookID], [BranchID], [No_of_Copies]) VALUES (38, N'3', 2)
INSERT [dbo].[BOOK_COPIES] ([BookID], [BranchID], [No_of_Copies]) VALUES (39, N'4', 3)
INSERT [dbo].[BOOK_COPIES] ([BookID], [BranchID], [No_of_Copies]) VALUES (40, N'5', 4)
INSERT [dbo].[BOOK_COPIES] ([BookID], [BranchID], [No_of_Copies]) VALUES (41, N'1', 2)
INSERT [dbo].[BOOK_COPIES] ([BookID], [BranchID], [No_of_Copies]) VALUES (42, N'2', 5)
INSERT [dbo].[BOOK_COPIES] ([BookID], [BranchID], [No_of_Copies]) VALUES (43, N'3', 2)
INSERT [dbo].[BOOK_COPIES] ([BookID], [BranchID], [No_of_Copies]) VALUES (44, N'4', 5)
INSERT [dbo].[BOOK_COPIES] ([BookID], [BranchID], [No_of_Copies]) VALUES (45, N'5', 4)
INSERT [dbo].[BOOK_COPIES] ([BookID], [BranchID], [No_of_Copies]) VALUES (46, N'1', 3)
INSERT [dbo].[BOOK_COPIES] ([BookID], [BranchID], [No_of_Copies]) VALUES (47, N'2', 4)
INSERT [dbo].[BOOK_COPIES] ([BookID], [BranchID], [No_of_Copies]) VALUES (48, N'3', 2)
INSERT [dbo].[BOOK_COPIES] ([BookID], [BranchID], [No_of_Copies]) VALUES (49, N'4', 5)
INSERT [dbo].[BOOK_COPIES] ([BookID], [BranchID], [No_of_Copies]) VALUES (50, N'5', 4)
GO
INSERT [dbo].[BOOK_LOANS] ([BookID], [BranchID], [CardNo], [DateOut], [DueDate]) VALUES (1, 3, N'5', N'2-14-17', N'2-21-17')
INSERT [dbo].[BOOK_LOANS] ([BookID], [BranchID], [CardNo], [DateOut], [DueDate]) VALUES (2, 2, N'2', N'2-14-17', N'2-21-17')
INSERT [dbo].[BOOK_LOANS] ([BookID], [BranchID], [CardNo], [DateOut], [DueDate]) VALUES (3, 2, N'6', N'2-14-17', N'2-21-17')
INSERT [dbo].[BOOK_LOANS] ([BookID], [BranchID], [CardNo], [DateOut], [DueDate]) VALUES (4, 1, N'1', N'2-14-17', N'2-21-17')
INSERT [dbo].[BOOK_LOANS] ([BookID], [BranchID], [CardNo], [DateOut], [DueDate]) VALUES (5, 4, N'7', N'2-14-17', N'2-21-17')
INSERT [dbo].[BOOK_LOANS] ([BookID], [BranchID], [CardNo], [DateOut], [DueDate]) VALUES (6, 4, N'7', N'2-14-17', N'2-21-17')
INSERT [dbo].[BOOK_LOANS] ([BookID], [BranchID], [CardNo], [DateOut], [DueDate]) VALUES (7, 5, N'3', N'2-14-17-', N'2-21-14')
INSERT [dbo].[BOOK_LOANS] ([BookID], [BranchID], [CardNo], [DateOut], [DueDate]) VALUES (8, 3, N'5', N'2-14-17', N'2-21-17')
INSERT [dbo].[BOOK_LOANS] ([BookID], [BranchID], [CardNo], [DateOut], [DueDate]) VALUES (9, 1, N'1', N'2-14-17', N'2-21-17')
INSERT [dbo].[BOOK_LOANS] ([BookID], [BranchID], [CardNo], [DateOut], [DueDate]) VALUES (10, 5, N'3', N'2-14-17', N'2-21-17')
INSERT [dbo].[BOOK_LOANS] ([BookID], [BranchID], [CardNo], [DateOut], [DueDate]) VALUES (11, 1, N'1', N'2-14-17', N'2-21-17')
INSERT [dbo].[BOOK_LOANS] ([BookID], [BranchID], [CardNo], [DateOut], [DueDate]) VALUES (12, 2, N'6', N'2-14-17', N'2-21-17')
INSERT [dbo].[BOOK_LOANS] ([BookID], [BranchID], [CardNo], [DateOut], [DueDate]) VALUES (13, 3, N'5', N'2-15-17', N'2-22-17')
INSERT [dbo].[BOOK_LOANS] ([BookID], [BranchID], [CardNo], [DateOut], [DueDate]) VALUES (14, 4, N'7', N'2-14-17', N'2-21-17')
INSERT [dbo].[BOOK_LOANS] ([BookID], [BranchID], [CardNo], [DateOut], [DueDate]) VALUES (15, 5, N'3', N'2-15-17', N'2-22-17')
INSERT [dbo].[BOOK_LOANS] ([BookID], [BranchID], [CardNo], [DateOut], [DueDate]) VALUES (16, 1, N'8', N'2-15-17', N'2-22-17')
INSERT [dbo].[BOOK_LOANS] ([BookID], [BranchID], [CardNo], [DateOut], [DueDate]) VALUES (17, 6, N'2', N'2-14-17', N'2-21-17')
INSERT [dbo].[BOOK_LOANS] ([BookID], [BranchID], [CardNo], [DateOut], [DueDate]) VALUES (18, 3, N'5', N'2-15-17', N'2-22-17')
INSERT [dbo].[BOOK_LOANS] ([BookID], [BranchID], [CardNo], [DateOut], [DueDate]) VALUES (19, 4, N'4', N'2-15-17', N'2-22-17')
INSERT [dbo].[BOOK_LOANS] ([BookID], [BranchID], [CardNo], [DateOut], [DueDate]) VALUES (20, 5, N'3', N'2-15-17', N'2-22-17')
INSERT [dbo].[BOOK_LOANS] ([BookID], [BranchID], [CardNo], [DateOut], [DueDate]) VALUES (21, 1, N'1', N'2-15-17', N'2-22-17')
INSERT [dbo].[BOOK_LOANS] ([BookID], [BranchID], [CardNo], [DateOut], [DueDate]) VALUES (22, 2, N'6', N'2-14-17', N'2-21-17')
INSERT [dbo].[BOOK_LOANS] ([BookID], [BranchID], [CardNo], [DateOut], [DueDate]) VALUES (23, 3, N'5', N'2-14-17', N'2-21-17')
INSERT [dbo].[BOOK_LOANS] ([BookID], [BranchID], [CardNo], [DateOut], [DueDate]) VALUES (24, 3, N'5', N'2-15-17', N'2-22-17')
INSERT [dbo].[BOOK_LOANS] ([BookID], [BranchID], [CardNo], [DateOut], [DueDate]) VALUES (25, 4, N'7', N'2-14-17', N'2-21-17')
INSERT [dbo].[BOOK_LOANS] ([BookID], [BranchID], [CardNo], [DateOut], [DueDate]) VALUES (26, 5, N'3', N'2-15-17', N'2-22-17')
INSERT [dbo].[BOOK_LOANS] ([BookID], [BranchID], [CardNo], [DateOut], [DueDate]) VALUES (27, 1, N'8', N'2-16-17', N'2-23-17')
INSERT [dbo].[BOOK_LOANS] ([BookID], [BranchID], [CardNo], [DateOut], [DueDate]) VALUES (28, 2, N'2', N'2-16-17', N'2-23-17')
INSERT [dbo].[BOOK_LOANS] ([BookID], [BranchID], [CardNo], [DateOut], [DueDate]) VALUES (29, 4, N'4', N'2-16-17', N'2-23-17')
INSERT [dbo].[BOOK_LOANS] ([BookID], [BranchID], [CardNo], [DateOut], [DueDate]) VALUES (30, 5, N'3', N'2-16-17', N'2-23-17')
INSERT [dbo].[BOOK_LOANS] ([BookID], [BranchID], [CardNo], [DateOut], [DueDate]) VALUES (31, 1, N'1', N'2-16-17', N'2-23-17')
INSERT [dbo].[BOOK_LOANS] ([BookID], [BranchID], [CardNo], [DateOut], [DueDate]) VALUES (32, 2, N'2', N'2-16-17', N'2-23-17')
INSERT [dbo].[BOOK_LOANS] ([BookID], [BranchID], [CardNo], [DateOut], [DueDate]) VALUES (33, 3, N'5', N'2-16-17', N'2-23-17')
INSERT [dbo].[BOOK_LOANS] ([BookID], [BranchID], [CardNo], [DateOut], [DueDate]) VALUES (34, 4, N'4', N'2-16-17', N'2-23-17')
INSERT [dbo].[BOOK_LOANS] ([BookID], [BranchID], [CardNo], [DateOut], [DueDate]) VALUES (35, 5, N'3', N'2-17-17', N'2-24-17')
INSERT [dbo].[BOOK_LOANS] ([BookID], [BranchID], [CardNo], [DateOut], [DueDate]) VALUES (37, 2, N'6', N'2-14-17', N'2-21-17')
INSERT [dbo].[BOOK_LOANS] ([BookID], [BranchID], [CardNo], [DateOut], [DueDate]) VALUES (27, 1, N'1', N'2-15-17', N'2-22-17')
INSERT [dbo].[BOOK_LOANS] ([BookID], [BranchID], [CardNo], [DateOut], [DueDate]) VALUES (4, 1, N'8', N'2-16-17', N'2-23-17')
INSERT [dbo].[BOOK_LOANS] ([BookID], [BranchID], [CardNo], [DateOut], [DueDate]) VALUES (47, 2, N'6', N'2-17-17', N'2-24-17')
INSERT [dbo].[BOOK_LOANS] ([BookID], [BranchID], [CardNo], [DateOut], [DueDate]) VALUES (39, 4, N'7', N'2-14-17', N'2-21-17')
INSERT [dbo].[BOOK_LOANS] ([BookID], [BranchID], [CardNo], [DateOut], [DueDate]) VALUES (49, 4, N'7', N'2-14-17', N'2-21-17')
INSERT [dbo].[BOOK_LOANS] ([BookID], [BranchID], [CardNo], [DateOut], [DueDate]) VALUES (44, 4, N'7', N'2-16-17', N'2-21-17')
INSERT [dbo].[BOOK_LOANS] ([BookID], [BranchID], [CardNo], [DateOut], [DueDate]) VALUES (11, 1, N'8', N'2-17-17', N'2-24-17')
INSERT [dbo].[BOOK_LOANS] ([BookID], [BranchID], [CardNo], [DateOut], [DueDate]) VALUES (22, 2, N'2', N'2-16-17', N'2-23-17')
INSERT [dbo].[BOOK_LOANS] ([BookID], [BranchID], [CardNo], [DateOut], [DueDate]) VALUES (50, 5, N'3', N'2-17-17', N'2-24-17')
INSERT [dbo].[BOOK_LOANS] ([BookID], [BranchID], [CardNo], [DateOut], [DueDate]) VALUES (22, 2, N'2', N'2-17-17', N'2-24-17')
INSERT [dbo].[BOOK_LOANS] ([BookID], [BranchID], [CardNo], [DateOut], [DueDate]) VALUES (48, 3, N'1', N'2-16-17', N'2-23-17')
INSERT [dbo].[BOOK_LOANS] ([BookID], [BranchID], [CardNo], [DateOut], [DueDate]) VALUES (20, 5, N'8', N'2-21-17', N'2-28-17')
INSERT [dbo].[BOOK_LOANS] ([BookID], [BranchID], [CardNo], [DateOut], [DueDate]) VALUES (38, 3, N'3', N'2-21-17', N'2-28-17')
INSERT [dbo].[BOOK_LOANS] ([BookID], [BranchID], [CardNo], [DateOut], [DueDate]) VALUES (41, 1, N'8', N'2-21-17', N'2-28-17')
INSERT [dbo].[BOOK_LOANS] ([BookID], [BranchID], [CardNo], [DateOut], [DueDate]) VALUES (1, 3, N'5', N'2-14-17', N'2-21-17')
INSERT [dbo].[BOOK_LOANS] ([BookID], [BranchID], [CardNo], [DateOut], [DueDate]) VALUES (2, 2, N'2', N'2-14-17', N'2-21-17')
INSERT [dbo].[BOOK_LOANS] ([BookID], [BranchID], [CardNo], [DateOut], [DueDate]) VALUES (3, 2, N'6', N'2-14-17', N'2-21-17')
INSERT [dbo].[BOOK_LOANS] ([BookID], [BranchID], [CardNo], [DateOut], [DueDate]) VALUES (4, 1, N'1', N'2-14-17', N'2-21-17')
INSERT [dbo].[BOOK_LOANS] ([BookID], [BranchID], [CardNo], [DateOut], [DueDate]) VALUES (5, 4, N'7', N'2-14-17', N'2-21-17')
INSERT [dbo].[BOOK_LOANS] ([BookID], [BranchID], [CardNo], [DateOut], [DueDate]) VALUES (6, 4, N'7', N'2-14-17', N'2-21-17')
INSERT [dbo].[BOOK_LOANS] ([BookID], [BranchID], [CardNo], [DateOut], [DueDate]) VALUES (7, 5, N'3', N'2-14-17-', N'2-21-14')
INSERT [dbo].[BOOK_LOANS] ([BookID], [BranchID], [CardNo], [DateOut], [DueDate]) VALUES (8, 3, N'5', N'2-14-17', N'2-21-17')
INSERT [dbo].[BOOK_LOANS] ([BookID], [BranchID], [CardNo], [DateOut], [DueDate]) VALUES (9, 1, N'1', N'2-14-17', N'2-21-17')
INSERT [dbo].[BOOK_LOANS] ([BookID], [BranchID], [CardNo], [DateOut], [DueDate]) VALUES (10, 5, N'3', N'2-14-17', N'2-21-17')
INSERT [dbo].[BOOK_LOANS] ([BookID], [BranchID], [CardNo], [DateOut], [DueDate]) VALUES (11, 1, N'1', N'2-14-17', N'2-21-17')
INSERT [dbo].[BOOK_LOANS] ([BookID], [BranchID], [CardNo], [DateOut], [DueDate]) VALUES (12, 2, N'6', N'2-14-17', N'2-21-17')
INSERT [dbo].[BOOK_LOANS] ([BookID], [BranchID], [CardNo], [DateOut], [DueDate]) VALUES (13, 3, N'5', N'2-15-17', N'2-22-17')
INSERT [dbo].[BOOK_LOANS] ([BookID], [BranchID], [CardNo], [DateOut], [DueDate]) VALUES (14, 4, N'7', N'2-14-17', N'2-21-17')
INSERT [dbo].[BOOK_LOANS] ([BookID], [BranchID], [CardNo], [DateOut], [DueDate]) VALUES (15, 5, N'3', N'2-15-17', N'2-22-17')
INSERT [dbo].[BOOK_LOANS] ([BookID], [BranchID], [CardNo], [DateOut], [DueDate]) VALUES (16, 1, N'8', N'2-15-17', N'2-22-17')
INSERT [dbo].[BOOK_LOANS] ([BookID], [BranchID], [CardNo], [DateOut], [DueDate]) VALUES (17, 6, N'2', N'2-14-17', N'2-21-17')
INSERT [dbo].[BOOK_LOANS] ([BookID], [BranchID], [CardNo], [DateOut], [DueDate]) VALUES (18, 3, N'5', N'2-15-17', N'2-22-17')
INSERT [dbo].[BOOK_LOANS] ([BookID], [BranchID], [CardNo], [DateOut], [DueDate]) VALUES (19, 4, N'4', N'2-15-17', N'2-22-17')
INSERT [dbo].[BOOK_LOANS] ([BookID], [BranchID], [CardNo], [DateOut], [DueDate]) VALUES (20, 5, N'3', N'2-15-17', N'2-22-17')
INSERT [dbo].[BOOK_LOANS] ([BookID], [BranchID], [CardNo], [DateOut], [DueDate]) VALUES (21, 1, N'1', N'2-15-17', N'2-22-17')
INSERT [dbo].[BOOK_LOANS] ([BookID], [BranchID], [CardNo], [DateOut], [DueDate]) VALUES (22, 2, N'6', N'2-14-17', N'2-21-17')
INSERT [dbo].[BOOK_LOANS] ([BookID], [BranchID], [CardNo], [DateOut], [DueDate]) VALUES (23, 3, N'5', N'2-14-17', N'2-21-17')
INSERT [dbo].[BOOK_LOANS] ([BookID], [BranchID], [CardNo], [DateOut], [DueDate]) VALUES (24, 3, N'5', N'2-15-17', N'2-22-17')
INSERT [dbo].[BOOK_LOANS] ([BookID], [BranchID], [CardNo], [DateOut], [DueDate]) VALUES (25, 4, N'7', N'2-14-17', N'2-21-17')
INSERT [dbo].[BOOK_LOANS] ([BookID], [BranchID], [CardNo], [DateOut], [DueDate]) VALUES (26, 5, N'3', N'2-15-17', N'2-22-17')
INSERT [dbo].[BOOK_LOANS] ([BookID], [BranchID], [CardNo], [DateOut], [DueDate]) VALUES (27, 1, N'8', N'2-16-17', N'2-23-17')
INSERT [dbo].[BOOK_LOANS] ([BookID], [BranchID], [CardNo], [DateOut], [DueDate]) VALUES (28, 2, N'2', N'2-16-17', N'2-23-17')
INSERT [dbo].[BOOK_LOANS] ([BookID], [BranchID], [CardNo], [DateOut], [DueDate]) VALUES (29, 4, N'4', N'2-16-17', N'2-23-17')
INSERT [dbo].[BOOK_LOANS] ([BookID], [BranchID], [CardNo], [DateOut], [DueDate]) VALUES (30, 5, N'3', N'2-16-17', N'2-23-17')
INSERT [dbo].[BOOK_LOANS] ([BookID], [BranchID], [CardNo], [DateOut], [DueDate]) VALUES (31, 1, N'1', N'2-16-17', N'2-23-17')
INSERT [dbo].[BOOK_LOANS] ([BookID], [BranchID], [CardNo], [DateOut], [DueDate]) VALUES (32, 2, N'2', N'2-16-17', N'2-23-17')
INSERT [dbo].[BOOK_LOANS] ([BookID], [BranchID], [CardNo], [DateOut], [DueDate]) VALUES (33, 3, N'5', N'2-16-17', N'2-23-17')
INSERT [dbo].[BOOK_LOANS] ([BookID], [BranchID], [CardNo], [DateOut], [DueDate]) VALUES (34, 4, N'4', N'2-16-17', N'2-23-17')
INSERT [dbo].[BOOK_LOANS] ([BookID], [BranchID], [CardNo], [DateOut], [DueDate]) VALUES (35, 5, N'3', N'2-17-17', N'2-24-17')
INSERT [dbo].[BOOK_LOANS] ([BookID], [BranchID], [CardNo], [DateOut], [DueDate]) VALUES (37, 2, N'6', N'2-14-17', N'2-21-17')
INSERT [dbo].[BOOK_LOANS] ([BookID], [BranchID], [CardNo], [DateOut], [DueDate]) VALUES (27, 1, N'1', N'2-15-17', N'2-22-17')
INSERT [dbo].[BOOK_LOANS] ([BookID], [BranchID], [CardNo], [DateOut], [DueDate]) VALUES (4, 1, N'8', N'2-16-17', N'2-23-17')
INSERT [dbo].[BOOK_LOANS] ([BookID], [BranchID], [CardNo], [DateOut], [DueDate]) VALUES (47, 2, N'6', N'2-17-17', N'2-24-17')
INSERT [dbo].[BOOK_LOANS] ([BookID], [BranchID], [CardNo], [DateOut], [DueDate]) VALUES (39, 4, N'7', N'2-14-17', N'2-21-17')
INSERT [dbo].[BOOK_LOANS] ([BookID], [BranchID], [CardNo], [DateOut], [DueDate]) VALUES (49, 4, N'7', N'2-14-17', N'2-21-17')
INSERT [dbo].[BOOK_LOANS] ([BookID], [BranchID], [CardNo], [DateOut], [DueDate]) VALUES (44, 4, N'7', N'2-16-17', N'2-21-17')
INSERT [dbo].[BOOK_LOANS] ([BookID], [BranchID], [CardNo], [DateOut], [DueDate]) VALUES (11, 1, N'8', N'2-17-17', N'2-24-17')
INSERT [dbo].[BOOK_LOANS] ([BookID], [BranchID], [CardNo], [DateOut], [DueDate]) VALUES (22, 2, N'2', N'2-16-17', N'2-23-17')
INSERT [dbo].[BOOK_LOANS] ([BookID], [BranchID], [CardNo], [DateOut], [DueDate]) VALUES (50, 5, N'3', N'2-17-17', N'2-24-17')
INSERT [dbo].[BOOK_LOANS] ([BookID], [BranchID], [CardNo], [DateOut], [DueDate]) VALUES (22, 2, N'2', N'2-17-17', N'2-24-17')
INSERT [dbo].[BOOK_LOANS] ([BookID], [BranchID], [CardNo], [DateOut], [DueDate]) VALUES (48, 3, N'1', N'2-16-17', N'2-23-17')
INSERT [dbo].[BOOK_LOANS] ([BookID], [BranchID], [CardNo], [DateOut], [DueDate]) VALUES (20, 5, N'8', N'2-21-17', N'2-28-17')
INSERT [dbo].[BOOK_LOANS] ([BookID], [BranchID], [CardNo], [DateOut], [DueDate]) VALUES (38, 3, N'3', N'2-21-17', N'2-28-17')
INSERT [dbo].[BOOK_LOANS] ([BookID], [BranchID], [CardNo], [DateOut], [DueDate]) VALUES (41, 1, N'8', N'2-21-17', N'2-28-17')
GO
INSERT [dbo].[BORROWER] ([CardNo], [Name], [Address], [Phone]) VALUES (N'1', N'Sally Smith', N'237 Main St., Sharpstown, PA', N'339-5711')
INSERT [dbo].[BORROWER] ([CardNo], [Name], [Address], [Phone]) VALUES (N'2', N'James Brown', N'8 Maple Ln., Dulltown, PA', N'555-0596')
INSERT [dbo].[BORROWER] ([CardNo], [Name], [Address], [Phone]) VALUES (N'3', N'John Adams', N'442 Pine St., Green, PA', N'734-6314')
INSERT [dbo].[BORROWER] ([CardNo], [Name], [Address], [Phone]) VALUES (N'4', N'Sarah Lee', N'1215 Rt. 37, Sharon, PA', N'487-1111')
INSERT [dbo].[BORROWER] ([CardNo], [Name], [Address], [Phone]) VALUES (N'5', N'John Kennedy', N'319 State St., Central, PA', N'556-1963')
INSERT [dbo].[BORROWER] ([CardNo], [Name], [Address], [Phone]) VALUES (N'6', N'Brad Pitt', N'24 Spring Dr., Dulltown, PA', N'555-0874')
INSERT [dbo].[BORROWER] ([CardNo], [Name], [Address], [Phone]) VALUES (N'7', N'George Washington', N'1600 Penn Ave., Sharon, PA', N'487-1600')
INSERT [dbo].[BORROWER] ([CardNo], [Name], [Address], [Phone]) VALUES (N'8', N'Meryl Streep', N'145 High Ct., Sharpstown, PA', N'339-1237')
INSERT [dbo].[BORROWER] ([CardNo], [Name], [Address], [Phone]) VALUES (N'9', N'Nina Sullivan', N'2047 Rose St., Central, PA', N'556-0837')
INSERT [dbo].[LIBRARY_BRANCH] ([BranchID], [BranchName], [Address]) VALUES (1, N'Sharpstown', N'23 Main St. Sharpstown, PA')
INSERT [dbo].[LIBRARY_BRANCH] ([BranchID], [BranchName], [Address]) VALUES (2, N'Dulltown', N'721 Rt. 3, Dulltown, PA')
INSERT [dbo].[LIBRARY_BRANCH] ([BranchID], [BranchName], [Address]) VALUES (3, N'Central', N'924 Green Rd., Wintertown, PA')
INSERT [dbo].[LIBRARY_BRANCH] ([BranchID], [BranchName], [Address]) VALUES (4, N'Sharon', N'110 Pleasant St., Sharon, PA')
INSERT [dbo].[LIBRARY_BRANCH] ([BranchID], [BranchName], [Address]) VALUES (5, N'Green', N'48 Rt. 2, Mountain Town, PA')
INSERT [dbo].[PUBLISHER] ([Name], [Address], [Phone]) VALUES (N'ABC Publishing Co.', N'123 Reading Road Burmingham AL 12344', N'866-478-5000')
INSERT [dbo].[PUBLISHER] ([Name], [Address], [Phone]) VALUES (N'Balboa Press', N'231 Sunshine Highway San Francisco CA 92211', N'800-442-2020')
INSERT [dbo].[PUBLISHER] ([Name], [Address], [Phone]) VALUES (N'Bantam', N'P.O. Box 89 Evans City PA 16033', N'900-621-1920')
INSERT [dbo].[PUBLISHER] ([Name], [Address], [Phone]) VALUES (N'Dell', N'P.O. Box 247 Seattle WA 87721', N'444-556-8000')
INSERT [dbo].[PUBLISHER] ([Name], [Address], [Phone]) VALUES (N'EduPress', N'7 Times Square 8th Fl. New York NY 10001', N'212-711-6000')
INSERT [dbo].[PUBLISHER] ([Name], [Address], [Phone]) VALUES (N'EFG Publishing Co.', N'321 Contact Lane Seattle WA 98101', N'206-111-7000')
INSERT [dbo].[PUBLISHER] ([Name], [Address], [Phone]) VALUES (N'Hamilton Publishers', N'P.O. Box 100 Portland OR 97201', N'800-337-7020')
INSERT [dbo].[PUBLISHER] ([Name], [Address], [Phone]) VALUES (N'Hay House', N'P.O. Box 5765 Syracuse NY 13290', N'317-200-0004')
INSERT [dbo].[PUBLISHER] ([Name], [Address], [Phone]) VALUES (N'HobbyLobby Co.', N'60 Dupont Circle Washington D.C 20001', N'202-670-9000')
INSERT [dbo].[PUBLISHER] ([Name], [Address], [Phone]) VALUES (N'Houghton Mifflin', N'215 Park Ave S New York NY 10003', N'212-661-3030')
INSERT [dbo].[PUBLISHER] ([Name], [Address], [Phone]) VALUES (N'KH Publishers', N'105 E. Townline Road Unit 116 Vernon Hills IL 60616', N'800-295-3737')
INSERT [dbo].[PUBLISHER] ([Name], [Address], [Phone]) VALUES (N'Mystery Publishers', N'303 N. Euclid St. Fullerton Ca 92832', N'714-447-3962')
INSERT [dbo].[PUBLISHER] ([Name], [Address], [Phone]) VALUES (N'Oceanworks', N'351 Phelps Drive Irving Texas 75261', N'888-277-4444')
INSERT [dbo].[PUBLISHER] ([Name], [Address], [Phone]) VALUES (N'Printing Press', N'229 W 36 St. New York NY 10018', N'212-619-4949')
INSERT [dbo].[PUBLISHER] ([Name], [Address], [Phone]) VALUES (N'Spraul', N'3 Lakes Dr. Northfield IL 60093', N'847-272-7400')
INSERT [dbo].[PUBLISHER] ([Name], [Address], [Phone]) VALUES (N'XYZ Publishing', N'100 Essex Ave. Avenel NJ 07001', N'312-677-1289')
INSERT [dbo].[PUBLISHER] ([Name], [Address], [Phone]) VALUES (N'XYX Publishing', N'P.O. Box 319 Tallahassee FL 05214', N'314-545-5454')
USE [master]
GO
ALTER DATABASE [Library] SET  READ_WRITE 
GO
