import 'package:rxdart/rxdart.dart';
import 'package:task/model/user.dart';
import 'package:task/network/api.dart';

class UserBloc {
  final NetworkApi _api = NetworkApi();

  final _isLoading = BehaviorSubject<bool>.seeded(false);
  final _userStream = PublishSubject<User>();
  Stream<bool> get isLoading => _isLoading.stream;
  Stream<User> get user => _userStream.stream;

  Future<void> createUser(UserData user) async {
    User createdUser;
    _isLoading.add(true);
    try {
      createdUser = await _api.createUser(user.toJson());
      if (createdUser == null) {
        print("Was unable to create user");
      }
      _userStream.add(createdUser);
    } catch (e) {
      _userStream.addError(e);
    }
    _isLoading.add(false);
  }
}
