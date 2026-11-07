# 🖥️ Datapath MIPS Monociclo (Instrucciones Tipo R)

Este repositorio contiene la implementación estructural en Verilog de la ruta de datos (Datapath) monociclo de un procesador MIPS. En esta iteración, el diseño está enfocado exclusivamente en la decodificación y ejecución de **instrucciones de formato R** (ADD, SUB, AND, OR, SLT).

Proyecto desarrollado para el **Seminario de Solución de Problemas de Arquitectura de Computadoras** de la Universidad de Guadalajara (CUCEI).

## ⚙️ Arquitectura y Módulos

El procesador está segmentado en los siguientes módulos de lógica combinacional:
* **`MIPS_Datapath_R.v`**: Archivo *Top-Level* que interconecta todos los componentes del sistema.
* **`Control_Unit.v`**: Unidad de control que extrae las banderas principales al detectar el *opcode* de Tipo R (`000000`).
* **`ALU_Control.v`**: Decodificador que recibe la señal de la Unidad de Control y el campo `funct` para determinar la operación matemática exacta.
* **`ALU.v`**: Unidad Lógico Aritmética que ejecuta operaciones de suma, resta y compuertas lógicas.
* **`Mux2x1_5bit.v` / `Mux2x1_32bit.v`**: Multiplexores para el ruteo de datos y selección de registro destino.

## 🛠️ Herramientas Utilizadas
* **Lenguaje:** Verilog HDL
* **Simulador:** ModelSim

## 🚀 Cómo simular el proyecto

1. Clona este repositorio o descarga los archivos `.v` localmente.
2. Crea un nuevo proyecto en **ModelSim** y añade todos los archivos fuente.
3. Haz clic derecho en el panel de proyecto y selecciona **Compile > Compile All**.
4. Ve a **Simulate > Start Simulation**, despliega la carpeta `work` y selecciona el banco de pruebas: `tb_MIPS_Datapath_R`.
5. Ejecuta la simulación escribiendo el comando `run -all` en la consola (Transcript).
6. Añade las señales a la ventana gráfica (Wave) para analizar el comportamiento combinacional en el tiempo.

## 🧪 Pruebas (Testbench)
El archivo `tb_MIPS_Datapath_R.v` incluye casos de prueba automatizados que inyectan los códigos binarios de 32 bits y los datos de lectura (`ReadData1` y `ReadData2`) correspondientes a instrucciones de suma, resta y AND lógico. El banco de pruebas verifica que la salida matemática de la ALU (`ALUResult`) y la selección de escritura en registro sean exactas en la simulación.
