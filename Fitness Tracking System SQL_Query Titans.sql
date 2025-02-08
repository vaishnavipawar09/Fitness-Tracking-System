USE z511s24vairai4;

CREATE TABLE NUTRITION (
  NutritionPlanID CHAR(6) NOT NULL,
  PlanName VARCHAR(255),
  Description TEXT,
  CalorieIntake INT,
  PRIMARY KEY (NutritionPlanID)
);

CREATE TABLE USER (
  UserID CHAR(6) NOT NULL,
  FirstName VARCHAR(50) NOT NULL,
  LastName VARCHAR(50) NOT NULL,
  UserDOB DATE NOT NULL,
  Email VARCHAR(255) UNIQUE NOT NULL,
  Height INT NOT NULL,
  Weight INT NOT NULL,
  NutritionPlanID CHAR(6),
  Gender ENUM('Male', 'Female', 'Other') NOT NULL,
  PRIMARY KEY (UserID),
  FOREIGN KEY (NutritionPlanID) references NUTRITION (NutritionPlanID) ON UPDATE SET NULL
);

CREATE TABLE ACTIVITY (
  ActivityID CHAR(6) NOT NULL,
  ActivityType ENUM('Running', 'Cycling', 'Swimming', 'Yoga', 'Gym') NOT NULL,
  Duration INT NOT NULL,
  CaloriesBurnt INT NOT NULL,
  ActivityDate DATE NOT NULL,
  PRIMARY KEY (ActivityID)
 
);

CREATE TABLE GOAL (
  GoalID CHAR(6) NOT NULL,
  UserID char(6) NULL,
  GoalDescription TEXT,
  StartDate DATE,
  EndDate DATE,
  Status ENUM('Not Started', 'In Progress', 'Completed', 'Failed'),
  PRIMARY KEY (GoalID),
  FOREIGN KEY (UserID) REFERENCES USER(UserID) ON DELETE CASCADE
);

CREATE TABLE REWARD (
    RewardID char(6) NOT NULL,
    RewardName VARCHAR(100),
    Achieved BOOLEAN,
    PRIMARY KEY (RewardID)
);

CREATE TABLE EVENT (
    EventID char(6) NOT NULL ,
    EventName VARCHAR(100) NOT NULL,
    StartDate DATE,
    EndDate DATE,
    RewardID char(6) NULL,
    PRIMARY KEY (EventID),
	FOREIGN KEY (RewardID) REFERENCES REWARD (RewardID) ON DELETE CASCADE
);



CREATE TABLE CERTIFIEDUSER (
  UserID CHAR(6) NOT NULL,
  CertificationLevel VARCHAR(255) NOT NULL,
  PRIMARY KEY (UserID),
  FOREIGN KEY (UserID) references USER (UserID) ON UPDATE CASCADE
  );
SELECT * FROM USER;
  CREATE TABLE NORMALUSER (
  UserID CHAR(6) NOT NULL,
  SignupDate DATE,
  PRIMARY KEY (UserID),
  FOREIGN KEY (UserID) references USER (UserID) ON DELETE CASCADE 
  );

CREATE TABLE USERPHONENO (
  UserID CHAR(6) NOT NULL,
  PhoneNo varchar(10) NOT NULL,
  PRIMARY KEY (UserID, PhoneNo),
  FOREIGN KEY (UserID) references USER (UserID) ON UPDATE CASCADE
  );
  
CREATE TABLE FOLLOWS(
FollowerUserID char(6) NOT NULL,
FollowedByUserID char(6) NOT NULL,
PRIMARY KEY (FollowerUserID, FollowedByUserID),
FOREIGN KEY (FollowerUserID) references USER (UserID) ON UPDATE CASCADE,
FOREIGN KEY (FollowedByUserID) references USER (UserID) ON UPDATE CASCADE
);

CREATE TABLE RECEIVES(
UserID char(6) NOT NULL,
RewardID char(6) NOT NULL,
PRIMARY KEY (UserID, RewardID),
FOREIGN KEY (UserID) references USER (UserID) ON UPDATE CASCADE,
FOREIGN KEY (RewardID) references REWARD (RewardID) ON DELETE CASCADE
);
 
 

