import 'package:flutter/material.dart';
import 'package:task/bloc/employeeList.dart';
import 'package:task/model/employeeList.dart';

class EmployeeListView extends StatefulWidget {
  @override
  _EmployeeListViewState createState() => _EmployeeListViewState();
}

class _EmployeeListViewState extends State<EmployeeListView> {
  EmployeeListBloc bloc = EmployeeListBloc();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Employee List"),
        actions: [
          IconButton(
              icon: Icon(Icons.refresh),
              onPressed: () {
                bloc.fetchEmployeeList();
              })
        ],
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          StreamBuilder<EmployeeList>(
            stream: bloc.listOfEmployees,
            builder: (context, snapshot2) {
              if (snapshot2.hasError) {
                return Center(child: Text("${snapshot2.error.toString()}"));
              }
              if (snapshot2.hasData)
                return Expanded(
                  child: ListView.builder(
                    padding: EdgeInsets.symmetric(horizontal: 16),
                    itemCount: snapshot2.data.data.length,
                    itemBuilder: (context, index) {
                      var data = snapshot2.data.data;
                      return Container(
                        padding: EdgeInsets.all(8),
                        margin: EdgeInsets.symmetric(vertical: 4),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            border: Border.all(color: Colors.green)),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text("ID - ${data[index].id}"),
                            Text("NAME - ${data[index].employeeName}"),
                            Text("AGE - ${data[index].employeeAge}"),
                            Text("SALARY - ${data[index].employeeSalary}"),
                            Text("IMAGE URL - ${data[index].profileImage}"),
                          ],
                        ),
                      );
                    },
                  ),
                );
              if (!snapshot2.hasData) {
                return Center(
                  child: Text('No DATA'),
                );
              }
              return SizedBox();
            },
          ),
          StreamBuilder<LoadingState>(
              stream: bloc.isLoading,
              builder: (context, snapshot) {
                if (snapshot.data == LoadingState.NONE)
                  return Center(
                    child: RaisedButton(
                      onPressed: () {
                        bloc.fetchEmployeeList();
                      },
                      child: Text("Fetch List"),
                    ),
                  );

                if (snapshot.data == LoadingState.LOADING)
                  return LinearProgressIndicator();

                if (snapshot.data == LoadingState.LOADED) return SizedBox();
                return SizedBox();
              }),
        ],
      ),
    );
  }
}
