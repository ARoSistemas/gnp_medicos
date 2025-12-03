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
    key: 'createAccount',
    value: 'Crear cuenta',
  );

  @override
  MsgProperty get enterYourEmail => MsgProperty(
    key: 'enterYourEmail',
    value: 'Ingresa tu correo electrónico',
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
    value: 'Ingresa tu nombre para continuar.',
  );

  @override
  MsgProperty get enterYourLastNameContinue => MsgProperty(
    key: 'enterYourLastNameContinue',
    value: 'Ingresa tu apellido para continuar',
  );

  @override
  MsgProperty get enterYourSecondLastNameContinue => MsgProperty(
    key: 'enterYourSecondLastNameContinue',
    value: 'Ingresa tu apellido materno para continuar',
  );

  @override
  MsgProperty get enterYourPassword => MsgProperty(
    key: 'enterYourPassword',
    value: 'Ingresa tu contraseña',
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
  MsgProperty get reTabulationsLegend => MsgProperty(
    key: 'reTabulationsLegend',
    value:
        '''Re Tabulaciones, dudas de tus pagos, aclaraciones de carta pase para comunicarte al Cam:''',
  );

  @override
  MsgProperty get bankingInfoLegend => MsgProperty(
    key: 'bankingInfoLegend',
    value:
        '''Información Bancaria, datos fiscales, actualización de estados de cuenta:''',
  );
  @override
  MsgProperty get personalizedAssistanceLegend => MsgProperty(
    key: 'personalizedAssistanceLegend',
    value: 'Asistencia personalizada, médico de confianza con ejecutivo:',
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

  /// Modulo: Anexos
  @override
  MsgProperty get noAnnexesAvailable => MsgProperty(
    key: 'noAnnexesAvailable',
    value: 'Sin anexos disponibles',
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

  /// Modulo: Directorio
  @override
  MsgProperty get medico => MsgProperty(
    key: 'medico',
    value: 'Médico',
    pValue: 'Médicos',
  );

  @override
  MsgProperty get enconvenio => MsgProperty(
    key: 'enconvenio',
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
  MsgProperty get otrosServicios => MsgProperty(
    key: 'otrosServicios',
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
    value: 'Para mostrar municipios, seleccione un estado',
  );

  @override
  MsgProperty get lookingforClinicaName => MsgProperty(
    key: 'lookingforClinicaName',
    value: 'Buscar por nombre de la clínica',
  );

  @override
  MsgProperty get lookingforOtrosServiciosName => MsgProperty(
    key: 'lookingforOtrosServiciosName',
    value: 'Buscar por nombre del establecimiento',
  );

  @override
  MsgProperty get pleaseSelectASpecialty => MsgProperty(
    key: 'please select a specialty.',
    value: 'Please select a specialty.',
  );

  @override
  MsgProperty get pleaseSelectASubspecialty => MsgProperty(
    key: 'pleaseSlectASubspecialty',
    value: 'Please select a subspecialty',
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

  ///
}
