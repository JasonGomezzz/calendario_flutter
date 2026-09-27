// Material reúne los widgets, colores e iconos que usaremos.
import 'package:flutter/material.dart';

// Guardamos la paleta aquí para reutilizar los mismos colores.
const Color azul = Color(0xFF4F46C8);
const Color verde = Color(0xFF148C78);
const Color coral = Color(0xFFE75F72);
const Color tinta = Color(0xFF202345);
const Color fondo = Color(0xFFF6F5FB);

// main inicia la aplicación y muestra CalendarioApp.
void main() => runApp(const CalendarioApp());

// Esta clase configura el tema y la pantalla principal.
class CalendarioApp extends StatelessWidget {
  const CalendarioApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Mi calendario', // Nombre interno de la app.
      debugShowCheckedModeBanner: false, // Oculta la cinta DEBUG.
      theme: ThemeData(useMaterial3: true, scaffoldBackgroundColor: fondo),
      home: const CalendarioPantalla(), // Abre la pantalla del calendario.
    );
  }
}

// StatelessWidget basta porque el laboratorio solo pide diseño visual.
class CalendarioPantalla extends StatelessWidget {
  const CalendarioPantalla({super.key});

  // Son 35 casillas: 31 de agosto, septiembre completo y 1 a 4 de octubre.
  static const List<int> dias = [
    31,
    1,
    2,
    3,
    4,
    5,
    6,
    7,
    8,
    9,
    10,
    11,
    12,
    13,
    14,
    15,
    16,
    17,
    18,
    19,
    20,
    21,
    22,
    23,
    24,
    25,
    26,
    27,
    28,
    29,
    30,
    1,
    2,
    3,
    4,
  ];

