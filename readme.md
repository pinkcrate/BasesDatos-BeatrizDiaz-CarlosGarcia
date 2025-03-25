Beatriz Rebeca Díaz Gómez y Carlos Andres Garcia Molina
pinkcrate y CGarcia1411


SCRIPT CREACIÓN BASE DE DATOS

	https://github.com/pinkcrate/BasesDatos-BeatrizDiaz-CarlosGarcia/blob/main/ScriptCreate.sql

Links a Scripts de llenado de datos:

	https://github.com/pinkcrate/BasesDatos-BeatrizDiaz-CarlosGarcia/blob/main/ScriptCurrencies.sql
	https://github.com/pinkcrate/BasesDatos-BeatrizDiaz-CarlosGarcia/blob/main/ScriptIA.sql
	https://github.com/pinkcrate/BasesDatos-BeatrizDiaz-CarlosGarcia/blob/main/ScriptInsertCountries.sql
	https://github.com/pinkcrate/BasesDatos-BeatrizDiaz-CarlosGarcia/blob/main/ScriptInsertLogs.sql
	https://github.com/pinkcrate/BasesDatos-BeatrizDiaz-CarlosGarcia/blob/main/ScriptInsertUsers.sql
	https://github.com/pinkcrate/BasesDatos-BeatrizDiaz-CarlosGarcia/blob/main/ScriptMediaFiles.sql
	https://github.com/pinkcrate/BasesDatos-BeatrizDiaz-CarlosGarcia/blob/main/ScriptRolesPermissions.sql

Links a Consultas:

	https://github.com/pinkcrate/BasesDatos-BeatrizDiaz-CarlosGarcia/blob/main/Query4.1.sql
	https://github.com/pinkcrate/BasesDatos-BeatrizDiaz-CarlosGarcia/blob/main/Query4.2.sql
	https://github.com/pinkcrate/BasesDatos-BeatrizDiaz-CarlosGarcia/blob/main/Query4.3.1.sql
	https://github.com/pinkcrate/BasesDatos-BeatrizDiaz-CarlosGarcia/blob/main/Query4.3.2.sql 
	https://github.com/pinkcrate/BasesDatos-BeatrizDiaz-CarlosGarcia/blob/main/Query4.4.sql 


4.1 : listar todos los usuarios de la plataforma que esten activos con su nombre completo, email, país de procedencia, y el total de cuánto han pagado en subscripciones desde el 2024 hasta el día de hoy, dicho monto debe ser en colones

| Name     | Last Name | Email                    | Country    | Total Paid (₡) |
|----------|-----------|--------------------------|------------|---------------:|
| Carlos   | García    | cgarcia@gmail.com        | Costa Rica |           5.14 |
| Fernanda | Torres    | ftorres@hotmail.com      | Costa Rica |          30.00 |
| Manuel   | Silva     | msilva@hotmail.com       | Costa Rica |          20.00 |
| María    | Rodríguez | mrodriguez@outlook.com   | Costa Rica |          49.99 |
| Andrés   | Díaz      | adiaz@outlook.com        | Costa Rica |          19.75 |
| Beatriz  | Diaz      | beccaDiaz@gmail.com      | Costa Rica |          19.07 |
| Juan     | Martínez  | jmartinez@yahoo.com      | Costa Rica |          67.00 |
| Camila   | Vargas    | cvargas@gmail.com        | Costa Rica |          48.14 |
| Ana      | López     | alopez@gmail.com         | Costa Rica |           7.50 |
| Ricardo  | Morales   | rmorales@yahoo.com       | Costa Rica |          99.99 |
| Luis     | Hernández | lhernandez@hotmail.com   | Costa Rica |         111.74 |
| Isabel   | Castro    | icastro@gmail.com        | Costa Rica |          25.00 |
| Sofía    | Gómez     | sgomez@gmail.com         | Costa Rica |          15.99 |
| Gabriel  | Mendoza   | gmendoza@hotmail.com     | Costa Rica |          96.75 |
| Diego    | Pérez     | dperez@outlook.com       | Costa Rica |          15.75 |
| Daniela  | Rojas     | drojas@outlook.com       | Costa Rica |           9.99 |
| Valeria  | Sánchez   | vsanchez@yahoo.com       | Panama     |          27.82 |
| Oscar    | Guerrero  | oguerrero@gmail.com      | Panama     |           5.99 |
| Jorge    | Ramírez   | jramirez@gmail.com       | Panama     |          10.00 |
| Lucía    | Flores    | lflores@yahoo.com        | Panama     |          12.50 |




4.2  listar todas las personas con su nombre completo e email, los cuales le queden menos de 15 días para tener que volver a pagar una nueva subscripción

| Name   | Last Name| Email               |
|--------|----------|---------------------|
| Camila | Vargas   | cvargas@gmail.com   |
| Jorge  | Ramírez  | jramirez@gmail.com  |
| Ana    | López    | alopez@gmail.com    |



