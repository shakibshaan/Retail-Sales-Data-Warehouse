/*
===============================================================================
Stored Procedure: Load Bronze Layer (Source -> Bronze)
===============================================================================
Script Purpose:
    This stored procedure loads data into the 'bronze' schema from external CSV files. 
    It performs the following actions:
    - Truncates the bronze tables before loading data.
    - Uses the `BULK INSERT` command to load data from csv Files to bronze tables.

Parameters:
    None. 
	  This stored procedure does not accept any parameters or return any values.

Usage Example:
    EXEC bronze.load_bronze;
===============================================================================
*/

CREATE OR ALTER PROCEDURE bronze.load_bronze AS
BEGIN 
    DECLARE @start_time DATETIME, @end_time DATETIME
    BEGIN TRY 
        PRINT '========================'
        PRINT 'Loading The Bronze Layer'
        PRINT '========================'
        PRINT  'Truncating Table: bronze.raw_order '
        PRINT  'Inserting Data Into: bronze.raw_order '
        
        SET @start_time = GETDATE();
        TRUNCATE TABLE bronze.raw_orders;
        BULK INSERT bronze.raw_orders
        FROM '/var/opt/mssql/SampleSuperstore.csv'
        WITH (
            FIRSTROW = 2,
            FIELDTERMINATOR = ',',
            TABLOCK
        );
        SET @end_time = GETDATE();
        PRINT '>> Load Duration: ' + CAST(DATEDIFF(second, @start_time, @end_time) AS NVARCHAR) + 'seconds';

        END TRY
        BEGIN CATCH
            PRINT '========================'
            PRINT 'ERROR LOADING THE BRONZE LAYER'
            PRINT 'ERROR MESSAGE: ' + ERROR_MESSAGE();
            PRINT 'ERROR MESSAGE: ' + CAST(ERROR_MESSAGE() AS NVARCHAR);
            PRINT 'ERROR MESSAGE: ' + CAST(ERROR_STATE() AS NVARCHAR);
        END CATCH
END
