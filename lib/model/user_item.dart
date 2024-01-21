class UserItem {
  int? money;
  bool? musicOn;

  UserItem({this.money, this.musicOn});

  factory UserItem.fromJson(Map<String, dynamic> parsedJson) {
    return UserItem(
      money: parsedJson['money'] ?? "",
      musicOn: parsedJson['musicOn'],
    );
  }

  Map<String, dynamic> toJson() {
    return {'money': money, 'musicOn': musicOn};
  }
}
