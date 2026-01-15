import 'dart:ui';

import 'package:medicos/core/messages/i_messages.dart';
import 'package:medicos/core/messages/messages.dart';
import 'package:medicos/shared/messages/es/es_messages.dart';
import 'package:medicos/shared/messages/i_app_messages.dart';

final enMessages = _ENMessages._();

class _ENMessages {
  _ENMessages._();

  IAppMessages get us => _US._();
}

class _US extends IAppMessages {
  _US._();
  final IAppMessages _r = esMessages.mx;

  @override
  Locale get locale => const Locale(
    LanguageCodes.en,
    CountryCodes.us,
  );

  @override
  MsgProperty get welcome => msg.welcome.copyWith(
    value: 'Welcome @0',
    pValue: 'Welcome @0 and @1 and @1 and @0',
    eValue: 'There is no welcome',
  );

  @override
  MsgProperty get dark => _r.dark.copyWith(
    value: 'Dark',
  );

  @override
  MsgProperty get light => _r.light.copyWith(
    value: 'Light',
  );

  @override
  MsgProperty get system => _r.system.copyWith(
    value: 'System',
  );

  @override
  MsgProperty get settings => _r.settings.copyWith(
    value: 'Settings',
  );

  @override
  MsgProperty get signOut => _r.signOut.copyWith(
    value: 'Sign out',
  );

  @override
  MsgProperty get identify => _r.identify.copyWith(
    value: 'Identify',
  );

  @override
  MsgProperty get welcomeApp => _r.welcomeApp.copyWith(
    value: 'Welcome',
  );

  @override
  MsgProperty get activateFingerprintFace =>
      _r.activateFingerprintFace.copyWith(
        value: 'Activate fingerprint or face',
      );

  @override
  MsgProperty get deleteAccount => _r.deleteAccount.copyWith(
    value: 'Delete account',
  );

  @override
  MsgProperty get quickLogin => _r.quickLogin.copyWith(
    value: 'Quick login',
  );

  @override
  MsgProperty get academicData => _r.academicData.copyWith(
    value: 'Academic Data',
  );

  @override
  MsgProperty get assistants => _r.assistants.copyWith(
    value: 'Assistants',
    eValue: 'Without assistants',
  );

  @override
  MsgProperty get myUsers => _r.myUsers.copyWith(
    value: 'My users',
    pValue: 'My user',
    eValue: 'No users',
  );

  @override
  MsgProperty get doctorsInformation => _r.doctorsInformation.copyWith(
    value: "Doctor's Information",
  );

  @override
  MsgProperty get myProfile => _r.myProfile.copyWith(
    value: 'My Profile',
  );

  @override
  MsgProperty get personalData => _r.personalData.copyWith(
    value: 'Personal Data',
  );

  @override
  MsgProperty get taxData => _r.taxData.copyWith(
    value: 'Tax Data',
  );

  @override
  MsgProperty get taxDataAccounts => _r.taxDataAccounts.copyWith(
    value: 'Tax Data - Accounts',
  );

  @override
  MsgProperty get user =>
      _r.taxDataAccounts.copyWith(value: 'User', pValue: 'Users');

  @override
  MsgProperty get changeUser => _r.changeUser.copyWith(
    value: 'Change user',
  );

  @override
  MsgProperty get continueB => _r.continueB.copyWith(
    value: 'Continue',
  );

  @override
  MsgProperty get login => _r.login.copyWith(
    value: 'Login',
  );

  @override
  MsgProperty get dontHaveAccount => _r.dontHaveAccount.copyWith(
    value: "Don't have an account?",
  );

  @override
  MsgProperty get email => _r.email.copyWith(
    value: 'Email',
  );

  @override
  MsgProperty get forgotPassword => _r.forgotPassword.copyWith(
    value: 'Forgot your password?',
  );

  @override
  MsgProperty get changePassword => _r.changePassword.copyWith(
    value: 'Change password',
  );

  @override
  MsgProperty get loginBiometrics => _r.loginBiometrics.copyWith(
    value: 'Login with biometrics',
  );

  @override
  MsgProperty get password => _r.password.copyWith(
    value: 'Password',
  );

  @override
  MsgProperty get registerNow => _r.registerNow.copyWith(
    value: 'Register now',
  );

  @override
  MsgProperty get cancel => _r.cancel.copyWith(
    value: 'Cancel',
  );

  @override
  MsgProperty get enterYourEmail => _r.enterYourEmail.copyWith(
    value: 'Enter your email',
  );

  @override
  MsgProperty get sendLink => _r.sendLink.copyWith(
    value: 'Send link',
  );

  @override
  MsgProperty get accept => _r.accept.copyWith(
    value: 'Accept',
  );

  @override
  MsgProperty get acceptAndContinue => _r.acceptAndContinue.copyWith(
    value: 'Accept and continue',
  );

  @override
  MsgProperty get addAssistant => _r.addAssistant.copyWith(
    value: 'Add user',
  );

  @override
  MsgProperty get disableAssistant => _r.disableAssistant.copyWith(
    value: 'The assistant will be disabled',
  );

  @override
  MsgProperty get disableUser => _r.disableUser.copyWith(
    value: 'Are you sure you want to disable the user?',
  );

  @override
  MsgProperty get enableAssistant => _r.enableAssistant.copyWith(
    value: 'The assistant will be enabled',
  );

  @override
  MsgProperty get enableUser => _r.enableUser.copyWith(
    value: 'Are you sure you want to enable the user?',
  );

  @override
  MsgProperty get loadingData => _r.loadingData.copyWith(
    value: 'Loading data',
  );

  @override
  MsgProperty get loadingInformation => _r.loadingInformation.copyWith(
    value: 'Loading information...',
  );

  @override
  MsgProperty get myAccess => _r.myAccess.copyWith(
    value: 'My accesses',
  );

