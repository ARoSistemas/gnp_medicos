import 'dart:ui';

import 'package:medicos/core/messages/i_messages.dart';
import 'package:medicos/core/messages/messages.dart';
import 'package:medicos/shared/messages/i_app_messages.dart';

final esMessages = _ESMessages._();

class _ESMessages {
  _ESMessages._();

  IAppMessages get mx => _MX._();
}

class _MX extends IAppMessages {
  _MX._();

  @override
  Locale get locale => const Locale(
    LanguageCodes.es,
    CountryCodes.mx,
  );

  @override
  MsgProperty get welcome => MsgProperty(
    key: 'welcome',
    value: '¡Bienvenido!',
    pValue: 'Bienvenidos',
    eValue: 'No hay bienvenida',
  );

  @override
  MsgProperty get dark => MsgProperty(
    key: 'dark',
    value: 'Obscuro',
  );

  @override
  MsgProperty get light => MsgProperty(
    key: 'light',
    value: 'Claro',
  );

  @override
  MsgProperty get system => MsgProperty(
    key: 'system',
    value: 'Sistema',
  );

  @override
  MsgProperty get settings => MsgProperty(
    key: 'settings',
    value: 'Configuración',
  );

  @override
  MsgProperty get signOut => MsgProperty(
    key: 'signOut',
    value: 'Cerrar sesión',
  );

  @override
  MsgProperty get changeUser => MsgProperty(
    key: 'changeUser',
    value: 'Cambiar usuario',
  );

  @override
  MsgProperty get user => MsgProperty(
    key: 'user',
    value: 'Usuario',
    pValue: 'Usuarios',
  );

  @override
  MsgProperty get email => MsgProperty(
    key: 'email',
    value: 'Correo electrónico',
  );

  @override
  MsgProperty get forgotPassword => MsgProperty(
    key: 'forgotPassword',
    value: '¿Olvidaste tu contraseña?',
  );

  @override
  MsgProperty get changePassword => MsgProperty(
    key: 'changePassword',
    value: 'Cambiar contraseña',
  );

  @override
  MsgProperty get password => MsgProperty(
    key: 'password',
    value: 'Contraseña',
  );

  @override
  MsgProperty get loginBiometrics => MsgProperty(
    key: 'loginBiometrics',
    value: 'Ingresa con biométricos',
  );

  @override
  MsgProperty get dontHaveAccount => MsgProperty(
    key: 'dontHaveAccount',
    value: '¿No tienes una cuenta?',
  );

  @override
  MsgProperty get registerNow => MsgProperty(
    key: 'registerNow',
    value: 'Crear cuenta',
  );

  @override
  MsgProperty get enterYourEmail => MsgProperty(
    key: 'enterYourEmail',
    value: 'Ingresa el correo electrónico',
  );

  @override
  MsgProperty get sendLink => MsgProperty(
    key: 'sendLink',
    value: 'Enviar link',
  );

  @override
  MsgProperty get deleteAccount => MsgProperty(
    key: 'deleteAccount',
    value: 'Eliminar cuenta',
  );

  @override
  MsgProperty get identify => MsgProperty(
    key: 'identify',
    value: 'Identifícate',
  );

  @override
  MsgProperty get welcomeApp => MsgProperty(
    key: 'welcomeApp',
    value: 'Bienvenido',
  );

  @override
  MsgProperty get activateFingerprintFace => MsgProperty(
    key: 'activateFingerprintFace',
    value: 'Activa tu huella o rostro',
  );

  @override
  MsgProperty get quickLogin => MsgProperty(
    key: 'quickLogin',
    value: 'Inicio de sesión rápido',
  );

  @override
  MsgProperty get myProfile => MsgProperty(
    key: 'myProfile',
    value: 'Mi perfil',
  );

  @override
  MsgProperty get doctorsInformation => MsgProperty(
    key: 'doctorsInformation',
    value: 'Datos del médico',
  );

  @override
  MsgProperty get personalData => MsgProperty(
    key: 'personalData',
    value: 'Datos personales',
  );

  @override
  MsgProperty get academicData => MsgProperty(
    key: 'academicData',
    value: 'Datos académicos',
  );

  @override
  MsgProperty get taxData => MsgProperty(
    key: 'taxData',
    value: 'Datos fiscales',
  );

  @override
  MsgProperty get taxDataAccounts => MsgProperty(
    key: 'taxDataAccounts',
    value: 'Datos Fiscales - Cuentas',
  );

  @override
  MsgProperty get assistants => MsgProperty(
    key: 'assistants',
    value: 'Asistente',
    pValue: 'Asistentes',
    eValue: 'Sin asistentes',
  );

  @override
  MsgProperty get myUsers => MsgProperty(
    key: 'myUsers',
    value: 'Mis usuarios',
    pValue: 'Mi usuario',
    eValue: 'Sin usuarios',
  );

  @override
  MsgProperty get continueB => MsgProperty(
    key: 'continueB',
    value: 'Continuar',
  );

  @override
  MsgProperty get login => MsgProperty(
    key: 'login',
    value: 'Iniciar sesión',
  );

  @override
  MsgProperty get cancel => MsgProperty(
    key: 'cancel',
    value: 'Cancelar',
  );

  @override
  MsgProperty get welcomeHome => MsgProperty(
    key: 'welcome',
    value: 'Bienvenido',
  );

  @override
  MsgProperty get selectProfile => MsgProperty(
    key: 'selectProfile',
    value: 'Selecciona el perfil del doctor al que deseas acceder.',
  );

  @override
  MsgProperty get myAccess => MsgProperty(
    key: 'myAccess',
    value: 'Mis accesos',
  );

  @override
  MsgProperty get noAssistantsToShow => MsgProperty(
    key: 'noAssistantsToShow',
    value: 'Sin asistentes para mostrar',
  );

  @override
  MsgProperty get noInformationToShow => MsgProperty(
    key: 'noInformationToShow',
    value: 'Sin información para mostrar',
  );

  @override
  MsgProperty get loadingInformation => MsgProperty(
    key: 'loadingInformation',
    value: 'Cargando información...',
  );

  @override
  MsgProperty get addAssistant => MsgProperty(
    key: 'addAssistant',
    value: 'Agregar usuario',
  );

  @override
  MsgProperty get errorLoadingInvites => MsgProperty(
    key: 'errorLoadingInvites',
    value: 'Error al cargar invitaciones',
  );

  @override
  MsgProperty get errorLoadingAssistants => MsgProperty(
    key: 'errorLoadingAssistants',
    value: 'Error al cargar asistentes.',
  );

  @override
  MsgProperty get errorLoadingForm => MsgProperty(
    key: 'errorLoadingForm',
    value: 'Error al cargar el formulario',
  );

