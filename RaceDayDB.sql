CREATE DATABASE RaceDayDB;

USE RaceDayDB;

CREATE TABLE Users( 
UserID INT IDENTITY (1,1) PRIMARY KEY,
FirstName VARCHAR(30) NOT NULL,
LastName VARCHAR(30) NOT NULL,
Email VARCHAR(50) NOT NULL UNIQUE,
PasswordHash VARCHAR(100) NOT NULL,
Role VARCHAR(20) NOT NULL,
PhoneNumber VARCHAR(11) NOT NULL, 
DateOfBirth DATE NOT NULL,
CreatedOn DATETIME2 NOT NULL DEFAULT GETDATE(),

CONSTRAINT CK_Users_Role
CHECK (Role IN ('Organiser','Participant'))

);

CREATE TABLE Events (
EventID INT IDENTITY(1,1) PRIMARY KEY,
OrganiserID INT NOT NULL,
Name VARCHAR(30) NOT NULL,
Description VARCHAR(500) NOT NULL,
EventDate DATE NOT NULL,
Venue VARCHAR(100) NOT NULL,
City VARCHAR(50) NOT NULL,
DistanceKm DECIMAL(6,2) NOT NULL,
EventType NVARCHAR(30) NOT NULL,
CreatedOn DATETIME2 NOT NULL DEFAULT GETDATE(),

CONSTRAINT FK_Events_Users
FOREIGN KEY (OrganiserId)
REFERENCES Users(UserId),

CONSTRAINT CK_Events_EventType
CHECK (EventType IN ('Run', 'Walk', 'Cycle')),

CONSTRAINT CK_Events_Distance
CHECK (DistanceKm > 0)
);







CREATE TABLE Routes (
RouteId INT IDENTITY(1,1) PRIMARY KEY,
EventId INT NOT NULL,

RouteName VARCHAR(100) NOT NULL,
AreasCovered VARCHAR(500) NOT NULL,
DistanceKm DECIMAL(6,2) NOT NULL,
StartLocation VARCHAR(150) NOT NULL,
FinishLocation VARCHAR(150) NOT NULL,
Description VARCHAR(500),
MapUrl VARCHAR(500),

CONSTRAINT FK_Routes_Events
FOREIGN KEY (EventId)
REFERENCES Events(EventId),

CONSTRAINT CK_Routes_Distance
CHECK (DistanceKm > 0)


);






CREATE TABLE Categories (
CategoryId INT IDENTITY(1,1) PRIMARY KEY,
EventId INT NOT NULL,
RouteId INT NOT NULL,

Name VARCHAR(100) NOT NULL,
CategoryType VARCHAR(20) NOT NULL,
MinimumAge INT,
MaximumAge INT,

CONSTRAINT FK_Categories_Events
FOREIGN KEY (EventId)
REFERENCES Events(EventId),

CONSTRAINT FK_Categories_Routes
FOREIGN KEY (RouteId)
REFERENCES Routes(RouteId),

CONSTRAINT CK_Categories_Type
CHECK (CategoryType IN ('Age', 'Distance')),

CONSTRAINT CK_Categories_Age
CHECK (MinimumAge IS NULL
       OR MaximumAge IS NULL
       OR MinimumAge <= MaximumAge),

CONSTRAINT CK_Categories_MinimumAge
CHECK (MinimumAge IS NULL OR MinimumAge >= 0),

CONSTRAINT CK_Categories_MaximumAge
CHECK (MaximumAge IS NULL OR MaximumAge >= 0)
);





CREATE TABLE Enrolments (
EnrolmentId INT IDENTITY(1,1) PRIMARY KEY,
ParticipantId INT NOT NULL,
EventId INT NOT NULL,
CategoryId INT NOT NULL,

EnrolmentDate DATETIME2 NOT NULL DEFAULT GETDATE(),
Status VARCHAR(20) NOT NULL DEFAULT 'Confirmed',

CONSTRAINT FK_Enrolments_Users
FOREIGN KEY (ParticipantId)
REFERENCES Users(UserId),

CONSTRAINT FK_Enrolments_Events
FOREIGN KEY (EventId)
REFERENCES Events(EventId),

CONSTRAINT FK_Enrolments_Categories
FOREIGN KEY (CategoryId)
REFERENCES Categories(CategoryId),

CONSTRAINT CK_Enrolments_Status
CHECK (Status IN ('Confirmed', 'Cancelled')),

CONSTRAINT UQ_Enrolments_Participant_Event_Category
UNIQUE (ParticipantId, EventId, CategoryId) --to prevent the same participant from enrolling twice in the same event--
);




