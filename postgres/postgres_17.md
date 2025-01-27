# After installation using scoop
Run run 'pg_ctl start' or 'pg_ctl stop' to start and stop the database or
register it as a service by running 'pg_ctl register -N PostgreSQL' from an elevated shell.
Default superuser login: postgres, password: <blank>


Creating a new PostgreSQL user and assigning privileges to that user in a newly installed PostgreSQL instance on Windows 11 involves several steps. Below is a detailed guide on how to accomplish this:

### Step 1: Start the PostgreSQL Command Line Interface (psql)

Start the psql tool by running:
```bash
psql -U postgres
```
You will be prompted to enter the password for the default user (`postgres`). If you haven't set a password yet, you might need to follow the PostgreSQL setup wizard to do so.

### Step 2: Create a New User

Once logged in as the `postgres` user, you can create a new user. For example, let's create a user named `newuser` with a password:
```sql
CREATE USER newuser WITH PASSWORD 'yourpassword';
```
Replace `'yourpassword'` with a strong password of your choice.

### Step 3: Create a New Database

Next, create a new database that this user will have access to. For example, let's create a database named `newdb`:
```sql
CREATE DATABASE newdb;
```

### Step 4: Grant Privileges to the New User on the New Database

To grant all privileges (such as SELECT, INSERT, UPDATE, DELETE) to the new user on the newly created database, use the following command:
```sql
GRANT ALL PRIVILEGES ON DATABASE newdb TO newuser;
```

### Step 5: Connect to the Newly Created Database and Grant Table Privileges

To grant privileges on specific tables within the database, first connect to the `newdb` database:
```sql
\c newdb
```
Now, if you have a table named `mytable`, you can grant all privileges on this table to `newuser`:
```sql
GRANT ALL PRIVILEGES ON TABLE mytable TO newuser;
```

### Step 6: Verify Privileges

To verify that the privileges have been granted correctly, you can log in as the newly created user and check their privileges. Exit from the current psql session by typing `\q` and then start a new psql session using:
```bash
psql -U newuser -d newdb
```
You will need to enter the password for `newuser`. Once logged in, you can run some test queries to ensure that the privileges are correctly assigned.

### Summary

1. Open Command Prompt or PowerShell.
2. Navigate to PostgreSQL's bin folder.
3. Start psql as the postgres user (`psql -U postgres`).
4. Create a new user with `CREATE USER`.
5. Create a new database with `CREATE DATABASE`.
6. Grant privileges on the database to the new user with `GRANT ALL PRIVILEGES ON DATABASE`.
7. Connect to the newly created database and grant table-specific privileges if needed.
8. Verify privileges by logging in as the new user.

This should help you set up a new PostgreSQL user, create a database, and assign the necessary privileges on that database.