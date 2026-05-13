# Fondos BTG — Prueba Técnica Flutter

Aplicación Flutter para la gestión de fondos de inversión (FPV/FIC) de BTG Pactual. Usuario único con saldo inicial de COP $500,000.

## Requisitos previos

- Flutter SDK **3.x** (Dart SDK `^3.11.1`)
- Chrome o navegador para ejecución web

## Instalación y ejecución

```bash
# Clonar el repositorio e instalar dependencias
cd fondo_btg
flutter pub get

# Ejecutar en modo debug (web por defecto)
flutter run

# Ejecutar en Chrome explícitamente
flutter run -d chrome
```

## Estructura del proyecto

```
lib/
├── app/                      # MaterialApp.router + GoRouter
├── core/
│   ├── constants/            # Constantes de la app
│   ├── providers/            # Estado global (saldo, suscripciones, transacciones, tema)
│   ├── theme/                # Colores, tipografía, tema claro/oscuro
│   └── utils/                # Formateadores (moneda, fecha)
├── data/datasources/         # Datos mock en memoria
├── domain/entities/          # Fund, Transaction, UserBalance, ActiveSubscription
└── features/                 # Feature-first
    ├── funds/                 # Pantalla principal: lista de fondos + saldo
    ├── subscribe/             # Suscripción y cancelación de fondos
    └── transactions/          # Historial de transacciones
```

## Funcionalidades

- **Saldo disponible**: Se muestra en la pantalla principal. Botón "Depositar" agrega COP $100,000 por click.
- **Suscripción a fondos**: Validación de monto mínimo y saldo suficiente. Notificación por Email o SMS.
- **Cancelación de fondos**: Reintegra el monto invertido completo al saldo. Confirmación requerida.
- **Historial de transacciones**: Lista filtrable (todas, suscripciones, cancelaciones), agrupada por fecha.
- **Restablecer cuenta**: Botón de reinicio que vuelve al saldo inicial y elimina suscripciones/transacciones.
- **Tema claro/oscuro**: Interruptor en la barra superior / inferior.
- **Diseño responsivo**: Adaptado para móvil, tablet y desktop.

## Reglas de negocio

| Regla | Detalle |
|-------|---------|
| Saldo inicial | COP $500,000 |
| Suscripción | No se puede suscribir si el monto es menor al mínimo del fondo o mayor al saldo disponible |
| Duplicado | No se puede suscribir al mismo fondo dos veces |
| Cancelación | Devuelve el monto completo invertido al saldo disponible |
| Depósito | Cada click agrega COP $100,000 al saldo |
| Restablecer | Vuelve saldo a COP $500,000, elimina suscripciones y transacciones |

## Rutas

| Ruta | Pantalla |
|------|----------|
| `/` | Fondos disponibles (home) |
| `/transactions` | Historial de transacciones |

> La suscripción y cancelación se abren como diálogo (desktop) o pantalla push (móvil), no como rutas de go_router.

## Fondos disponibles

| Fondo | Mínimo | Categoría |
|-------|--------|-----------|
| FPV_BTG_PACTUAL_RECAUDADORA | COP $75,000 | FPV |
| FPV_BTG_PACTUAL_ECOPETROL | COP $125,000 | FPV |
| DEUDAPRIVADA | COP $50,000 | FIC |
| FDO-ACCIONES | COP $250,000 | FIC |
| FPV_BTG_PACTUAL_DINAMICA | COP $100,000 | FPV |

## Testing

```bash
flutter test
flutter analyze
```

## Stack técnico

- **Flutter** + **Dart 3.x**
- **go_router** — Navegación declarativa con ShellRoute
- **flutter_riverpod** — Estado con StateProvider
- **google_fonts** + **hugeicons** — Tipografía e iconografía
- **intl** — Formato de moneda COP (locale `es_CO`)