# Trading Dashboard App

Aplicación Flutter que se conecta a la API pública de Binance vía WebSocket para mostrar datos de trading en tiempo real. Simula un dashboard profesional con precios, gráficas, order book y calculadora de trading.

## 📦 Características

- **Dashboard Principal**  
  - Pares BTC/USDT y ETH/USDT  
  - Precio en tiempo real con indicador de subida/bajada  
  - Cambio porcentual 24h y volumen  
- **Vista Detallada**  
  - Estadísticas del día (open, high, low, close)  
  - Gráfica de precios con animación  
- **Order Book**  
  - Bids (verde) y Asks (rojo) en tiempo real  
  - Spread dinámico  
- **Calculadora de Trading**  
  - Cálculo de cantidad a recibir incluyendo fees  
  - Validaciones de monto mínimo/máximo  
  - Actualización instantánea según precio  

## 🚀 Cómo correr la app

### Prerrequisitos

- Flutter SDK ≥ 3.7.2  
- Android Studio o VS Code con plugin Flutter  
- Dispositivo o emulador Android/iOS configurado  

### Pasos de instalación

1. Clona este repositorio  
   ```bash
   git clone https://github.com/tu-usuario/trading_dashboard_app.git
   cd trading_dashboard_app
   ```
2. Obtén dependencias  
   ```bash
   flutter pub get
   ```
3. Corre la aplicación en modo debug  
   ```bash
   flutter run
   ```
   > Selecciona tu dispositivo/emulador cuando se te solicite.

## 📱 APK listo para ejecutar

En la raíz del repositorio encontrarás el archivo `app-release.apk`.  
Solo cópialo a tu dispositivo Android y ejecútalo directamente (asegúrate de permitir instalación de orígenes desconocidos).

## 🗂 Estructura del proyecto

```
trading_dashboard_app/
├─ android/  
├─ ios/  
├─ lib/
│  ├─ main.dart          ← Punto de entrada y SplashScreen
│  ├─ provider/          ← Lógica de WebSocket y estado
│  ├─ screens/           ← Pantallas: Dashboard, OrderBook, Calculadora
│  └─ widgets/           ← Componentes reutilizables
├─ assets/
│  └─ splash.png  
├─ pubspec.yaml  
└─ app-release.apk       ← APK compilado
```

