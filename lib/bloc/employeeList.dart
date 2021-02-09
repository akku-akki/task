import 'package:rxdart/rxdart.dart';
import 'package:task/model/employeeList.dart';
import 'package:task/network/api.dart';

enum LoadingState { NONE, LOADING, LOADED }

class EmployeeListBloc {
  final NetworkApi _api = NetworkApi();

  final _isLoading = BehaviorSubject<LoadingState>.seeded(LoadingState.NONE);
  final _employeeList = PublishSubject<EmployeeList>();
  Stream<LoadingState> get isLoading => _isLoading.stream;
  Stream<EmployeeList> get listOfEmployees => _employeeList.stream;

  Future<void> fetchEmployeeList() async {
    EmployeeList employeeList;
    _isLoading.add(LoadingState.LOADING);
    try {
      employeeList = await _api.fetchEmployeeList();
      _employeeList.add(employeeList);
    } catch (e) {
      _employeeList.addError(e);
    }
    _isLoading.add(LoadingState.LOADED);
  }
}