  @override
  MsgProperty get errorLoadingInfo => MsgProperty(
    key: 'errorLoadingInfo',
    value: 'Error al cargar la información',
  );

  @override
  MsgProperty get pleaseTryAgainLater => MsgProperty(
    key: 'pleaseTryAgainLater',
    value: 'Por favor, inténtalo más tarde.',
  );

  @override
  MsgProperty get loadingData => MsgProperty(
    key: 'loadingData',
    value: 'Cargando datos',
  );

  @override
  MsgProperty get accept => MsgProperty(
    key: 'accept',
    value: 'Aceptar',
  );

  @override
  MsgProperty get acceptAndContinue => MsgProperty(
    key: 'acceptAndContinue',
    value: 'Aceptar y continuar',
  );

  @override
  MsgProperty get disableUser => MsgProperty(
    key: 'disableUser',
    value: '¿Estas seguro de deshabilitar el usuario?',
  );

  @override
  MsgProperty get enableUser => MsgProperty(
    key: 'enableUser',
    value: '¿Estas seguro de habilitar el usuario?',
  );

  @override
  MsgProperty get disableAssistant => MsgProperty(
    key: 'disableAssistant',
    value: 'Se deshabilitará el asistente',
  );

  @override
  MsgProperty get enableAssistant => MsgProperty(
    key: 'enableAssistant',
    value: 'Se habilitará el asistente',
  );

  @override
  MsgProperty get generalData => MsgProperty(
    key: 'generalData',
    value: 'Datos Generales',
  );

  @override
  MsgProperty get permissions => MsgProperty(
    key: 'permissions',
    value: 'Permisos',
  );

  @override
  MsgProperty get updateUser => MsgProperty(
    key: 'updateUser',
    value: 'Actualizar usuario',
  );

  @override
  MsgProperty get registerUser => MsgProperty(
    key: 'registerUser',
    value: 'Registrar usuario',
  );

  @override
  MsgProperty get newUser => MsgProperty(
    key: 'newUser',
    value: 'Nuevo usuario',
  );

  @override
  MsgProperty get name => MsgProperty(
    key: 'name',
    value: 'Nombre',
    pValue: 'Nombre(s)',
  );

  @override
  MsgProperty get lastName => MsgProperty(
    key: 'lastName',
    value: 'Apellido paterno',
  );

  @override
  MsgProperty get secondLastName => MsgProperty(
    key: 'secondLastName',
    value: 'Apellido materno',
  );

  @override
  MsgProperty get notLastName => MsgProperty(
    key: 'notLastName',
    value: 'Primer Apellido',
  );
  @override
  MsgProperty get notSecondLastName => MsgProperty(
    key: 'notSecondLastName',
    value: 'Segundo Apellido',
  );

  @override
  MsgProperty get phoneNumber => MsgProperty(
    key: 'phoneNumber',
    value: 'Número celular',
  );

  @override
  MsgProperty get birthdate => MsgProperty(
    key: 'birthdate',
    value: 'Fecha de nacimiento',
  );

  @override
  MsgProperty get typeUser => MsgProperty(
    key: 'typeUser',
    value: 'Tipo de usuario',
  );

  @override
  MsgProperty get stepOneOfTwo => MsgProperty(
    key: 'stepOneOfTwo',
    value: 'Paso 1 de 2',
  );

  @override
  MsgProperty get stepTwoOfTwo => MsgProperty(
    key: 'stepTwoOfTwo',
    value: 'Paso 2 de 2',
  );

  @override
  MsgProperty get selectOneOrMoreOptions => MsgProperty(
    key: 'selectOneOrMoreOptions',
    value: 'Selecciona una o más opciones',
  );

  @override
  MsgProperty get clabe => MsgProperty(
    key: 'clabe',
    value: 'CLABE',
  );

  @override
  MsgProperty get numberAccount => MsgProperty(
    key: 'numberAccount',
    value: 'No. de cuenta',
  );

  @override
  MsgProperty get pleaseWait => MsgProperty(
    key: 'pleaseWait',
    value: 'Por favor, espere...',
  );

  @override
  MsgProperty get errorLoadingContact => MsgProperty(
    key: 'errorLoadingContact',
    value: 'Error al cargar los datos de contacto.',
  );

  @override
  MsgProperty get noInvites => MsgProperty(
    key: 'noInvites',
    value: 'Sin invitaciones',
  );

  @override
  MsgProperty get noActiveInvites => MsgProperty(
    key: 'noActiveInvites',
    value: 'No tiene invitaciones activas',
  );

  @override
  MsgProperty get noForm => MsgProperty(
    key: 'noForm',
    value: 'Sin formulario para mostrar',
  );

  @override
  MsgProperty get annexes => MsgProperty(
    key: 'annexes',
    value: 'Anexos',
  );

  @override
  MsgProperty get medicalReport => MsgProperty(
    key: 'medicalReport',
    value: 'Informe médico',
  );

  @override
  MsgProperty get requestMedicalAgreement => MsgProperty(
    key: 'requestMedicalAgreement',
    value:
        'Sube todos los documentos '
        'requeridos para complementar tu solicitud '
        'de convenio. Los archivos deben estar en formato PDF o JPG.',
  );

  @override
  MsgProperty get paymentNumber => MsgProperty(
    key: 'paymentNumber',
    value: 'Número de pago',
  );

  @override
  MsgProperty get paymentManual => MsgProperty(
    key: 'paymentManual',
    value: 'Manual de pagos',
  );

  @override
  MsgProperty get glossaryTerms => MsgProperty(
    key: 'glossaryTerms',
    value: 'Glosario de términos',
  );

  @override
  MsgProperty get levelsAndTabs => MsgProperty(
    key: 'levelsAndTabs',
    value: 'Niveles y tabuladores',
  );

  @override
  MsgProperty get benefits => MsgProperty(
    key: 'benefits',
    value: 'Beneficios',
  );

  @override
  MsgProperty get gnpContact => MsgProperty(
    key: 'gnpContact',
    value: 'Contacto GNP',
  );

  @override
  MsgProperty get webSite => MsgProperty(
    key: 'webSite',
    value: 'Sitio web',
  );

  @override
  MsgProperty get gnpLine => MsgProperty(
    key: 'gnpLine',
    value: 'Línea GNP',
  );

  @override
  MsgProperty get contactGnp => MsgProperty(
    key: 'contactGnp',
    value: 'Contacto GNP',
  );

  @override
  MsgProperty get contact => MsgProperty(
    key: 'contact',
    value: 'Contacto',
  );

  @override
  MsgProperty get agreement => MsgProperty(
    key: 'agreement',
    value: 'Convenio',
  );

  @override
  MsgProperty get download => MsgProperty(
    key: 'download',
    value: 'Descargar',
  );

