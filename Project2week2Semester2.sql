/***************************************************************************************************************************************************
*	Name			Date		Description
*
*	Matthew Pugel	3/1/2019	Initial implementation of disk_items
****************************************************************************************************************************************************/


USE master
GO
IF DB_ID('disk_inventory') IS NOT NULL
	DROP DATABASE AP
GO
create database disk_inventory
go
use disk_inventory
go
create table genre
	(
	genre_id int not null primary key identity,
	description nvarchar(100) not null
	)
go
create table status
	(
	status_id int not null primary key identity,
	description nvarchar(100) not null
	)
go
create table disk_type
	(
	disk_type_id int not null primary key identity,
	description nvarchar(100) not null
	)
go
create table artist_type
	(
	artist_type_id int not null primary key identity,
	description nvarchar(100) not null
	)
go
create table borrower
	(
	borrower_id int not null primary key identity,
	fname nvarchar(100) not null,
	lname nvarchar(100) not null,
	phone_numb varchar(50) not null
	)
go
create table Artist
	(
	artist_id int not null primary key identity,
	fname nvarchar(100) not null,
	lname nvarchar(100) null,
	artist_type_id int not null references artist_type(artist_type_id)
	)
go
create table disk
	(
	disk_id int not null primary key identity,
	disk_name nvarchar(100) not null,
	releaseDate datetime not null,
	genre_id int not null references genre(genre_id),
	status_id int not null references status(status_id),
	disk_type_id int not null references disk_type(disk_type_id)
	)
go
create table diskHasBorrower
	(
	disk_id int not null references disk(disk_id),
	borrower_id int not null references borrower(borrower_id),
	borrowed_date datetime not null,
	returned_date datetime null,
	primary key (disk_id, borrower_id, borrowed_date)
	)
go
create table diskHasArtist
	(
	disk_id int not null references disk(disk_id),
	artist_id int not null references Artist(artist_id),
	primary key (disk_id, artist_id)
	)
go


use master
go
if SUSER_ID('diskUsermm') is not null
	drop login diskUsermm
go
create login diskUsermm with password = 'Pa$$w0rd',
	default_database = disk_inventory
go
use disk_inventory
go
if USER_ID('diskUsermm') is not null
	drop user diskUsermm
go
create user diskUsermm
go
alter role db_datareader add member diskUsermm
go