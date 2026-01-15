import 'dart:convert';

class DatosPersonalesDto {
  DatosPersonalesDto({
    required this.genero,
    required this.telefono,
    required this.correo,
    required this.nacionalidad,
    required this.nombre,
    required this.fechaNacimiento,
    required this.direccion,
  });

  factory DatosPersonalesDto.empty() => DatosPersonalesDto(
    genero: '',
    telefono: '',
    correo: '',
    nacionalidad: '',
    nombre: '',
    fechaNacimiento: '',
    direccion: '',
  );

  factory DatosPersonalesDto.fromMap(
    Map<String, dynamic> json,
    Map<String, dynamic> jsonFiscales,
  ) {
    final String direccion = jsonFiscales['domicilioFiscal'] ?? '';
    return DatosPersonalesDto(
      nombre: json['nombre'] ?? '',
      fechaNacimiento: json['fechaNacimiento'] ?? '',
      genero: json['genero'] ?? '',
      telefono: json['telefono'] ?? '',
      correo: json['correo'] ?? '',
      nacionalidad: json['nacionalidad'] ?? '',
      direccion: direccion,
    );
  }

  Map<String, dynamic> toMap() => {
    'nombre': nombre,
    'fechaNacimiento': fechaNacimiento,
    'genero': genero,
    'telefono': telefono,
    'correo': correo,
    'nacionalidad': nacionalidad,
    'direccion': direccion,
  };

  final String nombre;
  final String fechaNacimiento;
  final String genero;
  final String telefono;
  final String correo;
  final String nacionalidad;
  final String direccion;
}

class DatosAcademicosDto {
  DatosAcademicosDto({
    required this.cedula,
    required this.especialidad,
    required this.tituloProfesional,
    required this.subspecialty
  });

  factory DatosAcademicosDto.empty() => DatosAcademicosDto(
    cedula: '',
    especialidad: '',
    tituloProfesional: '',
    subspecialty: ''
  );

  factory DatosAcademicosDto.fromMap(Map<String, dynamic> json) =>
      DatosAcademicosDto(
        cedula: json['cedula'] ?? '',
        especialidad: json['especialidad'] ?? '',
        tituloProfesional: json['tituloProfesional'] ?? '',
        subspecialty: json['descripcionCortaSubespecialidad'] ?? ''
      );

  Map<String, dynamic> toMap() => {
    'cedula': cedula,
    'especialidad': especialidad,
    'tituloProfesional': tituloProfesional,
    'subspecialty': subspecialty
  };

  final String cedula;
  final String especialidad;
  final String tituloProfesional;
  final String subspecialty;
}

class DatosFiscalesDto {
  DatosFiscalesDto({
    required this.rfc,
    required this.domicilioFiscal,
    required this.metodoPago,
  });

  factory DatosFiscalesDto.empty() => DatosFiscalesDto(
    rfc: '',
    domicilioFiscal: '',
    metodoPago: '',
  );

  factory DatosFiscalesDto.fromMap(Map<String, dynamic> json) =>
      DatosFiscalesDto(
        rfc: json['rfc'] ?? '',
        domicilioFiscal: json['domicilioFiscal'] ?? '',
        metodoPago: json['metodoPago'] ?? '',
      );

  Map<String, dynamic> toMap() => {
    'rfc': rfc,
    'domicilioFiscal': domicilioFiscal,
    'metodoPago': metodoPago,
  };

  final String rfc;
  final String domicilioFiscal;
  final String metodoPago;
}

class BankingDataDto {
  BankingDataDto({
    required this.clabe,
    required this.account,
    required this.bankDescription,
    required this.preferredPaymentMethodKey,
    required this.preferredPaymentMethodDescription,
  });

  factory BankingDataDto.empty() => BankingDataDto(
    clabe: '',
    account: '',
    bankDescription: '',
    preferredPaymentMethodKey: '',
    preferredPaymentMethodDescription: '',
  );

