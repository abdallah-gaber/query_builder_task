part of query_builder;

final allFakeUsersProvider = FutureProvider<List<UserModel>>((_) async {
  final allFakeUsers = await ApiCaller().getAllFakeUsersList();
  return allFakeUsers;
});

final userProvider =
    ChangeNotifierProvider<UserViewModel>((ref){
      return UserViewModel(ref.read(allFakeUsersProvider).value ?? []);
    });
