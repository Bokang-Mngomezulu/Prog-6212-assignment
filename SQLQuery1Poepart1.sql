create database raceday;

use raceday;

create table role(
roleID int identity(1,1) primary key,
rolename varchar(50)not null
);

create table users(
userID int identity(1,1) primary key,
roleID int not null,
fullname varchar(100) not null,
email varchar(100) not null,
password varchar(250) not null,
phone varchar(20) null,
foreign key (roleID) references role(roleID)
);

create table category(
categoryID int identity(100,1) primary key,
categoryname varchar(50) not null,
sportType varchar(50) not null
);

create table event(
    eventID int identity(10,1) primary key,
    organiserID int not null,
    title varchar(150) not null,
    description varchar(max) null,
    date datetime not null,
    location varchar(150) not null,
    information varchar(max) null,
    liveWeather varchar(255) null,
    foreign key (organiserID) references Users(userID)
);

create table eventCategories(
    eventCategoryID int identity(1,1) primary key,
    eventID int not null,
    categoryID int not null,
    entryFee decimal(10,2) not null default 0.00,
    maxCapacity int not null default 100,
    foreign key (eventID) references event(eventID),
    foreign key (categoryID) references category(categoryID)
);

create table enrolment(
    enrolmentID int identity(100,1) primary key,
    participantID int not null,
    eventCategoryID int not null,
    status varchar(20) not null default 'Confirmed',
    foreign key (participantID) references users(userID),
    foreign key (eventCategoryID) references eventCategories(eventCategoryID)
);

create table result(
    resultID int identity(1,1) primary key,
    enrolmentID int not null unique,
    finishTime decimal(6,2) not null,
    overallPosition int null,
    foreign key (enrolmentID) references enrolment(enrolmentID)
);

-- inserting --

insert into role(rolename)
values('Organiser'),
('Participant');

select * from role

insert into users(roleID, fullname, email, password, phone)
values(1, 'Sipho Ndlovu', 'sipho.organiser@raceday.co.za', 'hash_pass_1', '0821234567'),
(1, 'Anika van Zyl', 'anika.events@raceday.co.za', 'hash_pass_2', '0839876543'),
(2, 'Thabo Mokoena', 'thabo.runner@gmail.com', 'hash_pass_3', '0711112222'),
(2, 'Sarah Jenkins', 'sarah.j@gmail.com', 'hash_pass_4', '0723334444'),
(2, 'Lethabo Molefe', 'lethabo.m@gmail.com', 'hash_pass_5', '0765556666');

select * from users

insert into category(categoryName, sportType)
values('10km Road Run', 'Running'),
('21km Half Marathon', 'Running'),
('42km Full Marathon', 'Running'),
('50km Cycle Tour', 'Cycling'),
('5km Fun Walk', 'Walking');

select * from category

insert into event(organiserID, title, description, date, location, information, liveWeather)
values(1, 'Soweto Marathon 2026', 'The iconic People’s Race through Soweto.', '2026-11-01 06:00:00', 'Soweto, Johannesburg', 'Starts at FNB Stadium.', 'Clear skies, 18°C'),
(1, 'Cape Town Coastal Cycle', 'Scenic road cycle along the coast.', '2026-10-15 07:00:00', 'Sea Point, Cape Town', 'Coastal loops with moderate elevation.', 'Breezy, 20°C'),
(2, 'Tshwane Spring 10km & Walk', 'Annual spring run and community walk.', '2026-09-20 07:30:00', 'Pretoria Botanical Gardens', 'Flat garden circuits.', 'Sunny, 22°C');

select * from event

insert into eventCategories(eventID, categoryID, entryFee, maxCapacity)
values(10, 101, 350.00, 5000),
(10, 102, 500.00, 8000),
(11, 103, 450.00, 3000),
(12, 100, 150.00, 1000),
(12, 104, 80.00, 500);

select * from eventCategories

insert into enrolment(participantID, eventCategoryID, status)
values(3, 1, 'Confirmed'),
(3, 2, 'Confirmed'),
(3, 3, 'Confirmed'),
(3, 4, 'Confirmed'),
(4, 3, 'Confirmed'),
(4, 5, 'Confirmed'),
(5, 1, 'Confirmed');

select * from enrolment

insert into result(enrolmentID, finishTime, overallPosition)
values(100, 105.50, 42),
(101, 240.10, 110),
(102, 110.00, 85),
(103, 48.20, 12);

select * from result

-- updating --

update category
set categoryname = '15km Night Run'
where categoryID = 100;


-- delete --

delete from result
where resultID = 4;
