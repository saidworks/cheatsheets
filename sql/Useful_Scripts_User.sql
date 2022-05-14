CREATE USER 'saidlearns'@'host' IDENTIFIED BY 'password';
/* https://www.digitalocean.com/community/tutorials/how-to-create-a-new-user-and-grant-permissions-in-mysql */
GRANT ALL PRIVILEGES ON *.* TO 'saidlearns'@'localhost' WITH GRANT OPTION;