  @override
  MsgProperty get view => MsgProperty(
    key: 'view',
    value: 'Visualizar',
  );

  @override
  MsgProperty get rfc => MsgProperty(
    key: 'rfc',
    value: 'RFC',
  );

  @override
  MsgProperty get withHomoclave => MsgProperty(
    key: 'withHomoclave',
    value: 'Con homoclave',
  );

  @override
  MsgProperty get doctorsName => MsgProperty(
    key: 'doctorsName',
    value: 'Nombre del Médico',
  );

  @override
  MsgProperty get specialty => MsgProperty(
    key: 'specialty',
    value: 'Especialidad',
    pValue: 'Especialidades',
    eValue: 'especialidad',
  );

  @override
  MsgProperty get subSpecialty => MsgProperty(
    key: 'subspecialty',
    value: 'Subespecialidad',
  );

  @override
  MsgProperty get state => MsgProperty(
    key: 'state',
    value: 'Estado',
  );

  @override
  MsgProperty get medicalCircle => MsgProperty(
    key: 'medicalCircle',
    value: 'Círculo médico',
  );

  @override
  MsgProperty get medicalTabulator => MsgProperty(
    key: 'medicalTabulator',
    value: 'Tabulador médico',
  );

  @override
  MsgProperty get status => MsgProperty(
    key: 'status',
    value: 'Estatus',
  );

  @override
  MsgProperty get tabulators => MsgProperty(
    key: 'tabulators',
    value: 'Tabuladores',
  );

  @override
  MsgProperty get consultGuidelines => MsgProperty(
    key: 'consultGuidelines',
    value: 'Consultar lineamientos',
  );

  @override
  MsgProperty get updateInformation => MsgProperty(
    key: 'updateInformation',
    value: 'Actualizar información',
  );

  @override
  MsgProperty get terminationAgreement => MsgProperty(
    key: 'terminationAgreement',
    value: 'Baja de convenio',
  );

  @override
  MsgProperty get downloadMedicalAgreement => MsgProperty(
    key: 'downloadMedicalAgreement',
    value: 'Descargar Convenio Médico',
  );

  @override
  MsgProperty get downloadFormats => MsgProperty(
    key: 'downloadFormats',
    value: 'Descargar formatos',
  );

  @override
  MsgProperty get directory => MsgProperty(
    key: 'directory',
    value: 'Directorio',
  );

  @override
  MsgProperty get medicalRegister => MsgProperty(
    key: 'medicalRegister',
    value: 'Registrar médico',
  );

  @override
  MsgProperty get registrationData => MsgProperty(
    key: 'registrationData',
    value: 'Datos de registro',
  );

  @override
  MsgProperty get fullName => MsgProperty(
    key: 'fullName',
    value: 'Nombre completo',
  );

  @override
  MsgProperty get createAccount => MsgProperty(
    key: 'createAccount',
    value: 'Crear cuenta',
  );

  @override
  MsgProperty get createRegister => MsgProperty(
    key: 'createRegister',
    value: 'Crea tu registro',
  );

  @override
  MsgProperty get rememberUser => MsgProperty(
    key: 'rememberUser',
    value: 'Recordar usuario',
  );

  @override
  MsgProperty get formats => MsgProperty(
    key: 'formats',
    value: 'Formatos',
  );

  @override
  MsgProperty get transplantOrthopedicsFormat => MsgProperty(
    key: 'transplantOrthopedicsFormat',
    value: 'Formato de Transplantes y Ortopedia',
  );

  @override
  MsgProperty get transferFormat => MsgProperty(
    key: 'transferFormat',
    value: 'Formato de transparencia para pa...',
  );

  @override
  MsgProperty get accessionLetter => MsgProperty(
    key: 'accessionLetter',
    value: 'Carta de adhesión',
  );

  @override
  MsgProperty get requestLog => MsgProperty(
    key: 'requestLog',
    value: 'Bitácora de solicitudes',
  );

  @override
  MsgProperty get applicationLog => MsgProperty(
    key: 'applicationLog',
    value: 'Bitácora de aplicaciones',
  );

  @override
  MsgProperty get applicationSheet => MsgProperty(
    key: 'applicationSheet',
    value: 'Folio de solicitud',
  );

  @override
  MsgProperty get dateRequest => MsgProperty(
    key: 'dateRequest',
    value: 'Fecha de solicitud',
  );

  @override
  MsgProperty get uploadInformation => MsgProperty(
    key: 'uploadInformation',
    value: 'Subir información',
  );

  @override
  MsgProperty get prepareFollowingDocumentation => MsgProperty(
    key: 'prepareFollowingDocumentation',
    value: 'Prepara la siguiente documentación',
  );

  @override
  MsgProperty get documentationFormat => MsgProperty(
    key: 'documentationFormat',
    value: 'La documentación deberá ser en formato PDF o JPG.',
  );

  @override
  MsgProperty get documentationFormatPDFPNG => MsgProperty(
    key: 'documentationFormat',
    value: 'La documentación deberá ser en formato PDF o JPG.',
  );

  @override
  MsgProperty get paymentByTransfer => MsgProperty(
    key: 'paymentByTransfer',
    value: 'Alta para pago por transferencia',
  );

  @override
  MsgProperty get documentationRequest => MsgProperty(
    key: 'documentationRequest',
    value: 'Solicitud de documentación',
  );

  @override
  MsgProperty get requestDocumentation => MsgProperty(
    key: 'requestDocumentation',
    value: 'Solicitud de documentación',
  );

  @override
  MsgProperty get begin => MsgProperty(
    key: 'begin',
    value: 'Comenzar',
  );

  @override
  MsgProperty get goOut => MsgProperty(
    key: 'goOut',
    value: 'Salir',
  );

  @override
  MsgProperty get selectDocumentUpload => MsgProperty(
    key: 'selectDocumentUpload',
    value: 'Selecciona el documento a subir.',
  );

  @override
  MsgProperty get documents => MsgProperty(
    key: 'documents',
    value: 'Documentos',
  );

  @override
  MsgProperty get documentsUploaded => MsgProperty(
    key: 'documentsUploaded',
    value: 'Documentos cargados',
  );

  @override
  MsgProperty get uploadFile => MsgProperty(
    key: 'uploadFile',
    value: 'Subir archivo',
  );

  @override
  MsgProperty get fileMaximum => MsgProperty(
    key: 'fileMaximum',
    value: 'Archivo de máximo de ',
  );

  @override
  MsgProperty get threeMB => MsgProperty(
    key: 'threeMB',
    value: '3 MB ',
  );

  @override
  MsgProperty get format => MsgProperty(
    key: 'format',
    value: 'en formato:',
  );

