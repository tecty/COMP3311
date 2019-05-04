create table Store (
    phone integer primary key, 
    'address' text not null
);

create table Customer (
    cust_no integer primary key,
    'name' text not null, 
    'address' text not null,  
    -- nullable favourate store
    favourate_store integer references Store(phone)
)

create table Account (
    acct_no integer primary key,
    use_at integer references Store(phone) not null, 
    balance float not null,
)

create table Account_Owner (
    cust_no integer references Customer(cust_no),
    acct_no integer references Account(acct_no),
    primary key (cust_no, acct_no)
)