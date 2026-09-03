# RaceDay-API
Programming 2B POE
* Drafted the initial concept and requirements for the RaceDay system.
* Designed the Entity-Relationship Diagram (ERD).
* Created the final ERD using Draw.io.
* Added the ERD to the `/docs` directory.
* Committed the ERD as a completed Part 1 milestone.

  
* Began planning the REST API endpoints based on the system requirements and ERD.
* Designed the endpoints for authentication, user profiles, events, categories, enrolments, and results.
* Documented each endpoint in a structured table containing the HTTP method, route, description, required role, request body, and expected response.
* Added appropriate success and failure responses for each endpoint.
* Committed the completed API endpoint plan to Git.


* Created the RaceDayDB database in SQL Server.
* Created the six database tables based on the ERD: Users, Events, Routes, Categories, Enrolments, and Results.
* Added primary keys, foreign keys, unique constraints, default values, and validation checks to enforce the required database rules.
* Verified that all tables were successfully created and matched the planned database structure.
* Committed the completed database schema to Git.




## System Description

RaceDay is a full-stack event management system designed for road running,
walking, and cycling events. The system allows organisers to manage events,
categories, enrolments, and results, while participants can view events,
enrol in categories, and view their results.

## User Roles

### Organiser
Organisers can create, update, and delete their own events, manage event
categories, view participant enrolments, and capture race results.

### Participant
Participants can view events and categories, enrol in events, view their
own enrolments, and view their own results.

## CI/CD Pipeline

[CI/CD pipeline screenshot here]

## YouTube Demonstration

[YouTube video link here]