  @override
  MsgProperty get noAssistantsToShow => _r.noAssistantsToShow.copyWith(
    value: 'No assistants to show',
  );

  @override
  MsgProperty get noInformationToShow => _r.noInformationToShow.copyWith(
    value: 'No information to show',
  );

  @override
  MsgProperty get pleaseTryAgainLater => _r.pleaseTryAgainLater.copyWith(
    value: 'Please try again later.',
  );

  @override
  MsgProperty get selectProfile => _r.selectProfile.copyWith(
    value: "Select the doctor's profile you want to access.",
  );

  @override
  MsgProperty get welcomeHome => _r.welcomeHome.copyWith(
    value: 'Welcome',
  );

  @override
  MsgProperty get birthdate => _r.birthdate.copyWith(
    value: 'Birthdate',
  );

  @override
  MsgProperty get generalData => _r.generalData.copyWith(
    value: 'General Data',
  );

  @override
  MsgProperty get name => _r.name.copyWith(
    value: 'Name(s)',
  );

  @override
  MsgProperty get lastName => _r.lastName.copyWith(
    value: 'Last Name',
  );

  @override
  MsgProperty get secondLastName => _r.secondLastName.copyWith(
    value: 'Second LastName',
  );

  @override
  MsgProperty get notLastName => _r.secondLastName.copyWith(
    value: 'LastName',
  );

  @override
  MsgProperty get notSecondLastName => _r.secondLastName.copyWith(
    value: 'Second LastName',
  );

  @override
  MsgProperty get newUser => _r.newUser.copyWith(
    value: 'New User',
  );

  @override
  MsgProperty get permissions => _r.permissions.copyWith(
    value: 'Permissions',
  );

  @override
  MsgProperty get phoneNumber => _r.phoneNumber.copyWith(
    value: 'Phone Number',
  );

  @override
  MsgProperty get registerUser => _r.registerUser.copyWith(
    value: 'Register User',
  );

  @override
  MsgProperty get stepOneOfTwo => _r.stepOneOfTwo.copyWith(
    value: 'Step 1 of 2',
  );

  @override
  MsgProperty get stepTwoOfTwo => _r.stepTwoOfTwo.copyWith(
    value: 'Step 2 of 2',
  );

  @override
  MsgProperty get typeUser => _r.typeUser.copyWith(
    value: 'User Type',
  );

  @override
  MsgProperty get updateUser => _r.updateUser.copyWith(
    value: 'Update User',
  );

  @override
  MsgProperty get clabe => _r.clabe.copyWith(
    value: 'CLABE',
  );

  @override
  MsgProperty get numberAccount => _r.numberAccount.copyWith(
    value: 'Account number',
  );

  @override
  MsgProperty get pleaseWait => _r.pleaseWait.copyWith(
    value: 'Please wait...',
  );

  @override
  MsgProperty get selectOneOrMoreOptions => _r.selectOneOrMoreOptions.copyWith(
    value: 'Select one or more options',
  );

  @override
  MsgProperty get errorLoadingAssistants => _r.errorLoadingAssistants.copyWith(
    value: 'Error loading assistants.',
  );

  @override
  MsgProperty get errorLoadingInvites => _r.errorLoadingInvites.copyWith(
    value: 'Error Loading Invites',
  );

  @override
  MsgProperty get errorLoadingContact => _r.errorLoadingInvites.copyWith(
    value: 'Error Loading Contact Data',
  );

  @override
  MsgProperty get errorLoadingForm => _r.noForm.copyWith(
    value: 'Error loading form',
  );

  @override
  MsgProperty get errorLoadingInfo => _r.errorLoadingInfo.copyWith(
    value: 'Error loading information',
  );

  @override
  MsgProperty get noInvites => _r.noInvites.copyWith(
    value: 'No Invites',
  );

  @override
  MsgProperty get noActiveInvites => _r.noActiveInvites.copyWith(
    value: 'You have no active invitations',
  );

  @override
  MsgProperty get noForm => _r.noForm.copyWith(
    value: 'No form to display',
  );

  @override
  MsgProperty get medicalReport => _r.medicalReport.copyWith(
    value: 'Medical Report',
  );

  @override
  MsgProperty get requestMedicalAgreement =>
      _r.requestMedicalAgreement.copyWith(
        value:
            'Upload all the necessary documents to complete your agreement '
            'application. Files must be in PDF or JPG format.',
      );

  @override
  MsgProperty get paymentManual => _r.paymentManual.copyWith(
    value: 'Payment Manual',
  );

  @override
  MsgProperty get paymentNumber => _r.paymentNumber.copyWith(
    value: 'Payment Number',
  );

  @override
  MsgProperty get glossaryTerms => _r.glossaryTerms.copyWith(
    value: 'Glossary of Terms',
  );

  @override
  MsgProperty get levelsAndTabs => _r.levelsAndTabs.copyWith(
    value: 'Levels and Tabs',
  );

  @override
  MsgProperty get annexes => _r.annexes.copyWith(
    value: 'Annexes',
  );

  @override
  MsgProperty get benefits => _r.benefits.copyWith(
    value: 'Benefits',
  );

  @override
  MsgProperty get gnpContact => _r.gnpContact.copyWith(
    value: 'GNP Contact',
  );

  @override
  MsgProperty get webSite => _r.webSite.copyWith(
    value: 'Web Site',
  );

  @override
  MsgProperty get gnpLine => _r.gnpLine.copyWith(
    value: 'GNP Line',
  );

  @override
  MsgProperty get contactGnp => _r.contactGnp.copyWith(
    value: 'GNP Contact',
  );

  @override
  MsgProperty get contact => _r.contact.copyWith(
    value: 'Contact',
  );

