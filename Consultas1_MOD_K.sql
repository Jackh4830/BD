-- -----------------------------------------
-- CONSULTAS DEL PROYECTO = 4/5
-- -----------------------------------------


-- #1 Lista los menús y lo ordena por su tipo y precio
SET @row=0;-- se debe ejecutar primero
SELECT 
	(@row:=@row+1) AS Nro, RES_nombre AS Restaurante, 
	MEN_nombre AS Menú, 
	MEN_precio AS Precio, 
	MEN_tamano AS Tamaño, 
	MEN_tipo AS Tipo, 
	MEN_descripcion AS Descripción
FROM menu JOIN restaurante 
WHERE RES_nit=RESTAURANTE_RES_nit
ORDER BY 4 ASC, 3 ASC;

-- #2 Menús que sean de tamaño personal y menores de 10 mil pesos
SELECT 
	RES_nombre AS Restaurante, 
	MEN_nombre AS Menú, 
	MEN_precio AS Precio, 
	MEN_descripcion AS Descripción 
FROM menu JOIN restaurante 
WHERE RES_nit=RESTAURANTE_RES_nit 
	AND  MEN_tamano='NORMAL' AND MEN_precio<=10000
GROUP BY RES_nombre;

-- #3 Menús que contengan arroz en su descripción
SELECT 
	RES_nombre AS Restaurante, 
	MEN_nombre AS Menú, 
	MEN_precio AS Precio, 
	MEN_descripcion AS Descripción 
FROM menu JOIN restaurante
WHERE RES_nit=RESTAURANTE_RES_nit
	AND MEN_descripcion LIKE '%arroz%'
GROUP BY RES_nombre;

-- #4 SE ARREGLA EL ERROR DE FERNANDO: Consulta del nombre de los restaurante que ofrecen COMBOS
SELECT RES_nombre 
FROM restaurante JOIN menu 
WHERE RES_nit IN
	(SELECT RESTAURANTE_RES_nit FROM menu WHERE MEN_tipo="COMBO")
    AND RESTAURANTE_RES_nit=RES_nit;