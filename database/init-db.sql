-- ---------------------------------------------------
-- 1. DECLARACIÓN DE VARIABLES KEYCLOAK
-- ---------------------------------------------------

-- Define el nombre del tablespace
\set tablespace_name 'ts_app_keycloak'
-- Define la ruta donde PostgreSQL almacenará los archivos del tablespace
-- ESTA RUTA DEBE EXISTIR EN EL SISTEMA DE ARCHIVOS DEL SERVIDOR DE BASE DE DATOS
\set tablespace_location '{{ DB_KEYCLOAK_TABLESPACE_LOCATION }}'

-- Define el nombre del nuevo usuario
\set user_name '{{ DB_KEYCLOAK_USER }}'
-- Define la contraseña para el nuevo usuario
\set user_password '{{ DB_KEYCLOAK_PASSWORD }}'
-- Define el nombre de la nueva base de datos
\set db_name '{{ DB_KEYCLOAK_NAME }}'

-- ---------------------------------------------------
-- 2. CREACIÓN DEL TABLESPACE
-- ---------------------------------------------------

-- Crea el TABLESPACE con la ubicación especificada.
-- ¡IMPORTANTE! El directorio debe existir y tener permisos adecuados.
CREATE TABLESPACE :tablespace_name
OWNER postgres -- Se le asigna el superusuario o un administrador como dueño inicial
LOCATION :'tablespace_location';

-- ---------------------------------------------------
-- 3. CREACIÓN DEL USUARIO (ROL)
-- ---------------------------------------------------

-- Crea el nuevo usuario (en PostgreSQL, los usuarios son roles con capacidad de login)
-- PASSWORD: Establece la contraseña, que debe ser segura.
-- NOSUPERUSER: No es un superusuario.
-- NOCREATEDB: No puede crear bases de datos.
-- NOCREATEROLE: No puede crear otros roles.
CREATE ROLE :user_name WITH 
  LOGIN
  PASSWORD :'user_password'
  NOSUPERUSER
  NOCREATEDB
  NOCREATEROLE;
  
-- Opcional: Asignar el tablespace como predeterminado para el nuevo usuario.
-- Los nuevos objetos del usuario usarán este tablespace a menos que se especifique lo contrario.
ALTER ROLE :user_name
SET default_tablespace = :tablespace_name;


-- ---------------------------------------------------
-- 4. CREACIÓN DE LA BASE DE DATOS
-- ---------------------------------------------------

-- Crea la nueva base de datos
-- OWNER: Asigna el nuevo usuario como dueño.
-- TABLESPACE: Asigna el tablespace predeterminado para esta base de datos.
CREATE DATABASE :db_name
  OWNER :user_name
  TABLESPACE = :tablespace_name
  ENCODING = 'UTF8'
  LC_COLLATE = 'es_MX.UTF-8'
  LC_CTYPE = 'es_MX.UTF-8'
  CONNECTION LIMIT = -1;

-- ---------------------------------------------------
-- 5. ASIGNAR PERMISOS AL DUEÑO (Para crear objetos)
-- ---------------------------------------------------

-- Conéctate a la nueva base de datos para modificar sus permisos
\c :db_name

-- El dueño de la BD ya tiene todos los privilegios, pero es buena práctica
-- asegurarle permisos explícitos en el esquema 'public'.
-- El permiso CREATE en el esquema 'public' permite al usuario crear tablas, vistas, etc.

-- REVOKE quita el permiso PUBLIC del esquema public para todos los usuarios.
-- Esto es una buena práctica de seguridad (se hace en la mayoría de las instalaciones).
REVOKE ALL ON SCHEMA public FROM PUBLIC;

-- GRANT otorga el permiso CREATE explícitamente al nuevo usuario.
GRANT ALL ON SCHEMA public TO :user_name;
GRANT CREATE ON SCHEMA public TO :user_name;
GRANT CONNECT ON DATABASE :db_name TO :user_name;

-- ---------------------------------------------------
-- 6. VERIFICACIÓN (Opcional)
-- ---------------------------------------------------

\echo '----------------------------------------------------------'
\echo 'Operaciones completadas:'
\echo TABLESPACE :'tablespace_name' Creado.
\echo USUARIO :'user_name' Creado.
\echo BASE DE DATOS :'db_name' Creada y asignada a :'user_name'.
\echo '----------------------------------------------------------'