  @override
  MsgProperty get agreement => _r.agreement.copyWith(
    value: 'Agreement',
  );

  @override
  MsgProperty get download => _r.download.copyWith(
    value: 'Download',
  );

  @override
  MsgProperty get view => _r.view.copyWith(
    value: 'View',
  );

  @override
  MsgProperty get rfc => _r.rfc.copyWith(
    value: 'RFC',
  );

  @override
  MsgProperty get withHomoclave => _r.withHomoclave.copyWith(
    value: 'With Homoclave',
  );

  @override
  MsgProperty get doctorsName => _r.doctorsName.copyWith(
    value: "Doctor's Name",
  );

  @override
  MsgProperty get specialty => _r.specialty.copyWith(
    value: 'Specialty',
    eValue: 'No specialty',
    pValue: 'Specialties',
  );

  @override
  MsgProperty get state => _r.state.copyWith(
    value: 'State',
  );

  @override
  MsgProperty get medicalCircle => _r.medicalCircle.copyWith(
    value: 'Medical Circle',
  );

  @override
  MsgProperty get medicalTabulator => _r.medicalTabulator.copyWith(
    value: 'Medical Tabulator',
  );

  @override
  MsgProperty get status => _r.status.copyWith(
    value: 'Status',
  );

  @override
  MsgProperty get tabulators => _r.tabulators.copyWith(
    value: 'Tabulators',
  );

  @override
  MsgProperty get consultGuidelines => _r.consultGuidelines.copyWith(
    value: 'Consult guidelines',
  );

  @override
  MsgProperty get updateInformation => _r.updateInformation.copyWith(
    value: 'Update information',
  );

  @override
  MsgProperty get terminationAgreement => _r.terminationAgreement.copyWith(
    value: 'Termination Agreement',
  );

  @override
  MsgProperty get downloadMedicalAgreement =>
      _r.downloadMedicalAgreement.copyWith(
        value: 'Download Medical Agreement',
      );

  @override
  MsgProperty get downloadFormats => _r.downloadFormats.copyWith(
    value: 'Download formats',
  );

  @override
  MsgProperty get directory => _r.directory.copyWith(
    value: 'Directory',
  );

  @override
  MsgProperty get medicalRegister => _r.medicalRegister.copyWith(
    value: 'Medical Register',
  );

  @override
  MsgProperty get registrationData => _r.registrationData.copyWith(
    value: 'Registration Data',
  );

  @override
  MsgProperty get fullName => _r.fullName.copyWith(
    value: 'Full Name',
  );

  @override
  MsgProperty get createAccount => _r.createAccount.copyWith(
    value: 'Create Account',
  );

  @override
  MsgProperty get createRegister => _r.createRegister.copyWith(
    value: 'Create register',
  );

  @override
  MsgProperty get rememberUser => _r.rememberUser.copyWith(
    value: 'Remember user',
  );

  @override
  MsgProperty get formats => _r.formats.copyWith(
    value: 'Formats',
  );

  @override
  MsgProperty get transplantOrthopedicsFormat =>
      _r.transplantOrthopedicsFormat.copyWith(
        value: 'Transplant and Orthopedics Format',
      );

  @override
  MsgProperty get transferFormat => _r.transferFormat.copyWith(
    value: 'Transfer format for ...',
  );

  @override
  MsgProperty get accessionLetter => _r.accessionLetter.copyWith(
    value: 'Accession Letter',
  );

  @override
  MsgProperty get requestLog => _r.requestLog.copyWith(
    value: 'Request Log',
  );

  @override
  MsgProperty get applicationLog => _r.applicationLog.copyWith(
    value: 'Application Log',
  );

  @override
  MsgProperty get applicationSheet => _r.applicationSheet.copyWith(
    value: 'Application sheet',
  );

  @override
  MsgProperty get dateRequest => _r.dateRequest.copyWith(
    value: 'Date Request',
  );

  @override
  MsgProperty get uploadInformation => _r.uploadInformation.copyWith(
    value: 'Upload Information',
  );

  @override
  MsgProperty get prepareFollowingDocumentation =>
      _r.prepareFollowingDocumentation.copyWith(
        value: 'Prepare the following documentation',
      );

  @override
  MsgProperty get documentationFormat => _r.documentationFormat.copyWith(
    value: 'The documentation must be in PDF or JPG format.',
  );

  @override
  MsgProperty get documentationFormatPDFPNG =>
      _r.documentationFormatPDFPNG.copyWith(
        value: 'The documentation must be in PDF or JPG format.',
      );

  @override
  MsgProperty get paymentByTransfer => _r.paymentByTransfer.copyWith(
    value: 'Payment by transfer',
  );

  @override
  MsgProperty get documentationRequest => _r.documentationRequest.copyWith(
    value: 'Documentation Request',
  );

  @override
  MsgProperty get requestDocumentation => _r.requestDocumentation.copyWith(
    value: 'Documentation Request',
  );

  @override
  MsgProperty get begin => _r.begin.copyWith(
    value: 'Begin',
  );

  @override
  MsgProperty get goOut => _r.goOut.copyWith(
    value: 'Go out',
  );

  @override
  MsgProperty get documents => _r.documents.copyWith(
    value: 'Documents',
  );

  @override
  MsgProperty get documentsUploaded => _r.documentsUploaded.copyWith(
    value: 'Documents uploaded',
  );

  @override
  MsgProperty get fileMaximum => _r.fileMaximum.copyWith(
    value: 'File maximum of ',
  );

  @override
  MsgProperty get format => _r.format.copyWith(
    value: 'in format:',
  );

  @override
  MsgProperty get formatsForUpload => _r.formatsForUpload.copyWith(
    value: 'JPG, PNG, PDF, XML, DOCX',
  );

  @override
  MsgProperty get requestAgreement => _r.requestAgreement.copyWith(
    value: 'Request Agreement',
  );

