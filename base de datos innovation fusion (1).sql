-- Crear la base de datos
CREATE DATABASE Innovation_Fusion ;
USE Innovation_Fusion;

-- -----------------------------------------------------
-- MÓDULO DE GESTIÓN DE USUARIOS
-- -----------------------------------------------------

-- Tabla tipo_de_documento
CREATE TABLE tipo_de_documento (
idTipoDeDocumento INT PRIMARY KEY NOT NULL AUTO_INCREMENT,
nombreTipoDeDocumento VARCHAR(45) NOT NULL
);

-- Tabla rol
CREATE TABLE rol (
  idRol INT PRIMARY KEY NOT NULL AUTO_INCREMENT,
  nombreRol ENUM('administrador', 'cliente') NOT NULL
) ;

-- Tabla estado_usuario
CREATE TABLE estado_usuario (
  idestado_usuario INT PRIMARY KEY NOT NULL AUTO_INCREMENT,
  nombre_Estado_usuario VARCHAR(45) NOT NULL
) ;

-- Tabla usuario
CREATE TABLE Usuario (
  idUsuario INT PRIMARY KEY NOT NULL AUTO_INCREMENT,
  numeroDocumento INT NOT NULL,
  nombreUsuario VARCHAR(45) NOT NULL,
  primerApellido VARCHAR(45) NOT NULL,
  segundoApellido VARCHAR(45) NULL,
  telefono VARCHAR(45) NOT NULL,
  contraseña VARCHAR(45) NULL,
  correoElectronico VARCHAR(45) NOT NULL,
  direccion VARCHAR(45) NOT NULL,
  idRol INT,
  idTipoDeDocumento INT,
  idestado_usuario INT,
  FOREIGN KEY (idRol) REFERENCES rol( idRol),
  FOREIGN KEY (idTipoDeDocumento) REFERENCES tipo_de_documento(idTipoDeDocumento),
  FOREIGN KEY (idestado_usuario) REFERENCES estado_usuario(idestado_usuario)
) ;

-- -----------------------------------------------------
-- MÓDULO DE PROMOCIONES Y DESCUENTOS
-- -----------------------------------------------------

-- Tabla colección
CREATE TABLE colección (
  idcolección INT NOT NULL AUTO_INCREMENT,
  nombre VARCHAR(45) NOT NULL,
  descripción  VARCHAR(45) NOT NULL,
  fechaCreacion DATE NULL,
  idUsuario INT,
  FOREIGN KEY (idUsuario) REFERENCES Usuario(idUsuario)
) ;

-- Tabla promoción
CREATE TABLE promoción (
  idpromocion INT PRIMARY KEY NOT NULL AUTO_INCREMENT,
  codigo_promocion INT NOT NULL,
  descuento INT NOT NULL,
  fecha_inicio VARCHAR(45) NOT NULL,
  fecha_fin  VARCHAR(45) NOT NULL
) ;

-- Tabla producto_promoción
CREATE TABLE producto_promoción (
  idProducto INT,
  idcategoria INT,
  idtipoProducto INT,
  idInventario INT,
  idProveedor INT,
  idcarrito INT,
  idpromocion INT,
  FOREIGN KEY (idProducto) REFERENCES producto(idProducto),
  FOREIGN KEY (idcategoria) REFERENCES categoría(idcategoria),
  FOREIGN KEY (idtipoProducto) REFERENCES tipoProducto(idtipoProducto),
  FOREIGN KEY (idInventario) REFERENCES proveedor( idInventario),
  FOREIGN KEY (idProveedor) REFERENCES proveedor(idProveedor),
  FOREIGN KEY (idcarrito) REFERENCES carrito(idcarrito),
  FOREIGN KEY (idpromocion) REFERENCES promoción(idpromocion)
) ;

-- -----------------------------------------------------
-- MÓDULO DE ADMINISTRADOR
-- -----------------------------------------------------

-- Tabla categoría
CREATE TABLE categoría (
  idcategoria INT PRIMARY KEY NOT NULL AUTO_INCREMENT,
  nombrecategoria  VARCHAR(45) NOT NULL
) ;

-- Tabla subCategorias
CREATE TABLE subCategorias (
  idSubCategorias INT PRIMARY KEY NOT NULL AUTO_INCREMENT,
  nombreSubCategorias VARCHAR(45) NOT NULL,
  idcategoria INT,
  FOREIGN KEY (idcategoria) REFERENCES categoría( idcategoria)
) ;