CREATE TABLE COMPLETES(
UserID char(6) NOT NULL,
ActivityID char(6) NOT NULL,
PRIMARY KEY (UserID, ActivityID),
FOREIGN KEY (UserID) references USER (UserID) ON UPDATE CASCADE,
FOREIGN KEY (ActivityID) references ACTIVITY (ActivityID) ON UPDATE CASCADE
);



CREATE TABLE PARTICIPATES(
UserID char(6) NOT NULL,
EventID char(6) NOT NULL,
PRIMARY KEY (UserID, EventID),
FOREIGN KEY (UserID) references USER (UserID) ON DELETE RESTRICT,
FOREIGN KEY (EventID) references EVENT (EventID) ON DELETE CASCADE 
);

CREATE TABLE TRACKING (
  TrackingID CHAR(6) NOT NULL,
  TrackingUserID CHAR(6) NOT NULL,
  TrackingGoalID CHAR(6) NOT NULL,
  TWeight INT,
  TBiceps DECIMAL(5,2),
  TThighs DECIMAL(5,2),
  TChest DECIMAL(5,2),
  TWaist DECIMAL(5,2),
  THips DECIMAL(5,2),
  TDate DATE NOT NULL,
  PRIMARY KEY (TrackingID, TrackingUserID),
  FOREIGN KEY (TrackingUserID) REFERENCES USER(UserID) ON UPDATE CASCADE,
  FOREIGN KEY (TrackingGoalID) REFERENCES GOAL(GoalID) ON DELETE CASCADE
);

CREATE TABLE TRACKS(
  ActivityID  char(6) NOT NULL,
  TrackingID CHAR(6) NOT NULL,
  TrackingUserID CHAR(6) NOT NULL,
  PRIMARY KEY (ActivityID, TrackingID, TrackingUserID),
  FOREIGN KEY (ActivityID) REFERENCES ACTIVITY (ActivityID) ON UPDATE CASCADE,
  FOREIGN KEY (TrackingID) REFERENCES TRACKING  (TrackingID) ON UPDATE CASCADE , 
  FOREIGN KEY (TrackingUserID) REFERENCES  TRACKING  (TrackingUserID) ON UPDATE CASCADE
);

INSERT INTO NUTRITION (NutritionPlanID, PlanName, Description, CalorieIntake) VALUES
('N00001', 'Balanced Diet', 'A well-rounded nutrition plan for general health.', 2000),
('N00002', 'Weight Loss', 'A calorie-deficit diet aimed at reducing body weight.', 1500),
('N00003', 'Muscle Gain', 'High protein diet for muscle building and recovery.', 3000),
('N00004', 'Low Carb', 'Reduced carbohydrate intake for weight loss and control.', 1800),
('N00005', 'Keto', 'High-fat, low-carb diet to achieve ketosis.', 1600),
('N00006', 'Vegan', 'Plant-based diet excluding all animal products.', 2200),
('N00007', 'Mediterranean', 'Diet inspired by the eating habits of the Mediterranean.', 2500),
('N00008', 'Paleo', 'Diet based on foods presumed to have been eaten by early humans.', 2300),
('N00009', 'Gluten-Free', 'Diet excluding gluten, suitable for those with allergies.', 2100),
('N00010', 'Detox', 'Plan focused on eliminating toxins from the body.', 1200);