  factory BankingDataDto.fromMap(Map<String, dynamic> json) =>
      BankingDataDto(
        clabe: json['clabeCuentaBancaria'] ?? '',
        account: json['numeroCuentaBancaria'] ?? '',
        bankDescription: json['descripcionBanco'] ?? '',
        preferredPaymentMethodKey: json['claveMetodoPagoPreferido'] ?? '',
        preferredPaymentMethodDescription: 
          json['descripcionMetodoPagoPreferido'] ?? '',
      );

  Map<String, dynamic> toMap() => {
    'clabeCuentaBancaria': clabe,
    'numeroCuentaBancaria': account,
    'descripcionBanco': bankDescription,
    'claveMetodoPagoPreferido': preferredPaymentMethodKey,
    'descripcionMetodoPagoPreferido': preferredPaymentMethodDescription,
  };

  final String clabe;
  final String account;
  final String bankDescription;
  final String preferredPaymentMethodKey;
  final String preferredPaymentMethodDescription;
}

class OfficeAddressDto {
  OfficeAddressDto({
    required this.countryCode,
    required this.stateName,
    required this.municipalityName,
    required this.postalCode,
    required this.settlementTypeCode,
    required this.settlementName,
    required this.addressTypeCode,
    required this.roadTypeCode,
    required this.roadName,
    required this.roadNumber,
  });

  factory OfficeAddressDto.empty() => OfficeAddressDto(
    countryCode: '',
    stateName: '',
    municipalityName: '',
    postalCode: '',
    settlementTypeCode: '',
    settlementName: '',
    addressTypeCode: '',
    roadTypeCode: '',
    roadName: '',
    roadNumber: '',
  );

  factory OfficeAddressDto.fromMap(Map<String, dynamic> json) =>
      OfficeAddressDto(
        countryCode: json['codigoPais'] ?? '',
        stateName: json['nombreEstado'] ?? '',
        municipalityName: json['nombreMunicipio'] ?? '',
        postalCode: json['codigoPostal'] ?? '',
        settlementTypeCode: json['codigoTipoAsentamiento'] ?? '',
        settlementName: json['nombreAsentamiento'] ?? '',
        addressTypeCode: json['codigoTipoDomicilio'] ?? '',
        roadTypeCode: json['codigoTipoVia'] ?? '',
        roadName: json['nombreVia'] ?? '',
        roadNumber: json['numeroVia'] ?? '',
      );

  Map<String, dynamic> toMap() => {
    'codigoPais': countryCode,
    'nombreEstado': stateName,
    'nombreMunicipio': municipalityName,
    'codigoPostal': postalCode,
    'codigoTipoAsentamiento': settlementTypeCode,
    'nombreAsentamiento': settlementName,
    'codigoTipoDomicilio': addressTypeCode,
    'codigoTipoVia': roadTypeCode,
    'nombreVia': roadName,
    'numeroVia': roadNumber,
  };

  final String countryCode;
  final String stateName;
  final String municipalityName;
  final String postalCode;
  final String settlementTypeCode;
  final String settlementName;
  final String addressTypeCode;
  final String roadTypeCode;
  final String roadName;
  final String roadNumber;
}

class MainHospitalDto {
  MainHospitalDto({
    required this.hospitalKey,
    required this.branchKey,
    required this.name,
  });

  factory MainHospitalDto.empty() => MainHospitalDto(
    hospitalKey: '',
    branchKey: '',
    name: '',
  );

  factory MainHospitalDto.fromMap(Map<String, dynamic> json) =>
      MainHospitalDto(
        hospitalKey: json['claveHospital'] ?? '',
        branchKey: json['claveSucursal'] ?? '',
        name: json['nombre'] ?? '',
      );

  Map<String, dynamic> toMap() => {
    'claveHospital': hospitalKey,
    'claveSucursal': branchKey,
    'nombre': name,
  };