  @override
  MsgProperty get requiredDocumentation => _r.requiredDocumentation.copyWith(
    value: 'Required Documentation',
  );

  @override
  MsgProperty get selectDocumentUpload => _r.selectDocumentUpload.copyWith(
    value: 'Select the document to upload.',
  );

  @override
  MsgProperty get uploadFile => _r.uploadFile.copyWith(
    value: 'Upload file',
  );

  @override
  MsgProperty get threeMB => _r.threeMB.copyWith(
    value: '3 MB ',
  );

  @override
  MsgProperty get understood => _r.understood.copyWith(
    value: 'Understood',
  );

  @override
  MsgProperty get consult => _r.consult.copyWith(
    value: 'Consult',
  );

  @override
  MsgProperty get cost => _r.cost.copyWith(
    value: 'Cost',
  );

  @override
  MsgProperty get cpts => _r.cpts.copyWith(
    value: 'CPT´s',
  );

  @override
  MsgProperty get medicalCircleTab => _r.medicalCircleTab.copyWith(
    value: 'Círculo/Tabulador Médico',
  );

  @override
  MsgProperty get procedure => _r.procedure.copyWith(
    value: 'Procedimiento',
  );

  @override
  MsgProperty get tabulator => _r.tabulator.copyWith(
    value: 'Tabulador',
  );

  @override
  MsgProperty get myData => _r.myData.copyWith(
    value: 'My data',
  );

  @override
  MsgProperty get profesionalTitle => _r.profesionalTitle.copyWith(
    value: 'Profesional Title',
  );

  @override
  MsgProperty get gender => _r.gender.copyWith(
    value: 'Gender',
  );

  @override
  MsgProperty get medicalOffice => _r.medicalOffice.copyWith(
    value: 'Medical office',
  );

  @override
  MsgProperty get nationality => _r.nationality.copyWith(
    value: 'Nationality',
  );

  @override
  MsgProperty get subSpecialty => _r.subSpecialty.copyWith(
    value: 'Subspecialty',
  );

  @override
  MsgProperty get enterTenDigits => _r.enterTenDigits.copyWith(
    value: 'Enter the 10 digits of your number',
  );

  @override
  MsgProperty get enterMinDigits => _r.enterMinDigits.copyWith(
    value: 'It must have at least 6 characters',
  );

  @override
  MsgProperty get enterYourDate => _r.enterYourDate.copyWith(
    value: 'Select a valid date',
  );

  @override
  MsgProperty get enterYourNameContinue => _r.enterYourNameContinue.copyWith(
    value: 'Enter your name to continue.',
  );

  @override
  MsgProperty get enterYourLastNameContinue =>
      _r.enterYourLastNameContinue.copyWith(
        value: 'Enter your lastname to continue',
      );

  @override
  MsgProperty get enterYourSecondLastNameContinue =>
      _r.enterYourSecondLastNameContinue.copyWith(
        value: 'Enter your second lastname to continue',
      );

  @override
  MsgProperty get enterYourOption => _r.enterYourOption.copyWith(
    value: 'Select a valid option',
  );

  @override
  MsgProperty get enterYourPassword => _r.enterYourPassword.copyWith(
    value: 'Enter your password',
  );

  @override
  MsgProperty get enterYourPhoneNumber => _r.enterYourPhoneNumber.copyWith(
    value: 'The phone number is required',
  );

  @override
  MsgProperty get enterYourRfc => _r.enterYourRfc.copyWith(
    value: 'The RFC is mandatory.',
  );

  @override
  MsgProperty get enterYourRfcName => _r.enterYourRfcName.copyWith(
    value: 'The RFC does not match the name and lastnames.',
  );

  @override
  MsgProperty get rfcFormatInvalid => _r.rfcFormatInvalid.copyWith(
    value: 'The RFC format is not valid.',
  );

  @override
  MsgProperty get rfcGenericNoAllowed => _r.rfcGenericNoAllowed.copyWith(
    value: 'The generic RFC is not allowed.',
  );

  @override
  MsgProperty get rfcDigitsTwelveThirteen =>
      _r.rfcDigitsTwelveThirteen.copyWith(
        value: 'The RFC must have 12 or 13 characters.',
      );

  @override
  MsgProperty get reTabulationsTitle => _r.reTabulationsTitle.copyWith(
    value:
        '''Questions about payments, tabulations, or clarifications of letters of introduction:''',
  );
  @override
  MsgProperty get reTabulationsSubtitle => _r.reTabulationsSubtitle.copyWith(
    value: '''Contact the Centro de Atención a Medicos (CAM):''',
  );

  @override
  MsgProperty get bankingInfoTitle => _r.bankingInfoTitle.copyWith(
    value: '''Data updates (tax, banking, or account statements):''',
  );
  @override
  MsgProperty get bankingInfoSubtitle => _r.bankingInfoSubtitle.copyWith(
    value: '''Please contact the Supplier Information area:''',
  );

  @override
  MsgProperty get personalizedAssistanceTitle =>
      _r.personalizedAssistanceTitle.copyWith(
        value: '''Personalized assistance:''',
      );

  @override
  MsgProperty
  get personalizedAssistanceSubtitle => 
  _r.personalizedAssistanceSubtitle.copyWith(
    value:
        '''If you require the contact information of the executive assigned to your specialty, please send an email to CAM requesting this information:''',
  );

  @override
  MsgProperty get onlyAlphabeticCharacters =>
      _r.onlyAlphabeticCharacters.copyWith(
        value: '''Only alphabetic characters are permitted''',
      );

  @override
  MsgProperty get toRegisterYouAccept => _r.toRegisterYouAccept.copyWith(
    value: '''By registering you agree to our ''',
  );
  @override
  MsgProperty get termsAndConditions => _r.termsAndConditions.copyWith(
    value: '''Terms and conditions of use of Electronic Media''',
  );

