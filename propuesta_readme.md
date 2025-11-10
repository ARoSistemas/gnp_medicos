# 🏥 Médicos GNP - Medical Platform

---

## 📑 Table of Contents

- [📝 Description](#-description)
- [🏆 Project Quality & Architecture](#-project-quality--architecture)
- [🚀 Quick Start](#-quick-start)
- [🛠️ Requirements](#-requirements)
- [📦 Technologies & Tools](#-technologies--tools)
- [🧩 Design Patterns](#-design-patterns)
- [🗂️ Project Structure](#-project-structure)
- [🎯 Main Features](#-main-features)
- [⚙️ Project Setup](#-project-setup)
- [🧪 Testing & Coverage](#-testing--coverage)
- [🔧 GetX Module Generation](#-getx-module-generation)
- [🌐 Multi-Environment Support](#-multi-environment-support)
- [📱 Responsive Design](#-responsive-design)
- [🔐 Security Features](#-security-features)
- [📚 Documentation](#-documentation)
- [🤝 Contribution](#-contribution)
- [📄 License](#-license)

---

## 📝 Description

Médicos GNP is a Flutter medical platform application designed for healthcare professionals and patients. It provides secure authentication, biometric login, and a comprehensive modular architecture following GNP's enterprise guidelines. The application supports multiple environments (QA, UAT, PRO) and implements responsive design for phone, tablet, and desktop platforms.

---

## 🏆 Project Quality & Architecture

This project demonstrates enterprise-level Flutter development with comprehensive architecture, security, and scalability considerations following GNP's architectural guidelines.


### 🎯 Architecture Highlights

- **🏗️ GetX Architecture:** Complete state management, dependency injection, and navigation
- **📱 Responsive Design:** Support for phone, tablet, and desktop platforms
- **🔐 Security First:** Biometric authentication, encryption, and secure storage
- **🌐 Multi-Environment:** QA, UAT, and PRO environments with flavor configuration
- **📚 Internationalization:** Multi-language support with Spanish as primary
- **⚡ Performance:** Optimized for fast loading and smooth user experience

### 📊 Code Quality Standards

| **SOLID Principles** | **DRY & KISS Principles** | **Code Standards** |
|:---|:---|:---|
| **S** - Single Responsibility | **DRY** - Don't Repeat Yourself | **📝** English-only code |
| **O** - Open/Closed | **KISS** - Keep It Simple | **🚫** No print() statements |
| **L** - Liskov Substitution | **🔄** Eliminate duplication | **📏** Strict linting rules |
| **I** - Interface Segregation | **🎯** Simple solutions | **📚** Complete documentation |
| **D** - Dependency Inversion | **🧹** Clean abstractions | **🏭** Factory pattern widgets |

### 🏆 Quality Enforcement

- **📝 English-Only Code:** All code, files, and documentation in English
- **🚫 No print() Statements:** Mandatory use of logger utility
- **📐 Strict Linting:** Comprehensive analysis_options.yaml rules
- **🏭 Factory Pattern:** Widget subcomponents with factory methods
- **📚 Documentation:** Complete DartDoc for all public APIs
- **🔍 Code Review:** Mandatory review process for all merges

---

## 🚀 Quick Start

```bash
git clone https://gitlab.com/gitgnp/gcp/nueva-administracion-proveedores/gae-gnp-admonproveedoressalud-medicos-front.git

cd gae-gnp-admonproveedoressalud-medicos-front

flutter pub get

flutter run --flavor qa -t lib/main.dart
```

---

## 🛠️ Requirements

```ssh
[√] Flutter (Channel stable, 3.32.8+)
[√] Windows 10/11 or higher / macOS 26.0.1
[√] Android toolchain (SDK 36+)
[√] Chrome (for web development)
[√] Visual Studio 2022  
[√] Android Studio (latest version)
[√] VS Code with Flutter extensions
```

---

## 📦 Technologies & Tools

### Core Framework
- **Framework:** Dart 3.8.1+
- **State Management:** GetX 4.7.2
- **Navigation:** GetX Navigation with Middlewares
- **Dependency Injection:** GetX Service Locator

### Security & Authentication
- **Local Authentication:** local_auth 2.3.0 (Biometrics)
- **Encryption:** encrypt 5.0.3
- **Secure Storage:** get_storage 2.1.1

### UI & Theming
- **Theme Management:** flex_color_scheme 8.2.0
- **Responsive Design:** Custom GetResponsiveView
- **Icons:** cupertino_icons 1.0.8

### Development Tools
- **Code Generation:** Mason CLI with custom bricks
- **Logging:** logger 2.6.1
- **Device Info:** device_info_plus 11.5.0
- **Package Info:** package_info_plus 8.3.0

---

## 🧩 Design Patterns

- **GetX Pattern:** Complete reactive state management with GetX controllers
- **Repository Pattern:** Data abstraction with local and remote repositories
- **Service Locator:** Centralized dependency injection with GetX services
- **Modular Architecture:** Feature-based module organization
- **Responsive View Pattern:** Adaptive UI components for different screen sizes
- **Middleware Pattern:** Route protection and navigation guards
- **Observer Pattern:** Reactive programming with GetX observables

---

## 🗂️ Project Structure

```plaintext
📁 NameProject/
├── 📁 lib/
│   ├── 📁 core/                           # Core utilities and services
│   │   ├── 📁 config/                     # App configuration
│   │   │   ├── 📄 flavor_config.dart      # Environment variables (QA, UAT, PRO)
│   │   │   └── 📄 uris_config.dart        # API endpoints configuration
│   │   ├── 📁 extensions/                 # Dart extensions
│   │   ├── 📁 messages/                   # Core internationalization
│   │   ├── 📁 services/                   # Core services
│   │   │   ├── 📁 alerts/                 # Notification service
│   │   │   ├── 📁 navigation/             # Navigation service
│   │   │   ├── 📁 network/                # Network connectivity
│   │   │   ├── 📁 security/               # Encryption service
│   │   │   ├── 📁 storage/                # Local storage service
│   │   │   ├── 📁 threads/                # Threading service
│   │   │   └── 📁 ui/                     # UI and theme services
│   │   └── 📁 utils/                      # Utilities and logger
│   │
│   ├── 📁 shared/                         # Shared components
│   │   ├── 📁 messages/                   # Internationalization
│   │   │   └── 📁 es/                     # Spanish translations
│   │   ├── 📁 models/                     # Data models
│   │   │   ├── 📁 incoming/               # Request models
│   │   │   └── 📁 outgoing/               # Response models
│   │   ├── 📁 navigation/                 # App navigation configuration
│   │   ├── 📁 services/                   # Shared services
│   │   │   └── 📁 storage/                # User storage
│   │   ├── 📁 utils/                      # Shared utilities
│   │   └── 📁 widgets/                    # Reusable widgets
│   │
│   ├── 📁 src/                            # Application source
│   │   ├── 📄 app.dart                    # Main app configuration
│   │   └── 📁 modules/                    # Feature modules
│   │       ├── 📁 intro/                  # Intro/Onboarding module
│   │       │   ├── 📄 intro_page.dart     # Main page entry
│   │       │   ├── 📄 intro_controller.dart # Business logic
│   │       │   ├── 📄 intro_bindings.dart # Dependency injection
│   │       │   ├── 📄 intro_middleware.dart # Route protection
│   │       │   ├── 📄 intro_model.dart    # Data model
│   │       │   └── 📁 responsive/         # Responsive views
│   │       │       ├── 📄 intro_phone_page.dart
│   │       │       ├── 📄 intro_tablet_page.dart
│   │       │       └── 📄 intro_desktop_page.dart
│   │       └── 📁 login/                  # Login module
│   │           ├── 📄 login_page.dart     # Main page entry
│   │           ├── 📄 login_controller.dart # Authentication logic
│   │           ├── 📄 login_bindings.dart # Dependency injection
│   │           ├── 📄 login_middleware.dart # Auth middleware
│   │           ├── 📄 login_model.dart    # Login data model
│   │           ├── 📁 services/           # Login-specific services
│   │           └── 📁 responsive/         # Responsive views
│   │               ├── 📄 login_phone_page.dart
│   │               ├── 📄 login_tablet_page.dart
│   │               └── 📄 login_desktop_page.dart
│   │
│   └── 📄 main.dart                       # App entry point
│
├── 📁 assets/                             # Static assets
│   ├── 📄 logo-gnp.png                   # Brand assets
│   ├── 📄 banner-home.png                # UI images
│   └── ...                               # Other assets
│
├── 📁 bricks/                             # Mason code generation
│   └── 📁 getx_module/                   # GetX module template
│       ├── 📄 brick.yaml                 # Brick configuration
│       └── 📁 __brick__/                 # Template files
│
├── 📁 android/                           # Android platform
├── 📁 ios/                               # iOS platform
├── 📁 web/                               # Web platform
├── 📁 windows/                           # Windows platform
├── 📁 linux/                             # Linux platform
├── 📁 macos/                             # macOS platform
│
├── 📄 pubspec.yaml                       # Dependencies and configuration
├── 📄 analysis_options.yaml              # Code analysis rules
├── 📄 mason.yaml                         # Mason configuration
└── 📄 DEVELOPMENT-GUIDELINES.md          # Development guidelines
```

### 🗣️ Directory Overview

- **core/**: Universal utilities, services, and configurations for Flutter projects
- **shared/**: Project-specific shared components, models, and widgets
  - **messages/**: Internationalization with i_app_messages.dart interface
  - **models/incoming**: Request models for API calls
  - **models/outgoing**: Response models from web services  
  - **network/providers**: API providers (user_api_provider.dart, policy_api_provider.dart)
  - **widgets**: Reusable UI components with factory method pattern
  - **services/storage**: User-specific storage services
- **src/modules/**: Feature-based modules following GetX architecture
- **assets/**: Static resources (images, icons, brand assets)
- **bricks/**: Mason templates for automated code generation

---

## 🎯 Main Features

### 🔐 Authentication & Security
- **Biometric Login:** Fingerprint and face recognition support
- **Secure Storage:** Encrypted local data storage
- **Session Management:** Secure user session handling
- **Multi-factor Authentication:** Enhanced security protocols

### 📱 User Interface
- **Responsive Design:** Adaptive UI for phone, tablet, and desktop
- **Dark/Light Theme:** Complete theme switching support
- **Multi-language:** Spanish primary with extensible i18n
- **Smooth Animations:** Fluid user experience with GetX transitions

### 🏥 Medical Platform Features
- **Patient Management:** Comprehensive patient data handling
- **Medical Records:** Secure medical documentation
- **Appointment System:** Scheduling and management
- **Integration Ready:** Prepared for medical APIs and services

---

## ⚙️ Project Setup

### 1. Clone the Repository
```bash
git clone https://github.com/ARoSistemas/Médicos_gnp.git
cd Médicos_gnp
```

### 2. Install Dependencies
```bash
flutter pub get
```

### 3. Setup Mason (for module generation)
```bash
# Activate Mason CLI globally
dart pub global activate mason_cli

# Get Mason dependencies
mason get
```

### 4. Run the Application

#### Development (QA Environment)
```bash
flutter run --flavor qa -t lib/main.dart --dart-define=flavor=QA --dart-define=appName="Medicos QA"
```

#### UAT Environment
```bash
flutter run --flavor uat -t lib/main.dart --dart-define=flavor=UAT --dart-define=appName="Medicos UAT"
```

#### Production
```bash
flutter run --flavor pro -t lib/main.dart --dart-define=flavor=PRO --dart-define=appName="Medicos"
```

---

## 🧪 Testing & Coverage

### 🎯 Test Strategy

Our testing approach ensures reliability across all layers of the application.

```bash
📊 Test Coverage Areas:
├── 🔧 Unit Tests: Controller logic and business rules
├── 🎨 Widget Tests: UI components and responsive layouts
├── 🚀 Integration Tests: Service integration and data flow
└── 📱 End-to-End: Complete user journey testing
```

### 🧪 Running Tests

```bash
# Run all tests
flutter test

# Run tests with coverage
flutter test --coverage

# Generate HTML coverage report
genhtml coverage/lcov.info -o coverage/html

# Open coverage report
start coverage/html/index.html  # Windows
open coverage/html/index.html   # macOS
```

### 🛡️ Code Quality

```bash
# Analyze code quality
flutter analyze

# Check for formatting issues
dart format --set-exit-if-changed .

# Run all quality checks
flutter analyze && flutter test --coverage
```

---

## 🔧 GetX Module Generation

### 🚀 Automated Module Creation

Use Mason bricks to generate complete GetX modules with proper structure:

```bash
# Generate a new module
./scripts/generate_getx_module.sh patient -o lib/src/modules

# Windows
./scripts/generate_getx_module.bat patient -o lib/src/modules
```

### 📋 Complete Generated Module Structure

```plaintext
📁 {module_name}/
├── 📄 {module_name}_page.dart **                  # Main responsive entry point
├── 📄 {module_name}_controller.dart ** @          # Business logic controller  
├── 📄 {module_name}_bindings.dart ** @            # Dependency injection
├── 📄 {module_name}_middleware.dart ** @          # Route protection/redirection
├── 📄 {module_name}_model.dart ** @               # Data model for the page
├── 📁 data/
│   ├── 📁 local/                                  # Local data provider
│   │   └── 📄 {module_name}_repository.dart       # Local storage operations
│   └── 📁 remote/                                 # Remote data provider
│       └── 📄 {module_name}_repository.dart       # API integration
├── 📁 responsive/
│   ├── 📄 {module_name}_phone_page.dart ** @      # Mobile UI implementation
│   ├── 📄 {module_name}_tablet_page.dart ** @     # Tablet UI implementation  
│   └── 📄 {module_name}_desktop_page.dart ** @    # Desktop/web UI implementation
├── 📁 utils/
│   ├── 📁 constants/                              # Module-specific constants
│   └── 📁 extensions/                             # Module-specific extensions
├── 📁 widgets/
│   ├── 📄 {module_name}_card.dart                 # Reusable UI components
│   └── � {module_name}_form_field.dart           # Form components
├── 📁 services/                                   # Business logic services
└── 📁 children/                                   # Nested sub-modules
    ├── 📁 {module_child_name}/                    # Child module structure
    │   ├── 📄 {module_child_name}_page.dart       # (Same structure as parent)
    │   ├── � {module_child_name}_controller.dart
    │   └── ...
    └── 📁 {module_child_name_2}/
```

### 📋 File Annotations

- **`**`**: Mandatory files for every module
- **`@`**: Requires "part of {module_name}_page.dart" directive
- **Repository Usage**: Network providers must be used inside `{module_name}_repository.dart`
- **Widget Factory**: Build subcomponents with factory methods to avoid naming confusion

### ⚙️ Module Integration

1. **Add to Navigation:** Register in `lib/shared/navigation/app_navigation.dart`
2. **Configure Routes:** Set up navigation paths and parameters
3. **Implement Services:** Add business logic and API integration
4. **Create UI:** Develop responsive views for all platforms

---

## 🌐 Multi-Environment Support

### 🎛️ Flavor Configuration

```dart
// Environment configuration
enum Flavors {
  qa('QA'),      // Development environment
  uat('UAT'),    // User acceptance testing
  pro('PRO');    // Production environment
}
```

### 🔧 Environment Variables

```bash
# QA Environment
--dart-define=flavor=QA
--dart-define=appName="Medicos QA"
--dart-define=apiUrl="https://api-qa.gnp.com"

# UAT Environment  
--dart-define=flavor=UAT
--dart-define=appName="Medicos UAT"
--dart-define=apiUrl="https://api-uat.gnp.com"

# Production
--dart-define=flavor=PRO
--dart-define=appName="Medicos"
--dart-define=apiUrl="https://api.gnp.com"
```

### 🏗️ Build Configurations

#### Production Builds with config.json

```bash
# Android builds
flutter build apk --dart-define-from-file="config.json"
flutter build appbundle --dart-define-from-file="config.json"

# iOS builds  
flutter build ios --dart-define-from-file="config.json"

# Web builds
flutter build web --dart-define-from-file="config.json"

# Windows builds
flutter build windows --dart-define-from-file="config.json"
```

#### Environment-Specific Builds

```bash
# Flavor-based builds
flutter build apk --flavor qa --dart-define-from-file="config_qa.json"
flutter build apk --flavor uat --dart-define-from-file="config_uat.json" 
flutter build apk --flavor pro --dart-define-from-file="config_pro.json"
```

#### ⚠️ Important Build Security

**NEVER** share debug versions of APK, iOS or web builds. Debug versions contain:
- Sensitive debug variables
- Code exposure vulnerabilities  
- Development endpoints
- Debugging information

Always use **release builds** for distribution:

```bash
# Secure release builds
flutter build apk --release --dart-define-from-file="config.json"
flutter build ios --release --dart-define-from-file="config.json"
```

---

## 📱 Responsive Design

### 🎨 GetResponsiveView Implementation

Every module implements responsive design through GetX's responsive view system:

```dart
class PatientPage extends GetResponsiveView<PatientController> {
  @override
  Widget? phone() => PatientPhonePage();    // Mobile UI
  
  @override  
  Widget? tablet() => PatientTabletPage();  // Tablet UI
  
  @override
  Widget? desktop() => PatientDesktopPage(); // Desktop UI
}
```

### 📐 Breakpoint Configuration

```dart
// Responsive breakpoints
- Phone: < 600px width
- Tablet: 600px - 1200px width  
- Desktop: > 1200px width
```

### 🎯 Design Principles

- **Mobile First:** Primary development for mobile devices
- **Adaptive Layouts:** Components adjust to screen size and orientation
- **Touch Optimization:** Proper touch targets and gesture handling
- **Performance:** Optimized rendering for each platform

---

## 🔐 Security Features

### 🛡️ Authentication Security

```dart
// Biometric authentication
- Fingerprint recognition
- Face ID/Face unlock
- PIN/Pattern fallback
- Session timeout management
```

### 🔒 Data Protection

```dart
// Encryption and storage
- AES encryption for sensitive data
- Secure local storage with GetStorage
- Network request encryption
- Certificate pinning (planned)
```

### 🚨 Security Protocols

- **Input Validation:** Comprehensive form validation
- **SQL Injection Prevention:** Parameterized queries
- **XSS Protection:** Input sanitization
- **HTTPS Enforcement:** Secure network communication

---

## 📚 Documentation

### 📖 Development Guidelines

Complete development guidelines are available in:
- `DEVELOPMENT-GUIDELINES.md` - Comprehensive development rules
- `_DEVELOPMENT-GUIDELINES.md` - Extended documentation with examples

### 🎯 Code Standards & Principles

#### 📜 GNP Development Rules

Follow [GNP Enterprise Architecture Guidelines](https://sites.google.com/gnp.com.mx/arquitectura-empresarial/lineamientos-arquitectura/moviles):

```dart
// Core Development Rules
✅ English-only code, files, and documentation
✅ Comprehensive DartDoc for all public APIs
✅ Strict linting with analysis_options.yaml
✅ Logger utility instead of print() statements
✅ Factory pattern for widget subcomponents
✅ SOLID, DRY, KISS principles adherence
```

#### 🏗️ Architecture Principles

- **SOLID Principles:** Single responsibility, Open/closed, Liskov substitution, Interface segregation, Dependency inversion
- **DRY (Don't Repeat Yourself):** Eliminate code duplication through proper abstractions
- **KISS (Keep It Simple, Stupid):** Maintain simplicity and readability
- **Clean Architecture:** Clear separation of concerns and dependency direction

#### 📋 Code Quality Rules

```dart
// Lint Rules References
- Dart Linter Rules: https://dart.dev/tools/linter-rules
- Dart Style Guide: https://dart.dev/effective-dart/style
- SOLID Principles: https://scalastic.io/en/solid-dry-kiss
```

#### 🚫 Prohibited Practices

```dart
// ❌ NEVER use print() for logging
print('Debug message'); // FORBIDDEN

// ✅ ALWAYS use logger utility
logger.i('Info message');
logger.d('Debug message');
logger.e('Error message');
```

#### 🏭 Widget Factory Pattern

```dart
// ✅ Correct: Factory method approach
class AppButton extends StatelessWidget {
  // Main constructor
  const AppButton({required this.text, super.key});
  
  // Factory constructors for variants
  factory AppButton.primary(String text) => AppButton(
    text: text,
    style: AppButtonStyle.primary,
  );
  
  factory AppButton.secondary(String text) => AppButton(
    text: text, 
    style: AppButtonStyle.secondary,
  );
}

// ❌ Avoid: Multiple widget classes
// AppPrimaryButton, AppSecondaryButton, etc.
```

### 📝 API Documentation

```bash
# Generate API documentation
dart doc .

# View documentation
start doc/api/index.html  # Windows
open doc/api/index.html   # macOS
```

### 🏗️ Architecture Documentation

- **GetX Patterns:** State management and dependency injection
- **Module Structure:** Feature-based organization
- **Service Layer:** Core services and utilities
- **Navigation:** Declarative routing with middlewares

---

## 🤝 Contribution

### 🔄 Development Workflow

1. **Fork the repository**
2. **Create a feature branch:**
   ```bash
   git checkout -b feature/new-medical-feature
   ```
3. **Follow coding standards:**
   - Use English for all code and comments
   - Follow the established GetX module structure
   - Add comprehensive tests
   - Update documentation
4. **Commit changes:**
   ```bash
   git commit -m "feat: add new medical feature"
   ```
5. **Push and create Pull Request:**
   ```bash
   git push origin feature/new-medical-feature
   ```

### 📋 Contribution Guidelines

- **Code Quality:** Maintain zero lint warnings/errors
- **Testing:** Add tests for new features
- **Documentation:** Update relevant documentation
- **Security:** Follow security best practices
- **Architecture:** Maintain GetX patterns and structure

### 🎯 Review Process

- Code review by senior developers
- Automated testing pipeline
- Security assessment for sensitive features
- Architecture compliance verification

---

## 📄 License

This project is licensed under the MIT License. See the LICENSE file for details.

---

## 🏥 About GNP

This application is developed following GNP's enterprise architectural guidelines for mobile applications. For more information about GNP's development standards, visit the [GNP Architecture Guidelines](https://sites.google.com/gnp.com.mx/arquitectura-empresarial/lineamientos-arquitectura/moviles).

---

**Made with ❤️ by ARoSistemas for GNP Healthcare Platform**