-- ============================================================
-- Semana 1: consultas finales sobre la tabla ventas
-- Base: postgres | Motor: PostgreSQL 18.6
-- Columnas: id_venta, fecha, vendedor, producto, cantidad, monto
-- ============================================================


-- ------------------------------------------------------------
-- Sesión 1: SELECT, DISTINCT, BETWEEN
-- ------------------------------------------------------------

-- ¿Qué fecha, vendedor y monto tuvo cada venta?
SELECT fecha, vendedor, monto
FROM ventas;

-- ¿Qué producto y cuántas unidades se vendieron en cada venta?
SELECT producto, cantidad
FROM ventas;

-- El gerente pregunta: ¿qué productos vendimos en octubre, sin repetir?
-- (rango con >= y <: incluye el inicio, excluye el fin)
SELECT DISTINCT producto
FROM ventas
WHERE fecha >= '2026-10-01'
  AND fecha <  '2026-11-01';

-- Validación: ¿el filtro de fechas deja afuera alguna fila?
-- Si los dos conteos coinciden (8 y 8), no se excluyó nada.
SELECT COUNT(*) FROM ventas;

SELECT COUNT(*)
FROM ventas
WHERE fecha >= '2026-10-01'
  AND fecha <  '2026-11-01';


-- ------------------------------------------------------------
-- Sesión 2: WHERE (comparaciones, IN, LIKE, AND)
-- ------------------------------------------------------------

-- ¿Qué ventas superaron los $100.000? (esperadas: 4 filas)
SELECT id_venta, producto, monto
FROM ventas
WHERE monto > 100000;

-- ¿Qué ventas hicieron Lucía o Sofía? (esperadas: 5 filas)
SELECT id_venta, vendedor, fecha, producto, cantidad, monto
FROM ventas
WHERE vendedor IN ('Lucía', 'Sofía');

-- ¿Qué productos (sin repetir) empiezan con "M"? (esperadas: 2 filas)
SELECT DISTINCT producto
FROM ventas
WHERE producto LIKE 'M%';

-- ¿Qué ventas de Martín o Lucía fueron de 2 unidades o más? (esperadas: 4 filas)
SELECT id_venta, vendedor, producto, cantidad, monto
FROM ventas
WHERE vendedor IN ('Martín', 'Lucía')
  AND cantidad >= 2;

-- El gerente pregunta: ¿qué ventas de Notebook o Monitor superaron
-- los $500.000 entre el 1 y el 7 de octubre inclusive? (esperadas: 3 filas)
SELECT id_venta, fecha, producto, monto
FROM ventas
WHERE producto IN ('Notebook', 'Monitor')
  AND monto > 500000
  AND fecha >= '2026-10-01'
  AND fecha <  '2026-10-08';


-- ------------------------------------------------------------
-- Sesión 3: ORDER BY, LIMIT, IS NULL
-- ------------------------------------------------------------

-- ¿Cuáles son las ventas ordenadas de la más reciente a la más antigua?
SELECT id_venta, fecha, producto, monto
FROM ventas
ORDER BY fecha DESC;

-- ¿Qué vendedor tuvo qué monto, de menor a mayor?
SELECT vendedor, monto
FROM ventas
ORDER BY monto ASC;

-- ¿Cuáles son las 2 ventas con mayor cantidad de unidades?
-- (id_venta desempata para que el resultado sea siempre el mismo)
SELECT id_venta, fecha, producto, cantidad
FROM ventas
ORDER BY cantidad DESC, id_venta
LIMIT 2;

-- ¿Cuáles son las ventas de Martín, de mayor a menor monto? (esperadas: 3 filas)
SELECT id_venta, producto, monto, vendedor
FROM ventas
WHERE vendedor = 'Martín'
ORDER BY monto DESC;

-- El gerente pregunta: ¿cuáles fueron las 3 ventas más chicas de octubre
-- y quién las hizo? (esperadas: ids 2, 8 y 6)
SELECT id_venta, producto, monto, cantidad, vendedor, fecha
FROM ventas
WHERE fecha >= '2026-10-01'
  AND fecha <  '2026-11-01'
ORDER BY monto ASC, id_venta
LIMIT 3;

-- ¿Hay ventas sin monto cargado? (en esta tabla devuelve 0 filas)
SELECT id_venta, producto, monto
FROM ventas
WHERE monto IS NULL;


-- ------------------------------------------------------------
-- Mini evaluación de la Semana 1
-- ------------------------------------------------------------

-- ¿Qué ventas fueron de más de $50.000 y de 1 sola unidad? (esperadas: ids 1 y 4)
SELECT id_venta, producto, monto, cantidad
FROM ventas
WHERE monto > 50000
  AND cantidad = 1;

-- ¿Qué ventas hicieron Sofía o Martín? (esperadas: 5 filas)
SELECT id_venta, vendedor, producto, monto, cantidad
FROM ventas
WHERE vendedor IN ('Sofía', 'Martín');

-- ¿Cuáles son las 2 ventas de mayor monto? (esperadas: ids 5 y 1)
SELECT vendedor, producto, monto
FROM ventas
ORDER BY monto DESC, id_venta
LIMIT 2;

-- Versión corregida: ¿qué montos tuvo Lucía, de mayor a menor?
-- (errores originales: faltaba la coma entre columnas y las comillas en 'Lucía')
SELECT vendedor, monto
FROM ventas
WHERE vendedor = 'Lucía'
ORDER BY monto DESC;

-- El gerente pregunta: ¿qué vendedores vendieron más de $600.000
-- en una sola venta durante octubre? (esperadas: Lucía y Martín)
SELECT DISTINCT vendedor
FROM ventas
WHERE monto > 600000
  AND fecha >= '2026-10-01'
  AND fecha <  '2026-11-01';