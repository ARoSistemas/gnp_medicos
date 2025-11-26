import 'package:medicos/core/messages/i_messages.dart';
import 'package:medicos/shared/messages/es/es_messages.dart';

final IAppMessages msg = esMessages.mx;

abstract class IAppMessages extends IMessages {
  const IAppMessages();

  abstract final MsgProperty welcome;
  abstract final MsgProperty light;
  abstract final MsgProperty dark;
  abstract final MsgProperty system;
  abstract final MsgProperty settings;
  abstract final MsgProperty signOut;
  abstract final MsgProperty deleteAccount;
  abstract final MsgProperty identify;
  abstract final MsgProperty welcomeApp;
  abstract final MsgProperty activateFingerprintFace;
  abstract final MsgProperty quickLogin;
  abstract final MsgProperty myProfile;
  abstract final MsgProperty doctorsInformation;
  abstract final MsgProperty personalData;
  abstract final MsgProperty academicData;
  abstract final MsgProperty taxDataAccounts;
  abstract final MsgProperty assistants;
  abstract final MsgProperty changeUser;
  abstract final MsgProperty password;
  abstract final MsgProperty email;
  abstract final MsgProperty forgotPassword;
  abstract final MsgProperty continueB;
  abstract final MsgProperty cancel;
  abstract final MsgProperty loginBiometrics;
  abstract final MsgProperty dontHaveAccount;
  abstract final MsgProperty registerNow;
  abstract final MsgProperty enterYourEmail;
  abstract final MsgProperty sendLink;
  abstract final MsgProperty welcomeHome;
  abstract final MsgProperty selectProfile;
  abstract final MsgProperty myAccess;
  abstract final MsgProperty noAssistantsToShow;
  abstract final MsgProperty noInformationToShow;
  abstract final MsgProperty loadingInformation;
  abstract final MsgProperty addAssistant;

  abstract final MsgProperty pleaseTryAgainLater;
  abstract final MsgProperty loadingData;
  abstract final MsgProperty accept;
  abstract final MsgProperty disableUser;
  abstract final MsgProperty enableUser;
  abstract final MsgProperty disableAssistant;
  abstract final MsgProperty enableAssistant;
  abstract final MsgProperty generalData;
  abstract final MsgProperty permissions;
  abstract final MsgProperty updateUser;
  abstract final MsgProperty newUser;
  abstract final MsgProperty typeUser;
  abstract final MsgProperty phoneNumber;
  abstract final MsgProperty birthdate;
  abstract final MsgProperty registerUser;
  abstract final MsgProperty stepOneOfTwo;
  abstract final MsgProperty stepTwoOfTwo;
  abstract final MsgProperty selectOneOrMoreOptions;
  abstract final MsgProperty clabe;
  abstract final MsgProperty numberAccount;
  abstract final MsgProperty pleaseWait;
  abstract final MsgProperty errorLoadingInvites;
  abstract final MsgProperty errorLoadingContact;
  abstract final MsgProperty noInvites;
  abstract final MsgProperty noActiveInvites;
  abstract final MsgProperty noForm;

  abstract final MsgProperty medicalReport;
  abstract final MsgProperty paymentManual;
  abstract final MsgProperty glossaryTerms;
  abstract final MsgProperty levelsAndTabs;
  abstract final MsgProperty annexes;
  abstract final MsgProperty benefits;
  abstract final MsgProperty gnpContact;
  abstract final MsgProperty webSite;
  abstract final MsgProperty gnpLine;
  abstract final MsgProperty agreement;
  abstract final MsgProperty download;
  abstract final MsgProperty view;
  abstract final MsgProperty rfc;
  abstract final MsgProperty withHomoclave;
  abstract final MsgProperty doctorsName;
  abstract final MsgProperty specialty;
  abstract final MsgProperty subSpecialty;
  abstract final MsgProperty state;
  abstract final MsgProperty medicalCircle;
  abstract final MsgProperty medicalTabulator;
  abstract final MsgProperty status;
  abstract final MsgProperty consultGuidelines;
  abstract final MsgProperty updateInformation;
  abstract final MsgProperty terminationAgreement;
  abstract final MsgProperty downloadMedicalAgreement;
  abstract final MsgProperty directory;
  abstract final MsgProperty medicalRegister;
  abstract final MsgProperty registrationData;

