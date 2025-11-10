import 'package:medicos/src/modules/directorio/domain/entities/items_directory_mdl.dart';

/// Represents the set of filters selected by the user to perform a search
/// in the directory.
class ItemToSearchDirectoryMdl {
  /// Creates an instance of [ItemToSearchDirectoryMdl] with all the required
  /// filter IDs.
  ItemToSearchDirectoryMdl({
    required this.idPage,
    required this.itemSelected,
    required this.especialidad,
    required this.planHospitalario,
    required this.clinica,
    required this.otrosServicios,
    required this.circuloMedico,
    required this.estado,
    required this.municipio,
    required this.searchBy,
  });

  /// Creates an empty instance of [ItemToSearchDirectoryMdl].
  factory ItemToSearchDirectoryMdl.empty() => ItemToSearchDirectoryMdl(
    idPage: '',
    itemSelected: ItemDirectoryMdl.empty(),
    especialidad: {},
    planHospitalario: {},
    clinica: {},
    otrosServicios: {},
    circuloMedico: {},
    estado: {},
    municipio: {},
    searchBy: '',
  );

  /// The ID of the page being searched (e.g., 'medicos', 'hospitales').
  final String idPage;

  /// The main directory item being searched (e.g., Doctors, Hospitals).
  final ItemDirectoryMdl itemSelected;

  /// The ID of the selected medical specialty.
  final Map<String, dynamic> especialidad;

  /// The ID of the selected hospital plan.
  final Map<String, dynamic> planHospitalario;

  /// The ID of the selected clinic type.
  final Map<String, dynamic> clinica;

  /// The ID of the selected "other services" type.
  final Map<String, dynamic> otrosServicios;

  /// The ID of the selected medical circle or tabulator.
  final Map<String, dynamic> circuloMedico;

  /// The ID of the selected state.
  final Map<String, dynamic> estado;

  /// The ID of the selected municipality.
  final Map<String, dynamic> municipio;

  ///  The name to search for in the directory.
  final String searchBy;
}
