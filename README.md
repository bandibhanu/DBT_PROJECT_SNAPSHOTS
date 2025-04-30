Welcome to your new dbt project!

To create a connection between the DBT and dataware house follow the steps:
**step1:** Create an DBT environment 
python -m vern env_name

**step2:** Activate the environment
./env_name/Scripts/Activate.ps1

**step3:** Once the environment is activated install the warehouse connection dependencies
```console
pip install dbt-snowflake
pip install dbt-bigquery
pip install dbt-postgres etc 
```

What ever the data warehouse you have been installed try to create the databases and schema. Here I have used the snowflake as a data ware house. 
Below commands might be useful

```console
USE ROLE ACCOUNTADMIN;
CREATE WAREHOUSE IF NOT EXISTS DBT_DEMO WITH WAREHOUSE_SIZE='X-SMALL';
CREATE ROLE IF NOT EXISTS DBT_ROLE;
CREATE DATABASE if not exists DBT_PREP_DEMO;
SHOW GRANTS ON WAREHOUSE DBT_DEMO;
GRANT USAGE ON WAREHOUSE DBT_DEMO TO ROLE DBT_ROLE;
GRANT ROLE DBT_ROLE TO USER XXXXXXX;
GRANT All ON DATABASE DBT_PREP_DEMO TO ROLE DBT_ROLE;
SHOW GRANTS ON DATABASE dbt_prep_demo;
USE ROLE DBT_ROLE;
CREATE SCHEMA DBT_PREP_DEMO.DBT_STAGING;
CREATE SCHEMA DBT_PREP_DEMO.DBT_HIST;
```

Once the Dataware house and schemas are created.

Now go back to DBT and run -- DBT INIT. 
give the details and per ask
It will used to create the dbt profiles.yml files and connect to snowflake. 
To test the connection --DBT DEBUG. It will do all the checks. If all the checks are passed that means you are connected to the snowflake. 
Run --DBT RUN to test the code

-----------------------------------------------

I have Utilized the s3 bucket to as raw layer. This is how we copy the data from s3 bucket to snowflake. 

**Step1:** Create a secure stage pointing to S3
```console
CREATE OR REPLACE STAGE my_s3_stage
  URL = 's3://demobucket/incoming_data/orders'
  CREDENTIALS = (
    AWS_KEY_ID = 'XXXXXXXXXXXXXXXX'      -- Replace with your key
    AWS_SECRET_KEY = 'XXXXXXXXXXXXXXXXXXX'  -- Replace with your secret
  )FILE_FORMAT =(TYPE='CSV');
```
**Step2:** Load data from S3 to Snowflake staging
 ```console
  COPY INTO DBT_PREP_DEMO.DBT_STAGING.ORDERS
  FROM @DBT_PREP_DEMO.DBT_STAGING.MY_S3_STAGE/orders_table.csv
    FILE_FORMAT=(
    TYPE='CSV',
    SKIP_HEADER=1
    );`
 ```