  @override
  MsgProperty get formatsForUpload => MsgProperty(
    key: 'formatsForUpload',
    value: 'JPG, PNG, PDF, XML, DOCX',
  );

  @override
  MsgProperty get requestAgreement => MsgProperty(
    key: 'requestAgreement',
    value: 'Solicitud de convenio',
  );

  @override
  MsgProperty get requiredDocumentation => MsgProperty(
    key: 'requiredDocumentation',
    value: 'Documentación requerida',
  );

  @override
  MsgProperty get understood => MsgProperty(
    key: 'understood',
    value: 'Entendido',
  );

  @override
  MsgProperty get tabulator => MsgProperty(
    key: 'tabulator',
    value: 'Tabulador',
  );

  @override
  MsgProperty get medicalCircleTab => MsgProperty(
    key: 'medicalCircleTab',
    value: 'Círculo/Tabulador Médico',
  );

  @override
  MsgProperty get procedure => MsgProperty(
    key: 'procedure',
    value: 'Procedimiento',
  );

  @override
  MsgProperty get cpts => MsgProperty(
    key: 'cpts',
    value: 'CPT´s',
  );

  @override
  MsgProperty get cost => MsgProperty(
    key: 'cost',
    value: 'Costo',
  );

  @override
  MsgProperty get consult => MsgProperty(
    key: 'consult',
    value: 'Consultar',
  );

  @override
  MsgProperty get myData => MsgProperty(
    key: 'myData',
    value: 'Mis datos',
  );

  @override
  MsgProperty get profesionalTitle => MsgProperty(
    key: 'profesionalTitle',
    value: 'Titulo profesional',
  );

  @override
  MsgProperty get gender => MsgProperty(
    key: 'gender',
    value: 'Género',
  );

  @override
  MsgProperty get medicalOffice => MsgProperty(
    key: 'medicalOffice',
    value: 'Dirección de Consultorio',
  );

  @override
  MsgProperty get nationality => MsgProperty(
    key: 'nationality',
    value: 'Nacionalidad',
  );

  @override
  MsgProperty get enterYourNameContinue => MsgProperty(
    key: 'enterYourNameContinue',
    value: 'Ingresa el nombre para continuar.',
  );

  @override
  MsgProperty get enterYourLastNameContinue => MsgProperty(
    key: 'enterYourLastNameContinue',
    value: 'Ingresa el apellido para continuar',
  );

  @override
  MsgProperty get enterYourSecondLastNameContinue => MsgProperty(
    key: 'enterYourSecondLastNameContinue',
    value: 'Ingresa el apellido materno para continuar',
  );

  @override
  MsgProperty get enterYourPassword => MsgProperty(
    key: 'enterYourPassword',
    value: 'Ingresa la contraseña',
  );

  @override
  MsgProperty get enterYourPhoneNumber => MsgProperty(
    key: 'enterYourPhoneNumber',
    value: 'El número de celular es requerido',
  );

  @override
  MsgProperty get enterTenDigits => MsgProperty(
    key: 'enterTenDigits',
    value: 'Ingresa los 10 dígitos de tu número',
  );

  @override
  MsgProperty get enterMinDigits => MsgProperty(
    key: 'enterMinDigits',
    value: 'Debe tener al menos 6 caracteres',
  );

  @override
  MsgProperty get enterYourOption => MsgProperty(
    key: 'enterYourOption',
    value: 'Selecciona una opción valida',
  );

  @override
  MsgProperty get enterYourDate => MsgProperty(
    key: 'enterYourDate',
    value: 'Selecciona fecha valida',
  );

  @override
  MsgProperty get enterYourRfc => MsgProperty(
    key: 'enterYourRfc',
    value: 'El RFC es obligatorio.',
  );

  @override
  MsgProperty get rfcFormatInvalid => MsgProperty(
    key: 'rfcFormatInvalid',
    value: 'El formato del RFC no es válido.',
  );

  @override
  MsgProperty get rfcGenericNoAllowed => MsgProperty(
    key: 'rfcGenericNoAllowed',
    value: 'El RFC genérico no está permitido.',
  );

  @override
  MsgProperty get enterYourRfcName => MsgProperty(
    key: 'enterYourRfcName',
    value: 'El RFC no coincide con el nombre y apellidos.',
  );

  @override
  MsgProperty get rfcDigitsTwelveThirteen => MsgProperty(
    key: 'rfcDigitsTwelveThirteen',
    value: 'El RFC debe tener 12 o 13 caracteres.',
  );

  @override
  MsgProperty get reTabulationsTitle => MsgProperty(
    key: 'reTabulationsTitle',
    value: '''Dudas sobre pagos, tabulaciones o aclaraciones de cartas pase''',
  );
  @override
  MsgProperty get reTabulationsSubtitle => MsgProperty(
    key: 'reTabulationsSubtitle',
    value: '''Comunícate al Centro de Atención a Médicos (CAM):''',
  );

  @override
  MsgProperty get bankingInfoTitle => MsgProperty(
    key: 'bankingInfoTitle',
    value:
        '''Actualización de datos (fiscales, bancarios o estados de cuenta)''',
  );

  @override
  MsgProperty get bankingInfoSubtitle => MsgProperty(
    key: 'bankingInfoSubtitle',
    value: '''Favor de contactar al área de Información Proveedores:''',
  );

  @override
  MsgProperty get personalizedAssistanceTitle => MsgProperty(
    key: 'personalizedAssistanceTitle',
    value: 'Asistencia Personalizada',
  );

  @override
  MsgProperty get personalizedAssistanceSubtitle => MsgProperty(
    key: 'personalizedAssistanceSubtitle',
    value:
        '''Si requieres el contacto del ejecutivo asignado a tu especialidad, por favor envía un correo al CAM solicitando esta información:''',
  );

  @override
  MsgProperty get onlyAlphabeticCharacters => MsgProperty(
    key: 'onlyAlphabeticCharacters',
    value: 'Solo se permiten valores alfabéticos',
  );

  @override
  MsgProperty get toRegisterYouAccept => MsgProperty(
    key: 'toRegisterYouAccept',
    value: 'Al registrarte aceptas nuestros ',
  );

  @override
  MsgProperty get termsAndConditions => MsgProperty(
    key: 'termsAndConditions',
    value: 'Términos y condiciones de uso de Medios Electrónicos ',
  );

  @override
  MsgProperty get fromGroupNational => MsgProperty(
    key: 'fromGroupNational',
    value: 'de Grupo Nacional Provincial S.A.B',
  );

  @override
  MsgProperty get signUp => MsgProperty(
    key: 'signUp',
    value: 'Registrarme',
  );