INSERT INTO USER (UserID, FirstName, LastName, UserDOB, Email, Height, Weight, NutritionPlanID, Gender) VALUES
('U00001', 'Alice', 'Baker', '1990-05-14', 'alice.baker@example.com', 170, 65, 'N00001', 'Female'),
('U00002', 'Bob', 'Carter', '1988-03-21', 'bob.carter@example.com', 180, 88, 'N00002', 'Male'),
('U00003', 'Charlie', 'Davis', '1992-11-08', 'charlie.davis@example.com', 165, 70, 'N00003', 'Male'),
('U00004', 'Diana', 'Evans', '1994-07-19', 'diana.evans@example.com', 160, 55, 'N00004', 'Female'),
('U00005', 'Ethan', 'Fisher', '1985-01-30', 'ethan.fisher@example.com', 175, 80, 'N00005', 'Male'),
('U00006', 'Fiona', 'Garcia', '1996-09-15', 'fiona.garcia@example.com', 162, 62, 'N00006', 'Female'),
('U00007', 'George', 'Harris', '1993-04-22', 'george.harris@example.com', 168, 76, 'N00007', 'Male'),
('U00008', 'Hannah', 'Irwin', '1987-12-27', 'hannah.irwin@example.com', 158, 58, 'N00008', 'Female'),
('U00009', 'Ian', 'Jones', '1991-10-11', 'ian.jones@example.com', 183, 90, 'N00009', 'Male'),
('U00010', 'Julia', 'Klein', '1989-08-05', 'julia.klein@example.com', 167, 61, 'N00010', 'Female');


INSERT INTO ACTIVITY (ActivityID, ActivityType, Duration, CaloriesBurnt, ActivityDate) VALUES
('A00001',  'Running', 30, 280, '2024-04-01'),
('A00002',  'Cycling', 45, 300, '2024-04-02'),
('A00003',  'Swimming', 30, 250, '2024-04-03'),
('A00004',  'Yoga', 60, 200, '2024-04-04'),
('A00005',  'Gym', 50, 450, '2024-04-05'),
('A00006',  'Running', 20, 230, '2024-04-06'),
('A00007',  'Cycling', 40, 390, '2024-04-07'),
('A00008',  'Swimming', 25, 210, '2024-04-08'),
('A00009',  'Yoga', 30, 180, '2024-04-09'),
('A00010',  'Gym', 60, 500, '2024-04-10'),
('A00011',  'Running', 25, 270, '2024-04-11'),
('A00012',  'Cycling', 55, 350, '2024-04-12'),
('A00013',  'Swimming', 20, 200, '2024-04-13'),
('A00014',  'Yoga', 40, 190, '2024-04-14'),
('A00015', 'Gym', 45, 400, '2024-04-15'),
('A00016',  'Running', 30, 290, '2024-04-16'),
('A00017',  'Cycling', 35, 360, '2024-04-17'),
('A00018',  'Swimming', 25, 220, '2024-04-18'),
('A00019',  'Yoga', 50, 170, '2024-04-19'),
('A00020',  'Gym', 55, 480, '2024-04-20');


INSERT INTO GOAL (GoalID, UserID, GoalDescription, StartDate, EndDate, Status) VALUES
('G00001', 'U00001', 'Run a marathon', '2024-01-01', '2024-10-01', 'In Progress'),
('G00002', 'U00002', 'Lose 10 pounds', '2024-02-01', '2024-05-01', 'In Progress'),
('G00003', 'U00003', 'Build muscle mass', '2024-03-01', '2024-09-01', 'In Progress'),
('G00004', 'U00004', 'Improve flexibility', '2024-04-01', '2024-07-01', 'In Progress'),
('G00005', 'U00005', 'Swim 1000 meters', '2024-05-01', '2024-12-01', 'Not Started'),
('G00006', 'U00006', 'Complete a triathlon', '2024-06-01', '2024-11-01', 'Not Started'),
('G00007', 'U00007', 'Learn advanced yoga', '2024-07-01', '2024-12-31', 'Not Started'),
('G00008', 'U00008', 'Bench press 200 lbs', '2024-08-01', '2024-12-31', 'Not Started'),
('G00009', 'U00009', 'Cycle 100 miles', '2024-09-01', '2024-12-31', 'In Progress'),
('G00010', 'U00010', 'Daily meditation', '2023-09-01',  '2023-10-01', 'Completed');


INSERT INTO CERTIFIEDUSER (UserID, CertificationLevel) VALUES
('U00001', 'Level 1'),
('U00002', 'Level 2'),
('U00003', 'Level 3'),
('U00004', 'Master'),
('U00005', 'Advanced'),
('U00006', 'Master');

