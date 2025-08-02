# 🛍️ Sistema de Inventario y Gestión de Clientes

Este es un proyecto de Python con SQLite, que permite administrar clientes y productos commo agregar, modificar, eliminar y mostrar los almacenados en una base de datos.

## 📁 Estructura del Proyecto
mi_libreria/
├── clientes.py           # Lógica para gestionar clientes (alta, baja, modificación)
├── productos.py          # Lógica para gestionar productos (categorías, stock, reportes)
├── ayuda.py              # Funciones auxiliares o de utilidad (colores, validaciones, etc.)
├── main.py               # Menú principal y navegación de opciones
├── clientes.json         # Backup o precarga de datos de clientes
├── productos.json        # Backup o precarga de datos de productos
├── libreria_reg.db       # Base de datos SQLite con tablas: clientes, productos, categorias
├── README.md             # Documentación principal del proyecto (explicación general)
└── docs/                 # Documentación automática generada con Sphinx
    ├── source/
    │   ├── conf.py       # Configuración de Sphinx
    │   ├── index.rst     # Página principal de documentación
    │   └── *.rst         # Archivos adicionales generados con `sphinx-apidoc`
    └── build/            # Carpeta generada automáticamente con la salida HTML

## Requisitos

- Python 3.x
- Tkinter (incluido en la instalación estándar de Python)
- SQLite (incluido en la instalación estándar de Python)

## Instalación

1. Clona o descarga este repositorio en tu máquina local.
2. Asegúrate de tener Python 3.x instalado en tu sistema.
3. No se requieren pasos de instalación adicionales, ya que el proyecto utiliza bibliotecas estándar de Python.

## ▶️ Cómo Ejecutar

1. Ejecuta el archivo `main.py` para iniciar la aplicación.
2. La aplicación abrirá una ventana con las opciones disponibles.
3. En la pestaña "Agregar Producto", puedes ingresar los detalles del nuevo producto y hacer clic en el botón "Agregar Producto" para agregarlo al inventario.
4. En la pestaña "Modificar Producto", puedes seleccionar un producto existente de la lista desplegable, modificar sus detalles y hacer clic en el botón "Modificar Producto" para guardar los cambios.
5. También puedes eliminar productos desde la pestaña "Modificar Producto" seleccionando un producto y haciendo clic en el botón "Eliminar Producto".
6. El botón "Mostrar Informe" en la ventana principal te permite ver un informe de inventario con detalles de todos los productos almacenados.

## Lógica de Funcionamiento
1. main.py – Menú Principal:
* Muestra un menú con 3 opciones:
* Gestionar Clientes
* Gestionar Productos
* Salir
- Usa match para dirigir según la opción ingresada.
- Cada opción llama a una función del módulo correspondiente.

### 2. clientes.py
### Funciones principales:
    - agregar_cliente_sql(): Pide nombre, apellido, email, guarda en DB.
    - ver_clientes_sql(): Muestra todos los clientes registrados.
    - buscar_cliente_por__id_(): Busca por id .
    - eliminar_cliente_por_id(): Elimina el cliente por id.

### Validaciones:
- Se valida que los campos no estén vacíos y que el email sea válido.
- Uso de datetime para guardar la fecha de registro.
3. productos.py
### Funciones principales:
- agregar_producto_sql(): Crea un nuevo producto con nombre, precio, stock y categoría.
- consultar_productos_sql(): Lista todos los productos disponibles.
- buscar_producto_por_id(): Busca un producto por su ID.
- actualizar_producto_sql(): Permite modificar nombre, precio o stock.
- eliminar_producto_sql(): Elimina producto por ID.
- reporte_stock_bajo(): Muestra productos con stock bajo un límite ingresado.

### Validaciones:
* Se valida que el precio sea un número positivo.
* El stock no puede ser negativo.
* Se verifica que la categoría seleccionada exista.

## 💾Base de Datos

Nombre del archivo: libreria_reg.db
*Tablas:*
clientes
CREATE TABLE IF NOT EXISTS clientes (
    cliente_id INTEGER PRIMARY KEY AUTOINCREMENT,
    nombre TEXT NOT NULL,
    apellido TEXT NOT NULL,
    email TEXT NOT NULL UNIQUE,
    fecha_registro TEXT NOT NULL
);

productos
CREATE TABLE IF NOT EXISTS productos (
    producto_id INTEGER PRIMARY KEY AUTOINCREMENT,
    nombre TEXT NOT NULL,
    precio REAL NOT NULL,
    stock INTEGER NOT NULL,
    categoria_id INTEGER,
    FOREIGN KEY (categoria_id) REFERENCES categorias(categoria_id)
);

categorias
CREATE TABLE IF NOT EXISTS categorias (
    categoria_id INTEGER PRIMARY KEY AUTOINCREMENT,
    nombre TEXT NOT NULL
);

## Ejemplo de Uso
### 📋 MENÚ PRINCIPAL
1. Gestionar Clientes
2. Gestionar Productos
3. Salir

Selecciona una opción (1-3): 2

📦 Menú Productos
1. Agregar producto
2. Ver productos
...
Selecciona una opción (1-7): 6
📉 Ingresá el límite de stock: 5

➡️ Muestra todos los productos con stock menor o igual a 5

## 🐞 Errores Comunes y Solución
|    Error           |    Causa               |       Solución                       |
| -------------------| -----------------------| ------------------------------------ |
| `AttributeError:   | Nombre de función mal  | Revisar nombres exactos              |
|  module has no     | llamado.               |  en el archivo py                    |
|  attribute`        |                        |                                      |
| `sqlite3.Operation`| El alias o nombre de   | Verificar nombres reales en la       |
| `alError: no such` | columna/tablas         | base de datos                        |
| `column`           |                        |                                      |


## ✅ Próximas Mejoras

- Agregar interfaz gráfica (Tkinter o PyQt).
- Conexión con API REST.
- Exportar reportes a CSV o Excel.

## 📌 Consideraciones

- El módulo se inicializa con init(autoreset=True) para usar colorama en la consola.
- Los datos también pueden persistirse en JSON como respaldo externo.
- Las operaciones muestran mensajes amigables con íconos (como ✅, ❌, 📢).

## 🙌 Agradecimientos

Quiero agradecer especialmente a la profesora Griselda por su dedicación y guía constante a lo largo del curso, y a la tutora Erica, por su acompañamiento paciente y siempre estar dispuesta a ayudar.

Este proyecto fue realizado como parte de mi formación y cada línea de código refleja el aprendizaje compartido en clase. ¡Gracias por motivarnos a seguir creciendo!