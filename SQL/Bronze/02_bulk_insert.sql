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
