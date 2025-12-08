# integrator

## Notes
Giovanni Gomez Castellanos - Posicion Satelital

Amanda Sofia Nuñez Castellanos
Juan M
Edgar



Prospecto para renta de servidores

Configuracion

Excalidraw

Frontend con Angular 20

Spring Boot Java 21

PostgreSQL 17

Identidades de usuario Keycloak 23 / 26

Un servidor en forma

Ubuntu Server en una maquina virtual

Gitlab

Venta e instalacion de dispositivos GPS para rastreo de vehículos.

Administración Interna

Terraform o Ansible



hostdime

godaddy

google space

dns

############################################

## Steps

1. Generar estructura del proyecto.
1.1. Generar estructura proyecto backend
1.2. Generar estructura proyecto frontend
1.3. Generar estructura de identity manager
1.4. Generar estructura de base de datos
1.5. Generar estructura de proxy
2. Instalacion de dependencias de cada componente.
2.1 Instalación de docker (1h)
2.2 Instalación de python (1h)
2.3 Instalación de ansible (1h)
3. Generación de playbook para generacion de imagenes.
3.1 Script para generación de imagen de base de datos (2h)
3.2 Script para generación de imagen de entity manager (12h)
3.3 Generación de docker-compose para levantar el proyecto
3.4 Configurar base de datos (2h)
3.5 COnfigurar backend (2h)
3.6 Configurar frontend (2h)
3.7 Ejecutar en ambiente local
3.8 Configurar keycloak (2h)
3.9 Tuning creacion database (8h)



## Instalación de ansible

### Prerrequisitos
Python 3.12+

```bash
python3 -m venv venv
source venv/bin/activate
pip install -r requirements.txt
ansible --version
```


## Generación de Imagenes Docker

### Prerrequisitos
Docker 29.0.1 o superior
Ansible 2.20.0 o superior

```bash
ansible-playbook playbook.yml -e @vars_produccion.yml
```


Generar certificados con certbot

https://certbot.eff.org/instructions?ws=nginx&os=pip




Para agregar nuevos scripts de inicializacion de base de datos
1. Agregar el script en el playbook.yml
2. Agregar el script en el docker-compose.yml en la definicion del servicio db


Para que la imagen del frontend compilara en modo productivo
se ajusto el archivo ps-frontend-app/angular.json

```bash
diff --git a/ps-frontend-app/angular.json b/ps-frontend-app/angular.json
index 5b1c0c1..c305415 100644
--- a/ps-frontend-app/angular.json
+++ b/ps-frontend-app/angular.json
@@ -39,13 +39,13 @@
               "budgets": [
                 {
                   "type": "initial",
-                  "maximumWarning": "500kB",
-                  "maximumError": "1MB"
+                  "maximumWarning": "2MB",
+                  "maximumError": "3MB"
                 },
                 {
                   "type": "anyComponentStyle",
-                  "maximumWarning": "4kB",
-                  "maximumError": "8kB"
+                  "maximumWarning": "6kB",
+                  "maximumError": "10kB"
                 }
               ],
               "outputHashing": "all"
@@ -94,5 +94,8 @@
         }
       }
     }
+  },
+  "cli": {
+    "analytics": false
   }
 }
```

ps-backend-app/src/main/java/mx/posicionsatelital/backend/config/CorsConfig.java