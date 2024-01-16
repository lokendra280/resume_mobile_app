import 'package:flutter/material.dart';

import 'add_project_bloc.dart';

class AddProjectBlocProvider extends InheritedWidget {
  final AddProjectBloc bloc;

  const AddProjectBlocProvider({
    required Key key,
    required this.bloc,
    required Widget child,
  }) : super(key: key, child: child);

  @override
  bool updateShouldNotify(_) => true;

  static AddProjectBloc of(BuildContext context) {
    return (context.dependOnInheritedWidgetOfExactType<AddProjectBlocProvider>()
            as AddProjectBlocProvider)
        .bloc;
  }
}
