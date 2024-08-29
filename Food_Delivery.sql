create database food_delivery_db;
use Food_Delivery_db;

create table Users (
    user_id int primary key auto_increment,
    username varchar(100),
    email varchar(100),
    password varchar(100),
    user_role enum('customer', 'delivery_person', 'admin'),
    created_at timestamp default current_timestamp
);

insert into Users (username, email, password, user_role) 
values('Anitha Palaniyappan', 'anitha@example.com', 'password123', 'customer'),
('Ranganayagi Sekar', 'ranganayagi@example.com', 'password123', 'customer'),
('Nandhini Murugan', 'nandhini@example.com', 'password123', 'customer'),
('Dharanisri Raman', 'dharanisri@example.com', 'password123', 'customer'),
('Deepa Selvakumar', 'deepa@example.com', 'password123', 'customer'),
('Thamynthi Jayaprakash', 'thamynthi@example.com', 'password123', 'customer'),
('Madhusri Mahendiran', 'madhusri@example.com', 'password123', 'customer'),
('Avanthika Punithavel', 'avanthika@example.com', 'password123', 'customer'),
('Kiruthika Kanagaraj', 'kiruthika@example.com', 'password123', 'customer'),
('Ownika Vignesh', 'ownika@example.com', 'password123', 'customer');


select * from users;

create table Restaurants (
    restaurant_id int primary key auto_increment,
    name varchar(100),
    address varchar(200),
    phone varchar(20)
);
insert into Restaurants (name, address, phone) 
values('Spicy Villa', '123 Anna Salai, Chennai, Tamil Nadu', '1234567891'),
('Ocean Breeze', '456 MG Road, Coimbatore, Tamil Nadu', '9876543210'),
('Golden Dragon', '789 Gandhi Road, Madurai, Tamil Nadu', '9876413156');

select * from Restaurants;

create table Menu_Items (
    item_id int primary key auto_increment,
    restaurant_id int,
    item_name varchar(100),
    item_price decimal(10, 2),
    category varchar(50),
    foreign key (restaurant_id) references Restaurants(restaurant_id)
);
insert into Menu_Items (restaurant_id, item_name, item_price, category) 
values(1, 'Spicy Chicken Curry', 12.99, 'Main Course'),
(1, 'Garlic Naan', 3.50, 'Side Dish'),
(2, 'Grilled Salmon', 18.50, 'Main Course'),
(2, 'Caesar Salad', 7.99, 'Appetizer'),
(3, 'Kung Pao Chicken', 10.99, 'Main Course'),
(3, 'Spring Rolls', 4.50, 'Appetizer');

select * from Menu_Items;

create table Orders (
    order_id int primary key auto_increment,
    user_id int,
    restaurant_id INT,
    order_date timestamp default current_timestamp ,
    total_amount decimal(10, 2),
    status enum('pending', 'delivered', 'canceled'),
    payment_status enum('pending', 'paid', 'failed'),
    foreign key (user_id) references Users(user_id),
    foreign key (restaurant_id) references Restaurants(restaurant_id)
);
insert into Orders (user_id, restaurant_id, order_date, total_amount, status, payment_status) 
values(1, 1, '2024-08-28 12:34:56', 16.49, 'delivered', 'paid'),
(2, 2, '2024-08-28 13:22:45', 26.49, 'pending', 'pending'),
(3, 3, '2024-08-28 14:10:10', 15.49, 'canceled', 'failed');

select * from Orders;

create table Order_Items (
    order_item_id int primary key auto_increment,
    order_id int,
    item_id int,
    quantity int,
    foreign key (order_id) references Orders(order_id),
    foreign key (item_id) references Menu_Items(item_id)
);
insert into Order_Items (order_id, item_id, quantity) 
values(1, 1, 1),
(1, 2, 2),
(2, 3, 1),
(2, 4, 1),
(3, 5, 1),
(3, 6, 1);

select * from  Order_Items;

create table Delivery_Address (
    address_id int primary key auto_increment,
    user_id int,
    address varchar(200),
    city varchar(50),
    state varchar(50),
    zip_code varchar(10),
    foreign key (user_id) references Users(user_id)
);
insert into Delivery_Address (user_id, address, city, state, zip_code) 
values(1, 'No. 12, VGP Layout, Chennai', 'Chennai', 'Tamil Nadu', '600042'),
(2, '456 Flower Market, Coimbatore', 'Coimbatore', 'Tamil Nadu', '641001'),
(3, '789 West Masi Street, Madurai', 'Madurai', 'Tamil Nadu', '625001');

select * from Delivery_Address;

create table Payments (
    payment_id int primary key auto_increment,
    order_id int,
    payment_method enum('credit_card', 'debit_card', 'paypal', 'cash_on_delivery'),
    payment_date timestamp default current_timestamp,
    amount decimal(10, 2),
    foreign key (order_id) references Orders(order_id)
);

insert into Payments (order_id, payment_method, payment_date, amount) 
values(1, 'credit_card', '2024-08-28 12:40:00', 16.49),
(2, 'paypal', '2024-08-28 13:30:00', 26.49);

select * from Payments;

create table Ratings (
    rating_id int primary key auto_increment,
    user_id int,
    restaurant_id int,
    rating int check (rating between 1 and 5),
    review text,
    rating_date timestamp default current_timestamp,
    foreign key (user_id) references Users(user_id),
    foreign key (restaurant_id) references Restaurants(restaurant_id)
);
insert into Ratings (user_id, restaurant_id, rating, review, rating_date) 
values(1, 1, 5, 'Amazing food and great service!', '2024-08-28 13:00:00'),
(2, 2, 4, 'Good food, but a bit pricey.', '2024-08-28 13:30:00'),
(3, 3, 2, 'Food was cold and delivery was late.', '2024-08-28 14:00:00');

select * from Ratings;

create table Delivery (
    delivery_id int primary key auto_increment,
    order_id int,
    delivery_person_id int,
    delivery_status enum('pending', 'on_the_way', 'delivered'),
    delivery_date timestamp default current_timestamp,
    foreign key (order_id) references Orders(order_id),
    foreign key (delivery_person_id) references Users(user_id)
);
insert into Delivery (order_id, delivery_person_id, delivery_status, delivery_date) 
values(1, 4, 'delivered', '2024-08-28 13:00:00'),
(2, 5, 'on_the_way', '2024-08-28 14:00:00');

select * from  Delivery;


create table Favorites (
    favorite_id int primary key auto_increment,
    user_id int,
    restaurant_id int,
    item_id int,
    foreign key (user_id) references Users(user_id),
    foreign key (restaurant_id) references Restaurants(restaurant_id),
    foreign key (item_id) references Menu_Items(item_id)
);

insert into Favorites (user_id, restaurant_id, item_id) 
values(1, 1, 1),
(2, 2, 3),
(3, 3, 5);

select * from Favorites;



select 
    Orders.order_id,
    Users.username,
    Users.email,
    Restaurants.name as restaurant_name,
    Orders.order_date,
    Orders.total_amount,
    Orders.status
from Orders
inner join Users on Orders.user_id = Users.user_id
inner join Restaurants on Orders.restaurant_id = Restaurants.restaurant_id;
