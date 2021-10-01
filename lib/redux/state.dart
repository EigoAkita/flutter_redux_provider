class AppState {
  final String? name;
  final int? age;
  final int? sex;
  final String? prefectures;
  final String? hobby;
  final String? profileImage;
  final int? currentIndex;

  AppState({
    this.name,
    this.age,
    this.sex,
    this.prefectures,
    this.hobby,
    this.profileImage,
    this.currentIndex,
  });

  AppState.initialState()
      : name = '',
        age = 0,
        sex = 0,
        prefectures = '',
        hobby = '',
        profileImage = '',
        currentIndex = 0;
}
