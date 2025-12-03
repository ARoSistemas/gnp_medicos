# Pasos para compilación de Aplicación Flutter Médicos

## Requisitos Previos

Para poder compilar es necesario contar con los requisitos mínimos:

[✓] Flutter (Channel stable, 3.35.4, on macOS 15.6.1 24G90 darwin-arm64, locale en-MX)

[✓] Android toolchain - develop for Android devices (Android SDK version 36.0.0)

[!] Xcode - develop for iOS and macOS (Xcode 26.0.1)

Para obtener esta información se puede ejecutar el comando:

`flutter doctor -v`

## Instrucciones de compilación

Ingresar a la ruta del proyecto y ejecutar el comando:
`flutter clean`

Luego ejecutar el comando:
`flutter pub get`

### [IOS]

---

Ir a la ruta /ios del proyecto desde la terminal y ejecutar:
`pod deintegrate`
`pod install`

#### Compilación

`flutter build ios --release --dart-define-from-file="config.json" --flavor qa`

`flutter build ios --release --dart-define-from-file="config.json" --flavor uat`

`flutter build ios --release --dart-define-from-file="config.json" --flavor prod`

En Xcode, abre **Runner.xcworkspace** en la carpeta ios de tu aplicación.
Selecciona **Product > Scheme > (ambiente necesario qa, uat, prod).**
Seleccionar en **"Show the Project navigator" -> Runner -> TARGETS -> Runner -> Signing and capabilites**
En todos los capabilites seleccionar el team la cuenta de GNP.

#### Generación de archivos .IPA para AD-HOC

1. Selecciona **Product > Destination > Generic iOS Device.**
2. Selecciona Runner en el navegador de proyectos Xcode a continuación.
3. Selecciona **Product > Archive** para producir un archivo compilado.
4. En la ventana **Organizer** , selecciona el archivo recién creado y haz clic en **Distribute App**.
5. Selecciona el método de distribución:

   * Elige **Ad Hoc** (para testing con UDIDs específicos).
6. **Signing (Firma):** Aquí es donde la aplicación se firmará correctamente.

   * Selecciona **Automatically manage signing** si tienes la cuenta de desarrollador configurada en Xcode y tu Perfil de Provisión Ad Hoc incluye todos los UDIDs del equipo de pruebas.
   * Si optaste por **Manual signing** , asegúrate de seleccionar el Perfil de Provisión Ad Hoc correcto.
7. Completa los pasos restantes (opciones de post-procesamiento) y hacer clic en **Export** o **Next** .
8. Xcode te pedirá una ubicación para guardar el paquete. El resultado final será la carpeta exportada que contiene el archivo **Runner-qa.ipa** (o el nombre definido en Xcode).

### [Android]
---------

La release APK para su aplicación se crea en <appdir>/build/app/outputs/flutter-apk/app-{ambiente}-release.apk

`flutter build apk --release --dart-define-from-file="config.json" --flavor qa`

`flutter build apk --release --dart-define-from-file="config.json" --flavor uat`

`flutter build apk --release --dart-define-from-file="config.json" --flavor prod`


### [Web] 
---------


`flutter build web --release --dart-define-from-file="config.json"`