  /// Personal Data
  abstract final MsgProperty name;
  abstract final MsgProperty fullName;
  abstract final MsgProperty lastName;
  abstract final MsgProperty secondLastName;
  abstract final MsgProperty enterYourNameContinue;
  abstract final MsgProperty enterYourLastNameContinue;
  abstract final MsgProperty enterYourSecondLastNameContinue;

  /// TMP
  abstract final MsgProperty notLastName;
  abstract final MsgProperty notSecondLastName;

  abstract final MsgProperty createAccount;
  abstract final MsgProperty formats;
  abstract final MsgProperty transplantOrthopedicsFormat;
  abstract final MsgProperty transferFormat;
  abstract final MsgProperty accessionLetter;
  abstract final MsgProperty requestLog;
  abstract final MsgProperty applicationLog;
  abstract final MsgProperty applicationSheet;
  abstract final MsgProperty dateRequest;
  abstract final MsgProperty uploadInformation;
  abstract final MsgProperty prepareFollowingDocumentation;
  abstract final MsgProperty documentationFormat;
  abstract final MsgProperty documentationFormatPDFPNG;
  abstract final MsgProperty paymentByTransfer;
  abstract final MsgProperty documentationRequest;
  abstract final MsgProperty goOut;
  abstract final MsgProperty begin;
  abstract final MsgProperty selectDocumentUpload;
  abstract final MsgProperty documents;
  abstract final MsgProperty uploadFile;
  abstract final MsgProperty fileMaximum;
  abstract final MsgProperty threeMB;
  abstract final MsgProperty format;
  abstract final MsgProperty formatsForUpload;
  abstract final MsgProperty requestAgreement;
  abstract final MsgProperty requiredDocumentation;
  abstract final MsgProperty understood;
  abstract final MsgProperty tabulator;
  abstract final MsgProperty medicalCircleTab;
  abstract final MsgProperty procedure;
  abstract final MsgProperty cpts;
  abstract final MsgProperty cost;
  abstract final MsgProperty consult;
  abstract final MsgProperty myData;
  abstract final MsgProperty profesionalTitle;
  abstract final MsgProperty gender;
  abstract final MsgProperty medicalOffice;
  abstract final MsgProperty nationality;
  abstract final MsgProperty enterYourPassword;
  abstract final MsgProperty enterYourPhoneNumber;
  abstract final MsgProperty enterTenDigits;
  abstract final MsgProperty enterYourOption;
  abstract final MsgProperty enterYourDate;
  abstract final MsgProperty enterYourRfc;
  abstract final MsgProperty rfcFormatInvalid;
  abstract final MsgProperty rfcGenericNoAllowed;
  abstract final MsgProperty enterYourRfcName;
  abstract final MsgProperty rfcDigitsTwelveThirteen;
  abstract final MsgProperty reTabulationsLegend;
  abstract final MsgProperty bankingInfoLegend;
  abstract final MsgProperty personalizedAssistanceLegend;
  abstract final MsgProperty onlyAlphabeticCharacters;
  abstract final MsgProperty toRegisterYouAccept;
  abstract final MsgProperty termsAndConditions;
  abstract final MsgProperty fromGroupNational;
  abstract final MsgProperty signUp;
  abstract final MsgProperty homeTerms;
  abstract final MsgProperty apologize;
  abstract final MsgProperty noInvitation;
  abstract final MsgProperty back;

  /// Msg error
  abstract final MsgProperty errorLoadingAssistants;
  abstract final MsgProperty errorLoadingForm;
  abstract final MsgProperty errorLoadingInfo;

  abstract final MsgProperty noResultsFound;
  abstract final MsgProperty selectBtnToContinue;

  /// Modulo: Anexos
  abstract final MsgProperty noAnnexesAvailable;
  abstract final MsgProperty errorOccurred;
  abstract final MsgProperty couldNotRetrieveAnnexes;

