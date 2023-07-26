class Model {
  final int id;
  final String imagePath;
  final String name;

  Model({
    required this.id,
    required this.imagePath,
    required this.name,
  });
}

List<Model> navBtn = [
  Model(id: 0, imagePath: 'assets/home.svg', name: 'Home'),
  Model(id: 1, imagePath: 'assets/search.svg', name: 'Search'),
  Model(id: 2, imagePath: 'assets/library.svg', name: 'Library'),
  Model(id: 3, imagePath: 'assets/Bookmark.svg', name: 'My Mix'),
  Model(id: 4, imagePath: 'assets/setting.svg', name: 'Settings'),
];