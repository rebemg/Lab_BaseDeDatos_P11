# Práctica 11
Rebeca Moreno González

## Objetivo
Comprender cómo los índices mejoran el rendimiento de las consultas, cómo analizar y optimizar sentencias SQL y qué estrategias utilizar para obtener tiempos de respuesta óptimos.

## Decisiones

En esta práctica utilicé PostgreSQL para revisar el rendimiento de una base de datos mediante el uso de índices. Para comenzar, creé diferentes tablas relacionadas, como empleado, departamento, cliente, producto, pedido, detalle_pedido e inventario. Después agregué datos de prueba para representar el funcionamiento de una pequeña empresa.

Una vez que tuve la información, revisé las consultas que se utilizaban con mayor frecuencia e identifiqué las columnas en las que sería conveniente implementar índices. Entre ellas estaban salario, puesto, nombre, fecha, cliente_id, producto_id y stock, ya que se utilizan en búsquedas, filtros y relaciones entre tablas.

Para evaluar los resultados utilicé EXPLAIN ANALYZE, una herramienta que permite observar cómo PostgreSQL ejecuta las consultas y qué planes de ejecución utiliza. Finalmente, ejecuté VACUUM ANALYZE para actualizar las estadísticas de la base de datos y proporcionar información actualizada al optimizador.

## Pruebas realizadas

**Para la actividad:**

- Creé las tablas empleado, departamento, cliente, producto, pedido, detalle_pedido e inventario.
- Agregué registros de prueba para representar una pequeña base de datos empresarial.
- Revisé las consultas más utilizadas para encontrar posibles mejoras de rendimiento.
- Implementé índices en columnas que participan frecuentemente en búsquedas y relaciones.
- Utilicé EXPLAIN ANALYZE para comparar los planes de ejecución antes y después de crear los índices.
- Realicé consultas para buscar empleados según su salario y puesto.
- Consulté los pedidos aplicando condiciones sobre las fechas.
- Probé relaciones mediante INNER JOIN entre las tablas cliente y pedido.
- Realicé consultas para relacionar productos con sus detalles de pedido.
- Busqué registros de inventario utilizando condiciones sobre el stock.
- Ejecuté VACUUM ANALYZE para actualizar las estadísticas de las tablas.
- Revisé los planes de ejecución seleccionados por PostgreSQL.

**Para el reto**

Al revisar los resultados comprobé que los índices se habían creado correctamente y estaban disponibles para que PostgreSQL pudiera utilizarlos. Sin embargo, observé que la mayoría de las consultas seguían utilizando Seq Scan (escaneo secuencial).

Esto sucedió porque las tablas tenían muy pocos registros, por lo que PostgreSQL consideró que recorrer todos los datos era más rápido y tenía un menor costo que acceder a ellos mediante los índices.

Con estas pruebas pude identificar que los índices tendrían un mayor impacto al trabajar con una cantidad más grande de registros. Aunque en esta práctica no se observaron mejoras importantes en el rendimiento, su implementación ayudará a que la base de datos pueda manejar un mayor volumen de información en el futuro.

## Errores

Durante la práctica encontré que el registro de Ana Torres estaba duplicado en la tabla empleado, lo que ocasionaba que algunas consultas mostraran información repetida. Para solucionarlo eliminé el registro duplicado y volví a realizar las pruebas. De esta manera, los resultados coincidieron con los datos que esperaba obtener.

Otro detalle que me llamó la atención fue que PostgreSQL seguía utilizando Seq Scan incluso después de haber creado los índices. Al principio pensé que algo había salido mal, pero después entendí que esto se debía a que las tablas tenían muy pocos registros y que, para el optimizador, recorrerlas completas era una mejor opción.

## Conclusión

Con esta práctica aprendí a crear índices en PostgreSQL y a comprobar su funcionamiento utilizando EXPLAIN ANALYZE. También pude entender mejor cómo el optimizador decide la manera más conveniente de ejecutar una consulta dependiendo de la cantidad de información y del costo de cada operación. Me pareció interesante comprobar que crear índices no significa que PostgreSQL siempre los vaya a utilizar, ya que también toma en cuenta las características de los datos. Aunque en este ejercicio no se notaron grandes mejoras por el tamaño de las tablas, comprendí que los índices son importantes para mantener un buen rendimiento cuando una base de datos comienza a crecer.
