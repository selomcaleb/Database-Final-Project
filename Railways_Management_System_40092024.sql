DROP DATABASE IF EXISTS Railways_Management_System_40092024;
CREATE DATABASE Railways_Management_System_40092024;
USE Railways_Management_System_40092024;

CREATE TABLE Department(
department_id INT PRIMARY KEY AUTO_INCREMENT,
department_name VARCHAR(80) NOT NULL
);


CREATE TABLE Passenger(
passenger_id INT PRIMARY KEY AUTO_INCREMENT,
passenger_first_name VARCHAR(50) NOT NULL,
passenger_last_name VARCHAR(50) NOT NULL,
phone_number VARCHAR(15) UNIQUE NOT NULL,
city VARCHAR(30) NOT NULL,
gender VARCHAR(7),
CHECK(gender in ('Male', 'Female', 'Unknown'))
);


CREATE TABLE Station(
station_id INT PRIMARY KEY AUTO_INCREMENT,
station_name varchar(50) NOT NULL,
station_location varchar(50) NOT NULL,
station_opening_time TIME NOT NULL,
station_closing_time TIME NOT NULL,
train_count INT NOT NULL
);


CREATE TABLE Employee(
employee_id INT PRIMARY KEY AUTO_INCREMENT,
employee_first_name varchar(50) NOT NULL,
employee_last_name varchar(50) NOT NULL,
date_of_birth DATE NOT NULL,
email varchar(80) UNIQUE NOT NULL,
employement_date DATE NOT NULL,
location varchar(50) NOT NULL,
salary int NOT NULL,
department_id INT,
FOREIGN KEY(department_id) REFERENCES Department(department_id) ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE Train(
train_id INT PRIMARY KEY AUTO_INCREMENT,
train_capacity INT NOT NULL,
number_of_staff INT NOT NULL,
horsepower INT NOT NULL,
employee_id INT,
FOREIGN KEY(employee_id) REFERENCES Employee(employee_id) ON DELETE CASCADE ON UPDATE CASCADE
);


CREATE TABLE Route(
route_code INT PRIMARY KEY auto_increment,
distance_between_routes FLOAT NOT NULL,
endDestination VARCHAR(50) NOT NULL,
startDestination VARCHAR(50) NOT NULL,
stops INT NOT NULL,
station_id INT,
FOREIGN KEY(station_id) REFERENCES Station(station_id) ON DELETE CASCADE ON UPDATE CASCADE
);
ALTER table Route auto_increment = 0001;


CREATE TABLE Trip(
trip_id INT PRIMARY KEY auto_increment,
departure_time TIME NOT NULL,
arrival_time TIME NOT NULL,
date_of_flight DATE NOT NULL,
destination_name varchar(30),
route_code INT,
FOREIGN KEY(route_code) REFERENCES Route(route_code) ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE Mode_Payment(
payment_id INT PRIMARY KEY,
payment_option ENUM('Mobile Money','Cash','ATM')
);

CREATE TABLE Ticket(
ticket_id INT PRIMARY KEY AUTO_INCREMENT,
price INT NOT NULL,
booking_date DATE NOT NULL,
passenger_id INT,
trip_id INT,
payment_id INT,
employee_id INT ,
FOREIGN KEY(passenger_id) REFERENCES Passenger(passenger_id) ON DELETE CASCADE ON UPDATE CASCADE,
FOREIGN KEY(trip_id) REFERENCES Trip(trip_id) ON DELETE CASCADE ON UPDATE CASCADE,
FOREIGN KEY(employee_id) REFERENCES Employee(employee_id) ON DELETE CASCADE ON UPDATE CASCADE,
FOREIGN KEY(payment_id) REFERENCES Mode_Payment(payment_id) ON DELETE CASCADE ON UPDATE CASCADE
);


CREATE TABLE VIP(
ticket_expiry_date DATE NOT NULL,
ticket_id INT PRIMARY KEY,
FOREIGN KEY(ticket_id) REFERENCES Ticket(ticket_id) ON DELETE CASCADE ON UPDATE CASCADE
);


CREATE TABLE Station_Department(
station_id INT,
department_id INT,
FOREIGN KEY(station_id) REFERENCES Station(station_id) ON DELETE CASCADE ON UPDATE CASCADE,
FOREIGN KEY(department_id) REFERENCES Department(department_id) ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE TrainRoute(
train_id INT,
route_code INT,
FOREIGN KEY(train_id) REFERENCES Train(train_id) ON DELETE CASCADE ON UPDATE CASCADE,
FOREIGN KEY(route_code) REFERENCES Route(route_code) ON DELETE CASCADE ON UPDATE CASCADE
);


#CREATE INDEXES
CREATE INDEX idx_pname ON Passenger(passenger_first_name,passenger_last_name);
CREATE INDEX idx_ename ON Employee(employee_first_name,employee_last_name);
CREATE INDEX route_journey 	ON Route(endDestination,startDestination);
CREATE INDEX idx_arrival_time ON Trip(arrival_time);


# INSERTIONS FOR STRONG ENTITIES

INSERT INTO Department(department_name) VALUES ("Booking Clerk Department");
INSERT INTO Department(department_name) VALUES("Drivers Department");
INSERT INTO Department(department_name) VALUES("Traffics Department");
INSERT INTO Department(department_name) VALUES("Finance Department");
INSERT INTO Department(department_name) VALUES("Engineering Department");


INSERT INTO Passenger(passenger_first_name, passenger_last_name,phone_number,city,gender)VALUES ("Abena","Fowuah", 0241884010,"Nima","Female");
INSERT INTO Passenger(passenger_first_name, passenger_last_name,phone_number,city,gender) VALUES ("Leroy","Otoo", 0503342607,"Gbawe","Male");
INSERT INTO Passenger(passenger_first_name, passenger_last_name,phone_number,city,gender) VALUES ("Mike", "Ross", 0208164302,"Dansoman","Male");
INSERT INTO Passenger(passenger_first_name, passenger_last_name,phone_number,city,gender) VALUES ("Sena","Vuvor", 0506299808, "Oyarifa","Female");
INSERT INTO Passenger(passenger_first_name, passenger_last_name,phone_number,city,gender) VALUES ("Joel","Asamoah", 0244365656, "Weija","Male");
INSERT INTO Passenger(passenger_first_name, passenger_last_name,phone_number,city,gender) VALUES ("Oheneba","Dade","0507732685","Lapaz","Male");


INSERT INTO Station(station_name,station_location,station_opening_time,station_closing_time,train_count) VALUES ("HeatRow Station","South Industrial Area","08:00","17:00",3);
INSERT INTO Station(station_name,station_location,station_opening_time,station_closing_time,train_count) VALUES ("Thompson Station","Spintex","08:30","17:30",2);
INSERT INTO Station(station_name,station_location,station_opening_time,station_closing_time,train_count) VALUES ("Odaw Station","Ring Road","09:00","17:00",2);
INSERT INTO Station(station_name,station_location,station_opening_time,station_closing_time,train_count) VALUES ("Pokausi JCT Station","Pokuasi","08:00","17:00",3);
INSERT INTO Station(station_name,station_location,station_opening_time,station_closing_time,train_count) VALUES ("DomeLAS Station","Dome","08:00","19:00",2);


INSERT INTO Employee(employee_first_name, employee_last_name ,date_of_birth,email,employement_date,location,salary,department_id) VALUES ("Sitsofe","Attipoe",'2000-09-11',"sitsofeattipoe@gmail.com",'2021-05-10',"South Industrial Area",1700.00,1);
INSERT INTO Employee(employee_first_name, employee_last_name ,date_of_birth,email,employement_date,location,salary,department_id) VALUES ('Chris','Arcmann','1999-02-20','chrisarcmann@gmail.com','2021-10-06','Spintex',1200.00,2);
INSERT INTO Employee(employee_first_name, employee_last_name ,date_of_birth,email,employement_date,location,salary,department_id) VALUES ('Jae','Su','2002-01-12','jaesu@gmail.com', '2021-03-02','Accra Circle', 1500.00,3);
INSERT INTO Employee(employee_first_name, employee_last_name ,date_of_birth,email,employement_date,location,salary,department_id) VALUES ('Chudah','Yakung','2003-08-07','chudahyakung@gmail.com', '2022-01-02','Dome', 1800.00,1);
INSERT INTO Employee(employee_first_name, employee_last_name ,date_of_birth,email,employement_date,location,salary,department_id) VALUES ('Carla','Otoo','2001-08-07','carlaotoo@gmail.com', '2022-02-19','Pokausi', 1900.00,2);
INSERT INTO Employee(employee_first_name, employee_last_name ,date_of_birth,email,employement_date,location,salary,department_id) VALUES ('Goodie','Dawson','1992-09-17','goodiedawson@gmail.com', '2022-01-02','Cantoments', 1650.00,3);
INSERT INTO Employee(employee_first_name, employee_last_name ,date_of_birth,email,employement_date,location,salary,department_id) VALUES ('Amma','Oforiwaa','1999-02-10','ammaoforiwaa@gmail.com', '2022-01-06','Lapaz', 1850.00,1);
INSERT INTO Employee(employee_first_name, employee_last_name ,date_of_birth,email,employement_date,location,salary,department_id) VALUES ('Kofi','Kyere','1998-08-07','kofikyere@gmail.com', '2022-03-22','Shiashi', 1200.00,2);
INSERT INTO Employee(employee_first_name, employee_last_name ,date_of_birth,email,employement_date,location,salary,department_id) VALUES ('Senam','Tay','2002-08-25','senamtay@gmail.com', '2022-04-12','Mallam', 1700.00,3);
INSERT INTO Employee(employee_first_name, employee_last_name ,date_of_birth,email,employement_date,location,salary,department_id) VALUES ('Mensima','Adams','2001-02-07','mensimaadams@gamil.com', '2022-01-02','Kasoa', 1500.00,1);
INSERT INTO Employee(employee_first_name, employee_last_name ,date_of_birth,email,employement_date,location,salary,department_id) VALUES ('Reginald','Sekyere','2000-08-09','reginaldsekyereg@gamil.com', '2022-01-02','Nima', 1400.00,1);
INSERT INTO Employee(employee_first_name, employee_last_name ,date_of_birth,email,employement_date,location,salary,department_id) VALUES ("Beatrice","Karbu",'2001-05-24',"beatricekarbue@gmail.com",'2021-05-10',"Malllam",1800.00,4);
INSERT INTO Employee(employee_first_name, employee_last_name ,date_of_birth,email,employement_date,location,salary,department_id) VALUES ('David','Osei','1999-11-03','davidosei@gmail.com','2021-11-06','Alajo',1600.00,5);


INSERT INTO Train(train_capacity,number_of_staff,horsepower,employee_id) VALUES (10,3,150.0,2);
INSERT INTO Train(train_capacity,number_of_staff,horsepower,employee_id) VALUES (8,2,170.0,5);
INSERT INTO Train(train_capacity,number_of_staff,horsepower,employee_id) VALUES (10,1,180.0,8);
INSERT INTO Train(train_capacity,number_of_staff,horsepower,employee_id) VALUES (10,2,120.0,2);
INSERT INTO Train(train_capacity,number_of_staff,horsepower,employee_id) VALUES (6,1,190.0,2);


INSERT INTO Route(distance_between_routes,endDestination,startDestination ,stops,station_id) VALUES (1720,'Spintex','South Industrial Area',2,1);
INSERT INTO Route(distance_between_routes,endDestination,startDestination ,stops,station_id) VALUES (1430,'Ring Road','Spintex',1,2);
INSERT INTO Route(distance_between_routes,endDestination,startDestination ,stops,station_id) VALUES (2301,'Pokuasi','Ring Road',4,3);
INSERT INTO Route(distance_between_routes,endDestination,startDestination ,stops,station_id) VALUES (1203,'Dome','Pokuasi',1,4);
INSERT INTO Route(distance_between_routes,endDestination,startDestination ,stops,station_id) VALUES (1450,'South Industrial Area','Dome',3,5);


INSERT INTO Trip(departure_time,arrival_time,date_of_flight,destination_name,route_code) VALUES ('10:00','11:15','2022-11-28','Spintex',0001);
INSERT INTO Trip(departure_time,arrival_time,date_of_flight,destination_name,route_code) VALUES ('11:20','12:20','2022-11-28','Ring Road',0002);
INSERT INTO Trip(departure_time,arrival_time,date_of_flight,destination_name,route_code) VALUES ('12:30','13:30','2022-11-28','Pokausi',0003);
INSERT INTO Trip(departure_time,arrival_time,date_of_flight,destination_name,route_code) VALUES ('13:40','14:40','2022-11-28','Dome',0004);
INSERT INTO Trip(departure_time,arrival_time,date_of_flight,destination_name,route_code) VALUES ('14:50','16:00','2022-11-28','South Industrial Area',0005);
INSERT INTO Trip(departure_time,arrival_time,date_of_flight,destination_name,route_code) VALUES ('10:30','11:45', '2022-11-29', 'Ring Road',0002);
INSERT INTO Trip(departure_time,arrival_time,date_of_flight,destination_name,route_code) VALUES ('12:00','13:15','2022-11-29','Dome',0004);
INSERT INTO Trip(departure_time,arrival_time,date_of_flight,destination_name,route_code) VALUES ('13:30','14:45','2022-11-29','Pokausi',0003);
INSERT INTO Trip(departure_time,arrival_time,date_of_flight,destination_name,route_code) VALUES ('15:00','16:00','2022-11-29','South Industrial Area',0005);
INSERT INTO Trip(departure_time,arrival_time,date_of_flight,destination_name,route_code) VALUES ('16:10','16:45','2022-11-29','Spintex',0001);


INSERT INTO Mode_Payment VALUES (1001,'Mobile Money');
INSERT INTO Mode_Payment VALUES (2002,'Cash');
INSERT INTO Mode_Payment VALUES (3003,'ATM');


INSERT INTO Ticket(price,booking_date,passenger_id,trip_id,payment_id,employee_id) VALUES(150,'2022-11-28',2,1,3003,1);
INSERT INTO Ticket(price,booking_date,passenger_id,trip_id,payment_id,employee_id) VALUES(150,'2022-11-28',3,2,2002,7);
INSERT INTO Ticket(price,booking_date,passenger_id,trip_id,payment_id,employee_id) VALUES(150,'2022-11-28',6,1,1001,10);
INSERT INTO Ticket(price,booking_date,passenger_id,trip_id,payment_id,employee_id) VALUES(200,'2022-10-28',1,2,3003,4);
INSERT INTO Ticket(price,booking_date,passenger_id,trip_id,payment_id,employee_id) VALUES(200,'2022-10-29',4,7,2002,11);
INSERT INTO Ticket(price,booking_date,passenger_id,trip_id,payment_id,employee_id) VALUES(200,'2022-10-27',5,3,1001,1);
INSERT INTO Ticket(price,booking_date,passenger_id,trip_id,payment_id,employee_id) VALUES(150,'2022-11-29',2,10,2002,1);
INSERT INTO Ticket(price,booking_date,passenger_id,trip_id,payment_id,employee_id) VALUES(200,'2022-10-29',2,9,3003,4);
INSERT INTO Ticket(price,booking_date,passenger_id,trip_id,payment_id,employee_id) VALUES(150,'2022-10-29',3,8,2002,10);
INSERT INTO Ticket(price,booking_date,passenger_id,trip_id,payment_id,employee_id) VALUES(150,'2022-10-29',6,10,2002,7);


INSERT INTO VIP(ticket_id,ticket_expiry_date) VALUES((Select ticket_id from Ticket where ticket_id = 4),'2023-10-28');
INSERT INTO VIP(ticket_id,ticket_expiry_date) VALUES((Select ticket_id from Ticket where ticket_id = 5),'2023-10-29');
INSERT INTO VIP(ticket_id,ticket_expiry_date) VALUES((Select ticket_id from Ticket where ticket_id = 6),'2023-10-27');
INSERT INTO VIP(ticket_id,ticket_expiry_date) VALUES((Select ticket_id from Ticket where ticket_id = 8),'2023-10-29');


INSERT INTO Station_Department(station_id,department_id) VALUES (1,1);
INSERT INTO Station_Department(station_id,department_id) VALUES (2,1);
INSERT INTO Station_Department(station_id,department_id) VALUES (3,1);
INSERT INTO Station_Department(station_id,department_id) VALUES (4,1);
INSERT INTO Station_Department(station_id,department_id) VALUES (5,1);
INSERT INTO Station_Department(station_id,department_id) VALUES (1,2);
INSERT INTO Station_Department(station_id,department_id) VALUES (2,2);
INSERT INTO Station_Department(station_id,department_id) VALUES (3,2);
INSERT INTO Station_Department(station_id,department_id) VALUES (4,2);
INSERT INTO Station_Department(station_id,department_id) VALUES (5,2);
INSERT INTO Station_Department(station_id,department_id) VALUES (1,3);
INSERT INTO Station_Department(station_id,department_id) VALUES (2,3);
INSERT INTO Station_Department(station_id,department_id) VALUES (3,3);
INSERT INTO Station_Department(station_id,department_id) VALUES (4,3);
INSERT INTO Station_Department(station_id,department_id) VALUES (5,3);


INSERT INTO TrainRoute VALUES(1,1);
INSERT INTO TrainRoute VALUES(1,2);
INSERT INTO TrainRoute VALUES(1,3);
INSERT INTO TrainRoute VALUES(1,4);
INSERT INTO TrainRoute VALUES(1,5);
INSERT INTO TrainRoute VALUES(2,1);
INSERT INTO TrainRoute VALUES(2,2);
INSERT INTO TrainRoute VALUES(2,3);
INSERT INTO TrainRoute VALUES(2,4);
INSERT INTO TrainRoute VALUES(2,5);
INSERT INTO TrainRoute VALUES(3,1);
INSERT INTO TrainRoute VALUES(3,2);
INSERT INTO TrainRoute VALUES(3,3);
INSERT INTO TrainRoute VALUES(3,4);
INSERT INTO TrainRoute VALUES(3,5);
INSERT INTO TrainRoute VALUES(4,1);
INSERT INTO TrainRoute VALUES(4,2);
INSERT INTO TrainRoute VALUES(4,3);
INSERT INTO TrainRoute VALUES(4,4);
INSERT INTO TrainRoute VALUES(4,5);
INSERT INTO TrainRoute VALUES(5,1);
INSERT INTO TrainRoute VALUES(5,2);
INSERT INTO TrainRoute VALUES(5,3);
INSERT INTO TrainRoute VALUES(5,4);
INSERT INTO TrainRoute VALUES(5,5);


#WRITING OF QUERIES
-- find the customers that have bought the most tickets currently.
SELECT concat(passenger_first_name, " ", passenger_last_name) as 'Frequent Customers', COUNT(*) AS ticket_purchase_count
FROM Passenger
INNER JOIN Ticket ON
Passenger.passenger_id = Ticket.passenger_id
WHERE CURDATE()- booking_date > 10
GROUP BY concat(passenger_first_name, " ", passenger_last_name) ORDER BY ticket_purchase_count DESC;


-- find the customers who purchased a VIP ticket and are reaching their expiry date.
SELECT concat(passenger_first_name, " ", passenger_last_name) as 'Customers Close to ExpiryDate',ticket_expiry_date
FROM Passenger
Inner join (
SELECT passenger_id,ticket_expiry_date FROM Ticket
INNER JOIN (
SELECT ticket_id,ticket_expiry_date
FROM VIP
WHERE CURDATE() - ticket_expiry_date < 30) A ON A.ticket_id = Ticket.ticket_id) B
ON B.passenger_id = Passenger.passenger_id
GROUP BY concat(passenger_first_name, " ", passenger_last_name),ticket_expiry_date;


-- find the booking clerk that has served the most customers to reward them for their effort
SELECT  concat(employee_first_name," ", employee_last_name) as 'Booking Clerk',email, COUNT(*) AS no_customers_served
FROM Employee
RIGHT OUTER JOIN Ticket ON
Employee.employee_id = Ticket.employee_id
GROUP BY concat(employee_first_name," ", employee_last_name),email
ORDER BY no_customers_served DESC;


-- find how many passengers took a  trip to enable management to better improve the trip time and their services
SELECT Trip.trip_id,departure_time,arrival_time,date_of_flight, COUNT(*) AS number_of_passengers_for_trip
FROM Trip
RIGHT OUTER JOIN Ticket ON
Trip.trip_id = Ticket.trip_id
GROUP BY Trip.trip_id,date_of_flight,departure_time,arrival_time;


-- finding out how much is earned from the various sources of income
SELECT payment_option, SUM(price) AS Total_Amount
FROM Mode_Payment
INNER JOIN Ticket ON
Mode_Payment.payment_id =  Ticket.payment_id
GROUP BY payment_option;


-- get the details of  a trip from a station
SELECT station_name,S.departure_time,S.arrival_time,S.date_of_flight,station_location,S.destination_name
FROM Station
INNER JOIN (
SELECT station_id, T.departure_time,T.arrival_time,T.date_of_flight,T.destination_name
FROM Route
INNER JOIN(
SELECT departure_time,arrival_time,date_of_flight,destination_name,route_code
FROM Trip
WHERE destination_name IN('Spintex','South Industrial Area','Pokuasi','Ring Road','Dome')) 
T ON
Route.route_code = T.route_code) S ON
Station.station_id = S.station_id;













