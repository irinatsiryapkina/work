CREATE ROLE "wte-admin"  WITH NOSUPERUSER NOCREATEDB NOCREATEROLE NOINHERIT NOLOGIN NOREPLICATION NOBYPASSRLS;
CREATE ROLE "wte-rw"     WITH NOSUPERUSER NOCREATEDB NOCREATEROLE   INHERIT NOLOGIN NOREPLICATION NOBYPASSRLS;
CREATE ROLE "wte-ro"     WITH NOSUPERUSER NOCREATEDB NOCREATEROLE   INHERIT NOLOGIN NOREPLICATION NOBYPASSRLS;
CREATE ROLE "wte-client" WITH NOSUPERUSER NOCREATEDB NOCREATEROLE   INHERIT   LOGIN NOREPLICATION NOBYPASSRLS ENCRYPTED PASSWORD 'OmrmjrFYByK6Ii';

CREATE ROLE "wte-users"  WITH NOSUPERUSER NOCREATEDB NOCREATEROLE   INHERIT NOLOGIN NOREPLICATION NOBYPASSRLS;