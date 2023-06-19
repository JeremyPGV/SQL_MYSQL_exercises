-- -- Création des tables --------------------------------------------------
/*
CREATE TABLE Sales
(
	purchase_number INT NOT NULL AUTO_INCREMENT,
    date_of_purchase DATE NOT NULL,
    customer_id INT,
    item_code VARCHAR (10) NOT NULL,
PRIMARY KEY (purchase_number)
);

CREATE TABLE Customers
(
	customer_id INT,
    first_name VARCHAR (255),
    last_name VARCHAR (255),
    email_adress VARCHAR (255),
    number_of_complaints INT,
PRIMARY KEY (customer_id)
);

CREATE TABLE Items
(
	item_code VARCHAR (255),
    item VARCHAR (255),
    unit_price NUMERIC (10,2),
    company_id VARCHAR (255),
PRIMARY KEY (item_code)
);

CREATE TABLE Companies
(
	company_id VARCHAR (255),
	company_name VARCHAR (255),
	headquarters_phone_number INT(12),
PRIMARY KEY (company_id)
);

*/

-- DROP TABLE Sales;

CREATE TABLE customers (

    customer_id INT AUTO_INCREMENT,

    first_name VARCHAR(255),

    last_name VARCHAR(255),

    email_address VARCHAR(255),

    number_of_complaints INT,

PRIMARY KEY (customer_id)

);

 ALTER TABLE customers

ADD COLUMN gender ENUM('M', 'F') AFTER last_name;

 

INSERT INTO customers (first_name, last_name, gender, email_address, number_of_complaints)

VALUES ('John', 'Mackinley', 'M', 'john.mckinley@365careers.com', 0)

;

CREATE TABLE Companies
(
	company_id VARCHAR (255),
	company_name VARCHAR (255) DEFAULT 'X',
	headquarters_phone_number INT(12),
PRIMARY KEY (company_id)
);

ALTER TABLE Companies
ADD UNIQUE KEY (headquarters_phone_number);
-- MODIFY headquarters_phone_number VARCHAR (255) NOT NULL;

DROP TABLE Companies