CREATE TABLE Results (
ResultId INT IDENTITY(1,1) PRIMARY KEY,
EnrolmentId INT NOT NULL,

FinishingPosition INT NOT NULL,
FinishTime TIME NOT NULL,

CONSTRAINT FK_Results_Enrolments
FOREIGN KEY (EnrolmentId)
REFERENCES Enrolments(EnrolmentId),

CONSTRAINT UQ_Results_Enrolment
UNIQUE (EnrolmentId),

CONSTRAINT CK_Results_Position
CHECK (FinishingPosition > 0)


);



--Insertion of data into the User Tables--

INSERT INTO Users
(FirstName, LastName, Email, PasswordHash, Role, PhoneNumber, DateOfBirth)
VALUES
('Thabo', 'Mokoena', 'thabo.mokoena@raceday.co.za','PART1_SEED_HASH_001', 'Organiser', '0825551001', '1985-04-12'),
('Lerato', 'Naidoo', 'lerato.naidoo@raceday.co.za','PART1_SEED_HASH_002', 'Organiser', '0835551002', '1990-08-25'),
('Sipho', 'Dlamini', 'sipho.dlamini@raceday.co.za','PART1_SEED_HASH_003', 'Participant', '0845551003', '2001-06-18'),
('Ayesha', 'Pillay', 'ayesha.pillay@raceday.co.za','PART1_SEED_HASH_004', 'Participant', '0855551004', '1998-11-03');

select * from Users;







--Insertion of events --

INSERT INTO Events
(OrganiserId, Name, Description, EventDate, Venue, City, Province, DistanceKm, EventType)
VALUES
(1,
'Johannesburg City Run',
'A community road running event through central Johannesburg.',
'2027-03-14',
'Mary Fitzgerald Square',
'Johannesburg',
'Gauteng',
10.00,
'Run'),

(1,
'Soweto Community Walk',
'A family-friendly walking event through Soweto.',
'2027-04-18',
'Walter Sisulu Square',
'Soweto',
'Gauteng',
8.00,
'Walk'),

(2,
'Pretoria Cycle Challenge',
'A road cycling event covering major routes around Pretoria.',
'2027-05-09',
'Union Buildings',
'Pretoria',
'Gauteng',
40.00,
'Cycle');




SELECT
EventID,
OrganiserID,
Name,
EventDate,
City,
Province,
DistanceKm,
EventType
FROM Events
ORDER BY EventID;






-- Insertion of Routes --

INSERT INTO Routes
(EventId, RouteName, AreasCovered, DistanceKm, StartLocation, FinishLocation, Description, MapUrl)
VALUES
(1,
'Johannesburg City 10K',
'Braamfontein, Newtown, Johannesburg CBD',
10.00,
'Mary Fitzgerald Square',
'Mary Fitzgerald Square',
'10 km road running route through central Johannesburg.',
'https://example.com/routes/johannesburg-city-10k'),

(2,
'Soweto Community 8K',
'Orlando, Kliptown, Soweto',
8.00,
'Walter Sisulu Square',
'Walter Sisulu Square',
'8 km community walking route through Soweto.',
'https://example.com/routes/soweto-community-8k'),

(3,
'Pretoria Cycle 40K',
'Arcadia, Pretoria CBD, Waterkloof',
40.00,
'Union Buildings',
'Union Buildings',
'40 km road cycling route around Pretoria.',
'https://example.com/routes/pretoria-cycle-40k');


SELECT
RouteId,
EventId,
RouteName,
DistanceKm,
StartLocation,
FinishLocation
FROM Routes
ORDER BY RouteId;




-- Insertion of Categories --

INSERT INTO Categories
(EventId, RouteId, Name, CategoryType, MinimumAge, MaximumAge)
VALUES
(1, 1, 'Senior 10K', 'Age', 18, 39),
(1, 1, 'Veteran 10K', 'Age', 40, 59),
(2, 2, 'Family Walk', 'Distance', NULL, NULL),
(3, 3, 'Open 40K', 'Distance', NULL, NULL),
(3, 3, 'Veteran Cycle', 'Age', 40, 59);



SELECT
CategoryId,
EventId,
RouteId,
Name,
CategoryType,
MinimumAge,
MaximumAge
FROM Categories
ORDER BY CategoryId;





-- Insertion of Enrolments --

INSERT INTO Enrolments
(ParticipantId, EventId, CategoryId)
VALUES
(3, 1, 1),
(4, 1, 2),
(3, 2, 3),
(4, 3, 4);



SELECT
EnrolmentId,
ParticipantId,
EventId,
CategoryId,
EnrolmentDate,
Status
FROM Enrolments
ORDER BY EnrolmentId;



--Insertion of enrolments--

INSERT INTO Results
(EnrolmentId, FinishingPosition, FinishTime)
VALUES
(3, 12, '00:52:34'),
(4, 27, '01:04:18');



SELECT
    ResultId,
    EnrolmentId,
    FinishingPosition,
    FinishTime
FROM Results
ORDER BY ResultId;









