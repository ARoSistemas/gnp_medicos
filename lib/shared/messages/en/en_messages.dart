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
  MsgProperty get dark => esMessages.mx.dark.copyWith(
    value: 'Dark',
  );

  @override
  MsgProperty get light => esMessages.mx.light.copyWith(
    value: 'Light',
  );

  @override
  MsgProperty get system => esMessages.mx.system.copyWith(
    value: 'System',
  );

  @override
  MsgProperty get settings => esMessages.mx.settings.copyWith(
    value: 'Settings',
  );

  @override
  MsgProperty get signOut => esMessages.mx.signOut.copyWith(
    value: 'Sign out',
  );

  @override
  MsgProperty get identify => esMessages.mx.identify.copyWith(
    value: 'Identify',
  );

  @override
  MsgProperty get welcomeApp => esMessages.mx.welcomeApp.copyWith(
    value: 'Welcome',
  );

  @override
  MsgProperty get activateFingerprintFace =>
      esMessages.mx.activateFingerprintFace.copyWith(
        value: 'Activate fingerprint or face',
      );

  @override
  MsgProperty get deleteAccount => esMessages.mx.deleteAccount.copyWith(
    value: 'Delete account',
  );

  @override
  MsgProperty get quickLogin => esMessages.mx.quickLogin.copyWith(
    value: 'Quick login',
  );

  @override
  MsgProperty get academicData => esMessages.mx.academicData.copyWith(
    value: 'Academic Data',
  );

  @override
  MsgProperty get assistants => esMessages.mx.assistants.copyWith(
    value: 'Assistants',
    eValue: 'Without assistants',
  );

  @override
  MsgProperty get doctorsInformation =>
      esMessages.mx.doctorsInformation.copyWith(
        value: "Doctor's Information",
      );

  @override
  MsgProperty get myProfile => esMessages.mx.myProfile.copyWith(
    value: 'My Profile',
  );

  @override
  MsgProperty get personalData => esMessages.mx.personalData.copyWith(
    value: 'Personal Data',
  );

  @override
  MsgProperty get taxDataAccounts => esMessages.mx.taxDataAccounts.copyWith(
    value: 'Tax Data - Accounts',
  );

  @override
  MsgProperty get changeUser => esMessages.mx.changeUser.copyWith(
    value: 'Change user',
  );

  @override
  MsgProperty get continueB => esMessages.mx.continueB.copyWith(
    value: 'Continue',
  );

  @override
  MsgProperty get dontHaveAccount => esMessages.mx.dontHaveAccount.copyWith(
    value: "Don't have an account?",
  );

  @override
  MsgProperty get email => esMessages.mx.email.copyWith(
    value: 'Email',
  );

  @override
  MsgProperty get forgotPassword => esMessages.mx.forgotPassword.copyWith(
    value: 'Forgot your password?',
  );

  @override
  MsgProperty get loginBiometrics => esMessages.mx.loginBiometrics.copyWith(
    value: 'Login with biometrics',
  );

  @override
  MsgProperty get password => esMessages.mx.password.copyWith(
    value: 'Password',
  );

  @override
  MsgProperty get registerNow => esMessages.mx.registerNow.copyWith(
    value: 'Register now',
  );

  @override
  MsgProperty get cancel => esMessages.mx.cancel.copyWith(
    value: 'Cancel',
  );

  @override
  MsgProperty get enterYourEmail => esMessages.mx.enterYourEmail.copyWith(
    value: 'Enter your email',
  );

  @override
  MsgProperty get sendLink => esMessages.mx.sendLink.copyWith(
    value: 'Send link',
  );

  @override
  MsgProperty get accept => esMessages.mx.accept.copyWith(
    value: 'Accept',
  );

  @override
  MsgProperty get addAssistant => esMessages.mx.addAssistant.copyWith(
    value: 'Add assistant',
  );

  @override
  MsgProperty get disableAssistant => esMessages.mx.disableAssistant.copyWith(
    value: 'The assistant will be disabled',
  );

  @override
  MsgProperty get disableUser => esMessages.mx.disableUser.copyWith(
    value: 'Are you sure you want to disable the user?',
  );

  @override
  MsgProperty get enableAssistant => esMessages.mx.enableAssistant.copyWith(
    value: 'The assistant will be enabled',
  );

  @override
  MsgProperty get enableUser => esMessages.mx.enableUser.copyWith(
    value: 'Are you sure you want to enable the user?',
  );

  @override
  MsgProperty get loadingData => esMessages.mx.loadingData.copyWith(
    value: 'Loading data',
  );

  @override
  MsgProperty get loadingInformation =>
      esMessages.mx.loadingInformation.copyWith(
        value: 'Loading information...',
      );

  @override
  MsgProperty get myAccess => esMessages.mx.myAccess.copyWith(
    value: 'My accesses',
  );

  @override
  MsgProperty get noAssistantsToShow =>
      esMessages.mx.noAssistantsToShow.copyWith(
        value: 'No assistants to show',
      );

  @override
  MsgProperty get noInformationToShow =>
      esMessages.mx.noInformationToShow.copyWith(
        value: 'No information to show',
      );

  @override
  MsgProperty get pleaseTryAgainLater =>
      esMessages.mx.pleaseTryAgainLater.copyWith(
        value: 'Please try again later.',
      );

  @override
  MsgProperty get selectProfile => esMessages.mx.selectProfile.copyWith(
    value: "Select the doctor's profile you want to access.",
  );

  @override
  MsgProperty get welcomeHome => esMessages.mx.welcomeHome.copyWith(
    value: 'Welcome',
  );

  @override
  MsgProperty get birthdate => esMessages.mx.birthdate.copyWith(
    value: 'Birthdate',
  );

  @override
  MsgProperty get generalData => esMessages.mx.generalData.copyWith(
    value: 'General Data',
  );

  @override
  MsgProperty get name => esMessages.mx.name.copyWith(
    value: 'Name(s)',
  );

  @override
  MsgProperty get lastName => esMessages.mx.lastName.copyWith(
    value: 'Last Name',
  );

  @override
  MsgProperty get secondLastName => esMessages.mx.secondLastName.copyWith(
    value: 'Second LastName',
  );

  @override
  MsgProperty get notLastName => esMessages.mx.secondLastName.copyWith(
    value: 'LastName',
  );

  @override
  MsgProperty get notSecondLastName => esMessages.mx.secondLastName.copyWith(
    value: 'Second LastName',
  );

  @override
  MsgProperty get newUser => esMessages.mx.newUser.copyWith(
    value: 'New User',
  );

  @override
  MsgProperty get permissions => esMessages.mx.permissions.copyWith(
    value: 'Permissions',
  );

  @override
  MsgProperty get phoneNumber => esMessages.mx.phoneNumber.copyWith(
    value: 'Phone Number',
  );

  @override
  MsgProperty get registerUser => esMessages.mx.registerUser.copyWith(
    value: 'Register User',
  );

  @override
  MsgProperty get stepOneOfTwo => esMessages.mx.stepOneOfTwo.copyWith(
    value: 'Step 1 of 2',
  );

  @override
  MsgProperty get stepTwoOfTwo => esMessages.mx.stepTwoOfTwo.copyWith(
    value: 'Step 2 of 2',
  );

  @override
  MsgProperty get typeUser => esMessages.mx.typeUser.copyWith(
    value: 'User Type',
  );

  @override
  MsgProperty get updateUser => esMessages.mx.updateUser.copyWith(
    value: 'Update User',
  );

  @override
  MsgProperty get clabe => esMessages.mx.clabe.copyWith(
    value: 'CLABE',
  );

  @override
  MsgProperty get numberAccount => esMessages.mx.numberAccount.copyWith(
    value: 'Account number',
  );

  @override
  MsgProperty get pleaseWait => esMessages.mx.pleaseWait.copyWith(
    value: 'Please wait...',
  );

  @override
  MsgProperty get selectOneOrMoreOptions =>
      esMessages.mx.selectOneOrMoreOptions.copyWith(
        value: 'Select one or more options',
      );

  @override
  MsgProperty get errorLoadingAssistants =>
      esMessages.mx.errorLoadingAssistants.copyWith(
        value: 'Error loading assistants.',
      );

  @override
  MsgProperty get errorLoadingInvites =>
      esMessages.mx.errorLoadingInvites.copyWith(
        value: 'Error Loading Invites',
      );

  @override
  MsgProperty get errorLoadingForm => esMessages.mx.noForm.copyWith(
    value: 'Error loading form',
  );

  @override
  MsgProperty get errorLoadingInfo => esMessages.mx.noForm.copyWith(
    value: 'Error loading information',
  );

  @override
  MsgProperty get noInvites => esMessages.mx.noInvites.copyWith(
    value: 'No Invites',
  );

  @override
  MsgProperty get noActiveInvites => esMessages.mx.noActiveInvites.copyWith(
    value: 'You have no active invitations',
  );

  @override
  MsgProperty get noForm => esMessages.mx.noForm.copyWith(
    value: 'No form to display',
  );

  @override
  MsgProperty get medicalReport => esMessages.mx.medicalReport.copyWith(
    value: 'Medical Report',
  );

  @override
  MsgProperty get paymentManual => esMessages.mx.paymentManual.copyWith(
    value: 'Payment Manual',
  );

  @override
  MsgProperty get glossaryTerms => esMessages.mx.glossaryTerms.copyWith(
    value: 'Glossary of Terms',
  );

  @override
  MsgProperty get levelsAndTabs => esMessages.mx.levelsAndTabs.copyWith(
    value: 'Levels and Tabs',
  );

  @override
  MsgProperty get annexes => esMessages.mx.annexes.copyWith(
    value: 'Annexes',
  );

  @override
  MsgProperty get benefits => esMessages.mx.benefits.copyWith(
    value: 'Benefits',
  );

  @override
  MsgProperty get gnpContact => esMessages.mx.gnpContact.copyWith(
    value: 'GNP Contact',
  );

  @override
  MsgProperty get webSite => esMessages.mx.webSite.copyWith(
    value: 'Web Site',
  );

  @override
  MsgProperty get gnpLine => esMessages.mx.gnpLine.copyWith(
    value: 'GNP Line',
  );

  @override
  MsgProperty get agreement => esMessages.mx.agreement.copyWith(
    value: 'Agreement',
  );

  @override
  MsgProperty get download => esMessages.mx.download.copyWith(
    value: 'Download',
  );

  @override
  MsgProperty get rfc => esMessages.mx.rfc.copyWith(
    value: 'RFC',
  );

  @override
  MsgProperty get withHomoclave => esMessages.mx.withHomoclave.copyWith(
    value: 'With Homoclave',
  );

  @override
  MsgProperty get doctorsName => esMessages.mx.doctorsName.copyWith(
    value: 'Doctors Name',
  );

  @override
  MsgProperty get specialty => esMessages.mx.specialty.copyWith(
    value: 'Specialty',
  );

  @override
  MsgProperty get state => esMessages.mx.state.copyWith(
    value: 'State',
  );

  @override
  MsgProperty get medicalCircle => esMessages.mx.medicalCircle.copyWith(
    value: 'Medical Circle',
  );

  @override
  MsgProperty get medicalTabulator => esMessages.mx.medicalTabulator.copyWith(
    value: 'Medical Tabulator',
  );

  @override
  MsgProperty get status => esMessages.mx.status.copyWith(
    value: 'Status',
  );

  @override
  MsgProperty get consultGuidelines => esMessages.mx.consultGuidelines.copyWith(
    value: 'Consult guidelines',
  );

  @override
  MsgProperty get updateInformation => esMessages.mx.updateInformation.copyWith(
    value: 'Update information',
  );

  @override
  MsgProperty get terminationAgreement =>
      esMessages.mx.terminationAgreement.copyWith(
        value: 'Termination Agreement',
      );

  @override
  MsgProperty get downloadMedicalAgreement =>
      esMessages.mx.downloadMedicalAgreement.copyWith(
        value: 'Download Medical Agreement',
      );

  @override
  MsgProperty get directory => esMessages.mx.directory.copyWith(
    value: 'Directory',
  );

  @override
  MsgProperty get medicalRegister => esMessages.mx.medicalRegister.copyWith(
    value: 'Medical Register',
  );

  @override
  MsgProperty get registrationData => esMessages.mx.registrationData.copyWith(
    value: 'Registration Data',
  );

  @override
  MsgProperty get fullName => esMessages.mx.fullName.copyWith(
    value: 'Full Name',
  );

  @override
  MsgProperty get createAccount => esMessages.mx.createAccount.copyWith(
    value: 'Create Account',
  );

  @override
  MsgProperty get formats => esMessages.mx.formats.copyWith(
    value: 'Formats',
  );

  @override
  MsgProperty get transplantOrthopedicsFormat =>
      esMessages.mx.transplantOrthopedicsFormat.copyWith(
        value: 'Transplant and Orthopedics Format',
      );

  @override
  MsgProperty get transferFormat => esMessages.mx.transferFormat.copyWith(
    value: 'Transfer format for ...',
  );

  @override
  MsgProperty get accessionLetter => esMessages.mx.accessionLetter.copyWith(
    value: 'Accession Letter',
  );

  @override
  MsgProperty get requestLog => esMessages.mx.requestLog.copyWith(
    value: 'Request Log',
  );

  @override
  MsgProperty get applicationLog => esMessages.mx.applicationLog.copyWith(
    value: 'Application Log',
  );

  @override
  MsgProperty get applicationSheet => esMessages.mx.applicationSheet.copyWith(
    value: 'Application sheet',
  );

  @override
  MsgProperty get dateRequest => esMessages.mx.dateRequest.copyWith(
    value: 'Date Request',
  );

  @override
  MsgProperty get uploadInformation => esMessages.mx.uploadInformation.copyWith(
    value: 'Upload Information',
  );

  @override
  MsgProperty get prepareFollowingDocumentation =>
      esMessages.mx.prepareFollowingDocumentation.copyWith(
        value: 'Prepare the following documentation',
      );

  @override
  MsgProperty get documentationFormat =>
      esMessages.mx.documentationFormat.copyWith(
        value: 'The documentation must be in PDF or JPG format.',
      );

  @override
  MsgProperty get documentationFormatPDFPNG =>
      esMessages.mx.documentationFormatPDFPNG.copyWith(
        value: 'The documentation must be in PDF or JPG format.',
      );

  @override
  MsgProperty get paymentByTransfer => esMessages.mx.paymentByTransfer.copyWith(
    value: 'Payment by transfer',
  );

  @override
  MsgProperty get documentationRequest =>
      esMessages.mx.documentationRequest.copyWith(
        value: 'Documentation Request',
      );

  @override
  MsgProperty get begin => esMessages.mx.begin.copyWith(
    value: 'Begin',
  );

  @override
  MsgProperty get goOut => esMessages.mx.goOut.copyWith(
    value: 'Go out',
  );

  @override
  MsgProperty get documents => esMessages.mx.documents.copyWith(
    value: 'Documents',
  );

  @override
  MsgProperty get fileMaximum => esMessages.mx.fileMaximum.copyWith(
    value: 'File maximum of ',
  );

  @override
  MsgProperty get format => esMessages.mx.format.copyWith(
    value: 'in format:',
  );

  @override
  MsgProperty get formatsForUpload => esMessages.mx.formatsForUpload.copyWith(
    value: 'JPG, PNG, PDF, XML, DOC',
  );

  @override
  MsgProperty get requestAgreement => esMessages.mx.requestAgreement.copyWith(
    value: 'Request Agreement',
  );

  @override
  MsgProperty get requiredDocumentation =>
      esMessages.mx.requiredDocumentation.copyWith(
        value: 'Required Documentation',
      );

  @override
  MsgProperty get selectDocumentUpload =>
      esMessages.mx.selectDocumentUpload.copyWith(
        value: 'Select the document to upload.',
      );

  @override
  MsgProperty get uploadFile => esMessages.mx.uploadFile.copyWith(
    value: 'Upload file',
  );

  @override
  MsgProperty get threeMB => esMessages.mx.threeMB.copyWith(
    value: '3 MB ',
  );

  @override
  MsgProperty get understood => esMessages.mx.understood.copyWith(
    value: 'Understood',
  );

  @override
  MsgProperty get consult => esMessages.mx.consult.copyWith(
    value: 'Consult',
  );

  @override
  MsgProperty get cost => esMessages.mx.cost.copyWith(
    value: 'Cost',
  );

  @override
  MsgProperty get cpts => esMessages.mx.cpts.copyWith(
    value: 'CPT´s',
  );

  @override
  MsgProperty get medicalCircleTab => esMessages.mx.medicalCircleTab.copyWith(
    value: 'Circulo / tabulador médico',
  );

  @override
  MsgProperty get procedure => esMessages.mx.procedure.copyWith(
    value: 'Procedimiento',
  );

  @override
  MsgProperty get tabulator => esMessages.mx.tabulator.copyWith(
    value: 'Tabulador',
  );

  @override
  MsgProperty get myData => esMessages.mx.myData.copyWith(
    value: 'My data',
  );

  @override
  MsgProperty get profesionalTitle => esMessages.mx.profesionalTitle.copyWith(
    value: 'Profesional Title',
  );

  @override
  MsgProperty get gender => esMessages.mx.gender.copyWith(
    value: 'Gender',
  );

  @override
  MsgProperty get medicalOffice => esMessages.mx.medicalOffice.copyWith(
    value: 'Medical office',
  );

  @override
  MsgProperty get nationality => esMessages.mx.nationality.copyWith(
    value: 'Nationality',
  );

  @override
  MsgProperty get subSpecialty => esMessages.mx.subSpecialty.copyWith(
    value: 'Subspecialty',
  );

  @override
  MsgProperty get enterTenDigits => esMessages.mx.enterTenDigits.copyWith(
    value: 'Enter the 10 digits of your number',
  );

  @override
  MsgProperty get enterYourDate => esMessages.mx.enterYourDate.copyWith(
    value: 'Select a valid date',
  );

  @override
  MsgProperty get enterYourNameContinue =>
      esMessages.mx.enterYourNameContinue.copyWith(
        value: 'Enter your name to continue.',
      );

  @override
  MsgProperty get enterYourLastNameContinue =>
      esMessages.mx.enterYourLastNameContinue.copyWith(
        value: 'Enter your lastname to continue',
      );

  @override
  MsgProperty get enterYourSecondLastNameContinue =>
      esMessages.mx.enterYourSecondLastNameContinue.copyWith(
        value: 'Enter your second lastname to continue',
      );

  @override
  MsgProperty get enterYourOption => esMessages.mx.enterYourOption.copyWith(
    value: 'Select a valid option',
  );

  @override
  MsgProperty get enterYourPassword => esMessages.mx.enterYourPassword.copyWith(
    value: 'Enter your password',
  );

  @override
  MsgProperty get enterYourPhoneNumber =>
      esMessages.mx.enterYourPhoneNumber.copyWith(
        value: 'The phone number is required',
      );

  @override
  MsgProperty get enterYourRfc => esMessages.mx.enterYourRfc.copyWith(
    value: 'The RFC is mandatory.',
  );

  @override
  MsgProperty get enterYourRfcName => esMessages.mx.enterYourRfcName.copyWith(
    value: 'The RFC does not match the name and lastnames.',
  );

  @override
  MsgProperty get rfcFormatInvalid => esMessages.mx.rfcFormatInvalid.copyWith(
    value: 'The RFC format is not valid.',
  );

  @override
  MsgProperty get rfcGenericNoAllowed =>
      esMessages.mx.rfcGenericNoAllowed.copyWith(
        value: 'The generic RFC is not allowed.',
      );

  @override
  MsgProperty get rfcDigitsTwelveThirteen =>
      esMessages.mx.rfcDigitsTwelveThirteen.copyWith(
        value: 'The RFC must have 12 or 13 characters.',
      );

  @override
  MsgProperty
  get reTabulationsLegend => esMessages.mx.reTabulationsLegend.copyWith(
    value:
        '''For fee schedule inquiries, questions about your payments, or clarifications on letters, please contact the CAM:''',
  );

  @override
  MsgProperty get bankingInfoLegend => esMessages.mx.bankingInfoLegend.copyWith(
    value:
        '''Banking information, tax information, account statement updates:''',
  );

  @override
  MsgProperty get personalizedAssistanceLegend =>
      esMessages.mx.personalizedAssistanceLegend.copyWith(
        value:
            '''Personalized assistance, and a dedicated executive for trusted physicians:''',
      );

  @override
  MsgProperty get onlyAlphabeticCharacters =>
      esMessages.mx.onlyAlphabeticCharacters.copyWith(
        value: '''Only is permited alphabetic characters''',
      );

  @override
  MsgProperty get toRegisterYouAccept =>
      esMessages.mx.toRegisterYouAccept.copyWith(
        value: '''By registering you agree to our ''',
      );
  @override
  MsgProperty get termsAndConditions =>
      esMessages.mx.termsAndConditions.copyWith(
        value: '''Terms and conditions of use of Electronic Media''',
      );

  @override
  MsgProperty get fromGroupNational => esMessages.mx.fromGroupNational.copyWith(
    value: '''of Grupo Nacional Provincial S.A.B''',
  );

  @override
  MsgProperty get signUp => esMessages.mx.fromGroupNational.copyWith(
    value: '''signUp''',
  );

  @override
  MsgProperty get homeTerms => esMessages.mx.homeTerms.copyWith(
    value:
        'Partial or total reproduction of the information contained on '
        'this site in digital form is prohibited.',
  );

  @override
  MsgProperty get noResultsFound => esMessages.mx.homeTerms.copyWith(
    value: 'No results found',
  );

  @override
  MsgProperty get selectBtnToContinue => esMessages.mx.homeTerms.copyWith(
    value: 'Select the "New Search" button to try again.',
  );
}
