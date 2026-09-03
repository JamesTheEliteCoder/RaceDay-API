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
CHECK (DistanceKm > 0),


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



