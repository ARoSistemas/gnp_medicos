class CheckItemModel {

  CheckItemModel({
    required this.name,
    required this.image,
    this.valid = false,
  });
  String name;
  String image; // Mantengo la lógica de cambiar la ruta de la imagen
  bool valid;
}
