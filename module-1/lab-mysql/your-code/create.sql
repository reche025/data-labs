USE lab_mysql;

CREATE TABLE Cars
(
    ID INTEGER AUTO_INCREMENT PRIMARY KEY,
    vehicle_identification_number VARCHAR(25) NOT NULL,
    manufacturer VARCHAR(40) NOT NULL,
    model VARCHAR(40) NOT NULL,
    vehicle_year INTEGER(4) NOT NULL,
    color VARCHAR(25)
);

CREATE TABLE Customers
(
    ID INTEGER AUTO_INCREMENT PRIMARY KEY,
    customer_ID INTEGER(11) NOT NULL,
    full_name VARCHAR(100) NOT NULL,
    phone_number VARCHAR(25),
    email VARCHAR(100),
    home_address VARCHAR(100),
    city VARCHAR(100),
    state_or_province VARCHAR(100),
    country VARCHAR(100),
    zip_or_postal_code VARCHAR(100)
);

CREATE TABLE Salesperson
(
    ID INTEGER AUTO_INCREMENT PRIMARY KEY,
    staff_ID INTEGER(11) NOT NULL,
    salesperson_name VARCHAR(25) NOT NULL,
    store VARCHAR(100) NOT NULL
);

CREATE TABLE Invoices
(
    ID INTEGER AUTO_INCREMENT PRIMARY KEY,
    invoice_number VARCHAR(50) NOT NULL,
    invoice_date VARCHAR(10) NOT NULL,
    car_ID INTEGER(11) NOT NULL,
    customer_ID INTEGER(11) NOT NULL,
    staff_ID INTEGER(11) NOT NULL
);
