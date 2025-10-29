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
    value: 'Registrate ahora',
  );

  @override
  MsgProperty get enterYourEmail => MsgProperty(
    key: 'enterYourEmail',
    value: 'Ingrese su correo electrónico',
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
    value: 'Identificate',
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
    value: 'Datos Académicos',
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
  MsgProperty get continueB => MsgProperty(
    key: 'continue',
    value: 'Continuar',
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
    value: 'Agregar asistente',
  );

  @override
  MsgProperty get errorLoadingAssistants => MsgProperty(
    key: 'errorLoadingAssistants',
    value: 'Error al cargar asistentes.',
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
  );

  @override
  MsgProperty get firstName => MsgProperty(
    key: 'firstName',
    value: 'Apellido paterno',
  );

  @override
  MsgProperty get lastName => MsgProperty(
    key: 'lastName',
    value: 'Apellido materno',
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
  MsgProperty get errorLoadingInvites => MsgProperty(
    key: 'errorLoadingInvites',
    value: 'Error al cargar invitaciones',
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
  MsgProperty get errorLoadingForm => MsgProperty(
    key: 'errorLoadingForm',
    value: 'Error al cargar el formulario',
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
  );

  @override
  MsgProperty get state => MsgProperty(
    key: 'state',
    value: 'Estado',
  );

  @override
  MsgProperty get medicalCircle => MsgProperty(
    key: 'medicalCircle',
    value: 'Circulo Médico',
  );

  @override
  MsgProperty get medicalTabulator => MsgProperty(
    key: 'medicalTabulator',
    value: 'Tabulador Médico',
  );

  @override
  MsgProperty get status => MsgProperty(
    key: 'status',
    value: 'Estatus',
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
  MsgProperty get directory => MsgProperty(
    key: 'directory',
    value: 'Directorio',
  );

  @override
  MsgProperty get medicalRegister => MsgProperty(
    key: 'medicalRecord',
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
    key: 'transparentFormat',
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
    value: 'Bitacora de solicitudes',
  );

  @override
  MsgProperty get applicationLog => MsgProperty(
    key: 'applicationLog',
    value: 'Bitacora de aplicaciones',
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
    value: 'Ata para pago por transferencia',
  );

  @override
  MsgProperty get documentationRequest => MsgProperty(
    key: 'documentationRequest',
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
  MsgProperty get uploadFile => MsgProperty(
    key: 'uploadFile',
    value: 'Subir archivo',
  );

  @override
  MsgProperty get fileMaximum => MsgProperty(
    key: 'fileMaximun',
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
    value: 'JPG, PNG, PDF, XML, DOC',
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
    value: 'Circulo / tabulador médico',
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
}
