import 'package:flutter/material.dart';

import 'add_language_bloc.dart';

class AddLanguageBlocProvider extends InheritedWidget {
  final AddLanguageBloc bloc;

  const AddLanguageBlocProvider({
    required Key key,
    required this.bloc,
    required Widget child,
  }) : super(key: key, child: child);

  @override
  bool updateShouldNotify(_) => true;

  static AddLanguageBloc of(BuildContext context) {
    return (context
                .dependOnInheritedWidgetOfExactType<AddLanguageBlocProvider>()
            as AddLanguageBlocProvider)
        .bloc;
  }
}
