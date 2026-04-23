create database BookStoreDB;
use BookStoreDB;

CREATE TABLE Category (
    category_id INT PRIMARY KEY AUTO_INCREMENT,
    category_name VARCHAR(100) NOT NULL,
    description VARCHAR(255)
);

CREATE TABLE Book (
    book_id INT PRIMARY KEY AUTO_INCREMENT,
    title VARCHAR(150) NOT NULL,
    status INT DEFAULT 1,
    publish_date DATE,
    price DECIMAL(10 , 2 ),
    category_id INT,
    FOREIGN KEY (category_id)
        REFERENCES Category (category_id)
);

create table BookOrder(
	order_id int primary key auto_increment, 
    customer_name varchar(100) not null , 
    book_id int,
    order_date date default (current_date()),
    delivery_date date , 
    foreign key (book_id) references Book(book_id)
);
-- Câu 2
alter table Book 
add author_name varchar(100) not null ;

alter table BookOrder 
modify customer_name varchar(200) not null,
add constraint check(delivery_date >= order_date);

-- Câu 3
insert into Category(category_name, description) values
('IT & Tech', 'Sách lập trình'),
('Business', 'Sách kinh doanh'),
('Novel', 'Tiểu thuyết');

insert into Book (title, status, publish_date, price, category_id, author_name) values 
('Clean Code', 1, '2020-05-10', 500000, 1, 'Robert C. Martin'), 
('Đắc Nhân Tâm', 0, '2018-08-20', 150000, 2, 'Dale Carnegie'), 
('JavaScript Nâng cao', 1, '2023-01-15', 350000, 1, 'Kyle Simpson'), 
('Nhà Giả Kim', 0, '2015-11-25', 120000, 3, 'Paulo Coelho');

insert into BookOrder(order_id, customer_name, book_id, order_date, delivery_date) values
(101, 'Nguyen Hai Nam ', 1, '2025-01-10', '2025-01-15'), 
(102, 'Tran Bao Ngoc ', 3, '2025-02-05', '2025-02-10'), 
(103, 'Le Hoang Yen ', 4, '2025-03-12', NULL);

update Book
set price = price + 50000
where category_id = 1; 

update BookOrder 
set delivery_date = '2025-12-31'
where delivery_date is NULL;

delete from BookOrder
where order_date < '2025-02-01';

-- Cau 4: 

-- CASE & AS
select 
	title, 
    author_name, 
    case 
		when status = 1 then 'Còn hàng' 
        when status = 0 then 'Hết hàng'
	end as status_name
from Book;

-- INNER JOIN
select 
	b.title, 
    b.price, 
    b.author_name 
from Book b 
join category c 
on b.category_id = c.category_id;

-- ORDER BY & LIMIT
select *
from Book
order by price desc
limit 2;

-- GROUP BY & HAVING
select 
	category_id, 
	count(book_id) as book_count
from Book 
group by categogy_id 
having book_count >= 2;

-- Scalar Subquery
select 
	title, 
    price 
from Book
where price > (
	select avg(price) 
    from Book
);