import 'package:flutter/material.dart';
import 'package:resume_app/common/button/custom_rounded_button.dart';
import 'package:resume_app/model/resume_model.dart';
import 'package:resume_app/widget/custom_text_feild_form.dart';

class AddReferenceDialog extends StatefulWidget {
  final Reference reference;

  AddReferenceDialog({required this.reference});

  @override
  _AddReferenceDialogState createState() => _AddReferenceDialogState();
}

class _AddReferenceDialogState extends State<AddReferenceDialog> {
  late TextEditingController _nameController;
  late TextEditingController _designationController;
  late TextEditingController _emailController;
  late TextEditingController _companyController;
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(
        text: widget.reference != null ? widget.reference.name : '');
    _emailController = TextEditingController(
        text: widget.reference != null ? widget.reference.email : '');
    _designationController = TextEditingController(
        text: widget.reference != null ? widget.reference.designation : '');
    _companyController = TextEditingController(
        text: widget.reference != null ? widget.reference.company : '');
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _designationController.dispose();
    _companyController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _buildForm(),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: IconThemeData(color: Colors.black),
        title: Text(
          'Add Reference',
          style: TextStyle(
            color: Colors.black,
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
                hintText: 'Reference person name ...',
                helperText: 'Name',
                validator: (val) => val?.length == 0
                    ? 'Empty name'
                    : val!.length < 2
                        ? 'Invalid name'
                        : null,
              ),
              SizedBox(height: 12.0),
              CustomTextField(
                controller: _designationController,
                hintText: 'Designation ...',
                helperText: 'Designation',
                validator: (val) =>
                    val?.length == 0 ? 'Empty designation' : null,
              ),
              SizedBox(height: 12.0),
              CustomTextField(
                controller: _companyController,
                hintText: 'Company name ...',
                helperText: 'Company',
                validator: (val) =>
                    val?.length == 0 ? 'Empty company name' : null,
              ),
              SizedBox(height: 12.0),
              CustomTextField(
                controller: _emailController,
                hintText: 'Email?',
                helperText: 'Email',
                textInputType: TextInputType.emailAddress,
                // validator: (val) {
                //   Pattern pattern =
                //       r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
                //   RegExp regex = new RegExp(pattern);
                //   if (!regex.hasMatch(val))
                //     return 'Enter Valid Email';
                //   else
                //     return null;
                // },
              ),
              SizedBox(height: 24.0),
              CustomRoundedButton(
                onPressed: onAddReference,
                title: 'Add',
              ),
            ],
          ),
        ),
      ),
    );
  }

  void onAddReference() {
    FocusScope.of(context).requestFocus(new FocusNode());
    if (_formKey.currentState!.validate()) {
      _formKey.currentState?.save();

      Navigator.of(context).pop(
        Reference(
          designation: _designationController.text,
          name: _nameController.text,
          email: _emailController.text,
          company: _companyController.text,
        ),
      );
    }
  }
}
