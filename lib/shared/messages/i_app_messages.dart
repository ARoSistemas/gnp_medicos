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
  abstract final MsgProperty errorLoadingAssistants;
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
  abstract final MsgProperty name;
  abstract final MsgProperty firstName;
  abstract final MsgProperty lastName;
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
  abstract final MsgProperty noInvites;
  abstract final MsgProperty noActiveInvites;
  abstract final MsgProperty noForm;
  abstract final MsgProperty errorLoadingForm;
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
  abstract final MsgProperty rfc;
  abstract final MsgProperty withHomoclave;
  abstract final MsgProperty doctorsName;
  abstract final MsgProperty specialty;
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
  abstract final MsgProperty fullName;
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
    ...errorLoadingAssistants.msgMap,
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
    ...firstName.msgMap,
    ...lastName.msgMap,
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
    ...errorLoadingInvites.msgMap,
    ...noInvites.msgMap,
    ...noActiveInvites.msgMap,
    ...noForm.msgMap,
    ...errorLoadingForm.msgMap,
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
  };
}
