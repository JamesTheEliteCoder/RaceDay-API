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

* Reviewed the API endpoint plan against the ERD and identified that routes required organiser management functionality.
* Added endpoints for organisers to create and update routes belonging to their events.
* Updated the API endpoint plan to include 18 endpoints covering authentication, user profiles, events, routes, categories, enrolments, and results.
* Committed the updated API endpoint plan to Git.

* Finalised the SQL database script to provide a clean and reproducible setup of the RaceDay database.
* Ensured the script creates all six tables, relationships, constraints, default values, and realistic seed data in the correct dependency order.
* Verified that the database structure matches the ERD and can be recreated from a clean database setup.
* Committed the final SQL database script to Git.


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

The CI/CD pipeline is implemented using GitHub Actions to validate the required Part 1 repository structure.


## YouTube Demonstration

[YouTube video link here]