  @override
  MsgProperty get homeTerms => MsgProperty(
    key: 'homeTerms',
    value:
        'Se prohíbe la reproducción parcial o total de la información '
        'contenida en este sitio a nivel digital.',
  );

  @override
  MsgProperty get noResultsFound => MsgProperty(
    key: 'noResultsFound',
    value: 'No se encontraron resultados',
  );

  @override
  MsgProperty get selectBtnToContinue => MsgProperty(
    key: 'selectBtnToContinue',
    value: 'Selecciona el botón de "Nueva búsqueda" para intentar de nuevo',
  );

  @override
  MsgProperty get apologize => MsgProperty(
    key: 'apologize',
    value: 'Lo siento',
    pValue: '¡Lo sentimos!',
  );

  @override
  MsgProperty get noInvitation => MsgProperty(
    key: 'noInvitation',
    value:
        'Parece que no tienes una invitación activa en este momento. '
        'Te sugerimos contactar a tu médico para que te brinde el acceso.',
  );

  @override
  MsgProperty get back => MsgProperty(
    key: 'back',
    value: 'Volver',
  );

  @override
  MsgProperty get errorOccurred => MsgProperty(
    key: 'errorOccurred',
    value: 'Ocurrió un error',
  );

  @override
  MsgProperty get couldNotRetrieveAnnexes => MsgProperty(
    key: 'couldNotRetrieveAnnexes',
    value: 'No fue posible recuperar los anexos',
  );

  @override
  MsgProperty get couldNotRetrieveBenefits => MsgProperty(
    key: 'couldNotRetrieveBenefits',
    value: 'No fue posible recuperar los beneficios',
  );

  @override
  MsgProperty get couldNotRetrieveFormats => MsgProperty(
    key: 'couldNotRetrieveFormats',
    value: 'No fue posible recuperar los formatos',
  );

  @override
  MsgProperty get noDataAvailable => MsgProperty(
    key: 'noDataAvailable',
    value: 'Sin @0 disponibles',
  );

  @override
  MsgProperty get doctor => MsgProperty(
    key: 'doctor',
    value: 'Médico',
    pValue: 'Médicos',
  );

  @override
  MsgProperty get inAgreement => MsgProperty(
    key: 'inAgreement',
    value: 'en convenio',
  );

  @override
  MsgProperty get hospital => MsgProperty(
    key: 'hospital',
    value: 'Hospital',
    pValue: 'Hospitales',
  );

  @override
  MsgProperty get clinica => MsgProperty(
    key: 'clinica',
    value: 'Clínica',
    pValue: 'Clínicas',
  );

  @override
  MsgProperty get otherServices => MsgProperty(
    key: 'otherServices',
    value: 'Otros servicios de salud',
    pValue: 'Otros servicios de salud',
  );

  @override
  MsgProperty get errorGetting => MsgProperty(
    key: 'errorGetting',
    value: 'Error al obtener',
  );

  @override
  MsgProperty get lookingforHospital => MsgProperty(
    key: 'lookingforHospital',
    value: 'Buscar por nombre del hospital',
  );

  @override
  MsgProperty get optionalName => MsgProperty(
    key: 'optionalName',
    value: 'Nombre (Opcional)',
  );
  @override
  MsgProperty get circle => MsgProperty(
    key: 'circle',
    value: 'Círculo',
    pValue: 'Círculos',
  );
  @override
  MsgProperty get circleOrTab => MsgProperty(
    key: 'circleOrTab',
    value: 'Círculo o tabulador',
  );

  @override
  MsgProperty get estado => MsgProperty(
    key: 'estado',
    value: 'Estado',
    pValue: 'Estados',
  );

  @override
  MsgProperty get healthPlan => MsgProperty(
    key: 'healthPlan',
    value: 'Plan hospitalario',
    pValue: 'Planes hospitalarios',
  );

  @override
  MsgProperty get clinicType => MsgProperty(
    key: 'clinicType',
    value: 'Tipo de clínica',
    pValue: 'Tipos de clínicas',
  );

  @override
  MsgProperty get servicesType => MsgProperty(
    key: 'servicesType',
    value: 'Tipo Servicios',
    pValue: 'Tipos de Servicios',
  );

  @override
  MsgProperty get municipality => MsgProperty(
    key: 'municipality',
    value: 'Municipio',
    pValue: 'Municipios',
  );

  @override
  MsgProperty get selectMunicipalityAfterState => MsgProperty(
    key: 'selectMunicipalityAfterState',
    value: 'Para mostrar municipios, seleccione un estado.',
  );

  @override
  MsgProperty get toCheckLevelHospital => MsgProperty(
    key: 'toCheckLevelHospital',
    value:
        '''Considera que el nivel hospitalario está en función de la póliza contratada del asegurado.''',
  );

  @override
  MsgProperty get lookingforClinicaName => MsgProperty(
    key: 'lookingforClinicaName',
    value: 'Buscar por nombre de la clínica.',
  );

  @override
  MsgProperty get lookingforOtherServicesName => MsgProperty(
    key: 'lookingforOtherServicesName',
    value: 'Buscar por nombre del establecimiento.',
  );

  @override
  MsgProperty get pleaseSelectASpecialty => MsgProperty(
    key: 'pleaseSelectASpecialty',
    value: 'Por favor, selecciona una especialidad.',
  );

  @override
  MsgProperty get pleaseSelectASubspecialty => MsgProperty(
    key: 'pleaseSelectASubspecialty',
    value: 'Por favor, selecciona una subespecialidad.',
  );

  @override
  MsgProperty get newRequest =>
      MsgProperty(key: 'newRequest', value: 'Nueva solicitud');

  @override
  MsgProperty get pleaseSelectAState => MsgProperty(
    key: 'pleaseSelectAState',
    value: 'Por favor, selecciona un estado',
  );

  @override
  MsgProperty get careHospitals => MsgProperty(
    key: 'careHospitals',
    value: 'Hospitales de atención',
  );

  @override
  MsgProperty get pleaseSelectAtLeastOneHospital => MsgProperty(
    key: 'pleaseSelectAtLeastOneHospital',
    value: 'Por favor, selecciona al menos un hospital.',
  );

  @override
  MsgProperty get medicalOfficeAddress => MsgProperty(
    key: 'medicalOfficeAddress',
    value: 'Dirección de consultorio médico',
  );

  @override
  MsgProperty get pleaseEnterYourOfficeAddress => MsgProperty(
    key: 'pleaseEnterYourOfficeAddress',
    value: 'Por favor, ingresa la dirección de tu consultorio.',
  );

  @override
  MsgProperty get sendRequest => MsgProperty(
    key: 'sendRequest',
    value: 'Enviar solicitud',
  );

  @override
  MsgProperty get myProcedures => MsgProperty(
    key: 'myProcedures',
    value: 'Mis trámites',
  );