  @override
  MsgProperty get fromGroupNational => _r.fromGroupNational.copyWith(
    value: '''of Grupo Nacional Provincial S.A.B''',
  );

  @override
  MsgProperty get signUp => _r.signUp.copyWith(
    value: '''signUp''',
  );

  @override
  MsgProperty get homeTerms => _r.homeTerms.copyWith(
    value:
        'Partial or total reproduction of the information contained on '
        'this site in digital form is prohibited.',
  );

  @override
  MsgProperty get noResultsFound => _r.noResultsFound.copyWith(
    value: 'No results found',
  );

  @override
  MsgProperty get selectBtnToContinue => _r.selectBtnToContinue.copyWith(
    value: 'Select the "New Search" button to try again.',
  );

  @override
  MsgProperty get apologize => _r.apologize.copyWith(
    value: 'Im sorry',
    pValue: "¡We're sorry!",
  );

  @override
  MsgProperty get noInvitation => _r.noInvitation.copyWith(
    value:
        "It appears you don't have an active invitation at this time. "
        'We suggest contacting your doctor to obtain access.',
  );

  @override
  MsgProperty get back => _r.back.copyWith(
    value: 'Back',
  );

  @override
  MsgProperty get errorOccurred => _r.errorOccurred.copyWith(
    value: 'Error occurred',
  );

  @override
  MsgProperty get couldNotRetrieveAnnexes =>
      _r.couldNotRetrieveAnnexes.copyWith(
        value: 'Could not retrieve annexes',
      );

  @override
  MsgProperty get couldNotRetrieveBenefits =>
      _r.couldNotRetrieveBenefits.copyWith(
        value: 'Could not retrieve benefits',
      );

  @override
  MsgProperty get couldNotRetrieveFormats =>
      _r.couldNotRetrieveFormats.copyWith(
        value: 'Could not retrieve formats',
      );

  @override
  MsgProperty get noDataAvailable => _r.noDataAvailable.copyWith(
    value: 'No @0 available',
  );

  @override
  MsgProperty get doctor => _r.doctor.copyWith(
    value: 'Doctor',
    pValue: 'Doctors',
  );

  @override
  MsgProperty get inAgreement => _r.inAgreement.copyWith(
    value: 'in agreement',
  );

  @override
  MsgProperty get hospital => _r.hospital.copyWith(
    value: 'Hospitals',
  );

  @override
  MsgProperty get clinica => _r.clinica.copyWith(
    value: 'Clinics',
  );

  @override
  MsgProperty get otherServices => _r.otherServices.copyWith(
    value: 'Other health services',
  );

  @override
  MsgProperty get errorGetting => _r.errorGetting.copyWith(
    value: 'Error getting ',
  );

  @override
  MsgProperty get lookingforHospital => _r.lookingforHospital.copyWith(
    value: 'Looking for hospital by name',
  );

  @override
  MsgProperty get optionalName => _r.optionalName.copyWith(
    value: 'Optional name',
  );

  @override
  MsgProperty get circle => _r.circle.copyWith(
    value: 'circle',
  );

  @override
  MsgProperty get circleOrTab => _r.circleOrTab.copyWith(
    value: 'Circle or tabulator',
  );

  @override
  MsgProperty get estado => _r.estado.copyWith(
    value: 'State',
  );

  @override
  MsgProperty get healthPlan => _r.healthPlan.copyWith(
    value: 'Health Plan',
  );

  @override
  MsgProperty get clinicType => _r.clinicType.copyWith(
    value: 'Clinic Type',
  );

  @override
  MsgProperty get servicesType => _r.servicesType.copyWith(
    value: 'Services Type',
  );

  @override
  MsgProperty get municipality => _r.municipality.copyWith(
    value: 'Municipality',
  );

  @override
  MsgProperty get selectMunicipalityAfterState =>
      _r.selectMunicipalityAfterState.copyWith(
        value: 'To show municipalities, select a state.',
      );

  @override
  MsgProperty get toCheckLevelHospital => _r.toCheckLevelHospital.copyWith(
    value:
        '''Note that the hospital level depends on the policy the insured has purchased.''',
  );

  @override
  MsgProperty get lookingforClinicaName => _r.lookingforClinicaName.copyWith(
    value: 'Looking for clinic by name',
  );

  @override
  MsgProperty get lookingforOtherServicesName =>
      _r.lookingforOtherServicesName.copyWith(
        value: 'Looking for other health services by name',
      );

  @override
  MsgProperty get careHospitals => _r.careHospitals.copyWith(
    value: 'Care Hospitals.',
  );

  @override
  MsgProperty get medicalOfficeAddress => _r.medicalOfficeAddress.copyWith(
    value: 'Medical office Address.',
  );

  @override
  MsgProperty get newRequest => _r.newRequest.copyWith(
    value: 'New request',
  );

  @override
  MsgProperty get pleaseEnterYourOfficeAddress =>
      _r.medicalOfficeAddress.copyWith(
        value: 'Please, enter your office address',
      );

  @override
  MsgProperty get pleaseSelectASpecialty => _r.pleaseSelectASpecialty.copyWith(
    value: 'Please select a specialty',
  );

  @override
  MsgProperty get pleaseSelectAState => _r.pleaseSelectAState.copyWith(
    value: 'Please select a state',
  );

  @override
  MsgProperty get pleaseSelectASubspecialty =>
      _r.pleaseSelectASubspecialty.copyWith(
        value: 'Please select a subspecialty',
      );

  @override
  MsgProperty get pleaseSelectAtLeastOneHospital =>
      _r.pleaseSelectAtLeastOneHospital.copyWith(
        value: 'Please select at least one hospital',
      );