  /// Modulo: Directorio
  abstract final MsgProperty medico;
  abstract final MsgProperty hospital;
  abstract final MsgProperty clinica;
  abstract final MsgProperty otrosServicios;
  abstract final MsgProperty enconvenio;
  abstract final MsgProperty errorGetting;
  abstract final MsgProperty lookingforHospital;
  abstract final MsgProperty optionalName;
  abstract final MsgProperty circle;
  abstract final MsgProperty circleOrTab;
  abstract final MsgProperty estado;
  abstract final MsgProperty healthPlan;
  abstract final MsgProperty clinicType;
  abstract final MsgProperty servicesType;
  abstract final MsgProperty municipality;
  abstract final MsgProperty selectMunicipalityAfterState;
  abstract final MsgProperty lookingforClinicaName;
  abstract final MsgProperty lookingforOtrosServiciosName;

  // Msg error nueva solicitud
  abstract final MsgProperty pleaseSelectASpecialty;
  abstract final MsgProperty pleaseSelectASubspecialty;
  abstract final MsgProperty pleaseSelectAState;
  abstract final MsgProperty careHospitals;
  abstract final MsgProperty pleaseSelectAtLeastOneHospital;
  abstract final MsgProperty pleaseEnterYourOfficeAddress;

  // Nueva solicitud
  abstract final MsgProperty newRequest;
  abstract final MsgProperty medicalOfficeAddress;
  abstract final MsgProperty sendRequest;

