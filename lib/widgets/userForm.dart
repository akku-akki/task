import 'package:flutter/material.dart';
import 'package:task/bloc/userBloc.dart';
import 'package:task/model/user.dart';

class UserForm extends StatefulWidget {

  @override
  _UserFormState createState() => _UserFormState();
}

class _UserFormState extends State<UserForm> {
  final _userFormKey = GlobalKey<FormState>();
  DateTime now = DateTime.now();
  DateTime today;
  DateTime century;
  DateTime _dob;
  String _name;
  String salary;
  TextEditingController _dateController;
  int age;
  UserBloc bloc = UserBloc();
  @override
  void initState() {
    _dateController = TextEditingController();
    today = DateTime(now.year, now.month, now.day);
    century = DateTime(today.year - 100, today.month, today.day);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("User Form"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _userFormKey,
          child: Column(
            children: [
              _buildName(),
              _buildSalary(),
              _buildAge(),
              Spacer(),
              StreamBuilder<bool>(
                  stream: bloc.isLoading,
                  builder: (context, snapshot) {
                    return RaisedButton(
                      key: UniqueKey(),
                      color: Theme.of(context).accentColor,
                      onPressed: snapshot.data == true
                          ? null
                          : () async {
                              if (_userFormKey.currentState.validate()) {
                                _userFormKey.currentState.save();
                                UserData user = UserData(
                                    name: _name,
                                    age: age.toString(),
                                    salary: salary);
                                bloc.createUser(user);
                              }
                            },
                      child: Text(
                        "Submit",
                        style: TextStyle(color: Colors.white),
                      ),
                    );
                  }),
              StreamBuilder<User>(
                  stream: bloc.user,
                  builder: (context, snapshot) {
                    if (snapshot.hasError)
                      return Center(child: Text("${snapshot.error.toString()}"));
                    if (snapshot.hasData)
                      return Text(
                          "${snapshot.data.status} Your ID is ${snapshot.data.data.id}");
                    return SizedBox();
                  }),
              Spacer(),
              StreamBuilder<bool>(
                  stream: bloc.isLoading,
                  builder: (context, snapshot) {
                    if (snapshot.data == true) return LinearProgressIndicator();
                    return SizedBox();
                  })
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildAge() {
    return Padding(
      padding: const EdgeInsets.only(top: 8),
      child: TextFormField(
        controller: _dateController,
        readOnly: true,
        onTap: () async {
          DateTime dateDOB = await showDatePicker(
              helpText: 'Date of Birth',
              confirmText: 'SET',
              context: context,
              initialDate: today,
              firstDate: century,
              lastDate: today);
          _dob = dateDOB;
          String dobString = "${dateDOB.year}/${dateDOB.month}/${dateDOB.day}";
          _dateController.text = dobString;
        },
        decoration: InputDecoration(
            border: InputBorder.none,
            prefixIcon: Icon(
              Icons.calendar_today,
              color: Theme.of(context).accentColor,
            ),
            hintText: "Date of birth",
            labelText: "Date of birth"),
        keyboardType: TextInputType.phone,
        textInputAction: TextInputAction.done,
        validator: (String value) {
          if (value.isEmpty) {
            return 'Birth Date Required';
          }
          var dif = today.difference(_dob).inDays / 365;
          var minAge = dif.floor();
          if (minAge < 14) {
            return 'Min age should be greater than 14';
          }
          return null;
        },
        onSaved: (_) {
          var dif = today.difference(_dob).inDays / 365;
          age = dif.floor();
        },
      ),
    );
  }

  Widget _buildSalary() {
    return TextFormField(
      decoration: InputDecoration(hintText: "Salary", labelText: "Salary"),
      keyboardType: TextInputType.phone,
      textInputAction: TextInputAction.done,
      validator: (String value) {
        if (value.isEmpty) {
          return 'Salary is Required';
        }
        if (!RegExp("^(([1-9]*)|(([1-9]*)\.([0-9]*)))\$").hasMatch(value)) {
          return 'Enter a valid input';
        }

        return null;
      },
      onSaved: (String value) {
        salary = value;
      },
    );
  }

  Widget _buildName() {
    return TextFormField(
      initialValue: _name,
      textInputAction: TextInputAction.next,
      decoration: InputDecoration(hintText: "Name", labelText: "Name"),
      validator: (String value) {
        if (value.isEmpty) {
          return 'Name is Required';
        }
        if (value.length > 100) {
          return 'Max 100 characters';
        }
        return null;
      },
      onSaved: (String value) {
        _name = value;
      },
    );
  }
}