  @override
  MsgProperty get sendRequest => _r.sendRequest.copyWith(
    value: 'Send request',
  );

  @override
  MsgProperty get myProcedures => _r.myProcedures.copyWith(
    value: 'My Procedures',
  );

  @override
  MsgProperty get notProcedures => _r.notProcedures.copyWith(
    value: 'Not found procedures',
  );

  @override
  MsgProperty get errorToGetProcedures => _r.errorToGetProcedures.copyWith(
    value: 'Error getting procedures',
  );

  @override
  MsgProperty get myPayments => _r.myPayments.copyWith(
    value: 'My payments',
  );

  @override
  MsgProperty get profile => _r.profile.copyWith(
    value: 'Profile',
  );

  @override
  MsgProperty get errorToGetProfile => _r.errorToGetProfile.copyWith(
    value: 'Error getting profile',
  );

  ///* Modulo: Directorio (Nuevas llaves)
  @override
  MsgProperty get home => _r.home.copyWith(value: 'Home');

  @override
  MsgProperty get all => _r.all.copyWith(value: 'All');

  @override
  MsgProperty get errorLoadingStates => _r.errorLoadingStates.copyWith(
    value: 'Error loading states. Please try again later',
  );

  @override
  MsgProperty get errorGettingMunicipalities =>
      _r.errorGettingMunicipalities.copyWith(
        value: 'Error getting municipalities. Please try again later',
      );

  @override
  MsgProperty get search => _r.search.copyWith(value: 'Search');

  @override
  MsgProperty get searchForSpecialty =>
      _r.searchForSpecialty.copyWith(value: 'Search by specialty');

  @override
  MsgProperty get searchResults =>
      _r.searchResults.copyWith(value: 'Search Results');

  @override
  MsgProperty get resultsFoundPage => _r.resultsFoundPage.copyWith(
    value: 'Found @0 results Page @1 of @2',
  );

  @override
  MsgProperty get selected => _r.selected.copyWith(value: 'selected');

  @override
  MsgProperty get noResultsWithFilters => _r.noResultsWithFilters.copyWith(
    value: 'No results were found with the selected filters.',
  );

  @override
  MsgProperty get calculatingPleaseWait => _r.calculatingPleaseWait.copyWith(
    value: 'Calculating, please wait a moment...',
  );

  @override
  MsgProperty get goodDay => _r.goodDay.copyWith(value: 'Good day, @0!');

  @override
  MsgProperty get welcomeMessageBody => _r.welcomeMessageBody.copyWith(
    value:
        '''You are a fundamental pillar for GNP Seguros. Thanks to your commitment and great vocation of service, we have supported and provided peace of mind to Mexican families when they need it most. Therefore, we want to continue teaming up with you and provide you with tools that optimize your administrative times.''',
  );

  @override
  MsgProperty get welcomeMessageFooter => _r.welcomeMessageFooter.copyWith(
    value:
        '''Being allies with our network doctors, and also with those who are not, we remain committed to the health recovery of patients while meeting GNP's efficiency and service indicators.''',
  );

  @override
  MsgProperty get deleteSearchFilters => _r.deleteSearchFilters.copyWith(
    value: '''Delete search''',
  );

  @override
  MsgProperty get errorGettingAnnexes => _r.errorGettingAnnexes.copyWith(
    value: 'Error getting Annexes. Please try again later',
  );

  @override
  MsgProperty get errorDownloadingAnnex => _r.errorDownloadingAnnex.copyWith(
    value: 'Error getting the Annex. Please try again later',
  );

  @override
  MsgProperty get couldNotDownloadAnnex => _r.couldNotDownloadAnnex.copyWith(
    value: 'Could not download the annex. Please try again later.',
  );

  @override
  MsgProperty get folio => _r.folio.copyWith(value: 'Folio');

  @override
  MsgProperty get insuredName => _r.insuredName.copyWith(value: 'Insured Name');

  @override
  MsgProperty get dateOfLoss => _r.dateOfLoss.copyWith(value: 'Date of Loss');

  @override
  MsgProperty get condition => _r.condition.copyWith(value: 'Condition');

  @override
  MsgProperty get attendingHospital =>
      _r.attendingHospital.copyWith(value: 'Attending Hospital');

  @override
  MsgProperty get policy => _r.policy.copyWith(value: 'Policy');

  @override
  MsgProperty get noProceduresFoundForDate =>
      _r.noProceduresFoundForDate.copyWith(
        value: 'No procedures found for the selected date',
      );

  @override
  MsgProperty get paymentStatus => _r.paymentStatus.copyWith(
    value: 'Payment Status',
  );

  @override
  MsgProperty get amountClaimed => _r.amountClaimed.copyWith(
    value: 'Amount Claimed',
  );

  @override
  MsgProperty get paymentDate => _r.paymentDate.copyWith(
    value: 'Payment Date',
  );

  @override
  MsgProperty get notPayments => _r.notPayments.copyWith(
    value: 'NotPayments',
  );

  @override
  List<String> get monthAbbreviations => [
    'Jan',
    'Feb',
    'Mar',
    'Apr',
    'May',
    'Jun',
    'Jul',
    'Aug',
    'Sep',
    'Oct',
    'Nov',
    'Dec',
  ];

  @override
  MsgProperty get amountPaid => _r.amountPaid.copyWith(
    value: 'Amount Paid',
  );

  @override
  MsgProperty get associatedIncident => _r.associatedIncident.copyWith(
    value: 'Associated Incident',
  );

  @override
  MsgProperty get paymentAccount => _r.paymentAccount.copyWith(
    value: 'Payment Account',
  );

  @override
  MsgProperty get bankingInstitution => _r.bankingInstitution.copyWith(
    value: 'Banking Institution:',
  );

