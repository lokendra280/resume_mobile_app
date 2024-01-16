import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:resume_app/common/button/custom_rounded_button.dart';
import 'package:resume_app/model/resume_model.dart';
import 'package:resume_app/screen/add_experience/bloc/bloc_provider.dart';
import 'package:resume_app/widget/custom_text_feild_form.dart';
import 'package:resume_app/widget/date_picker_field.dart';

import 'bloc/add_experience_bloc.dart';

class AddExperienceDialog extends StatefulWidget {
  final Experience experience;

  AddExperienceDialog({required this.experience});

  @override
  _AddExperienceDialogState createState() => _AddExperienceDialogState();
}

class _AddExperienceDialogState extends State<AddExperienceDialog> {
  late TextEditingController _nameController;

  late TextEditingController _designationController;

  late TextEditingController _linkController;

  late TextEditingController _summaryController;

  final _formKey = GlobalKey<FormState>();
  late AddExperienceBloc _bloc;

  @override
  void initState() {
    super.initState();
    _bloc = AddExperienceBloc();

    _nameController = TextEditingController(
        text: widget.experience != null ? widget.experience.companyName : '');
    _designationController = TextEditingController(
        text: widget.experience != null ? widget.experience.designation : '');
    _linkController = TextEditingController(
        text: widget.experience != null ? widget.experience.companyLink : '');
    _summaryController = TextEditingController(
        text: widget.experience != null ? widget.experience.summary : '');
    _bloc.startDate = widget.experience != null
        ? widget.experience.startDate
        : DateTime.now();
    _bloc.endDate =
        widget.experience != null ? widget.experience.endDate : DateTime.now();
  }

  @override
  void dispose() {
    _bloc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AddExperienceBlocProvider(
      bloc: _bloc,
      key: ValueKey('addExperienceBlocProviderKey'),
      child: Scaffold(
        body: _buildForm(),
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          iconTheme: const IconThemeData(color: Colors.black),
          title: const Text(
            'Add Experience',
            style: TextStyle(
              color: Colors.black,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildForm() {
    return SingleChildScrollView(
      child: Form(
        key: _formKey,
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              CustomTextField(
                controller: _nameController,
                hintText: 'Name of company ...',
                helperText: 'Your company',
                validator: (val) => val?.length == 0
                    ? 'Empty name'
                    : val!.length < 2
                        ? 'Invalid name'
                        : null,
              ),
              SizedBox(height: 16.0),
              CustomTextField(
                controller: _linkController,
                hintText: 'Company website',
                helperText: 'Company link',
                validator: null,
              ),
              SizedBox(height: 16.0),
              CustomTextField(
                controller: _designationController,
                hintText: 'What was your role?',
                helperText: 'Your designation',
                validator: (val) => val?.length == 0
                    ? 'Empty designation'
                    : val!.length < 2
                        ? 'Invalid designation'
                        : null,
              ),
              SizedBox(height: 16.0),
              CustomTextField(
                controller: _summaryController,
                hintText: 'What was your contribution?',
                helperText: 'Job summary',
                validator: null,
                maxLines: 10,
              ),
              SizedBox(height: 16.0),
              _DateRow(),
              SizedBox(height: 24.0),
              CustomRoundedButton(
                onPressed: onAddExperience,
                title: 'Add',
              ),
            ],
          ),
        ),
      ),
    );
  }

  void onAddExperience() {
    FocusScope.of(context).requestFocus(new FocusNode());
    if (_formKey.currentState!.validate()) {
      _formKey.currentState?.save();

      if (_bloc.startDate.isAfter(_bloc.endDate)) {
        _bloc.errorSink.add('Invalid date');
        return;
      }

      Navigator.of(context).pop(
        Experience(
          companyLink: _linkController.value.text,
          startDate: _bloc.startDate,
          endDate: _bloc.endDate,
          designation: _designationController.value.text,
          companyName: _nameController.value.text,
          summary: _summaryController.value.text,
        ),
      );
    }
  }
}

class _DateRow extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final _bloc = AddExperienceBlocProvider.of(context);
    return StreamBuilder<String>(
        stream: _bloc.errorStream,
        builder: (context, errorSnapshot) {
          String? error = errorSnapshot.hasData ? errorSnapshot.data : null;
          return Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.end,
            mainAxisSize: MainAxisSize.max,
            children: <Widget>[
              Expanded(
                child: StreamBuilder<DateTime>(
                    stream: _bloc.startDateStream,
                    builder: (context, snapshot) {
                      _bloc.startDate =
                          (snapshot.hasData ? snapshot.data : _bloc.startDate)!;
                      return DatePicker(
                        labelText: 'Start',
                        errorText: "",
                        dateTime: _bloc.startDate,
                        onChanged: (dateTime) =>
                            _bloc.startDateSink.add(dateTime),
                        key: ValueKey('endDatePickerKey'),
                      );
                    }),
              ),
              SizedBox(
                width: 24,
              ),
              Expanded(
                child: StreamBuilder<DateTime>(
                    stream: _bloc.endDateStream,
                    builder: (context, snapshot) {
                      _bloc.endDate =
                          (snapshot.hasData ? snapshot.data : _bloc.endDate)!;
                      return DatePicker(
                        labelText: 'End',
                        errorText: "error",
                        dateTime: _bloc.endDate,
                        onChanged: (dateTime) =>
                            _bloc.endDateSink.add(dateTime),
                        key: ValueKey('endDatePickerKey'),
                      );
                    }),
              ),
            ],
          );
        });
  }
}
