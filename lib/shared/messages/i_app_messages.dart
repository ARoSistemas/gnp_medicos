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
  abstract final MsgProperty identify;
  abstract final MsgProperty welcomeApp;
  abstract final MsgProperty activateFingerprintFace;
  abstract final MsgProperty quickLogin;
  abstract final MsgProperty myProfile;
  abstract final MsgProperty doctorsInformation;
  abstract final MsgProperty personalData;
  abstract final MsgProperty academicData;
  abstract final MsgProperty taxDataAccounts;
  abstract final MsgProperty taxData;
  abstract final MsgProperty assistants;
  abstract final MsgProperty myUsers;
  abstract final MsgProperty changeUser;
  abstract final MsgProperty password;
  abstract final MsgProperty email;
  abstract final MsgProperty forgotPassword;
  abstract final MsgProperty changePassword;
  abstract final MsgProperty continueB;
  abstract final MsgProperty login;
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
  abstract final MsgProperty acceptAndContinue;
  abstract final MsgProperty disableUser;
  abstract final MsgProperty enableUser;
  abstract final MsgProperty disableAssistant;
  abstract final MsgProperty enableAssistant;
  abstract final MsgProperty generalData;
  abstract final MsgProperty permissions;
  abstract final MsgProperty updateUser;
  abstract final MsgProperty user;
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
  abstract final MsgProperty requestMedicalAgreement;
  abstract final MsgProperty paymentManual;
  abstract final MsgProperty paymentNumber;
  abstract final MsgProperty glossaryTerms;
  abstract final MsgProperty levelsAndTabs;
  abstract final MsgProperty annexes;
  abstract final MsgProperty benefits;
  abstract final MsgProperty gnpContact;
  abstract final MsgProperty webSite;
  abstract final MsgProperty gnpLine;
  abstract final MsgProperty contact;
  abstract final MsgProperty contactGnp;
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
  abstract final MsgProperty tabulators;
  abstract final MsgProperty consultGuidelines;
  abstract final MsgProperty updateInformation;
  abstract final MsgProperty terminationAgreement;
  abstract final MsgProperty downloadMedicalAgreement;
  abstract final MsgProperty downloadFormats;
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
  abstract final MsgProperty createRegister;
  abstract final MsgProperty rememberUser;
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
  abstract final MsgProperty requestDocumentation;
  abstract final MsgProperty goOut;
  abstract final MsgProperty begin;
  abstract final MsgProperty selectDocumentUpload;
  abstract final MsgProperty documents;
  abstract final MsgProperty documentsUploaded;
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
  abstract final MsgProperty enterMinDigits;
  abstract final MsgProperty enterYourOption;
  abstract final MsgProperty enterYourDate;
  abstract final MsgProperty enterYourRfc;
  abstract final MsgProperty rfcFormatInvalid;
  abstract final MsgProperty rfcGenericNoAllowed;
  abstract final MsgProperty enterYourRfcName;
  abstract final MsgProperty rfcDigitsTwelveThirteen;
  abstract final MsgProperty reTabulationsTitle;
  abstract final MsgProperty reTabulationsSubtitle;
  abstract final MsgProperty bankingInfoTitle;
  abstract final MsgProperty bankingInfoSubtitle;
  abstract final MsgProperty personalizedAssistanceTitle;
  abstract final MsgProperty personalizedAssistanceSubtitle;
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

  /// Modulo: Anexxes
  abstract final MsgProperty noDataAvailable;
  abstract final MsgProperty errorOccurred;
  abstract final MsgProperty couldNotRetrieveAnnexes;
  abstract final MsgProperty errorGettingAnnexes;
  abstract final MsgProperty couldNotRetrieveBenefits;
  abstract final MsgProperty couldNotRetrieveFormats;
  abstract final MsgProperty errorDownloadingAnnex;
  abstract final MsgProperty couldNotDownloadAnnex;

  /// Modulo: Directory
  abstract final MsgProperty doctor;
  abstract final MsgProperty hospital;
  abstract final MsgProperty clinica;
  abstract final MsgProperty otherServices;
  abstract final MsgProperty inAgreement;
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
  abstract final MsgProperty toCheckLevelHospital;
  abstract final MsgProperty lookingforClinicaName;
  abstract final MsgProperty lookingforOtherServicesName;
  abstract final MsgProperty home;
  abstract final MsgProperty all;
  abstract final MsgProperty errorLoadingStates;
  abstract final MsgProperty search;
  abstract final MsgProperty errorGettingMunicipalities;
  abstract final MsgProperty searchForSpecialty;
  abstract final MsgProperty searchResults;
  abstract final MsgProperty resultsFoundPage;
  abstract final MsgProperty selected;
  abstract final MsgProperty noResultsWithFilters;
  abstract final MsgProperty calculatingPleaseWait;
  abstract final MsgProperty goodDay;
  abstract final MsgProperty welcomeMessageBody;
  abstract final MsgProperty welcomeMessageFooter;
  abstract final MsgProperty deleteSearchFilters;

  /// Msg error nueva solicitud
  abstract final MsgProperty pleaseSelectASpecialty;
  abstract final MsgProperty pleaseSelectASubspecialty;
  abstract final MsgProperty pleaseSelectAState;
  abstract final MsgProperty careHospitals;
  abstract final MsgProperty pleaseSelectAtLeastOneHospital;
  abstract final MsgProperty pleaseEnterYourOfficeAddress;

  /// New Request
  abstract final MsgProperty newRequest;
  abstract final MsgProperty medicalOfficeAddress;
  abstract final MsgProperty sendRequest;
  abstract final MsgProperty actions;

  /// My Procedures
  abstract final MsgProperty myProcedures;
  abstract final MsgProperty notProcedures;
  abstract final MsgProperty errorToGetProcedures;
  abstract final MsgProperty folio;
  abstract final MsgProperty insuredName;
  abstract final MsgProperty dateOfLoss;
  abstract final MsgProperty condition;
  abstract final MsgProperty attendingHospital;
  abstract final MsgProperty policy;
  abstract final MsgProperty noProceduresFoundForDate;
  abstract final List<String> monthAbbreviations;

  /// Profile
  abstract final MsgProperty errorToGetProfile;
  abstract final MsgProperty profile;
  abstract final MsgProperty errorGettingDoctors;
  abstract final MsgProperty errorGettingHospitals;
  abstract final MsgProperty errorGettingClinics;
  abstract final MsgProperty errorGettingOtherServices;
  abstract final MsgProperty resetPassword;
  abstract final MsgProperty signOut;
  abstract final MsgProperty deleteAccount;
  abstract final MsgProperty tResetPassword;
  abstract final MsgProperty dResetPassword;
  abstract final MsgProperty tSignOut;
  abstract final MsgProperty dSignOut;
  abstract final MsgProperty tDeleteAccount;
  abstract final MsgProperty dDeleteAccount;
  abstract final MsgProperty tDeletedAccount;
  abstract final MsgProperty dDeletedAccount;

  /// My Payments
  abstract final MsgProperty myPayments;
  abstract final MsgProperty paymentDate;
  abstract final MsgProperty amountPaid;
  abstract final MsgProperty paymentAccount;
  abstract final MsgProperty associatedIncident;
  abstract final MsgProperty paymentStatus;
  abstract final MsgProperty amountClaimed;
  abstract final MsgProperty bankingInstitution;
  abstract final MsgProperty notPayments;
  abstract final MsgProperty errorToGetPayments;

  /// Module: ItemMap
  abstract final MsgProperty noDataReceived;
  abstract final MsgProperty locationServicesDisabledTitle;
  abstract final MsgProperty locationServicesDisabledMessage;
  abstract final MsgProperty permissionsDeniedTitle;
  abstract final MsgProperty permissionsDeniedMessage;
  abstract final MsgProperty permissionsPermanentlyDeniedTitle;
  abstract final MsgProperty permissionsPermanentlyDeniedMessage;
  abstract final MsgProperty errorMakingPhoneCall;
  abstract final MsgProperty routeNotAvailableTitle;
  abstract final MsgProperty routeNotAvailableMsg;
  abstract final MsgProperty youAreHere;
  abstract final MsgProperty errorLoadingProfileTitle;

  abstract final MsgProperty evaluations;
  abstract final MsgProperty error;
  abstract final MsgProperty success;
  abstract final MsgProperty failed;
  abstract final MsgProperty endOfList;
  abstract final MsgProperty emptyFilters;
  abstract final MsgProperty invalidUserOrPassword;
  abstract final MsgProperty passwordRecoveryLinkSent;
  abstract final MsgProperty biometricsNotAvailable;
  abstract final MsgProperty biometricAuthenticationFailed;
  abstract final MsgProperty errorAuthenticating;
  abstract final MsgProperty errorGettingFormat;
  abstract final MsgProperty errorDetail;
  abstract final MsgProperty errorLoadingProfile;
  abstract final MsgProperty errorGettingDocument;
  abstract final MsgProperty agreementNotInEffect;
  abstract final MsgProperty agreementUpdated;
  abstract final MsgProperty requestRegistered;
  abstract final MsgProperty requestNotRegistered;
  abstract final MsgProperty noMoreProceduresToLoad;
  abstract final MsgProperty selectFilterAndEnterData;
  abstract final MsgProperty successfulRegistration;
  abstract final MsgProperty userRegisteredSuccessfully;
  abstract final MsgProperty successfulUpdate;
  abstract final MsgProperty assistantNotUpdated;
  abstract final MsgProperty errorUpdatingAssistantPermissions;
  abstract final MsgProperty noDocumentsUploadedYet;
  abstract final MsgProperty dataNotLoaded;
  abstract final MsgProperty errorLoadingData;
  abstract final MsgProperty temailAlreadyRegistered;
  abstract final MsgProperty demailAlreadyRegistered;

  /// Change Password
  abstract final MsgProperty dAtLeast8Chars;
  abstract final MsgProperty dAtLeastOneUppercase;
  abstract final MsgProperty dAtLeastOneLowercase;
  abstract final MsgProperty dAtLeast4AlphaChars;
  abstract final MsgProperty dAtLeastOneNumeric;
  abstract final MsgProperty dAtLeastOneSpecialChar;
  abstract final MsgProperty dNoGnpWord;
  abstract final MsgProperty dNoConsecutiveEqualChars;
  abstract final MsgProperty dNoConsecutiveChars;
  abstract final MsgProperty dNoWhiteSpaces;
  abstract final MsgProperty dPasswordsDoNotMatch;
  abstract final MsgProperty successfulChange;
  abstract final MsgProperty dPasswordUpdated;

  /// New Messages for Registration
  abstract final MsgProperty professionalLicense;
  abstract final MsgProperty speciality;
  abstract final MsgProperty subspeciality;
  abstract final MsgProperty fieldRequired;


  abstract final MsgProperty pageNotFound;

  @override
  Map<String, String> toJson() => {
    ...welcome.msgMap,
    ...light.msgMap,
    ...dark.msgMap,
    ...system.msgMap,
    ...settings.msgMap,
    ...resetPassword.msgMap,
    ...signOut.msgMap,
    ...deleteAccount.msgMap,
    ...tResetPassword.msgMap,
    ...dResetPassword.msgMap,
    ...tSignOut.msgMap,
    ...dSignOut.msgMap,
    ...tDeleteAccount.msgMap,
    ...dDeleteAccount.msgMap,
    ...tDeletedAccount.msgMap,
    ...dDeletedAccount.msgMap,
    ...identify.msgMap,
    ...welcomeApp.msgMap,
    ...activateFingerprintFace.msgMap,
    ...quickLogin.msgMap,
    ...myProfile.msgMap,
    ...doctorsInformation.msgMap,
    ...personalData.msgMap,
    ...academicData.msgMap,
    ...taxDataAccounts.msgMap,
    ...taxData.msgMap,
    ...assistants.msgMap,
    ...changeUser.msgMap,
    ...user.msgMap,
    ...password.msgMap,
    ...email.msgMap,
    ...forgotPassword.msgMap,
    ...changePassword.msgMap,
    ...continueB.msgMap,
    ...login.msgMap,
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
    ...acceptAndContinue.msgMap,
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
    ...errorLoadingInfo.msgMap,
    ...noInvites.msgMap,
    ...noActiveInvites.msgMap,
    ...noForm.msgMap,
    ...medicalReport.msgMap,
    ...requestMedicalAgreement.msgMap,
    ...paymentManual.msgMap,
    ...paymentNumber.msgMap,
    ...glossaryTerms.msgMap,
    ...levelsAndTabs.msgMap,
    ...annexes.msgMap,
    ...benefits.msgMap,
    ...gnpContact.msgMap,
    ...webSite.msgMap,
    ...contactGnp.msgMap,
    ...gnpLine.msgMap,
    ...agreement.msgMap,
    ...download.msgMap,
    ...downloadFormats.msgMap,
    ...rfc.msgMap,
    ...withHomoclave.msgMap,
    ...doctorsName.msgMap,
    ...specialty.msgMap,
    ...state.msgMap,
    ...medicalCircle.msgMap,
    ...medicalTabulator.msgMap,
    ...status.msgMap,
    ...tabulators.msgMap,
    ...consultGuidelines.msgMap,
    ...updateInformation.msgMap,
    ...terminationAgreement.msgMap,
    ...downloadMedicalAgreement.msgMap,
    ...directory.msgMap,
    ...medicalRegister.msgMap,
    ...registrationData.msgMap,
    ...fullName.msgMap,
    ...createAccount.msgMap,
    ...createRegister.msgMap,
    ...rememberUser.msgMap,
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
    ...requestDocumentation.msgMap,
    ...requestMedicalAgreement.msgMap,
    ...goOut.msgMap,
    ...begin.msgMap,
    ...selectDocumentUpload.msgMap,
    ...documents.msgMap,
    ...documentsUploaded.msgMap,
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
    ...enterMinDigits.msgMap,
    ...enterYourOption.msgMap,
    ...enterYourDate.msgMap,
    ...enterYourRfc.msgMap,
    ...rfcFormatInvalid.msgMap,
    ...rfcGenericNoAllowed.msgMap,
    ...enterYourRfcName.msgMap,
    ...rfcDigitsTwelveThirteen.msgMap,
    ...reTabulationsTitle.msgMap,
    ...reTabulationsSubtitle.msgMap,
    ...bankingInfoTitle.msgMap,
    ...bankingInfoSubtitle.msgMap,
    ...personalizedAssistanceTitle.msgMap,
    ...personalizedAssistanceSubtitle.msgMap,
    ...onlyAlphabeticCharacters.msgMap,
    ...toRegisterYouAccept.msgMap,
    ...termsAndConditions.msgMap,
    ...fromGroupNational.msgMap,
    ...signUp.msgMap,
    ...notLastName.msgMap,
    ...notSecondLastName.msgMap,
    ...homeTerms.msgMap,
    ...view.msgMap,
    ...apologize.msgMap,
    ...noInvitation.msgMap,
    ...back.msgMap,
    ...doctor.msgMap,
    ...inAgreement.msgMap,
    ...hospital.msgMap,
    ...clinica.msgMap,
    ...otherServices.msgMap,
    ...errorGetting.msgMap,
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
    ...toCheckLevelHospital.msgMap,
    ...lookingforClinicaName.msgMap,
    ...lookingforOtherServicesName.msgMap,
    ...newRequest.msgMap,
    ...pleaseSelectASpecialty.msgMap,
    ...pleaseSelectASubspecialty.msgMap,
    ...pleaseSelectAState.msgMap,
    ...careHospitals.msgMap,
    ...pleaseSelectAtLeastOneHospital.msgMap,
    ...medicalOfficeAddress.msgMap,
    ...pleaseEnterYourOfficeAddress.msgMap,
    ...sendRequest.msgMap,
    ...myProcedures.msgMap,
    ...notProcedures.msgMap,
    ...errorToGetProcedures.msgMap,
    ...myPayments.msgMap,
    ...profile.msgMap,
    ...errorToGetProfile.msgMap,
    ...errorGettingDoctors.msgMap,
    ...errorGettingHospitals.msgMap,
    ...errorGettingClinics.msgMap,
    ...errorGettingOtherServices.msgMap,
    ...myUsers.msgMap,
    ...home.msgMap,
    ...all.msgMap,
    ...errorLoadingStates.msgMap,
    ...errorGettingMunicipalities.msgMap,
    ...search.msgMap,
    ...searchForSpecialty.msgMap,
    ...searchResults.msgMap,
    ...resultsFoundPage.msgMap,
    ...selected.msgMap,
    ...noResultsWithFilters.msgMap,
    ...calculatingPleaseWait.msgMap,
    ...goodDay.msgMap,
    ...welcomeMessageBody.msgMap,
    ...welcomeMessageFooter.msgMap,
    ...deleteSearchFilters.msgMap,
    ...errorGettingAnnexes.msgMap,
    ...errorDownloadingAnnex.msgMap,
    ...couldNotDownloadAnnex.msgMap,
    ...folio.msgMap,
    ...insuredName.msgMap,
    ...dateOfLoss.msgMap,
    ...condition.msgMap,
    ...attendingHospital.msgMap,
    ...policy.msgMap,
    ...noProceduresFoundForDate.msgMap,
    ...paymentDate.msgMap,
    ...amountPaid.msgMap,
    ...paymentAccount.msgMap,
    ...associatedIncident.msgMap,
    ...paymentStatus.msgMap,
    ...amountClaimed.msgMap,
    ...bankingInstitution.msgMap,
    ...notPayments.msgMap,
    ...noDataReceived.msgMap,
    ...locationServicesDisabledTitle.msgMap,
    ...locationServicesDisabledMessage.msgMap,
    ...permissionsDeniedTitle.msgMap,
    ...permissionsDeniedMessage.msgMap,
    ...permissionsPermanentlyDeniedTitle.msgMap,
    ...permissionsPermanentlyDeniedMessage.msgMap,
    ...errorMakingPhoneCall.msgMap,
    ...routeNotAvailableTitle.msgMap,
    ...routeNotAvailableMsg.msgMap,
    ...youAreHere.msgMap,
    ...errorLoadingProfileTitle.msgMap,
    ...noDataAvailable.msgMap,
    ...evaluations.msgMap,
    ...error.msgMap,
    ...success.msgMap,
    ...failed.msgMap,
    ...endOfList.msgMap,
    ...emptyFilters.msgMap,
    ...invalidUserOrPassword.msgMap,
    ...passwordRecoveryLinkSent.msgMap,
    ...biometricsNotAvailable.msgMap,
    ...biometricAuthenticationFailed.msgMap,
    ...errorAuthenticating.msgMap,
    ...errorGettingFormat.msgMap,
    ...errorDetail.msgMap,
    ...errorLoadingProfile.msgMap,
    ...errorGettingDocument.msgMap,
    ...agreementNotInEffect.msgMap,
    ...agreementUpdated.msgMap,
    ...requestRegistered.msgMap,
    ...requestNotRegistered.msgMap,
    ...noMoreProceduresToLoad.msgMap,
    ...selectFilterAndEnterData.msgMap,
    ...successfulRegistration.msgMap,
    ...userRegisteredSuccessfully.msgMap,
    ...successfulUpdate.msgMap,
    ...assistantNotUpdated.msgMap,
    ...errorUpdatingAssistantPermissions.msgMap,
    ...dataNotLoaded.msgMap,
    ...errorLoadingData.msgMap,
    ...noDocumentsUploadedYet.msgMap,
    ...dAtLeast8Chars.msgMap,
    ...dAtLeastOneUppercase.msgMap,
    ...dAtLeastOneLowercase.msgMap,
    ...dAtLeast4AlphaChars.msgMap,
    ...dAtLeastOneNumeric.msgMap,
    ...dAtLeastOneSpecialChar.msgMap,
    ...dNoGnpWord.msgMap,
    ...dNoConsecutiveEqualChars.msgMap,
    ...dNoConsecutiveChars.msgMap,
    ...dNoWhiteSpaces.msgMap,
    ...dPasswordsDoNotMatch.msgMap,
    ...successfulChange.msgMap,
    ...dPasswordUpdated.msgMap,
    ...temailAlreadyRegistered.msgMap,
    ...demailAlreadyRegistered.msgMap,
    ...errorToGetPayments.msgMap,
    ...professionalLicense.msgMap,
    ...speciality.msgMap,
    ...subspeciality.msgMap,
    ...fieldRequired.msgMap,
    ...actions.msgMap,
    ...noResultsFound.msgMap,
    ...pageNotFound.msgMap
  };
}