  @override
  MsgProperty get notProcedures => MsgProperty(
    key: 'notProcedures',
    value: 'No encontramos trámites.',
  );

  @override
  MsgProperty get profile => MsgProperty(
    key: 'profile',
    value: 'Perfil',
  );

  @override
  MsgProperty get errorToGetProcedures => MsgProperty(
    key: 'errorToGetProcedures',
    value: 'Error al obtener los trámites. Inténtalo de nuevo más tarde.',
  );

  @override
  MsgProperty get myPayments =>
      MsgProperty(key: 'myPayments', value: 'Mis pagos');

  @override
  MsgProperty get errorToGetProfile => MsgProperty(
    key: 'errorToGetProfile',
    value: 'Error al obtener el perfil. Inténtalo de nuevo más tarde.',
  );

  @override
  MsgProperty get errorGettingDoctors => MsgProperty(
    key: 'errorGettingDoctors',
    value: 'Error al obtener medicos. Inténtalo de nuevo más tarde',
  );

  @override
  MsgProperty get errorGettingHospitals => MsgProperty(
    key: 'errorGettingHospitals',
    value: 'Error al obtener hospitales. Inténtalo de nuevo más tarde',
  );

  @override
  MsgProperty get errorGettingClinics => MsgProperty(
    key: 'errorGettingClinics',
    value: 'Error al obtener clínicas. Inténtalo de nuevo más tarde',
  );
  @override
  MsgProperty get errorGettingOtherServices => MsgProperty(
    key: 'errorGettingOtherServices',
    value: 'Error al obtener otros servicios. Inténtalo de nuevo más tarde',
  );

  @override
  MsgProperty get evaluations => MsgProperty(
    key: 'evaluations',
    value: 'Evaluación',
  );

  @override
  MsgProperty get home => MsgProperty(key: 'home', value: 'Inicio');

  @override
  MsgProperty get all => MsgProperty(key: 'all', value: 'Todos');

  @override
  MsgProperty get errorLoadingStates => MsgProperty(
    key: 'errorLoadingStates',
    value: 'Error al cargar los estados. Inténtalo de nuevo más tarde',
  );

  @override
  MsgProperty get errorGettingMunicipalities => MsgProperty(
    key: 'errorGettingMunicipalities',
    value: 'Error al obtener municipios. Inténtalo de nuevo más tarde',
  );

  @override
  MsgProperty get search => MsgProperty(key: 'search', value: 'Buscar');

  @override
  MsgProperty get searchForSpecialty =>
      MsgProperty(key: 'searchForSpecialty', value: 'Buscar por especialidad');

  @override
  MsgProperty get searchResults =>
      MsgProperty(key: 'searchResults', value: 'Resultados de Búsqueda');

  @override
  MsgProperty get resultsFoundPage => MsgProperty(
    key: 'resultsFoundPage',
    value: 'Se encontraron @0 resultados Página @1 de @2',
  );

  @override
  MsgProperty get selected =>
      MsgProperty(key: 'selected', value: 'seleccionado');

  @override
  MsgProperty get noResultsWithFilters => MsgProperty(
    key: 'noResultsWithFilters',
    value: 'No se encontraron resultados con los filtros seleccionados.',
  );

  @override
  MsgProperty get calculatingPleaseWait => MsgProperty(
    key: 'calculatingPleaseWait',
    value: 'Calculando, por favor espere un momento...',
  );

  @override
  MsgProperty get goodDay =>
      MsgProperty(key: 'goodDay', value: '¡Buen día, @0!');

  @override
  MsgProperty get welcomeMessageBody => MsgProperty(
    key: 'welcomeMessageBody',
    value:
        '''Eres un pilar fundamental para GNP Seguros, gracias a tu compromiso y gran vocación de servicio, hemos respaldado y brindado tranquilidad a las familias mexicanas cuando más lo necesitan, por ello, queremos seguir haciendo equipo contigo y brindarte las herramientas que optimicen tus tiempos administrativos.''',
  );

  @override
  MsgProperty get welcomeMessageFooter => MsgProperty(
    key: 'welcomeMessageFooter',
    value:
        '''Ser aliados de nuestros médicos en convenio, y también de quienes no lo son, manteniéndonos comprometidos con la recuperación de la salud de los pacientes mientras cumplimos con los indicadores de eficiencia y servicio de GNP.''',
  );

  @override
  MsgProperty get deleteSearchFilters => MsgProperty(
    key: 'deleteSearchFilters',
    value: 'Borrar búsqueda',
  );

  @override
  MsgProperty get errorGettingAnnexes => MsgProperty(
    key: 'errorGettingAnnexes',
    value: 'Error al obtener Anexos. Inténtalo de nuevo más tarde',
  );

  @override
  MsgProperty get errorDownloadingAnnex => MsgProperty(
    key: 'errorDownloadingAnnex',
    value: 'Error al obtener el Anexo. Inténtalo de nuevo más tarde',
  );

  @override
  MsgProperty get couldNotDownloadAnnex => MsgProperty(
    key: 'couldNotDownloadAnnex',
    value: 'No se pudo descargar el anexo. Inténtalo de nuevo más tarde.',
  );

  @override
  MsgProperty get folio => MsgProperty(key: 'folio', value: 'Folio');

  @override
  MsgProperty get insuredName =>
      MsgProperty(key: 'insuredName', value: 'Nombre del asegurado');

  @override
  MsgProperty get dateOfLoss =>
      MsgProperty(key: 'dateOfLoss', value: 'Fecha de siniestro');

  @override
  MsgProperty get condition =>
      MsgProperty(key: 'condition', value: 'Padecimiento');

  @override
  MsgProperty get attendingHospital =>
      MsgProperty(key: 'attendingHospital', value: 'Hospital de atención');

  @override
  MsgProperty get policy => MsgProperty(key: 'policy', value: 'Póliza');

  @override
  MsgProperty get noProceduresFoundForDate => MsgProperty(
    key: 'noProceduresFoundForDate',
    value: 'No se encontraron trámites para la fecha seleccionada',
  );

  @override
  MsgProperty get paymentDate => MsgProperty(
    key: 'paymentDate',
    value: 'Fecha de pago',
  );

  @override
  MsgProperty get associatedIncident => MsgProperty(
    key: 'associatedInc',
    value: 'Siniestro asociado',
  );

  @override
  MsgProperty get amountPaid => MsgProperty(
    key: 'amountPaid',
    value: 'Monto pagado',
  );

  @override
  MsgProperty get paymentAccount => MsgProperty(
    key: 'paymentAccount',
    value: 'Cuenta de pago:',
  );

  @override
  MsgProperty get paymentStatus => MsgProperty(
    key: 'paymentStatus',
    value: 'Estatus del pago',
  );

