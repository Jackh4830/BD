-- -----------------------------------------
-- CONSULTAS DEL PROYECTO = 9/10
-- -----------------------------------------


-- #1 K: Lista los menús y lo ordena por su tipo y precio
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

-- #2 K: Menús que sean de tamaño personal y menores de 10 mil pesos
SELECT 
	RES_nombre AS Restaurante, 
	MEN_nombre AS Menú, 
	MEN_precio AS Precio, 
	MEN_descripcion AS Descripción 
FROM menu JOIN restaurante 
WHERE RES_nit=RESTAURANTE_RES_nit 
	AND  MEN_tamano='NORMAL' AND MEN_precio<=10000
GROUP BY RES_nombre;

-- #3 K: Menús que contengan arroz en su descripción
SELECT 
	RES_nombre AS Restaurante, 
	MEN_nombre AS Menú, 
	MEN_precio AS Precio, 
	MEN_descripcion AS Descripción 
FROM menu JOIN restaurante
WHERE RES_nit=RESTAURANTE_RES_nit
	AND MEN_descripcion LIKE '%arroz%'
GROUP BY RES_nombre;

-- #4 K: SE ARREGLA EL ERROR DE FERNANDO: Consulta del nombre de los restaurante que ofrecen COMBOS
SELECT RES_nombre 
FROM restaurante JOIN menu 
WHERE RES_nit IN
	(SELECT RESTAURANTE_RES_nit FROM menu WHERE MEN_tipo="COMBO")
    AND RESTAURANTE_RES_nit=RES_nit;


-- #5 F: Conuslta el nombre de un menu y su PRECIO, cuando el precio del menu está entre 10000 y 20000
# Se puede modificar el rango del precio, considerando un PA que le ingrese un valor minimo y uno maximo
SELECT 
	MEN_nombre AS Nombre,
	RES_nombre AS restaurante,
	MEN_precio AS Precio,
	MEN_tipo AS Tipo,
	MEN_tamano AS Tamaño,
	MEN_descripcion AS Descripción
FROM MENU JOIN RESTARUTANTE 
WHERE RESTAURANTE_RES_nit=RES_nit AND MEN_precio>10000 AND MEN_precio<20000;

-- #6 F: Consulta el nombre de un menú, su precio y descripcion, cuando el nombre del restaurante es KFC,
# Se puede modificar el nombre del restaurante con un PA

SELECT MEN_nombre AS Nombre, 
	MEN_precio AS Precio,
	MEN_tipo AS Tipo,
	MEN_tamano AS Tamaño,
	MEN_descripcion AS Descripción,
	CCO_nombre AS `Centro comercial`
FROM MENU JOIN `CENTRO COMERCIAL`
WHERE CCO_id= (SELECT CENTRO COMERCIAL_CCO_id FROM RESTAURANTE WHERE RES_nombre="KFC")
AND RESTAURANTE_RES_nit=(SELECT RES_nit FROM RESTAURANTE WHERE RES_nombre="KFC");

-- #7 F: consulta el nombre de un menu, su precio y descripcion, cuando el tipo de menu es COMBO
SELECT MEN_nombre AS Nombre,
 RES_nombre AS restaurante,
 MEN_precio AS Precio,
 MEN_tipo AS Tipo,
 MEN_tamano AS Tamaño,
 MEN_descripcion AS Descripción 
FROM MENU JOIN RESTAURANTE WHERE RESTAURANTE_RES_nit=RES_nit 
AND MEN_tipo="COMBO";

-- #8 F: consulta los empleados del restaurante KFC
# Se puede modificar el nombre del restaurante con un PA

SELECT 
	EMP_id AS cc, 
	EMP_nombre AS Nombre, 
	EMP_cargo AS Cargo
FROM EMPLEADO JOIN RESTAURANTE
WHERE RESTAURANTE_RES_nit=(SELECT RES_nit FROM RESTAURANTE WHERE RES_nombre="KFC");

-- #9 F: consulta el NumMesa de un  pedido 
SELECT TUR_numMesa AS `Numero de mesa` 
FROM TURNO JOIN PEDIDO
WHERE `DETALLE PEDIDO_ PEDIDO_PED_id` IN (SELECT PED_id FROM PEDIDO);