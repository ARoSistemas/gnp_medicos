import 'package:medicos/src/modules/directorio/domain/entities/items_directory_mdl.dart';

/// Represents the set of filters selected by the user to perform a search
/// in the directory.
class ItemToSearchDirectoryMdl {
  /// Creates an instance of [ItemToSearchDirectoryMdl] with all the required
  /// filter IDs.
  ItemToSearchDirectoryMdl({
    required this.itemSelected,
    required this.idEspecialidad,
    required this.idPlanHospitalario,
    required this.idClinica,
    required this.idOtrosServicios,
    required this.idCirculoMedico,
    required this.idEstado,
    required this.idMunicipio,
    required this.doctor,
    required this.asegurado,
    required this.searchCtrler,
  });

  /// Creates an empty instance of [ItemToSearchDirectoryMdl].
  factory ItemToSearchDirectoryMdl.empty() => ItemToSearchDirectoryMdl(
    itemSelected: ItemsDirectoryMdl.empty(),
    idEspecialidad: '',
    idPlanHospitalario: '',
    idClinica: '',
    idOtrosServicios: null,
    idCirculoMedico: '',
    idEstado: '',
    idMunicipio: '',
    doctor: '',
    asegurado: '',
    searchCtrler: {},
  );

  /// The main directory item being searched (e.g., Doctors, Hospitals).
  final ItemsDirectoryMdl itemSelected;

  /// The ID of the selected medical specialty.
  final String idEspecialidad;

  /// The ID of the selected hospital plan.
  final String idPlanHospitalario;

  /// The ID of the selected clinic type.
  final String idClinica;

  /// The ID of the selected "other services" type.
  final int? idOtrosServicios;

  /// The ID of the selected medical circle or tabulator.
  final String idCirculoMedico;

  /// The ID of the selected state.
  final String idEstado;

  /// The ID of the selected municipality.
  final String idMunicipio;

  /// The name of the doctor to search for.
  final String doctor;

  /// The name or policy number of the insured to search for.
  final String asegurado;

  final Map<String, dynamic> searchCtrler;
}
