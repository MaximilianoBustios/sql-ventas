-- Email en minúscula y sin espacios en los bordes.
SELECT id, LOWER(TRIM(email)) AS email_minuscula
FROM contactos;

-- Código de factura normalizado. "caracteres" mide el código original (sirve de validación).
SELECT id,
       UPPER(TRIM(cod_factura)) AS codigo_limpio,
       LENGTH(cod_factura) AS caracteres
FROM contactos;

-- Contactos con espacios sobrantes en el nombre.
SELECT id, nombre, email, cod_factura
FROM contactos
WHERE LENGTH(nombre) - LENGTH(TRIM(nombre)) > 0;

-- Caso gerente: códigos que no respetan el formato estándar (mayúsculas y sin espacios).
SELECT id, cod_factura
FROM contactos
WHERE UPPER(TRIM(cod_factura)) <> cod_factura;

SELECT COUNT(*) AS filas_no_estandar
FROM contactos
WHERE UPPER(TRIM(cod_factura)) <> cod_factura;