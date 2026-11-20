-- Monto mínimo, máximo, promedio y clientes distintos.
SELECT MIN(monto) AS monto_minimo,
       MAX(monto) AS monto_maximo,
       ROUND(AVG(monto), 2) AS promedio,
       COUNT(DISTINCT cliente) AS clientes
FROM facturas;

-- Total facturado por categoría.
SELECT categoria, SUM(monto) AS total_facturado
FROM facturas
GROUP BY categoria
ORDER BY total_facturado DESC;

-- Por cliente: facturas, cobradas y total facturado.
SELECT cliente,
       COUNT(*) AS total_facturas,
       COUNT(fecha_pago) AS fact_pagadas,
       SUM(monto) AS total_facturado
FROM facturas
GROUP BY cliente
ORDER BY total_facturado DESC;

-- Caso gerente: facturación y ticket promedio por vendedor en octubre de 2026.
SELECT vendedor,
       SUM(monto) AS total_facturado,
       ROUND(AVG(monto), 2) AS ticket_promedio
FROM facturas
WHERE fecha >= '2026-10-01' AND fecha < '2026-11-01'
GROUP BY vendedor
ORDER BY total_facturado DESC;

-- HAVING: vendedores con más de 3 facturas.
SELECT vendedor, COUNT(*) AS total_facturas
FROM facturas
GROUP BY vendedor
HAVING COUNT(*) > 3;

-- HAVING: categorías con total facturado mayor a 400.000.
SELECT categoria, SUM(monto) AS total_facturado
FROM facturas
GROUP BY categoria
HAVING SUM(monto) > 400000
ORDER BY total_facturado DESC;

-- HAVING: clientes con al menos 2 facturas cobradas.
SELECT cliente, COUNT(fecha_pago) AS facturas_cobradas
FROM facturas
GROUP BY cliente
HAVING COUNT(fecha_pago) >= 2;

-- Caso gerente: clientes con deuda pendiente mayor a 100.000, de mayor a menor.
SELECT cliente, SUM(monto) AS total_deuda
FROM facturas
WHERE fecha_pago IS NULL
GROUP BY cliente
HAVING SUM(monto) > 100000
ORDER BY total_deuda DESC;

-- Vendedores con deuda pendiente mayor a 100.000.
SELECT vendedor, COUNT(*) AS cant_facturas, SUM(monto) AS total
FROM facturas
WHERE fecha_pago IS NULL
GROUP BY vendedor
HAVING SUM(monto) > 100000;