-- ---------------------------------------------------
-- 1. DECLARACIÓN DE VARIABLES APP
-- ---------------------------------------------------

-- Define el nombre del tablespace
\set tablespace_name 'ts_app_possatdb'
-- Define la ruta donde PostgreSQL almacenará los archivos del tablespace
-- ESTA RUTA DEBE EXISTIR EN EL SISTEMA DE ARCHIVOS DEL SERVIDOR DE BASE DE DATOS
\set tablespace_location '{{ DB_APP_TABLESPACE_LOCATION }}'

-- Define el nombre del nuevo usuario
\set user_name '{{ DB_APP_USER }}'
-- Define la contraseña para el nuevo usuario
\set user_password '{{ DB_APP_PASSWORD }}'
-- Define el nombre de la nueva base de datos
\set db_name '{{ DB_APP_NAME }}'

-- ---------------------------------------------------
-- 2. CREACIÓN DEL TABLESPACE
-- ---------------------------------------------------

-- Crea el TABLESPACE con la ubicación especificada.
-- ¡IMPORTANTE! El directorio debe existir y tener permisos adecuados.
CREATE TABLESPACE :tablespace_name
OWNER postgres -- Se le asigna el superusuario o un administrador como dueño inicial
LOCATION :'tablespace_location';

-- ---------------------------------------------------
-- 3. CREACIÓN DEL USUARIO (ROL)
-- ---------------------------------------------------

-- Crea el nuevo usuario (en PostgreSQL, los usuarios son roles con capacidad de login)
-- PASSWORD: Establece la contraseña, que debe ser segura.
-- NOSUPERUSER: No es un superusuario.
-- NOCREATEDB: No puede crear bases de datos.
-- NOCREATEROLE: No puede crear otros roles.
CREATE ROLE :user_name WITH 
  LOGIN
  PASSWORD :'user_password'
  NOSUPERUSER
  NOCREATEDB
  NOCREATEROLE;
  
-- Opcional: Asignar el tablespace como predeterminado para el nuevo usuario.
-- Los nuevos objetos del usuario usarán este tablespace a menos que se especifique lo contrario.
ALTER ROLE :user_name
SET default_tablespace = :tablespace_name;


-- ---------------------------------------------------
-- 4. CREACIÓN DE LA BASE DE DATOS
-- ---------------------------------------------------

-- Crea la nueva base de datos
-- OWNER: Asigna el nuevo usuario como dueño.
-- TABLESPACE: Asigna el tablespace predeterminado para esta base de datos.
CREATE DATABASE :db_name
  OWNER :user_name
  TABLESPACE = :tablespace_name
  ENCODING = 'UTF8'
  LC_COLLATE = 'es_MX.UTF-8'
  LC_CTYPE = 'es_MX.UTF-8'
  CONNECTION LIMIT = -1;

-- ---------------------------------------------------
-- 5. ASIGNAR PERMISOS AL DUEÑO (Para crear objetos)
-- ---------------------------------------------------

-- Conéctate a la nueva base de datos para modificar sus permisos
\c :db_name

-- El dueño de la BD ya tiene todos los privilegios, pero es buena práctica
-- asegurarle permisos explícitos en el esquema 'public'.
-- El permiso CREATE en el esquema 'public' permite al usuario crear tablas, vistas, etc.

-- REVOKE quita el permiso PUBLIC del esquema public para todos los usuarios.
-- Esto es una buena práctica de seguridad (se hace en la mayoría de las instalaciones).
REVOKE ALL ON SCHEMA public FROM PUBLIC;

-- GRANT otorga el permiso CREATE explícitamente al nuevo usuario.
GRANT ALL ON SCHEMA public TO :user_name;
GRANT CREATE ON SCHEMA public TO :user_name;
GRANT CONNECT ON DATABASE :db_name TO :user_name;

-- ---------------------------------------------------
-- 6. VERIFICACIÓN (Opcional)
-- ---------------------------------------------------

\echo '----------------------------------------------------------'
\echo 'Operaciones completadas:'
\echo TABLESPACE :'tablespace_name' Creado.
\echo USUARIO :'user_name' Creado.
\echo BASE DE DATOS :'db_name' Creada y asignada a :'user_name'.
\echo '----------------------------------------------------------'

