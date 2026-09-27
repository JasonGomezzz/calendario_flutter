# Laboratorio Flutter: diseño de un calendario

Calendario visual de **septiembre de 2026** hecho con Flutter. Puede presentarse en Flutter Web. El diseño usa una paleta propia de índigo, verde y coral y toma solo la organización general de las referencias del laboratorio.

## Ver la aplicación en Brave

Abre este proyecto en Visual Studio Code y ejecuta en su terminal:

```bash
CHROME_EXECUTABLE='/Applications/Brave Browser.app/Contents/MacOS/Brave Browser' flutter run -d chrome
```

Flutter llamará al dispositivo `Chrome (web)`, pero abrirá **Brave** porque la variable apunta a su ejecutable. Mientras el comando siga activo, escribe `r` en la terminal para recargar cambios y `q` para detenerlo.

También puedes usar `flutter run -d web-server` y abrir en Brave la dirección local que aparezca en la terminal. La depuración en ese modo es limitada.

**Vista actual:** [captura del calendario en Brave](docs/calendario-web.jpg).

## Criterios del laboratorio

- **Mes y año:** el encabezado muestra septiembre de 2026.
- **Semana y cuadrícula:** siete columnas y cinco filas construidas principalmente con `Row` y `Column`.
- **Eventos:** los días 5, 12 y 21 tienen un punto y una tarjeta descriptiva.
- **Día destacado:** el 21 aparece con fondo verde.
- **Diseño:** colores, bordes redondeados, iconos, tipografía, sombras y espaciados personalizados.
- **Alcance:** solo diseño visual; no hay base de datos, navegación entre meses ni creación de eventos.

## Cómo está organizado el código

- `lib/main.dart`: toda la interfaz. Sus comentarios en español explican cada sección y las instrucciones clave.
- `pubspec.yaml`: nombre del proyecto y dependencias.
- `web/`: archivos que permiten iniciar Flutter Web en el navegador.
- `ios/`: soporte opcional para iPhone; no se necesita para presentar este laboratorio en web.

En `main.dart`, `CalendarioApp` prepara el tema, `CalendarioPantalla` organiza la vista, `_calendario` arma la cuadrícula, `_dia` dibuja cada casilla y `_evento` reutiliza una tarjeta para los tres eventos.

## Verificación

- `flutter analyze`: sin problemas.
- `flutter build web`: compilación correcta.
- Vista abierta y revisada en Brave.
