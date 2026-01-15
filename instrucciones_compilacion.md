# Pasos para compilación de Aplicación Flutter Médicos

## Requisitos Previos

Para poder compilar es necesario contar con los requisitos mínimos:

[✓] Flutter (Channel stable, 3.35.4, on macOS 15.6.1 24G90 darwin-arm64, locale en-MX)

[✓] Android toolchain - develop for Android devices (Android SDK version 36.0.0)

[!] Xcode - develop for iOS and macOS (Xcode 26.0.1)

Para obtener esta información se puede ejecutar el comando:

`flutter doctor -v`

## Instrucciones de compilación

1. Ingresar a la ruta del proyecto y ejecutar el comando:
   `flutter clean`

2. Luego ejecutar el comando:
   `flutter pub get`


### [Config.json]
---------

El archivo config.json se encuentra en la siguiente ruta, tomar el respectivo dentro de la carpeta según el ambiente seleccionado y reemplazarlo por el archivo en raíz antes de compilar.

https://gitlab.com/gitgnp/gcp/nueva-administracion-proveedores/documentacion/-/tree/feature-DMND0057446/gnp-admonproveedoressalud/gae-gnp-admonproveedoressalud-medicos-front?ref_type=heads


### [IOS]
---------

Ir a la ruta /ios del proyecto desde la terminal y ejecutar:
`pod deintegrate`
`pod install`

En el archivo de ios/Runner/AppDelegate.swift ingresar dentro del bloque "application() { (aqui).. }" la siguiente línea:
GMSServices.provideAPIKey("{iosFirebaseApiKey}")
donde el valor de iosFirebaseApiKey (reemplazar con todo y corchetes {}) se encuentra en el archivo de config.json

#### Compilación ambientes previos

`flutter build ios --release --flavor qa --dart-define-from-file="config.json" --obfuscate --split-debug-info=./symbols`

`flutter build ios --release --flavor uat --dart-define-from-file="config.json" --obfuscate --split-debug-info=./symbols`

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

#### Compilación y despliegue ambiente de producción

`flutter build ios --release --flavor prod --dart-define-from-file="config.json" --obfuscate --split-debug-info=./symbols`

1. En Xcode, abre **Runner.xcworkspace**.
2. Selecciona **Product > Scheme > Edit Scheme...**. En la sección **Archive**, asegúrate de que el **Build Configuration** sea **Release**.
3. Selecciona **Product > Scheme > prod**.
4. Selecciona **Product > Destination > Any iOS Device (arm64)**.
5. Selecciona **Product > Archive**.
6. En la ventana **Organizer**, selecciona el archivo recién creado y haz clic en **Distribute App**.
7. Selecciona el método de distribución **App Store Connect**.
8. Selecciona **Upload** y sigue los pasos para subir la aplicación a TestFlight/App Store.
9. **Certificados:** Para este proceso se requiere un certificado de tipo **Distribution**, la cuenta de GNP debe asignarlo automaticamente.

### [Android]
---------

#### Compilación ambientes previos

La release APK para su aplicación se crea en <appdir>/build/app/outputs/flutter-apk/app-{ambiente}-release.apk

`flutter build apk --release --flavor qa --dart-define-from-file="config.json" --obfuscate --split-debug-info=./symbols --target-platform android-arm64`

`flutter build apk --release --flavor uat --dart-define-from-file="config.json" --obfuscate --split-debug-info=./symbols --target-platform android-arm64`

#### Compilación y despliegue ambiente de producción

Para generar el bundle de producción, es indispensable contar con el archivo del almacén de llaves (.jks) y el archivo `android/key.properties` correctamente configurados con los certificados de producción de GNP.

*   **Generación del Keystore:** Para generar el almacén de llaves se puede utilizar el comando `keytool`. Para más detalles consulta la [documentación oficial de Flutter](https://docs.flutter.dev/deployment/android#sign-the-app).
*   **Responsabilidad:** El **equipo de liberación** será el único responsable de generar, administrar, resguardar y mantener la vigencia de la llave (.jks) y sus credenciales.
*   **Ubicación de la llave:** El archivo `.jks` se debe colocar directamente en la carpeta `android/` del proyecto.
*   **Archivo android/key.properties:** Este archivo se debe generar y contener las siguientes propiedades:
    ```properties
    storePassword=<password-super-secreto-del-almacen>
    keyPassword=<password-super-secreto-de-la-llave>
    keyAlias=<alias-de-la-llave>
    storeFile=<nombre-del-archivo>.jks
    ```
    *(Nota: Al colocar el archivo .jks en la carpeta `android/`, el valor de `storeFile` solo requiere el nombre del archivo).*

*   **Nota de Seguridad:** Los archivos `android/key.properties` y el archivo `.jks` **NUNCA** deben ser subidos al repositorio de código.

El release de AAB para el despliegue en tienda se genera en <appdir>/build/app/outputs/bundle/prodRelease/app-prod-release.aab

`flutter build appbundle --release --flavor prod --target-platform android-arm,android-arm64,android-x64 --dart-define-from-file="config.json" --obfuscate --split-debug-info=./symbols`

1. Ingresa a [Google Play Console](https://play.google.com/console/).
2. Selecciona la aplicación y navega a la sección de **Producción**.
3. Cargar el archivo `.aab` generado.
4. Carga los símbolos de depuración (archivos generados dentro de la carpeta `./symbols`) para visualizar errores legibles en la consola.

Dudas sobre el despliegue en la siguiente liga:
https://docs.flutter.dev/deployment/android

### [Web]
---------


`flutter build web --release --dart-define-from-file="config.json"`

