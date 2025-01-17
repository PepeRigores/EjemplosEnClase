\! echo "Borramos los roles y usuarios anteriores"
\! echo ------------------------------------------

REVOKE ALL PRIVILEGES ON ALL TABLES IN SCHEMA public FROM read_only;
REVOKE ALL PRIVILEGES ON ALL SEQUENCES IN SCHEMA public FROM read_only;
REVOKE ALL PRIVILEGES ON ALL FUNCTIONS IN SCHEMA public FROM read_only;

REVOKE ALL PRIVILEGES ON ALL TABLES IN SCHEMA public FROM read_write;
REVOKE ALL PRIVILEGES ON ALL SEQUENCES IN SCHEMA public FROM read_write;
REVOKE ALL PRIVILEGES ON ALL FUNCTIONS IN SCHEMA public FROM read_write;

\! echo
\! echo "Borramos los roles y usuarios"
\! echo -------------------------------

DROP USER IF EXISTS readonly_one;
DROP USER IF EXISTS readonly_two;
DROP USER IF EXISTS readwrite_one;
DROP USER IF EXISTS readwrite_two;
DROP ROLE IF EXISTS read_only;
DROP ROLE IF EXISTS read_write;

\! echo
\! echo "Creamos los roles"
\! echo -------------------

CREATE ROLE read_only;
CREATE ROLE read_write;

GRANT CONNECT ON DATABASE usuarios TO read_only;
GRANT CONNECT ON DATABASE usuarios TO read_write;

GRANT USAGE ON SCHEMA public TO read_only;
GRANT USAGE ON SCHEMA public TO read_write;

GRANT SELECT ON ALL TABLES IN SCHEMA public TO read_only;
GRANT SELECT ON ALL SEQUENCES IN SCHEMA public TO read_only;
GRANT EXECUTE ON ALL FUNCTIONS IN SCHEMA public TO read_only;

GRANT SELECT, INSERT, UPDATE, DELETE ON ALL TABLES IN SCHEMA public TO read_write;
GRANT USAGE, SELECT, UPDATE ON ALL SEQUENCES IN SCHEMA public TO read_write;
GRANT EXECUTE ON ALL FUNCTIONS IN SCHEMA public TO read_write;

ALTER DEFAULT PRIVILEGES IN SCHEMA public GRANT SELECT ON TABLES TO read_only;
ALTER DEFAULT PRIVILEGES IN SCHEMA public GRANT SELECT, INSERT, UPDATE, DELETE ON TABLES TO read_write;

\! echo
\! echo "Creamos los usuarios"
\! echo ----------------------

CREATE USER readonly_one WITH PASSWORD 'readOnly1';
CREATE USER readonly_two WITH PASSWORD 'readOnly2';

GRANT read_only TO readonly_one;
GRANT read_only TO readonly_two;

CREATE USER readwrite_one WITH PASSWORD 'readWrite1';
CREATE USER readwrite_two WITH PASSWORD 'readWrite2';

GRANT read_write TO readwrite_one;
GRANT read_write TO readwrite_two;

\du