4.3 un ranking del top 15 de usuarios que más uso le dan a la aplicación y el top 15 que menos uso le dan a la aplicación 

4.3.1 Descendente:

| ID | Name     | Last Name | Email                    | Hrs Spent |
|----|----------|-----------|--------------------------|----------:|
| 12 | Camila   | Vargas    | cvargas@gmail.com        |      2354 |
| 13 | Ricardo  | Morales   | rmorales@yahoo.com       |       894 |
| 17 | Oscar    | Guerrero  | oguerrero@gmail.com      |       798 |
|  3 | Juan     | Martínez  | jmartinez@yahoo.com      |       789 |
|  7 | Diego    | Pérez     | dperez@outlook.com       |       742 |
| 14 | Isabel   | Castro    | icastro@gmail.com        |       654 |
|  2 | María    | Rodríguez | mrodriguez@outlook.com   |       456 |
|  4 | Ana      | López     | alopez@gmail.com         |       456 |
|  6 | Sofía    | Gómez     | sgomez@gmail.com         |       456 |
|  9 | Jorge    | Ramírez   | jramirez@gmail.com       |       456 |
| 10 | Fernanda | Torres    | ftorres@hotmail.com      |       456 |
| 15 | Gabriel  | Mendoza   | gmendoza@hotmail.com     |       255 |
| 11 | Andrés   | Díaz      | adiaz@outlook.com        |       158 |
|  1 | Carlos   | García    | cgarcia@gmail.com        |       156 |
|  5 | Luis     | Hernández | lhernandez@hotmail.com   |       123 |


4.3.2 Ascendente:

| ID | name       | last_name | email                   |hrs_spent|
|----|------------|-----------|-------------------------|---------|
| 16 | Daniela    | Rojas     | drojas@outlook.com      |   8     |
| 18 | Lucía      | Flores    | lflores@yahoo.com       |   12    |
| 19 | Manuel     | Silva     | msilva@hotmail.com      |   36    |
| 20 | Beatriz    | Diaz      | beccaDiaz@gmail.com     |   56    |
| 5  | Luis       | Hernández | lhernandez@hotmail.com  |   123   |
| 8  | Valeria    | Sánchez   | vsanchez@yahoo.com      |   123   |
| 1  | Carlos     | García    | cgarcia@gmail.com       |   156   |
| 11 | Andrés     | Díaz      | adiaz@outlook.com       |   158   |
| 15 | Gabriel    | Mendoza   | gmendoza@hotmail.com    |   255   |
| 2  | María      | Rodríguez | mrodriguez@outlook.com  |   456   |
| 4  | Ana        | López     | alopez@gmail.com        |   456   |
| 6  | Sofía      | Gómez     | sgomez@gmail.com        |   456   |
| 9  | Jorge      | Ramírez   | jramirez@gmail.com      |   456   |
| 10 | Fernanda   | Torres    | ftorres@hotmail.com     |   456   |
| 14 | Isabel     | Castro    | icastro@gmail.com       |   654   |




4.4 determinar cuáles son los análisis donde más está fallando la AI, encontrar los casos, situaciones, interpretaciones, halucinaciones o errores donde el usuario está teniendo más problemas en hacer que la AI determine correctamente lo que se desea hacer, rankeando cada problema de mayor a menor cantidad de ocurrencias entre un rango de fechas

4.4
|   ID   | Error Code | Description                        |
|--------|------------|------------------------------------|
| 69     | 309        | Datos inconsistentes               |
| 68     | 401        | Transacción rechazada              |
| 67     | 210        | Validación fallida                 |
| 66     | 502        | Error de conexión                  |
| 65     | 301        | Formato inválido                   |
| 64     | 503        | Timeout de sesión                  |
| 63     | 207        | Banco no reconocido                |
| 62     | 410        | Saldo insuficiente                 |
| 61     | 305        | Token expirado                     |
| 60     | 201        | Error en autenticación             |
| 54     | 253        | Formato JSON inválido              |
| 53     | 250        | Error en caché                     |
| 52     | 901        | Sesión duplicada                   |
| 51     | 241        | Fallo en notificación              |
| 50     | 238        | Error en red                       |
| 49     | 512        | Tarjeta bloqueada                  |
| 48     | 203        | Validación KYC requerida           |
| 47     | 199        | Error en encriptación              |
| 46     | 186        | Configuración corrupta             |
| 45     | 123        | Dispositivo no reconocido          |
| 44     | 160        | Error en geolocalización           |
| 43     | 512        | Límite diario excedido             |
| 42     | 114        | Formato de fecha inválido          |
| 41     | 111        | Error en firma digital             |
| 40     | 308        | API no disponible                  |
| 39     | 1205       | Validación de seguridad fallida    |
| 38     | 112        | Error en base de datos             |
| 37     | 102        | Plantilla no encontrada            |
| 36     | 901        | Sesión expirada                    |
| 35     | 815        | Error en conversión de moneda      |
| 34     | 512        | Saldo insuficiente                 |
| 33     | 701        | Autenticación fallida              |