  @override
  MsgProperty get amountClaimed => MsgProperty(
    key: 'amountClaimed',
    value: 'Monto reclamado',
  );

  @override
  MsgProperty get bankingInstitution => MsgProperty(
    key: 'bankingInstitution',
    value: 'Institución bancaria:',
  );

  @override
  MsgProperty get notPayments => MsgProperty(
    key: 'notPayments',
    value: 'No se encontraron pagos.',
  );

  @override
  List<String> get monthAbbreviations => [
    'Ene',
    'Feb',
    'Mar',
    'Abr',
    'May',
    'Jun',
    'Jul',
    'Ago',
    'Sep',
    'Oct',
    'Nov',
    'Dic',
  ];

  @override
  MsgProperty get noDataReceived => MsgProperty(
    key: 'noDataReceived',
    value: 'No se recibieron datos.',
  );

  @override
  MsgProperty get locationServicesDisabledTitle => MsgProperty(
    key: 'locationServicesDisabledTitle',
    value: 'Servicios de ubicación desactivados',
  );

  @override
  MsgProperty get locationServicesDisabledMessage => MsgProperty(
    key: 'locationServicesDisabledMessage',
    value: 'Por favor, habilita los servicios de ubicación.',
  );

  @override
  MsgProperty get permissionsDeniedTitle => MsgProperty(
    key: 'permissionsDeniedTitle',
    value: 'Permisos denegados',
  );

  @override
  MsgProperty get permissionsDeniedMessage => MsgProperty(
    key: 'permissionsDeniedMessage',
    value: 'No se puede obtener la ubicación actual sin permisos.',
  );

  @override
  MsgProperty get permissionsPermanentlyDeniedTitle => MsgProperty(
    key: 'permissionsPermanentlyDeniedTitle',
    value: 'Permisos denegados permanentemente',
  );

  @override
  MsgProperty get permissionsPermanentlyDeniedMessage => MsgProperty(
    key: 'permissionsPermanentlyDeniedMessage',
    value: 'Abre la configuración de la app para habilitar la ubicación.',
  );

  @override
  MsgProperty get errorMakingPhoneCall => MsgProperty(
    key: 'errorMakingPhoneCall',
    value:
        '''Error al intentar realizar la llamada telefónica. Por favor, inténtalo de nuevo más tarde.''',
  );

  @override
  MsgProperty get routeNotAvailableTitle => MsgProperty(
    key: 'routeNotAvailableTitle',
    value: 'Ruta no disponible',
  );

  @override
  MsgProperty get routeNotAvailableMsg => MsgProperty(
    key: 'routeNotAvailableMsg',
    value:
        '''No se pudo obtener la ruta al destino. Por favor, inténtalo de nuevo más tarde.''',
  );

  @override
  MsgProperty get youAreHere => MsgProperty(
    key: 'youAreHere',
    value: 'Aquí te encuentras',
  );

  @override
  MsgProperty get errorLoadingProfileTitle => MsgProperty(
    key: 'errorLoadingProfileTitle',
    value: 'Error al cargar perfil',
  );

  @override
  MsgProperty get error => MsgProperty(key: 'error', value: 'Error');

  @override
  MsgProperty get success =>
      MsgProperty(key: 'success', value: 'Envió exitoso');

  @override
  MsgProperty get failed => MsgProperty(key: 'failed', value: 'Falló');

  @override
  MsgProperty get endOfList =>
      MsgProperty(key: 'endOfList', value: 'Final de lista');

  @override
  MsgProperty get emptyFilters =>
      MsgProperty(key: 'emptyFilters', value: 'Filtros vacíos');

  @override
  MsgProperty get invalidUserOrPassword => MsgProperty(
    key: 'invalidUserOrPassword',
    value:
        'Usuario y/o contraseña incorrectos. Verifícala e inténtalo de nuevo.',
  );

  @override
  MsgProperty get passwordRecoveryLinkSent => MsgProperty(
    key: 'passwordRecoveryLinkSent',
    value: 'Se envió un enlace de recuperación de contraseña a tu correo.',
  );

  @override
  MsgProperty get biometricsNotAvailable => MsgProperty(
    key: 'biometricsNotAvailable',
    value: 'La biometría no está disponible en este dispositivo.',
  );

  @override
  MsgProperty get biometricAuthenticationFailed => MsgProperty(
    key: 'biometricAuthenticationFailed',
    value: 'Autenticación Biométrica Fallida.',
  );

  @override
  MsgProperty get errorAuthenticating => MsgProperty(
    key: 'errorAuthenticating',
    value: 'Ocurrió un error al intentar autenticar.',
  );

  @override
  MsgProperty get errorGettingFormat => MsgProperty(
    key: 'errorGettingFormat',
    value: 'No se logró obtener el formato.',
  );

  @override
  MsgProperty get errorDetail =>
      MsgProperty(key: 'errorDetail', value: 'Ocurrió el detalle @0.');

  @override
  MsgProperty get errorLoadingProfile => MsgProperty(
    key: 'errorLoadingProfile',
    value:
        '''Hubo un problema al cargar el perfil. Por favor, inténtalo de nuevo más tarde.''',
  );

  @override
  MsgProperty get errorGettingDocument => MsgProperty(
    key: 'errorGettingDocument',
    value: 'No se logró obtener el documento.',
  );

  @override
  MsgProperty get agreementNotInEffect => MsgProperty(
    key: 'agreementNotInEffect',
    value: 'El convenio no se encuentra vigente.',
  );

  @override
  MsgProperty get agreementUpdated => MsgProperty(
    key: 'agreementUpdated',
    value: 'El convenio ha sido actualizado.',
  );

  @override
  MsgProperty get requestRegistered => MsgProperty(
    key: 'requestRegistered',
    value: 'La solicitud fue registrada.',
  );

  @override
  MsgProperty get requestNotRegistered => MsgProperty(
    key: 'requestNotRegistered',
    value: 'La solicitud no fue registrada.',
  );

  @override
  MsgProperty get noMoreProceduresToLoad => MsgProperty(
    key: 'noMoreProceduresToLoad',
    value: 'No hay más trámites para cargar.',
  );

  @override
  MsgProperty get selectFilterAndEnterData => MsgProperty(
    key: 'selectFilterAndEnterData',
    value: 'Por favor, selecciona un filtro e ingresa un dato para continuar.',
  );

  @override
  MsgProperty get successfulRegistration => MsgProperty(
    key: 'successfulRegistration',
    value: 'Registro exitoso',
  );

  @override
  MsgProperty get userRegisteredSuccessfully => MsgProperty(
    key: 'userRegisteredSuccessfully',
    value: 'Se registró al usuario correctamente.',
  );

