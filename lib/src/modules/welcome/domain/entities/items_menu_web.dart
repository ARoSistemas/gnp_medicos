class ItemForMenuWeb {
  ItemForMenuWeb({
    required this.iconName,
    required this.title,
    this.visible = false,
  });
  final String iconName;
  final String title;
  final bool visible;
}