  @override
  MsgProperty get errorGettingClinics => _r.errorGettingClinics.copyWith(
    value: 'Error getting clinics. Please try again later',
  );

  @override
  MsgProperty get errorGettingDoctors => _r.errorGettingDoctors.copyWith(
    value: 'Error getting doctors. Please try again later',
  );

  @override
  MsgProperty get errorGettingHospitals => _r.errorGettingHospitals.copyWith(
    value: 'Error getting hospitals. Please try again later',
  );

  @override
  MsgProperty get errorGettingOtherServices =>
      _r.errorGettingOtherServices.copyWith(
        value: 'Error getting other services. Please try again later',
      );

  @override
  MsgProperty get noDataReceived => _r.noDataReceived.copyWith(
    value: 'No data received.',
  );

  @override
  MsgProperty get locationServicesDisabledTitle =>
      _r.locationServicesDisabledTitle.copyWith(
        value: 'Location services disabled',
      );

  @override
  MsgProperty get locationServicesDisabledMessage =>
      _r.locationServicesDisabledMessage.copyWith(
        value: 'Please enable location services.',
      );

  @override
  MsgProperty get permissionsDeniedTitle => _r.permissionsDeniedTitle.copyWith(
    value: 'Permissions denied',
  );

  @override
  MsgProperty get permissionsDeniedMessage =>
      _r.permissionsDeniedMessage.copyWith(
        value: 'Cannot get current location without permissions.',
      );

  @override
  MsgProperty get permissionsPermanentlyDeniedTitle =>
      _r.permissionsPermanentlyDeniedTitle.copyWith(
        value: 'Permissions permanently denied',
      );

  @override
  MsgProperty get permissionsPermanentlyDeniedMessage =>
      _r.permissionsPermanentlyDeniedMessage.copyWith(
        value: 'Open app settings to enable location.',
      );

  @override
  MsgProperty get errorMakingPhoneCall => _r.errorMakingPhoneCall.copyWith(
    value: 'Error trying to make the phone call. Please try again later.',
  );

  @override
  MsgProperty get routeNotAvailableTitle => _r.routeNotAvailableTitle.copyWith(
    value: 'Route not available',
  );

  @override
  MsgProperty get routeNotAvailableMsg => _r.routeNotAvailableMsg.copyWith(
    value:
        '''Could not get the route to the destination. Please try again later.''',
  );

  @override
  MsgProperty get youAreHere => _r.youAreHere.copyWith(
    value: 'You are here',
  );

  @override
  MsgProperty get evaluations => _r.evaluations.copyWith(
    value: 'Evaluations',
  );

  ///* Modulo: Alertas Genericas
  @override
  MsgProperty get error => _r.error.copyWith(value: 'Error');

  @override
  MsgProperty get success =>
      _r.success.copyWith(value: 'Successful submission');

  @override
  MsgProperty get failed => _r.failed.copyWith(value: 'Failed');

  @override
  MsgProperty get endOfList => _r.endOfList.copyWith(value: 'End of list');

  @override
  MsgProperty get emptyFilters =>
      _r.emptyFilters.copyWith(value: 'Empty filters');

  @override
  MsgProperty get invalidUserOrPassword => _r.invalidUserOrPassword.copyWith(
    value: 'Incorrect user and/or password. Please check and try again.',
  );

  @override
  MsgProperty get passwordRecoveryLinkSent =>
      _r.passwordRecoveryLinkSent.copyWith(
        value: 'A password recovery link has been sent to your email.',
      );

  @override
  MsgProperty get biometricsNotAvailable => _r.biometricsNotAvailable.copyWith(
    value: 'Biometrics are not available on this device.',
  );

  @override
  MsgProperty get biometricAuthenticationFailed =>
      _r.biometricAuthenticationFailed.copyWith(
        value: 'Biometric Authentication Failed.',
      );

  @override
  MsgProperty get errorAuthenticating => _r.errorAuthenticating.copyWith(
    value: 'An error occurred while trying to authenticate.',
  );

  @override
  MsgProperty get errorGettingFormat => _r.errorGettingFormat.copyWith(
    value: 'Failed to get the format.',
  );

  @override
  MsgProperty get errorDetail =>
      _r.errorDetail.copyWith(value: 'An error occurred: @0.');

  @override
  MsgProperty get errorLoadingProfile => _r.errorLoadingProfile.copyWith(
    value: 'There was a problem loading the profile. Please try again later.',
  );

  @override
  MsgProperty get errorGettingDocument => _r.errorGettingDocument.copyWith(
    value: 'Failed to get the document.',
  );

  @override
  MsgProperty get agreementNotInEffect => _r.agreementNotInEffect.copyWith(
    value: 'The agreement is not in effect.',
  );

  @override
  MsgProperty get agreementUpdated => _r.agreementUpdated.copyWith(
    value: 'The agreement has been updated.',
  );

  @override
  MsgProperty get requestRegistered => _r.requestRegistered.copyWith(
    value: 'The request was registered.',
  );

  @override
  MsgProperty get requestNotRegistered => _r.requestNotRegistered.copyWith(
    value: 'The request was not registered.',
  );

  @override
  MsgProperty get noMoreProceduresToLoad => _r.noMoreProceduresToLoad.copyWith(
    value: 'No more procedures to load.',
  );

  @override
  MsgProperty get selectFilterAndEnterData =>
      _r.selectFilterAndEnterData.copyWith(
        value: 'Please select a filter and enter data to continue.',
      );

  @override
  MsgProperty get successfulRegistration => _r.successfulRegistration.copyWith(
    value: 'Successful registration',
  );

  @override
  MsgProperty get userRegisteredSuccessfully =>
      _r.userRegisteredSuccessfully.copyWith(
        value: 'User registered successfully.',
      );

  @override
  MsgProperty get successfulUpdate => _r.successfulUpdate.copyWith(
    value: 'Successful update',
  );