-- Tabla tipoProducto
CREATE TABLE tipoProducto (
  idtipoProducto INT PRIMARY KEY NOT NULL AUTO_INCREMENT,
  nombretipoProducto VARCHAR(45) NOT NULL
) ;

-- Tabla inventario
CREATE TABLE inventario (
  idInventario INT PRIMARY KEY NOT NULL AUTO_INCREMENT,
  color VARCHAR(45) NOT NULL, 
  talla VARCHAR(45) NOT NULL,
  cantidad VARCHAR(45) NOT NULL
) ;

-- Tabla proveedor
CREATE TABLE proveedor (
  idProveedor INT PRIMARY KEY NOT NULL AUTO_INCREMENT,
  nombreProveedor VARCHAR(45) NOT NULL,
  contacto VARCHAR(45) NULL,
  dirección VARCHAR(45) NULL
) ;

-- Tabla producto
CREATE TABLE producto (
  idProducto INT PRIMARY KEY NOT NULL AUTO_INCREMENT,
  nombreProducto VARCHAR(45) NULL, 
  descripcion VARCHAR(45) NULL, 
  urlImagen VARCHAR(45) NOT NULL,
  precio DOUBLE NOT NULL , 
  marca VARCHAR(45) NULL,
  fechaCreacion VARCHAR(16) NOT NULL,
  fechaModificacion VARCHAR(40) NULL,
  estado VARCHAR(45) NULL,
  idcategoria INT,
  idtipoProducto INT,
  idInventario INT,
  idProveedor INT,
  idcarrito INT,
  idcolección INT,
  idUsuario INT,
  FOREIGN KEY (idcategoria) REFERENCES categoría(idcategoria),
  FOREIGN KEY (idtipoProducto) REFERENCES tipoProducto(idtipoProducto),
  FOREIGN KEY (idInventario) REFERENCES inventario(idInventario),
  FOREIGN KEY (idProveedor) REFERENCES proveedor( idProveedor),
  FOREIGN KEY (idcarrito) REFERENCES carrito(idcarrito),
  FOREIGN KEY (idcolección) REFERENCES colección(idcolección),
  FOREIGN KEY (idUsuario) REFERENCES Usuario(idUsuario)
) ;

-- -----------------------------------------------------
-- MÓDULO DE GESTION DE COMPRAS
-- -----------------------------------------------------

-- Tabla MetodoPago
CREATE TABLE MetodoPago (
  idMetodoPago INT PRIMARY KEY NOT NULL AUTO_INCREMENT,
  nombreMetodoPago VARCHAR(45) NOT NULL
) ;

-- Tabla pago
CREATE TABLE pago (
  idpago INT PRIMARY KEY NOT NULL AUTO_INCREMENT,
  cantidad VARCHAR(45) NOT NULL,
  idMetodoPago INT,
  FOREIGN KEY (idMetodoPago) REFERENCES MetodoPago(idMetodoPago)
) ;

-- Tabla comprobanteDeVenta
CREATE TABLE comprobanteDeVenta (
  idcomprobanteDeVenta INT NOT NULL AUTO_INCREMENT,
  fecha INT NOT NULL, -- FK (No Identificadora)
  nombreUsuario INT NOT NULL, -- FK (No Identificadora)
  primerApellidoUsuario DATETIME NOT NULL,
  segundoApellidoUsuario DOUBLE NOT NULL,
  idUsuario INT,
  idTipoDeDocumento INT,
  FOREIGN KEY (idUsuario) REFERENCES Usuario(idUsuario),
  FOREIGN KEY (idTipoDeDocumento) REFERENCES tipo_de_documento(idTipoDeDocumento)
) ;

-- Tabla detallesComprobanteDeVenta 
CREATE TABLE detallesComprobanteDeVenta (
  idProducto INT,
  idtipoProducto INT,
  idDetallesComprobanteDeVenta INT,
  idcomprobanteDeVenta INT,
  FOREIGN KEY (idProducto) REFERENCES producto(idProducto),
  FOREIGN KEY (idtipoProducto) REFERENCES tipoProducto(idtipoProducto),
  FOREIGN KEY (idDetallesComprobanteDeVenta) REFERENCES detallesComprobanteDeVenta(idDetallesComprobanteDeVenta),
  FOREIGN KEY (idcomprobanteDeVenta) REFERENCES comprobanteDeVenta( idcomprobanteDeVenta),
  precio_unitario DOUBLE NOT NULL, 
  cantidad INT NOT NULL, 
  urlImagen VARCHAR(45) NOT NULL
) ;