  // Estos rótulos encabezan las siete columnas del calendario.
  static const List<String> semana = [
    'Lun',
    'Mar',
    'Mié',
    'Jue',
    'Vie',
    'Sáb',
    'Dom',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // SafeArea evita los bordes del iPhone y del navegador.
      body: SafeArea(
        // Center centra el diseño cuando la ventana web es ancha.
        child: Center(
          // El ancho máximo conserva la proporción de una pantalla móvil.
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 480),
            // El desplazamiento evita recortes en pantallas bajas.
            child: SingleChildScrollView(
              padding: const EdgeInsets.fromLTRB(22, 20, 22, 28),
              // Column apila el encabezado, el mes y los eventos.
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _encabezado(),
                  const SizedBox(height: 26), // Separación vertical.
                  _calendario(),
                  const SizedBox(height: 30), // Separación vertical.
                  _eventos(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  // Muestra el icono, el mes, el año y una frase introductoria.
  Widget _encabezado() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Row coloca icono y nombre de la agenda en la misma línea.
        Row(
          children: [
            Container(
              width: 40, // Ancho del recuadro del icono.
              height: 40, // Alto del recuadro del icono.
              decoration: BoxDecoration(
                color: azul,
                borderRadius: BorderRadius.circular(13),
              ),
              child: const Icon(
                Icons.calendar_month_rounded,
                color: Colors.white,
              ),
            ),
            const SizedBox(width: 11),
            const Text(
              'MI AGENDA',
              style: TextStyle(
                color: azul,
                fontSize: 13,
                fontWeight: FontWeight.w800,
                letterSpacing: 2,
              ),
            ),
          ],
        ),
        const SizedBox(height: 24),
        const Text(
          'Septiembre 2026', // Mes y año pedidos por la guía.
          style: TextStyle(
            color: tinta,
            fontSize: 31,
            fontWeight: FontWeight.w800,
            letterSpacing: -1,
          ),
        ),
        const SizedBox(height: 5),
        const Text(
          'Tus planes, de un vistazo.',
          style: TextStyle(color: Color(0xFF777B99), fontSize: 15),
        ),
      ],
    );
  }

  // Dibuja la tarjeta blanca con los nombres y números de los días.
  Widget _calendario() {
    return Container(
      padding: const EdgeInsets.fromLTRB(12, 20, 12, 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(28),
        boxShadow: const [
          BoxShadow(
            color: Color(0x100E1640),
            blurRadius: 28,
            offset: Offset(0, 12),
          ),
        ],
      ),
      child: Column(
        children: [
          // Cada Expanded da el mismo ancho a un día de la semana.
          Row(
            children: [
              for (final nombre in semana)
                Expanded(
                  child: Center(
                    child: Text(
                      nombre,
                      style: const TextStyle(
                        color: Color(0xFF8A8EA8),
                        fontSize: 12,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                ),
            ],
          ),
          const SizedBox(height: 14),
          // Cinco Row forman las cinco semanas de septiembre.
          for (int fila = 0; fila < 5; fila++)
            Row(
              children: [
                // Cada Row contiene siete casillas del mismo ancho.
                for (int columna = 0; columna < 7; columna++)
                  Expanded(child: _dia(fila * 7 + columna)),
              ],
            ),
        ],
      ),
    );
  }

  // indice indica qué casilla de la lista "dias" estamos dibujando.
  Widget _dia(int indice) {
    // La primera casilla es agosto y las últimas cuatro son octubre.
    final bool fueraDelMes = indice == 0 || indice >= 31;
    // El 21 tendrá un fondo verde para destacarlo.
    final bool destacado = indice == 21;
    // Los días 5, 12 y 21 tienen eventos señalados por un punto.
    final Color? colorEvento = switch (indice) {
      5 => azul,
      12 => coral,
      21 => verde,
      _ => null,
    };

    return Padding(
      padding: const EdgeInsets.all(2),
      child: Container(
        height: 48, // Mantiene iguales todas las casillas.
        decoration: BoxDecoration(
          color: destacado ? verde : fondo,
          borderRadius: BorderRadius.circular(14),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              dias[indice].toString(), // Convierte el número en texto visible.
              style: TextStyle(
                color: destacado
                    ? Colors.white
                    : fueraDelMes
                    ? const Color(0xFFB7B9C9)
                    : tinta,
                fontSize: 15,
                fontWeight: destacado ? FontWeight.w800 : FontWeight.w600,
              ),
            ),
            // Solo mostramos el punto si ese día tiene un evento.
            if (colorEvento != null) ...[
              const SizedBox(height: 3),
              Container(
                width: 5,
                height: 5,
                decoration: BoxDecoration(
                  color: destacado ? Colors.white : colorEvento,
                  shape: BoxShape.circle,
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }

  // Reúne los tres eventos visuales que exige el laboratorio.
  Widget _eventos() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Próximos eventos',
          style: TextStyle(
            color: tinta,
            fontSize: 21,
            fontWeight: FontWeight.w800,
          ),
        ),
        const SizedBox(height: 14),
        _evento(
          dia: '05',
          titulo: 'Reunión de equipo',
          hora: '10:00 a. m.',
          icono: Icons.groups_rounded,
          color: azul,
        ),
        const SizedBox(height: 10),
        _evento(
          dia: '12',
          titulo: 'Examen de programación',
          hora: '9:00 a. m.',
          icono: Icons.school_rounded,
          color: coral,
        ),
        const SizedBox(height: 10),
        _evento(
          dia: '21',
          titulo: 'Presentación de proyecto',
          hora: '2:00 p. m.',
          icono: Icons.auto_graph_rounded,
          color: verde,
        ),
      ],
    );
  }

  // Recibe los datos de un evento y construye una tarjeta reutilizable.
  Widget _evento({
    required String dia, // Número grande que aparece a la izquierda.
    required String titulo, // Nombre del evento.
    required String hora, // Hora que aparece debajo del título.
    required IconData icono, // Dibujo de la derecha.
    required Color color, // Color propio de este evento.
  }) {
    return Container(
      padding: const EdgeInsets.all(13),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
      ),
      // Row ordena fecha, descripción e icono de izquierda a derecha.
      child: Row(
        children: [
          Container(
            width: 54,
            height: 58,
            decoration: BoxDecoration(
              color: color.withValues(alpha: 0.11),
              borderRadius: BorderRadius.circular(14),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  dia,
                  style: TextStyle(
                    color: color,
                    fontSize: 22,
                    fontWeight: FontWeight.w900,
                  ),
                ),
                Text(
                  'SEP',
                  style: TextStyle(
                    color: color,
                    fontSize: 10,
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 13),
          // Expanded deja al título el espacio que queda en la fila.
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  titulo,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    color: tinta,
                    fontSize: 14,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  hora,
                  style: const TextStyle(
                    color: Color(0xFF8589A4),
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 8),
          Icon(icono, color: color, size: 25),
        ],
      ),
    );
  }
}
