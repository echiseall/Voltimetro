# Voltimetro
Voltimetro digital codificado en VHDL para la placa Arty-35. SIntetizado en Vivado.

El voltímetro cuenta con 4 componentes principales los cuales son: el conversor analógico digital, multiplexor, memoria ROM, VGA.

Conversor A/D: Convierte la señal analógica recibida en una señal digital y la almacena en registros. Entradas: Data, Clock, Enable, Reset. Salidas: Realimentación y los registros. Aclaración: el diagrama de bloques fue cortado debido a su tamaño (cantidad de compuertas AND). Se intentó mostrar los componentes del mismo. Se encuentra conformado por 4 componentes de los cuales cada unos se detalla si función a continuación:
● Conversor A/D sigma delta: Utiliza la modulación sigma-delta. Permite leer señales de baja frecuencia.Este es un flip flop D pero con realimentación (salida negada). Entrada: Data, Clock, Enable, Reset. Salida: Q, Realimentación.
● Flip-flop D: Dispositivo electrónico que actúa como una memoria de un solo bit, capaz de almacenar y cambiar su estado de salida en función de la señal de entrada en el flanco de reloj.  Entrada: Data, Clock, Enable, Reset. Salida: Q.
● Contador de unos: Son seis contadores BCDs conectados en cascada, cuenta con cada flancoascendente de clock. Entradas: Clock, Enable, Reset. Salidas: 6 BCDs.
● Contador binario: Los registros deben activarse una vez que el contador ventana haya alcanzado el valor de 3300000, momento en el cual se almacenarán los valores actuales del contador de unos. Entradas: Clock, Enable, Reset.
● Registro: Se requiere un registro para cada contador BCD del cual se desee almacenar los valores, en este caso son 3. Se utiliza para almacenar un valor de 4 bits, que es el tamaño de salida de cada contador BCD y posteriormente los envía a la ROM. Entradas: Clock, Enable, Reset, Data. Salida: Q. (similar al flip-flop pero con más bits).

Multiplexor: El multiplexor se utiliza para mostrar en pantalla el valor medido por el voltímetro. Es un dispositivo que selecciona y envía el carácter correspondiente a la posición actual de la pantalla. Este elige entre varias señales de entrada y las dirigehacia una única salida. Esta herramienta se utiliza para conectar múltiples fuentes a un solo destino o para distribuir una fuente a varios destinos. El multiplexor específico a emplear cuenta con un total de 6 entradas: 3 para los datos provenientes de los registros que serían el número entero, primer decimal y segundo decimal; una para el símbolo del punto decimal, otra para el símbolo 'V', además de una entrada de selección y una salida. Este componente permite
seleccionar el carácter a mostrar, y dicha selección está coordinada mediante 3 bits de la coordenada x de la VGA, junto con la 'V' y el punto decimal.

Memoria ROM: La ROM almacena los patrones de bits de los posibles caracteres que serán mostrados en la pantalla, es decir los números de 0 a 9. En la entrada, recibe el dígito del multiplexor, que determina qué carácter dibujaremos. También recibe coordenadas verticales y horizontales que indican qué bit del patrón de dibujo imprime en cada momento. La salida de la ROM se dirige directamente a la pantalla.

VGA: El bloque de display me permite imprimir los valores seleccionados por el multiplexor en la ROM. Hubo que ajustar la frecuencia del reloj de la VGA, que necesita ser de 25 MHz, a pesar de que la placa proporciona un reloj de 100 MHz, se optó por utilizar un MMCM para reducir la frecuencia de 100 a 25 MHz (generado en el programa Vivado). Esto se realizó utilizando el código del voltímetro top level proporcionado por la cátedra. El funcionamiento de este bloque es que pantalla se escanee de manera secuencial de izquierda a derecha y de arriba hacia abajo, siendo cada línea precedida por un pulso de sincronización horizontal, mientras que cada actualización completa de la imagen es precedida por un pulso de sincronización vertical. Además, se requieren señales para identificar la parte visible de la pantalla, que tiene dimensiones de 524 x 800, aunque la imagen se muestra en una dimensión visible de 480x640, dividida en 4 filas y 5 columnas. Para esto se utilizan los contadores y algunos
comparadores dependiendo del número que necesitase.

Conexion: Se utilizará una entrada simple de la placa Arty A7-35 y 6 salidas, 5 para la conexión VGA (se debe incluir una masa) y otra para la realimentación. Las resistencias eran de  10kΩ y el capacitor de 100nF. Las señales relacionadas con el controlador VGA deberían ser exteriorizadas a través de los pines de los conectores PMODs (sugerencia: usar el conector JA) y conectarlas a través de cables tipo Dupont al conector VGA del monitor (para la masa alcanzaría con usar sólo el pin 8 del conector). Se utilizarán dos pines de la placa (sugerencia: utilizar el conector PMOD JD). Uno de los pines se deberá configurar como entrada y el otro como salida.
      Puerto     | Pin :
clk_i            -> E3,
rst_i            -> D9,
data_volt_in_i   -> D4,
data_volt_out_o  -> F3,
hs_o             -> D12,
vs_o             -> K16,
red_o            -> G13,
grn_o            -> B11,
blu_o            -> A11,

