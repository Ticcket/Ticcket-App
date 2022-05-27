class AppConstants {
  static const String _assets = "assets";

  static const String _svg = "$_assets/svg";
  static const String onBoardingSvg = "$_svg/onboarding.svg";
  static const String logoSvg = "$_svg/logo/Logo.svg";
  static List<Model> navBtn = [
    Model(id: 0, imagePath: 'assets/icons/home.png', name: 'Home'),
    Model(id: 1, imagePath: 'assets/icons/search.png', name: 'Search'),
    Model(id: 2, imagePath: 'assets/icons/heart.png', name: 'Like'),
    Model(id: 3, imagePath: 'assets/icons/notification.png', name: 'notification'),
    Model(id: 4, imagePath: 'assets/icons/user.png', name: 'Profile'),
  ];
}

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