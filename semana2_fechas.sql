-- Facturas y total cobrado por mes de cobro.
SELECT DATE_TRUNC('month', fecha_pago) AS mes,
       COUNT(*) AS cant_facturas,
       SUM(monto) AS total
FROM facturas
WHERE fecha_pago IS NOT NULL
GROUP BY mes
ORDER BY mes;

-- Días que tardó en cobrarse cada factura. Desempate con id_factura.
SELECT id_factura, cliente, fecha_pago - fecha AS dias_tardados
FROM facturas
WHERE fecha_pago IS NOT NULL
ORDER BY dias_tardados DESC, id_factura DESC;

-- Promedio de días de cobro por vendedor (solo facturas ya cobradas).
SELECT vendedor,
       ROUND(AVG(fecha_pago - fecha), 2) AS dias_cobro,
       COUNT(*) AS fact_cobradas
FROM facturas
WHERE fecha_pago IS NOT NULL
GROUP BY vendedor
ORDER BY vendedor;

-- Caso gerente: facturas emitidas hace más de 30 días que siguen sin cobrar.
SELECT id_factura, fecha, cliente, monto,
       CURRENT_DATE - fecha AS dias_sin_cobrar
FROM facturas
WHERE fecha_pago IS NULL
  AND fecha < CURRENT_DATE - 30
ORDER BY dias_sin_cobrar DESC;