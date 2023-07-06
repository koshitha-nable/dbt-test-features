# DBT LABS
## _dbt-test-Data Masking-models_

[![N|able](https://user-images.githubusercontent.com/76805373/152945012-5d715499-4498-4d8b-85c7-b5b8a6b82da9.png)](https://www.n-able.biz/)


[![Build Status](https://travis-ci.org/joemccann/dillinger.svg?branch=master)](https://github.com/koshitha-nable/dbt-test-features/tree/develop)

# Running Data Masking Models in dbt

## Introduction
In dbt Labs, We can achieve data masking and redaction for privacy-related requirements using the dbt_privacy module. This module provides a set of macros and functions that allow you to define and apply data masking rules to your data during the transformation process in dbt.

## Prerequisites
Before running models, make sure you have the following prerequisites in place:
- dbt installed and configured
- Understanding of unique keys and their importance in  processing
- Ensure your data source and target database support  processing
- DBT Version Required >= 1.2.0
- Ensure dbt privacy package is included in packages.yml file

```sh
packages:
  - package: pvcy/dbt_privacy
    version: 0.3.1
```

## Getting Started

To get started with this project, follow the steps below:

## Prerequisites

- dbt (data build tool) installed on your local machine. You can install dbt by following the instructions at [dbt Installation Guide](https://docs.getdbt.com/dbt-cli/installation)

## Installation
### psql server setup - steps
### Prerequisites
Before you begin, ensure that you have the following prerequisites installed:
- Docker: You can download and install Docker from the official website (https://www.docker.com).

### **STEPS:**
#### Intall Docker #### 
##### 1. Download and install Docker by following the official instructions for your operating system. #####

##### 2. Once the installation is complete, verify that Docker is running by opening a terminal (or command prompt) and running the following command: ##### 
```sh
docker --version
```
You should see the Docker version information printed in the terminal.

#### Start PostgreSQL Container #### 
##### 1. Open a terminal (or command prompt).
##### 2. Run the following command to start a PostgreSQL container:
```sh
docker run --name postgres-container -e POSTGRES_PASSWORD=your_password -p 5432:5432 -d postgres
```
Replace **your_password** with a strong password of your choice.
##### 3. Wait for the container to start. You can check its status by running the command:
```sh
docker ps
```
you should see the postgres-container listed with a status of "Up" or "Running."
#### Install and Start pgAdmin
##### 1. Open a web browser and go to http://localhost:5050.
##### 2. Click on the "Click here" link to download the pgAdmin Docker image.
##### 3. Once the download is complete, go to your terminal (or command prompt) and run the following command to start the pgAdmin container:
   ```sh
   docker run --name pgadmin-container -p 5050:80 -e PGADMIN_DEFAULT_EMAIL=your_email -e PGADMIN_DEFAULT_PASSWORD=your_password -d dpage/pgadmin4
   ```
   Replace your_email and your_password with your desired email address and password for the pgAdmin login.
   
#### Configure pgAdmin
1. Go back to your web browser and access http://localhost:5050.
2. Log in to pgAdmin using the email and password you set in the previous step.
3. In the pgAdmin interface, click on "Add New Server" under the "Quick Links" section.
4. Enter the following details:
- **Name**: Give a name for your server (e.g., My PostgreSQL Server).
- **Host name/address**: postgres-container
- **Port**: 5432
- **Username**: postgres
- **Password**: The password you set for the PostgreSQL container.
6. Click "Save" to add the server.
7. You should now see the server listed in the left sidebar. Click on it to access and manage your PostgreSQL database using pgAdmin.
### Run this command to Clone the repository to your local machine:
   ```sh
   git clone https://github.com/koshitha-nable/dbt-test-features.git
   ```
### Navigate to the project directory:
   ```sh
  cd dbt-test-features
   ```
### Install the project dependencies:
```sh
pip install -r requirements.txt
```
### Configuration
1. Open the dbt_project.yml file and update the necessary configurations, such as **target database**, **credentials**, and other project-specific settings.
2. Configure your database connection by creating a **profiles.yml** file in the ~/.dbt directory. Refer to the [dbt Profiles Documentation](https://docs.getdbt.com/reference/warehouse-profiles) for more details.


### Data Source Configuration
Please make sure to have student dataset available in your target database before running the dbt commands.

## Running the project
#### Building Data Models ####
**To build the data models and transform your data, follow these steps:**
#### 1. Navigate to the dbt project directory:
   ```sh
  cd dbt_test
   ```
##### 2. Test the database connection and show information for debugging purposes ####
```sh
dbt debug
```
##### 3. Downloads dependencies for a project
```sh
dbt deps
```
**Required for install  privacy package**

##### 4. Loads CSV file into the database #####
```sh
dbt seed
```
This command will load csv files located in the seed-paths directory of your dbt project into your data warehouse.
##### 5. To execute the compiled SQL transformations and materialize the models, use the following command: #####
```sh
dbt run --select stg_student
```
Running this command will create or update the tables/views defined in your project. It applies the transformations defined in the models and loads the data into the target database.

##### If you want to perform a full refresh of the data models, including dropping and recreating the tables/views, use the following command: #####

```sh
dbt run --full-refresh
```
This command ensures that the data models reflect the latest state of the source data.

#### Testing ####
**To test the project models and ensure the accuracy of the transformations, follow these step:**
##### To execute the tests defined in your project, use the following command: ##### 
```sh
dbt test
```
This command runs the tests specified in this project, checking if the expected results match the actual data.

#### Documentation #### 
**To generate and view the documentation for this dbt project, follow these steps:**
##### 1. Generate the documentation by running the following command: #####
```sh
dbt docs generate
```
This command generates HTML pages documenting the models, tests, and macros in your project.
#####  2. Serve the documentation locally by running the following command: ##### 
```sh
dbt docs serve
```
This command starts a local web server to host the documentation. You can access it by opening your browser and visiting the provided URL.

###### Generated lineage graph
![lineage graph!](lineage_graph.PNG)

**Note**: Remember to generate the documentation before serving it.

 Refer the [dbt commands](https://docs.getdbt.com/reference/dbt-commands) for more details.



