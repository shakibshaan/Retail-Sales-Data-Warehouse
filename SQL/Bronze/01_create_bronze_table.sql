IF OBJECT_ID ('bronze.raw_orders', 'U') IS NOT NULL 
    DROP TABLE bronze.raw_orders;
CREATE TABLE bronze.raw_orders (
    ship_mode       NVARCHAR(50),
    segment         NVARCHAR(50),
    country         NVARCHAR(50),
    city            NVARCHAR(50),
    state_s         NVARCHAR(50),
    postal_code     NVARCHAR(50),
    region          NVARCHAR(50),
    category        NVARCHAR(50),
    sub_category    NVARCHAR(50),
    sales           DECIMAL(10, 4),
    quantity        INT,
    discount        DECIMAL(4, 2),
    profit          DECIMAL(10, 4)            
);