  final String hospitalKey;
  final String branchKey;
  final String name;
}

class ProfessionDto {
  ProfessionDto({
    required this.key,
    required this.name,
  });

  factory ProfessionDto.empty() => ProfessionDto(
    key: '',
    name: '',
  );

  factory ProfessionDto.fromMap(Map<String, dynamic> json) =>
      ProfessionDto(
        key: json['clave'] ?? '',
        name: json['nombre'] ?? '',
      );

  Map<String, dynamic> toMap() => {
    'clave': key,
    'nombre': name,
  };

  final String key;
  final String name;
}

class ProfileDto {
  ProfileDto({
    required this.datosPersonales,
    required this.datosAcademicos,
    required this.datosFiscales,
    required this.bankingData,
    required this.officeAddress,
    required this.mainHospital,
    required this.profession,
  });

  factory ProfileDto.empty() => ProfileDto(
    datosPersonales: DatosPersonalesDto.empty(),
    datosAcademicos: DatosAcademicosDto.empty(),
    datosFiscales: DatosFiscalesDto.empty(),
    bankingData: BankingDataDto.empty(),
    officeAddress: OfficeAddressDto.empty(),
    mainHospital: MainHospitalDto.empty(),
    profession: ProfessionDto.empty(),
  );

  factory ProfileDto.fromMap(Map<String, dynamic> json) => ProfileDto(
    datosPersonales: json['datosPersonales'] == null
        ? DatosPersonalesDto.empty()
        : DatosPersonalesDto.fromMap(
            json['datosPersonales'] as Map<String, dynamic>,
            json['datosFiscales'] == null
                ? {}
                : json['datosFiscales'] as Map<String, dynamic>,
          ),
    datosAcademicos: json['datosAcademicos'] == null
        ? DatosAcademicosDto.empty()
        : DatosAcademicosDto.fromMap(
            json['datosAcademicos'] as Map<String, dynamic>,
          ),
    datosFiscales: json['datosFiscales'] == null
        ? DatosFiscalesDto.empty()
        : DatosFiscalesDto.fromMap(
            json['datosFiscales'] as Map<String, dynamic>,
          ),
    bankingData: json['datosBancarios'] == null
        ? BankingDataDto.empty()
        : BankingDataDto.fromMap(
            json['datosBancarios'] as Map<String, dynamic>,
          ),
    officeAddress: json['domicilioConsultorio'] == null
        ? OfficeAddressDto.empty()
        : OfficeAddressDto.fromMap(
            json['domicilioConsultorio'] as Map<String, dynamic>,
          ),
    mainHospital: json['hospitalAtencionPrincipal'] == null
        ? MainHospitalDto.empty()
        : MainHospitalDto.fromMap(
            json['hospitalAtencionPrincipal'] as Map<String, dynamic>,
          ),
    profession: json['profesion'] == null
        ? ProfessionDto.empty()
        : ProfessionDto.fromMap(
            json['profesion'] as Map<String, dynamic>,
          ),
  );

  factory ProfileDto.fromRaw(String str) =>
      ProfileDto.fromMap(json.decode(str) as Map<String, dynamic>);

  String toRaw() => json.encode(toMap());

  Map<String, dynamic> toMap() => {
    'datosPersonales': datosPersonales.toMap(),
    'datosAcademicos': datosAcademicos.toMap(),
    'datosFiscales': datosFiscales.toMap(),
    'datosBancarios': bankingData.toMap(),
    'domicilioConsultorio': officeAddress.toMap(),
    'hospitalAtencionPrincipal': mainHospital.toMap(),
    'profesion': profession.toMap(),
  };

  final DatosPersonalesDto datosPersonales;
  final DatosAcademicosDto datosAcademicos;
  final DatosFiscalesDto datosFiscales;
  final BankingDataDto bankingData;
  final OfficeAddressDto officeAddress;
  final MainHospitalDto mainHospital;
  final ProfessionDto profession;
}