  @override
  Map<String, String> toJson() => {
    ...welcome.msgMap,
    ...light.msgMap,
    ...dark.msgMap,
    ...system.msgMap,
    ...settings.msgMap,
    ...signOut.msgMap,
    ...deleteAccount.msgMap,
    ...identify.msgMap,
    ...welcomeApp.msgMap,
    ...activateFingerprintFace.msgMap,
    ...quickLogin.msgMap,
    ...myProfile.msgMap,
    ...doctorsInformation.msgMap,
    ...personalData.msgMap,
    ...academicData.msgMap,
    ...taxDataAccounts.msgMap,
    ...assistants.msgMap,
    ...changeUser.msgMap,
    ...password.msgMap,
    ...email.msgMap,
    ...forgotPassword.msgMap,
    ...continueB.msgMap,
    ...cancel.msgMap,
    ...loginBiometrics.msgMap,
    ...dontHaveAccount.msgMap,
    ...registerNow.msgMap,
    ...enterYourEmail.msgMap,
    ...sendLink.msgMap,
    ...welcomeHome.msgMap,
    ...selectProfile.msgMap,
    ...myAccess.msgMap,
    ...noAssistantsToShow.msgMap,
    ...noInformationToShow.msgMap,
    ...loadingInformation.msgMap,
    ...addAssistant.msgMap,
    ...pleaseTryAgainLater.msgMap,
    ...loadingData.msgMap,
    ...accept.msgMap,
    ...disableUser.msgMap,
    ...enableUser.msgMap,
    ...disableAssistant.msgMap,
    ...enableAssistant.msgMap,
    ...updateUser.msgMap,
    ...newUser.msgMap,
    ...generalData.msgMap,
    ...permissions.msgMap,
    ...name.msgMap,
    ...lastName.msgMap,
    ...secondLastName.msgMap,
    ...typeUser.msgMap,
    ...phoneNumber.msgMap,
    ...birthdate.msgMap,
    ...registerUser.msgMap,
    ...stepOneOfTwo.msgMap,
    ...stepTwoOfTwo.msgMap,
    ...selectOneOrMoreOptions.msgMap,
    ...clabe.msgMap,
    ...numberAccount.msgMap,
    ...pleaseWait.msgMap,
    ...errorLoadingAssistants.msgMap,
    ...errorLoadingInvites.msgMap,
    ...errorLoadingContact.msgMap,
    ...noInvites.msgMap,
    ...noActiveInvites.msgMap,
    ...noForm.msgMap,
    ...medicalReport.msgMap,
    ...paymentManual.msgMap,
    ...glossaryTerms.msgMap,
    ...levelsAndTabs.msgMap,
    ...annexes.msgMap,
    ...benefits.msgMap,
    ...gnpContact.msgMap,
    ...webSite.msgMap,
    ...gnpLine.msgMap,
    ...agreement.msgMap,
    ...download.msgMap,
    ...rfc.msgMap,
    ...withHomoclave.msgMap,
    ...doctorsName.msgMap,
    ...specialty.msgMap,
    ...state.msgMap,
    ...medicalCircle.msgMap,
    ...medicalTabulator.msgMap,
    ...status.msgMap,
    ...consultGuidelines.msgMap,
    ...updateInformation.msgMap,
    ...terminationAgreement.msgMap,
    ...downloadMedicalAgreement.msgMap,
    ...directory.msgMap,
    ...medicalRegister.msgMap,
    ...registrationData.msgMap,
    ...fullName.msgMap,
    ...createAccount.msgMap,
    ...formats.msgMap,
    ...transplantOrthopedicsFormat.msgMap,
    ...transferFormat.msgMap,
    ...accessionLetter.msgMap,
    ...requestLog.msgMap,
    ...applicationLog.msgMap,
    ...applicationSheet.msgMap,
    ...dateRequest.msgMap,
    ...uploadInformation.msgMap,
    ...prepareFollowingDocumentation.msgMap,
    ...documentationFormat.msgMap,
    ...documentationFormatPDFPNG.msgMap,
    ...paymentByTransfer.msgMap,
    ...documentationRequest.msgMap,
    ...goOut.msgMap,
    ...begin.msgMap,
    ...selectDocumentUpload.msgMap,
    ...documents.msgMap,
    ...uploadFile.msgMap,
    ...fileMaximum.msgMap,
    ...threeMB.msgMap,
    ...format.msgMap,
    ...formatsForUpload.msgMap,
    ...requestAgreement.msgMap,
    ...requiredDocumentation.msgMap,
    ...understood.msgMap,
    ...tabulator.msgMap,
    ...medicalCircleTab.msgMap,
    ...procedure.msgMap,
    ...cpts.msgMap,
    ...cost.msgMap,
    ...consult.msgMap,
    ...myData.msgMap,
    ...profesionalTitle.msgMap,
    ...gender.msgMap,
    ...medicalOffice.msgMap,
    ...nationality.msgMap,
    ...subSpecialty.msgMap,
    ...enterYourNameContinue.msgMap,
    ...enterYourLastNameContinue.msgMap,
    ...enterYourSecondLastNameContinue.msgMap,
    ...enterYourPassword.msgMap,
    ...enterYourPhoneNumber.msgMap,
    ...enterTenDigits.msgMap,
    ...enterYourOption.msgMap,
    ...enterYourDate.msgMap,
    ...enterYourRfc.msgMap,
    ...rfcFormatInvalid.msgMap,
    ...rfcGenericNoAllowed.msgMap,
    ...enterYourRfcName.msgMap,
    ...rfcDigitsTwelveThirteen.msgMap,
    ...reTabulationsLegend.msgMap,
    ...bankingInfoLegend.msgMap,
    ...onlyAlphabeticCharacters.msgMap,
    ...toRegisterYouAccept.msgMap,
    ...termsAndConditions.msgMap,
    ...fromGroupNational.msgMap,
    ...signUp.msgMap,
    ...personalizedAssistanceLegend.msgMap,
    ...notLastName.msgMap,
    ...notSecondLastName.msgMap,
    ...homeTerms.msgMap,
    ...view.msgMap,
    ...apologize.msgMap,
    ...noInvitation.msgMap,
    ...back.msgMap,
    ...medico.msgMap,
    ...enconvenio.msgMap,
    ...hospital.msgMap,
    ...clinica.msgMap,
    ...otrosServicios.msgMap,
    ...errorGetting.msgMap,
    ...noAnnexesAvailable.msgMap,
    ...lookingforHospital.msgMap,
    ...optionalName.msgMap,
    ...circle.msgMap,
    ...errorOccurred.msgMap,
    ...couldNotRetrieveAnnexes.msgMap,
    ...circleOrTab.msgMap,
    ...estado.msgMap,
    ...healthPlan.msgMap,
    ...clinicType.msgMap,
    ...servicesType.msgMap,
    ...municipality.msgMap,
    ...selectMunicipalityAfterState.msgMap,
    ...lookingforClinicaName.msgMap,
    ...lookingforOtrosServiciosName.msgMap,
    ...newRequest.msgMap,
    ...pleaseSelectASpecialty.msgMap,
    ...pleaseSelectASubspecialty.msgMap,
    ...pleaseSelectAState.msgMap,
    ...careHospitals.msgMap,
    ...pleaseSelectAtLeastOneHospital.msgMap,
    ...medicalOfficeAddress.msgMap,
    ...pleaseEnterYourOfficeAddress.msgMap,
    ...sendRequest.msgMap,
  };
}
