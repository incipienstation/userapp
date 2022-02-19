class User {
  final String uid;
  final List<String>? favoriteStoreIds;

  User({required this.uid, this.favoriteStoreIds});

  asStringMap() {
    return {
      'uid': uid,
      'favoriteStores': favoriteStoreIds,
    };
  }
}