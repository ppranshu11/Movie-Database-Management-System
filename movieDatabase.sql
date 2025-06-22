CREATE SCHEMA IF NOT EXISTS LMS;
use LMS;
drop schema LMS;
CREATE TABLE roles (
    role_id int PRIMARY KEY AUTO_INCREMENT,
    role_name VARCHAR(50) NOT NULL
);

show tables;
drop table roles;


CREATE TABLE LMS.users (
    user_id SERIAL PRIMARY KEY,
    username VARCHAR(100) NOT NULL UNIQUE,
    email VARCHAR(255) NOT NULL UNIQUE,
    password VARCHAR(255) NOT NULL,
    role_id INT NOT NULL REFERENCES roles(role_id),
    subscription_plan VARCHAR(50) DEFAULT 'free',
    created TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE LMS.subscriptions (
    subcriptions_id SERIAL PRIMARY KEY,
    course_limit INT,
    price DECIMAL(10, 2) NOT NULL,
    created TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE LMS.courses (
    course_id SERIAL PRIMARY KEY,
    course_name VARCHAR(255) NOT NULL,
    description TEXT,
    price DECIMAL(10, 2) DEFAULT 0, 
    created_by INT NOT NULL REFERENCES users(user_id),
    created_time TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE LMS.modules (
    module_id INT PRIMARY KEY,
    module_name VARCHAR(255),
    module_description TEXT,
    course_id INT  REFERENCES courses(course_id)
);

CREATE TABLE LMS.contents (studentStudent_id
    module_id SERIAL PRIMARY KEY REFERENCES modules(modules_id),
    content_type VARCHAR(2) NOT NULL CHECK (content_type IN ('video','pdf' )),
    content_duration INT 
);

CREATE TABLE LMS.discounts (
	course_id INT NOT NULL REFERENCES courses(course_id),
    course_type VARCHAR(50) NOT NULL REFERENCES courses_types(course_type),
    discount_type VARCHAR(50) NOT NULL CHECK (discount_type IN ('percentage', 'fixed')),
    discount_value DECIMAL(10, 2) NOT NULL
);

CREATE TABLE LMS.enrollments (
    enrollment_id SERIAL PRIMARY KEY,
    user_id INT NOT NULL REFERENCES users(user_id),
    course_id INT NOT NULL REFERENCES courses(course_id),
    enrollment_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE LMS.payments (
    transaction_id SERIAL PRIMARY KEY,
    pay_by INT NOT NULL REFERENCES useres(username),
    user_id INT NOT NULL REFERENCES users(user_id),
    course_id INT REFERENCES courses(course_id), 
    subscription_id INT REFERENCES subscriptions(subscription_id), 
    payment_amount DECIMAL(10, 2) NOT NULL,
    payment_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    payment_status varchar(200));
    
    
drop schema LMS;
select*from LMS.roles;
    