INSERT INTO NORMALUSER (UserID, SignupDate) VALUES
('U00006', '2023-01-01'),
('U00007', '2023-02-15'),
('U00008', '2023-03-20'),
('U00009', '2023-04-25'),
('U00010', '2023-05-30');

INSERT INTO REWARD (RewardID, RewardName, Achieved) VALUES
('R1001', 'Marathon Runner', FALSE),
('R1002', 'Aquatic Master', TRUE),
('R1003', 'Cycling Enthusiast', FALSE),
('R1004', 'Zen Achiever', TRUE),
('R1005', 'Strength Hero', FALSE);


INSERT INTO EVENT (EventID, EventName, StartDate, EndDate, RewardID) VALUES
('E1001', 'City Marathon', '2024-09-10', '2024-09-11', 'R1001'),
('E1002', 'Open Water Swim', '2024-08-05', '2024-08-06', 'R1002'),
('E1003', 'Countryside Bike Rally', '2024-07-21', '2024-07-22', 'R1003'),
('E1004', 'Meditation Retreat', '2024-10-15', '2024-10-20', 'R1004'),
('E1005', 'Powerlifting Competition', '2024-11-25', '2024-11-26', 'R1005');

INSERT INTO EVENT (EventID, EventName, StartDate, EndDate, RewardID) VALUES
('E1006', 'Powerlifting Competition', '2024-04-25', '2024-04-26', 'R1005');

INSERT INTO FOLLOWS (FollowerUserID, FollowedByUserID) VALUES
('U00001', 'U00002'),
('U00001', 'U00003'),
('U00002', 'U00003'),
('U00004', 'U00009'),
('U00009', 'U00001');

INSERT INTO USERPHONENO (UserID, PhoneNo) VALUES
('U00001', '1234567890'),
('U00001', '1987654321'), 
('U00002', '2345678901'),
('U00002', '2987654321'),
('U00003', '3456789012'),
('U00004', '4567890123'),
('U00005', '4587654321'), 
('U00005', '4598765432'), 
('U00006', '5678901234'),
('U00007', '5687654321'); 

INSERT INTO RECEIVES (UserID, RewardID) VALUES
('U00001', 'R1001'),
('U00002', 'R1001'),
('U00003', 'R1003'),
('U00004', 'R1004'),
('U00005', 'R1005');

INSERT INTO COMPLETES (UserID, ActivityID) VALUES
('U00001', 'A00001'),
('U00002', 'A00002'),
('U00003', 'A00003'),
('U00004', 'A00004'),
('U00004', 'A00006'),
('U00004', 'A00007'),
('U00005', 'A00005'),
('U00006', 'A00005'),
('U00007', 'A00005');

INSERT INTO PARTICIPATES (UserID, EventID) VALUES
('U00001', 'E1001'),
('U00002', 'E1002'),
('U00003', 'E1003'),
('U00004', 'E1004'),
('U00005', 'E1005'),
('U00006', 'E1005'),
('U00007', 'E1003'),
('U00008', 'E1002'),
('U00009', 'E1003'),
('U00002', 'E1003'),
('U00002', 'E1004');

INSERT INTO TRACKING (TrackingID, TrackingUserID, TrackingGoalID, TWeight, TBiceps, TThighs, TChest, TWaist, THips, TDate) VALUES
('T1001', 'U00001', 'G00001', 65, 30.5, 50, 100, 85, 95, '2024-04-10'),
('T1002', 'U00002', 'G00002', 85, 36, 55, 120, 90, 100, '2024-04-11'),
('T1003', 'U00003', 'G00003', 75, 32, 52, 110, 88, 98, '2024-04-12'),
('T1004', 'U00004', 'G00004', 60, 28, 48, 90, 70, 80, '2024-04-13'),
('T1005', 'U00005', 'G00005', 90, 38, 57, 130, 95, 105, '2024-04-14');


