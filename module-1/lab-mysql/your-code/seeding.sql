USE lab_mysql;

INSERT INTO Cars (vehicle_identification_number, manufacturer, model, vehicle_year, color) 
VALUES ('3K096I98581DHSNUP', 'Volkswagen', 'Tiguan', '2019', 'Blue');

INSERT INTO Cars (vehicle_identification_number, manufacturer, model, vehicle_year, color) 
VALUES ('ZM8G7BEUQZ97IH46V', 'Peugeot', 'Rifter' , '2019' , 'Red');

INSERT INTO Cars (vehicle_identification_number, manufacturer, model, vehicle_year, color) 
VALUES ('RKXVNNIHLVVZOUB4M' , 'Ford' , 'Fusion' , '2018 ', 'White');

INSERT INTO Cars (vehicle_identification_number, manufacturer, model, vehicle_year, color) 
VALUES ('HKNDGS7CU31E9Z7JW' , 'Toyota' , 'RAV4' , '2018' , 'Silver');

INSERT INTO Cars (vehicle_identification_number, manufacturer, model, vehicle_year, color) 
VALUES ('DAM41UDN3CHU2WVF6' , 'Volvo' , 'V60' , '2019' , 'Gray');

INSERT INTO Cars (vehicle_identification_number, manufacturer, model, vehicle_year, color) 
VALUES ('DAM41UDN3CHU2WVF6' , 'Volvo' , 'V60 Cross Country' , '2019' , 'Gray');


INSERT INTO Customers (customer_ID,full_name,phone_number,email,home_address,city,state_or_province,country,zip_or_postal_code)
VALUES (10001 , 'Pablo Picasso' , '+34 636 17 63 82' , '-' , 'Paseo de la Chopera, 14' , 'Madrid' , 'Madrid' , 'Spain' , 28045);

INSERT INTO Customers (customer_ID,full_name,phone_number,email,home_address,city,state_or_province,country,zip_or_postal_code)
VALUES (20001 , 'Abraham Lincoln' , '+1 305 907 7086' , '-' , '120 SW 8th St' , 'Miami' , 'Florida' , 'United States' , 33130);

INSERT INTO Customers (customer_ID,full_name,phone_number,email,home_address,city,state_or_province,country,zip_or_postal_code)
VALUES (30001 , 'Napoléon Bonaparte' , '+33 1 79 75 40 00' , '-' , '40 Rue du Colisée' , 'Paris' , 'Île-de-France' , 'France' , 75008);


INSERT INTO Invoices (invoice_number, invoice_date, car_ID, customer_ID, staff_ID)
VALUES (852399038 , '22-08-2018' , 0 , 1 , 3);

INSERT INTO Invoices (invoice_number, invoice_date, car_ID, customer_ID, staff_ID)
VALUES (731166526 , '31-12-2018' , 3 , 0 , 5);

INSERT INTO Invoices (invoice_number, invoice_date, car_ID, customer_ID, staff_ID)
VALUES (271135104 , '22-01-2019' , 2 , 2 , 7);


INSERT INTO Salesperson (staff_ID, salesperson_name, store)
VALUES (00001 , 'Petey Cruiser' , 'Madrid');

INSERT INTO Salesperson (staff_ID, salesperson_name, store)
VALUES (00002 , 'Anna Sthesia' , 'Barcelona');

INSERT INTO Salesperson (staff_ID, salesperson_name, store)
VALUES (00003 , 'Paul Molive' , 'Berlin');

INSERT INTO Salesperson (staff_ID, salesperson_name, store)
VALUES (00004 , 'Gail Forcewind' , 'Paris');

INSERT INTO Salesperson (staff_ID, salesperson_name, store)
VALUES (00005 , 'Paige Turner' , 'Miami');

INSERT INTO Salesperson (staff_ID, salesperson_name, store)
VALUES (00006 , 'Bob Frapples' , 'Mexico City');

INSERT INTO Salesperson (staff_ID, salesperson_name, store)
VALUES (00007 , 'Walter Melon' , 'Amsterdam');

INSERT INTO Salesperson (staff_ID, salesperson_name, store)
VALUES (00008 , 'Shonda Leer' , 'São Paulo');
