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
    DECLARE @start_time DATETIME, @end_time DATETIME, @batch_start_time DATETIME, @batch_end_time DATETIME;
    BEGIN TRY 
        SET @batch_start_time = GETDATE();
        PRINT '========================'
        PRINT 'Loading The Bronze Layer'
        PRINT '========================'


        PRINT  'Truncating Table: bronze.raw_order '
        PRINT  'Inserting Data Into: bronze.raw_order '
        SET @start_time = GETDATE();
        TRUNCATE TABLE bronze.raw_users;
        BULK INSERT bronze.raw_users
        FROM '/var/opt/mssql/uae_ai_analytics_files/users.csv'
        WITH (
            FIRSTROW = 2,
            FIELDTERMINATOR = ',',
            ROWTERMINATOR = '\n',
            TABLOCK
        );
        SET @end_time = GETDATE();
        PRINT'>> Load Duration: ' + CAST(DATEDIFF(second, @start_time, @end_Time) AS NVARCHAR) + 'seconds';
        PRINT '>> -------------';


        PRINT  'Truncating Table: bronze.raw_ai_tools '
        PRINT  'Inserting Data Into: bronze.raw_ai_tools '
        SET @start_time = GETDATE();
        TRUNCATE TABLE bronze.raw_ai_tools;
        BULK INSERT bronze.raw_ai_tools
        FROM '/var/opt/mssql/uae_ai_analytics_files/ai_tools.csv'
        WITH (
            FIRSTROW = 2,
            FIELDTERMINATOR = ',',
            ROWTERMINATOR = '\n',
            TABLOCK
        );
        SET @end_time = GETDATE();
        PRINT'>> Load Duration: ' +  CAST(DATEDIFF(second, @start_time, @end_time) AS NVARCHAR) + 'seconds'
        PRINT '>> -------------';


        PRINT  'Truncating Table: bronze.raw_ai_usage_logs '
        PRINT  'Inserting Data Into: bronze.raw_ai_usage_logs '
        SET @start_time = GETDATE();
        TRUNCATE TABLE bronze.raw_ai_usage_logs;
        BULK INSERT bronze.raw_ai_usage_logs
        FROM '/var/opt/mssql/uae_ai_analytics_files/ai_usage_logs.csv'
        WITH (
            FIRSTROW = 2,
            FIELDTERMINATOR = ',',
            ROWTERMINATOR = '\n',
            TABLOCK
        );
        SET @end_time = GETDATE();
        PRINT'>> Load Duration: ' +  CAST(DATEDIFF(second, @start_time, @end_time) AS NVARCHAR) + 'seconds'
        PRINT '>> -------------';



        PRINT  'Truncating Table: bronze.raw_feedback '
        PRINT  'Inserting Data Into: bronze.raw_feedback '
        SET @start_time = GETDATE();
        TRUNCATE TABLE bronze.raw_feedback;
        BULK INSERT bronze.raw_feedback
        FROM '/var/opt/mssql/uae_ai_analytics_files/feedback.csv'
        WITH (
            FIRSTROW = 2,
            FIELDTERMINATOR = ',',
            ROWTERMINATOR = '\n',
            TABLOCK
        );
        SET @end_time = GETDATE();
        PRINT'>> Load Duration: ' +  CAST(DATEDIFF(second, @start_time, @end_time) AS NVARCHAR) + 'seconds'
        PRINT '>> -------------';

        
        PRINT  'Truncating Table: bronze.raw_subscriptions '
        PRINT  'Inserting Data Into: bronze.raw_subscriptions '
        SET @start_time = GETDATE();
        TRUNCATE TABLE bronze.raw_subscriptions;
        BULK INSERT bronze.raw_subscriptions
        FROM '/var/opt/mssql/uae_ai_analytics_files/subscriptions.csv'
        WITH (
            FIRSTROW = 2,
            FIELDTERMINATOR = ',',
            ROWTERMINATOR = '\n',
            TABLOCK
        );
        SET @end_time = GETDATE();
        PRINT '>> Load Duration: ' + CAST(DATEDIFF(second, @start_time, @end_time) AS NVARCHAR) + 'seconds';


        SET @batch_end_time = GETDATE();
        PRINT '=========================================='
		PRINT 'Loading Bronze Layer is Completed';
        PRINT '>> Total Load Duration: ' + CAST(DATEDIFF(SECOND, @batch_start_time, @batch_end_time) AS NVARCHAR) + ' seconds';
		PRINT '=========================================='

        END TRY
        BEGIN CATCH
            PRINT '========================'
            PRINT 'ERROR LOADING THE BRONZE LAYER'
            PRINT 'ERROR MESSAGE: ' + ERROR_MESSAGE();
            PRINT 'ERROR MESSAGE: ' + CAST(ERROR_MESSAGE() AS NVARCHAR);
            PRINT 'ERROR MESSAGE: ' + CAST(ERROR_STATE() AS NVARCHAR);
        END CATCH
END


