part of query_builder;

final isThereConnection = StreamProvider<InternetConnectionStatus>((_) {
  final internetConnection = InternetConnectionChecker();
  internetConnection.checkInterval = const Duration(seconds: 3);
  var subscription = internetConnection.onStatusChange;
  return subscription;
});

final isThereInternet = FutureProvider<bool>((ref) async {
  var isDeviceConnected = (await InternetConnectionChecker().connectionStatus) ==
      InternetConnectionStatus.connected;
  ref.watch(isThereConnection);
  // isThereConnectionProvider.when(
  //     data: (result) async {
  //       isDeviceConnected = result == InternetConnectionStatus.connected;
  //     },
  //     error: (_, __) {},
  //     loading: () {});
  return isDeviceConnected;
});

final allFakeUsersProvider = FutureProvider<List<UserModel>>((_) async {
  final allFakeUsers = await ApiCaller().getAllFakeUsersList();
  return allFakeUsers;
});

final userProvider = ChangeNotifierProvider<UserViewModel>((ref) {
  return UserViewModel(ref.read(allFakeUsersProvider).value ?? []);
});