  @override
  MsgProperty get successfulUpdate => MsgProperty(
    key: 'successfulUpdate',
    value: 'Actualización exitosa',
  );

  @override
  MsgProperty get assistantNotUpdated => MsgProperty(
    key: 'assistantNotUpdated',
    value: 'El asistente no se actualizó.',
  );

  @override
  MsgProperty get errorUpdatingAssistantPermissions => MsgProperty(
    key: 'errorUpdatingAssistantPermissions',
    value: 'Error al actualizar los permisos del asistente.',
  );

  @override
  MsgProperty get noDocumentsUploadedYet => MsgProperty(
    key: 'noDocumentsUploadedYet',
    value: 'Aún no has subido documentos.',
  );

  @override
  MsgProperty get dataNotLoaded => MsgProperty(
    key: 'dataNotLoaded',
    value: 'No se cargaron los datos',
  );

  @override
  MsgProperty get errorLoadingData => MsgProperty(
    key: 'errorLoadingData',
    value: 'Error: @0',
  );

  @override
  MsgProperty get dAtLeast8Chars => MsgProperty(
    key: 'dAtLeast8Chars',
    value: 'Debe ser al menos de 8 carácteres.',
  );
  @override
  MsgProperty get dAtLeastOneUppercase => MsgProperty(
    key: 'dAtLeastOneUppercase',
    value: 'Debe contener al menos una mayúscula.',
  );
  @override
  MsgProperty get dAtLeastOneLowercase => MsgProperty(
    key: 'dAtLeastOneLowercase',
    value: 'Debe contener al menos una minúscula.',
  );
  @override
  MsgProperty get dAtLeast4AlphaChars => MsgProperty(
    key: 'dAtLeast4AlphaChars',
    value: 'Debe contener al menos cuatro carácteres alfabéticos.',
  );
  @override
  MsgProperty get dAtLeastOneNumeric => MsgProperty(
    key: 'dAtLeastOneNumeric',
    value: 'Debe contener al menos un caracter numérico.',
  );
  @override
  MsgProperty get dAtLeastOneSpecialChar => MsgProperty(
    key: 'dAtLeastOneSpecialChar',
    value: 'Debe contener al menos un carácter especial.',
  );
  @override
  MsgProperty get dNoGnpWord => MsgProperty(
    key: 'dNoGnpWord',
    value: 'No debe contener la palabra GNP.',
  );
  @override
  MsgProperty get dNoConsecutiveEqualChars => MsgProperty(
    key: 'dNoConsecutiveEqualChars',
    value:
        '''''No debe contener más de dos carácteres consecutivos iguales (p.e. 222, eee).''',
  );
  @override
  MsgProperty get dNoConsecutiveChars => MsgProperty(
    key: 'dNoConsecutiveChars',
    value:
        'No debe contener más de dos carácteres consecutivos (p.e. 123, abc).',
  );
  @override
  MsgProperty get dNoWhiteSpaces => MsgProperty(
    key: 'dNoWhiteSpaces',
    value: 'No debe contener espacios en blanco.',
  );

  @override
  MsgProperty get dPasswordsDoNotMatch => MsgProperty(
    key: 'dPasswordsDoNotMatch',
    value: 'Las contraseñas no coinciden',
  );

  @override
  MsgProperty get successfulChange => MsgProperty(
    key: 'successfulChange',
    value: 'Cambio Exitoso',
  );
  @override
  MsgProperty get dPasswordUpdated => MsgProperty(
    key: 'dPasswordUpdated',
    value: 'Tu contraseña ha sido actualizada.',
  );

  @override
  MsgProperty get resetPassword => MsgProperty(
    key: 'resetPassword',
    value: 'Restablecer contraseña',
  );

  @override
  MsgProperty get tResetPassword => MsgProperty(
    key: 'tResetPassword',
    value: 'Restablecimiento de acceso',
  );

  @override
  MsgProperty get dResetPassword => MsgProperty(
    key: 'dResetPassword',
    value:
        '''La sesión se cerrará para proceder con el restablecimiento de su '''
        '''contraseña. Asegúrese de tener acceso al correo electrónico registrado '''
        '''para recibir la información correspondiente.''',
  );

  @override
  MsgProperty get tSignOut => MsgProperty(
    key: 'tSignOut',
    value: 'Confirmación de cierre de sesión',
  );

  @override
  MsgProperty get dSignOut => MsgProperty(
    key: 'dSignOut',
    value: 'Está a punto de cerrar su sesión. ¿Desea continuar?',
  );

  @override
  MsgProperty get tDeleteAccount => MsgProperty(
    key: 'tDeleteAccount',
    value: 'Confirmación de eliminación de cuenta',
  );

  @override
  MsgProperty get dDeleteAccount => MsgProperty(
    key: 'dDeleteAccount',
    value:
        '¿Estás seguro de que deseas eliminar tu cuenta? Esta acción es '
        'permanente y no podrás recuperarla.',
  );

  @override
  MsgProperty get temailAlreadyRegistered =>
      MsgProperty(key: 'emailAlreadyRegistered', value: 'CORREO YA REGISTRADO');

  @override
  MsgProperty get demailAlreadyRegistered => MsgProperty(
    key: 'registeredEmailAregisteredEmailAddressIsAlreadyAssociatedWithAccount',
    value: 'El correo registrado ya está asociado a su cuenta',
  );

  @override
  MsgProperty get errorToGetPayments => MsgProperty(
    key: 'errorToGetPayments',
    value: 'Error al obtener los pagos. Inténtalo de nuevo más tarde',
  );

  @override
  MsgProperty get professionalLicense => MsgProperty(
    key: 'professionalLicense',
    value: 'Cédula profesional',
  );

  @override
  MsgProperty get speciality => MsgProperty(
    key: 'speciality',
    value: 'Cédula especialidad',
  );
  
  @override
  MsgProperty get subspeciality => MsgProperty(
    key: 'subspeciality',
    value: 'Cédula subespecialidad',
  );

  @override
  MsgProperty get fieldRequired => MsgProperty(
    key: 'fieldRequired',
    value: 'Este campo es obligatorio.',
  );
 
  @override
  MsgProperty
  get actions => MsgProperty(
    key: 'actions',
    value: 'Acciones',
  );

  @override
  MsgProperty get tDeletedAccount => MsgProperty(
    key: 'tDeletedAccount',
    value: 'Cuenta eliminada',
  );

  @override
  MsgProperty get dDeletedAccount => MsgProperty(
    key: 'dDeletedAccount',
    value: 'La eliminación de la cuenta se realizó correctamente.',
  );

  @override
  MsgProperty get pageNotFound => MsgProperty(
    key: 'pageNotFound',
    value: 'Página no encontrada',
  );
}
