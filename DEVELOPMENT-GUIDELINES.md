# DEVELOPMENT GUIDELINES FOR THIS PROJECT

> *“Any fool can write code that a computer can understand.
> Good programmers write code that humans can understand.”
> — Martin Fowler*

## GNP Rules

[Lineamientos Arquitectura Apps](https://sites.google.com/gnp.com.mx/arquitectura-empresarial/lineamientos-arquitectura/moviles?authuser=0)

## Code rules

All rules were defined in [analysis_options](analysis_options.yaml), please follow these rules development to keep clean code in all project. These rules were defined to maintain the best code practices for development.

All code, files, etc. must be **written** in english, this simplifies the search of classes, methods, and everything what you want.

For more information:

* [Lint rules](https://dart.dev/tools/linter-rules)
* [Dart style guide](https://dart.dev/effective-dart/style)

Principles

* [Principles](https://scalastic.io/en/solid-dry-kiss)

**IMPORTANT**

To print on console, is prohibited the use of "print()". Rule defined [avoid_print](https://dart.dev/tools/linter-rules/avoid_print)

Use [logger](lib/core/utils/logger.dart) to print whatever you need.

## Compilation

Build executables.

`flutter build android --dart-define-from-file="config.json"`

`flutter build ios --dart-define-from-file="config.json"`

`flutter build web --dart-define-from-file="config.json"`

**IMPORTANT**

Avoid to share **"debug"** versions of android APK, iOS or web. Debug versions contains sensitive debug variables that exposes code.

# GetX Module Generation

Scripts examples to generate a correct folder structure module
`./scripts/generate_getx_module.sh login -o lib/src/modules`
`./scripts/generate_getx_module.bat login -o lib/src/modules`

*{module_name}* is used to generate brick (login in this example)

*-o* flag is optional, default output dir is *lib/src/modules*

## Project Structure

### Getx

[Getx](https://pub.dev/packages/get) is probably de most important library used in this project cause it manages different aspects of the project, like:

* State management
* Dependency injection.
* Route management.
* Responsive page.
* Middlewares.
* Bindings.
* etc.

Getx defines the structure of a project (like Bloc, Riverpood, etc), so its very important to understand it.

**Important**

The use of other state managers will be refused in merges.

### Root folder structure

root/
├── config.json
├── lib/
│   ├── core/
│   ├── src/
│   │   ├──app.dart     // main app
│   ├── shared/
└── └── main.dart

* core/ contains template of utilities, services, methods, widgets, etc. for all Flutter projects.
* modules/ defines every module (feature) used by the app. Like "Home", "Login", "Settings", etc.
* shared/ contains all models, providers, widgets, etc. to use ONLY in current project.

### Core folder structure
This folder contains all utilities, services, methods, widgets, etc. for all Flutter projects.

core/
├── config/
│   ├── flavor_config.dart // all flavors environment variables are loaded here.
│   ├── uris_config.dart // all uris environment variables are loaded here.
├── messages/   // main messages files
├── services/
│   ├── navigation/     // main service file to nav along the app
│   ├── network/        // main network file. (connectivity status, etc.)
│   ├── security/       // security file for encryption/decryption
│   ├── storage/        // storage file for local data
│   ├── threads/        // threads file for async tasks
│   ├── ui/             // ui file for theme management
├── utils/              // utils file for logger, exceptions, etc.


### Shared folder structure

Shared folder contains all common/shared models that can be used along the app.
- messages is the main folder to setup internationalization messages.
- models (incoming and outgoing) are used to retrieve/send information from web services and must be used by providers.
- network providers must be used inside {module_name}_repository.dart
- widgets that are used in whole app. 
** IMPORTANT ** Build new subcomponents of each widget with factory method, this avoid use of multiple name widgets that may cause confusion. 

shared/
├── messages/
│   ├── i_app_messages.dart
│   ├── es
│       ├── es_messages.dart
│   └── us
│       ├── us_messages.dart
│   └── ...        
├── models/
│   ├── incoming
│       ├── user_request.dart
│   └── outgoing
│       ├── user_response.dart
├── widgets/
│   ├── button
│       ├── app_button.dart
├── network/
│   ├── providers/
│   │   ├── user_api_provider.dart
│   │   ├── policy_api_provider.dart
│   │   └── ...
└── ...

### Modules folder structure

We use [mason](https://pub.dev/packages/mason) to generate templates of folders and files to mantain same structure in whole project.

For more information follow the next [link](https://himanshu-agarwal.medium.com/revolutionize-your-flutter-workflow-a-complete-code-generation-guide-to-mason-9215ca5a13ed)

To activate mason only run

`flutter pub get`

`dart pub global activate mason_cli`

This should be enough to start using the scripts defined in GetX Module generation.

The */bricks* folder contains mason bricks used in this project, the most relevant is *getx_module*

#### Structure

* @: Mandatory "part of {module_name}_page.dart" directive
* **: Mandatory files

Every single module
{module_name}/
├── {module_name}_page.dart **          // The main entry point for the page, responsible for loading responsive views
├── {module_name}_controller.dart ** @  // The controller for the main module logic
├── {module_name}_bindings.dart ** @    // Defines dependencies for the module's controller
├── {module_name}_middleware.dart ** @  // Middleware for route protection or redirection
├── {module_name}_model.dart ** @       // Data model to use on page
├── responsive/
│   ├── {module_name}_phone_page.dart ** @      // UI for phone screens
│   ├── {module_name}_tablet_page.dart ** @     // UI for tablet screens
│   └── {module_name}_desktop_page.dart ** @    // UI for desktop/web screens
├── utils/
│   ├── constants/
│   ├── extensions/
├── data/
│   ├── local/
│       └── {module_name}_repository.dart     // Local data provider.
│   ├── remote/
│       └── {module_name}_repository.dart     // Remote data provider.
├── widgets/
│   ├── {module_name}_card.dart         // Reusable UI components specific to this module
│   └── {module_name}_form_field.dart   // Reusable UI components specific to this module
└── children/
│   ├── {module_child_name}/             // Nested module, structured equals to parent (its own page, controller, etc.)
│   │   ├── {module_child_name}_page.dart
│   │   ├── {module_child_name}_controller.dart
│   │   └── ...
└── └── {module_child_name_2}/
└── ...