INSERT INTO TRACKS (ActivityID, TrackingID, TrackingUserID) VALUES
('A00001', 'T1001', 'U00001'),
('A00002', 'T1002', 'U00002'),
('A00003', 'T1003', 'U00003'),
('A00004', 'T1004', 'U00004'),
('A00005', 'T1005', 'U00005');


#1.List users and their nutrition plans
SELECT u.FirstName, u.LastName, n.PlanName
FROM USER u
INNER JOIN NUTRITION n ON u.NutritionPlanID = n.NutritionPlanID;

# 2. Count the number of users per gender
SELECT Gender, COUNT(*) AS TotalUsers
FROM USER
GROUP BY Gender;

#3Classify users based on their weight
SELECT UserID, Weight,
CASE 
    WHEN Weight < 50 THEN 'Underweight'
    WHEN Weight BETWEEN 50 AND 70 THEN 'Normal'
    WHEN Weight > 70 THEN 'Overweight'
END AS WeightCategory
FROM USER;

#4.Find users with their completed activities and goals
SELECT u.FirstName, u.LastName, a.ActivityType, g.GoalDescription
FROM USER u
JOIN COMPLETES c ON u.UserID = c.UserID
JOIN ACTIVITY a ON c.ActivityID = a.ActivityID
JOIN GOAL g ON u.UserID = g.UserID;

#5.Total calories burnt by each user
SELECT u.FirstName, u.LastName, SUM(a.CaloriesBurnt) AS TotalCaloriesBurnt
FROM USER u
JOIN COMPLETES c ON u.UserID = c.UserID
JOIN ACTIVITY a ON c.ActivityID = a.ActivityID
GROUP BY u.UserID;

#6 Classify total duration of activities into categories
SELECT u.UserID, u.FirstName, u.LastName,
CASE 
    WHEN SUM(a.Duration) < 100 THEN 'Light Exerciser'
    WHEN SUM(a.Duration) BETWEEN 100 AND 300 THEN 'Moderate Exerciser'
    WHEN SUM(a.Duration) > 300 THEN 'Heavy Exerciser'
END AS ExerciseLevel
FROM USER u
JOIN COMPLETES c ON u.UserID = c.UserID
JOIN ACTIVITY a ON c.ActivityID = a.ActivityID
GROUP BY u.UserID;

#7 List of Users Participating in Each Event
SELECT e.EventName, u.FirstName, u.LastName
FROM EVENT e
JOIN PARTICIPATES p ON e.EventID = p.EventID
JOIN USER u ON p.UserID = u.UserID
ORDER BY e.EventName, u.LastName;

#8. List users, their last activity date and activity status
SELECT u.UserID, u.FirstName, u.LastName, MAX(a.ActivityDate) AS LastActivityDate,
CASE
    WHEN MAX(a.ActivityDate) >= CURDATE() - INTERVAL 7 DAY THEN 'Active Recently'
    ELSE 'Inactive'
END AS ActivityStatus
FROM USER u
JOIN COMPLETES c ON u.UserID = c.UserID
JOIN ACTIVITY a ON c.ActivityID = a.ActivityID
GROUP BY u.UserID;

#9.Event Participation Report
SELECT e.EventName, COUNT(*) AS NumberOfParticipants, r.RewardName
FROM EVENT e
JOIN PARTICIPATES p ON e.EventID = p.EventID
JOIN REWARD r ON e.RewardID = r.RewardID
GROUP BY e.EventName, r.RewardName
ORDER BY NumberOfParticipants DESC;

#10.Tracking Progress Report
SELECT u.FirstName, u.LastName, g.GoalDescription, tr.TWeight AS CurrentWeight, g.EndDate, 
       (g.EndDate - CURDATE()) AS DaysRemaining
FROM TRACKING tr
JOIN USER u ON tr.TrackingUserID = u.UserID
JOIN GOAL g ON tr.TrackingGoalID = g.GoalID
WHERE g.Status = 'In Progress' AND g.EndDate > CURDATE()
ORDER BY DaysRemaining ASC;
--------------