  @override
  MsgProperty get assistantNotUpdated => _r.assistantNotUpdated.copyWith(
    value: 'The assistant was not updated.',
  );

  @override
  MsgProperty get errorUpdatingAssistantPermissions =>
      _r.errorUpdatingAssistantPermissions.copyWith(
        value: 'Error updating assistant permissions.',
      );

  @override
  MsgProperty get errorLoadingProfileTitle =>
      _r.errorLoadingProfileTitle.copyWith(
        value: 'Error loading profile',
      );

  @override
  MsgProperty get noDocumentsUploadedYet => _r.noDocumentsUploadedYet.copyWith(
    value: 'You have not uploaded any documents yet.',
  );

  @override
  MsgProperty get dataNotLoaded => _r.dataNotLoaded.copyWith(
    value: 'Data not loaded',
  );

  @override
  MsgProperty get errorLoadingData => _r.errorLoadingData.copyWith(
    value: 'Error: @0',
  );

  @override
  MsgProperty get dAtLeast8Chars => _r.dAtLeast8Chars.copyWith(
    value: 'Must be at least 8 characters.',
  );

  @override
  MsgProperty get dAtLeastOneUppercase => _r.dAtLeastOneUppercase.copyWith(
    value: 'Must contain at least one uppercase letter.',
  );

  @override
  MsgProperty get dAtLeastOneLowercase => _r.dAtLeastOneLowercase.copyWith(
    value: 'Must contain at least one lowercase letter.',
  );

  @override
  MsgProperty get dAtLeast4AlphaChars => _r.dAtLeast4AlphaChars.copyWith(
    value: 'Must contain at least four alphabetic characters.',
  );

  @override
  MsgProperty get dAtLeastOneNumeric => _r.dAtLeastOneNumeric.copyWith(
    value: 'Must contain at least one numeric character.',
  );

  @override
  MsgProperty get dAtLeastOneSpecialChar => _r.dAtLeastOneSpecialChar.copyWith(
    value: 'Must contain at least one special character.',
  );

  @override
  MsgProperty get dNoGnpWord => _r.dNoGnpWord.copyWith(
    value: 'Must not contain the word GNP.',
  );

  @override
  MsgProperty
  get dNoConsecutiveEqualChars => _r.dNoConsecutiveEqualChars.copyWith(
    value:
        '''''Must not contain more than two consecutive equal characters (e.g. 222, eee).''',
  );

  @override
  MsgProperty get dNoConsecutiveChars => _r.dNoConsecutiveChars.copyWith(
    value:
        '''''Must not contain more than two consecutive characters (e.g. 123, abc).''',
  );

  @override
  MsgProperty get dNoWhiteSpaces => _r.dNoWhiteSpaces.copyWith(
    value: 'Must not contain whitespace.',
  );

  @override
  MsgProperty get dPasswordsDoNotMatch => _r.dPasswordsDoNotMatch.copyWith(
    value: 'Passwords do not match',
  );

  @override
  MsgProperty get successfulChange => _r.successfulChange.copyWith(
    value: 'Successful Change',
  );

  @override
  MsgProperty get dPasswordUpdated => _r.dPasswordUpdated.copyWith(
    value: 'Your password has been updated.',
  );

  @override
  MsgProperty get dDeleteAccount => _r.dDeleteAccount.copyWith(
    value:
        'Are you sure you want to delete your account? This action is '
        'permanent and you will not be able to recover it.',
  );

  @override
  MsgProperty get dResetPassword => _r.dResetPassword.copyWith(
    value:
        'Your session will now close so we can reset your password. Please '
        'ensure you have access to the registered email address to receive the '
        'corresponding instructions.',
  );

  @override
  MsgProperty get dSignOut => _r.dSignOut.copyWith(
    value: 'You are about to log out. Do you wish to continue?',
  );

  @override
  MsgProperty get resetPassword =>
      _r.resetPassword.copyWith(value: 'Reset password');

  @override
  MsgProperty get tDeleteAccount =>
      _r.tDeleteAccount.copyWith(value: 'Account deletion confirmation');

  @override
  MsgProperty get tResetPassword =>
      _r.tResetPassword.copyWith(value: 'Access restoration');

  @override
  MsgProperty get tSignOut =>
      _r.tSignOut.copyWith(value: 'Session closure confirmation');

  @override
  MsgProperty get temailAlreadyRegistered => _r.temailAlreadyRegistered
      .copyWith(value: 'The email is already registered.');

  @override
  MsgProperty
  get demailAlreadyRegistered => _r.demailAlreadyRegistered.copyWith(
    value:
        'The registered email address is already associated with your account.',
  );

  @override
  MsgProperty get errorToGetPayments => _r.errorToGetPayments.copyWith(
    value: 'Error getting payments',
  );

  @override
  MsgProperty get professionalLicense => _r.professionalLicense.copyWith(
    value: 'Professional License',
  );

  @override
  MsgProperty get speciality => _r.speciality.copyWith(
    value: 'Speciality',
  );

  @override
  MsgProperty get subspeciality => _r.subspeciality.copyWith(
    value: 'Subspeciality',
  );

  @override
  MsgProperty get fieldRequired => _r.fieldRequired.copyWith(
    value: 'This field is required.',
  );

  @override
  MsgProperty get actions => _r.actions.copyWith(
    value: 'Actions',
  );


  @override
  MsgProperty get tDeletedAccount => _r.tDeletedAccount.copyWith(
    value: 'Deleted account'
  );

  @override
  MsgProperty get dDeletedAccount => _r.dDeletedAccount.copyWith(
    value: 'The account deletion was successful.',
  );

  @override
  MsgProperty get pageNotFound => _r.pageNotFound.copyWith(
    value: 'Page not found.',
  );
}
