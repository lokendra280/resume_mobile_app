import 'package:flutter/material.dart';

import 'add_education_bloc.dart';

class AddEducationBlocProvider extends InheritedWidget {
  final AddEducationBloc bloc;

  const AddEducationBlocProvider({
    required Key key,
    required this.bloc,
    required Widget child,
  }) : super(key: key, child: child);

  @override
  bool updateShouldNotify(_) => true;

  static AddEducationBloc of(BuildContext context) {
    return (context
                .dependOnInheritedWidgetOfExactType<AddEducationBlocProvider>()
            as AddEducationBlocProvider)
        .bloc;
  }
}