-- Tabla carrito
CREATE TABLE carrito (
  idcarrito INT PRIMARY KEY NOT NULL AUTO_INCREMENT,
  fecha_creación VARCHAR(45) NOT NULL,
  idPedido INT,
  idUsuario INT,
  FOREIGN KEY (idPedido) REFERENCES pedido(idPedido),
  FOREIGN KEY (idUsuario) REFERENCES Usuario(idUsuario)
) ;

-- Tabla producto_pedido 
CREATE TABLE producto_pedido (
  idProducto INT,
  idcategoria INT,
  idtipoProducto INT,
  idInventario INT,
  idProveedor INT,
  idPedido INT,
  idDetallePedido INT,
  FOREIGN KEY (idProducto) REFERENCES producto(idProducto),
  FOREIGN KEY (idcategoria) REFERENCES categoría(idcategoria),
  FOREIGN KEY (idtipoProducto) REFERENCES tipoProducto(idtipoProducto),
  FOREIGN KEY (idInventario) REFERENCES proveedor( idInventario),
  FOREIGN KEY (idProveedor) REFERENCES proveedor(idProveedor),
  FOREIGN KEY (idPedido) REFERENCES pedido(idPedido),
  FOREIGN KEY (idDetallePedido) REFERENCES detallePedido(idDetallePedido)
) ;


-- -----------------------------------------------------
-- MÓDULO DE GESTIÓN DE PEDIDOS
-- -----------------------------------------------------

-- Tabla estadoPedido
CREATE TABLE estadoPedido (
  idEstado INT PRIMARY KEY NOT NULL AUTO_INCREMENT,
  nombreEstado VARCHAR(45) NOT NULL
) ;

-- Tabla pedido
CREATE TABLE pedido (
  idPedido INT PRIMARY KEY NOT NULL AUTO_INCREMENT,
  fechaPedido INT NOT NULL, 
  direccionEntrega INT NOT NULL,
  idUsuario INT,
  idpago INT,
  idMetodoPago INT,
  FOREIGN KEY (idUsuario) REFERENCES Usuario(idUsuario),
  FOREIGN KEY (idpago) REFERENCES pago(idpago),
  FOREIGN KEY (idMetodoPago) REFERENCES MetodoPago(idMetodoPago)
) ;

-- Tabla seguimientoPedido
CREATE TABLE seguimientoPedido (
  idSeguimiento INT PRIMARY KEY NOT NULL AUTO_INCREMENT,
  fechaestado VARCHAR(255) NOT NULL,
  comentario VARCHAR(45) NULL,
  idPedido INT,
  idMetodoPago INT,
  FOREIGN KEY (idPedido) REFERENCES pedido(idPedido),
  FOREIGN KEY (idEstado) REFERENCES estadoPedido(idEstado)
) ;

-- Tabla detallePedido
CREATE TABLE detallePedido (
  idDetallePedido INT PRIMARY KEY NOT NULL AUTO_INCREMENT,
  talla INT NOT NULL, 
  cantidad INT NOT NULL,
  precioUnitario DOUBLE NOT NULL,
  idPedido INT,
  idUsuario INT,
  FOREIGN KEY (idPedido) REFERENCES pedido(idPedido),
  FOREIGN KEY (idUsuario) REFERENCES Usuario(idUsuario)
) ;

-- Tabla devoluciones_Cambios
CREATE TABLE devoluciones_Cambios (
  id_devolucion INT PRIMARY KEY NOT NULL AUTO_INCREMENT,
  motivo VARCHAR(255) NOT NULL, 
  tipo_solicitud VARCHAR(200) NOT NULL, 
  estado_solicitud VARCHAR(45) NOT NULL,
  fecha_solicitud VARCHAR(40) NOT NULL,
  fecha_respuesta VARCHAR(45) NOT NULL, 
  idUsuario INT,
  idRol INT,
  idTipoDeDocumento INT,
  idestado_usuario INT,
  FOREIGN KEY (idUsuario) REFERENCES Usuario(idUsuario),
  FOREIGN KEY (idRol) REFERENCES rol(idRol),
  FOREIGN KEY (idTipoDeDocumento) REFERENCES tipo_de_documento(idTipoDeDocumento),
  FOREIGN KEY (idestado_usuario) REFERENCES estado_usuario( idestado_usuario)
  
) ;

