# sql-ventas

Consultas SQL de práctica sobre datos comerciales ficticios: ventas, facturas, cobranzas y contactos de clientes. Escritas en PostgreSQL como parte de mi camino para trabajar como Data & Reporting Analyst.

El foco no es solo escribir consultas, sino **responder preguntas de negocio y validar que los números sean correctos**.

## Tablas

Todos los datos son ficticios.

| Tabla | Qué contiene | Columnas |
|---|---|---|
| `ventas` | Ventas por vendedor y producto | `id_venta`, `fecha`, `vendedor`, `producto`, `cantidad`, `monto` |
| `facturas` | Facturas emitidas y su cobranza (`fecha_pago` NULL = sin cobrar) | `id_factura`, `fecha`, `cliente`, `vendedor`, `categoria`, `monto`, `fecha_pago` |
| `contactos` | Datos de contacto con formatos de texto inconsistentes, para practicar limpieza | `id`, `nombre`, `email`, `cod_factura` |

## Archivos

| Archivo | Qué muestra |
|---|---|
| `semana1_consultas_basicas.sql` | `SELECT`, `DISTINCT`, `WHERE` (comparaciones, `IN`, `LIKE`, `AND`), `ORDER BY`, `LIMIT`, `IS NULL`, rangos de fechas |
| `semana2_group_by_having.sql` | `GROUP BY`, `COUNT` / `SUM` / `AVG` / `MIN` / `MAX`, `HAVING` y su combinación con `WHERE` |
| `semana2_fechas.sql` | `DATE_TRUNC`, resta de fechas, `CURRENT_DATE`, antigüedad de facturas sin cobrar |
| `semana2_texto.sql` | `TRIM`, `UPPER`, `LOWER`, `LENGTH` para detectar y normalizar datos mal cargados |

## Preguntas de negocio que responden

- ¿Cuánto facturó cada vendedor en octubre y cuál fue su ticket promedio?
- ¿Qué clientes tienen deuda pendiente mayor a 100.000?
- ¿Cuántos días tarda en cobrarse cada factura, y cuál es el promedio por vendedor?
- ¿Qué facturas emitidas hace más de 30 días siguen sin cobrar?
- ¿Cuántos códigos de factura no respetan el formato estándar?

## Cómo validé los resultados

Cada consulta importante tiene un segundo camino de control: un total sin agrupar que coincide con la suma de los subtotales, conteos de filas antes y después de un filtro, o un cálculo a mano con los datos de la tabla.

## Limitaciones

- Los promedios de días de cobro consideran solo las facturas ya cobradas. Las pendientes quedan afuera y pueden subestimar el tiempo real de cobranza.
- Las consultas con `CURRENT_DATE` cambian de resultado según el día en que se ejecutan.
- Los scripts de creación de tablas todavía no están en el repositorio.

## Herramientas

PostgreSQL 18, DBeaver, Git y GitHub.

## Próximos pasos

`JOIN`, subconsultas, CTE, funciones de ventana y un análisis comercial completo sobre el dataset público de e-commerce de Olist.
