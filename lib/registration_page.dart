import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';

class RegistrationPage extends StatefulWidget {
  const RegistrationPage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<RegistrationPage> createState() => _RegistrationPageState();
}

class _RegistrationPageState extends State<RegistrationPage> {

  final TextEditingController _nameController = TextEditingController();

  final TextEditingController _emailController = TextEditingController();

  final TextEditingController _passwordController = TextEditingController();

  String? _passwordError = "";

  String? _emailError = "invalid email format";

  String? _nameError = "";

  bool _firstSubmit = false;

  bool _validSubmit = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Card(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: _buildContent(),
              ),
            ),
          ),
        ),
    );
  }

  Widget _buildContent(){
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        TextField(
          key: Key("username_input"),
          decoration: InputDecoration(
            labelText: "Username",
            errorText: _firstSubmit ? _nameError : null,
          ),
          controller: _nameController,
          onChanged: (name) => _checkNameField(),
          enabled: !_validSubmit,
        ),
        TextField(
          key: Key("email_input"),
          decoration: InputDecoration(
            labelText: "Email",
            errorText: _firstSubmit ? _emailError : null,
          ),
          keyboardType: TextInputType.emailAddress,
          controller: _emailController,
          onChanged: (email) => _checkEmailField(),
          enabled: !_validSubmit,
        ),
        TextField(
          key: Key("password_input"),
          decoration: InputDecoration(
            labelText: "Password",
            errorText: _firstSubmit ? _passwordError : null,
          ),
          obscureText: true,
          controller: _passwordController,
          onChanged: (password) => _checkPasswordField(),
          enabled: !_validSubmit,
        ),
        Padding(
            padding: EdgeInsets.symmetric(vertical: 20, horizontal: 0),
            child: _validSubmit ?  makeLoadingAnimation() : makeSubmitButton(),
        ),
      ],
    );
  }

  Widget makeLoadingAnimation(){
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [CircularProgressIndicator()],
    );
  }

  Widget makeSubmitButton(){
    return ElevatedButton(
      key: Key("submit_button"),
      onPressed: getIfInputIsValid() || !_firstSubmit ? _submitForm : null,
      child: Text("Submit form"),

    );
  }

  bool getIfInputIsValid(){
    return _emailError == null && _nameError == null && _passwordError == null;
  }

  void _submitForm(){
    _checkPasswordField();
    _checkNameField();
    _checkEmailField();
    _validSubmit = getIfInputIsValid();
    setState(() {
      _firstSubmit = true;
    });
  }

  void _checkEmailField(){
    String email = _emailController.text;
    String? error = null;
    if(email.length == 0 || !EmailValidator.validate(email, false, true)){
      error = "invalid email format";
    }
    setState(() {
      _emailError = error;
    });
  }

  void _checkPasswordField(){
    String password = _passwordController.text.trim();
    RegExp regrex = RegExp(r"^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)[a-zA-Z\d]{6,}$");
    int length = password.length;
    String? error = null;
    if(length < 6 || length > 20 || !regrex.hasMatch(password)){
      error = "6-20 chars, uppercase, lowercase, digits";
    }
    setState(() {
      _passwordError = error;
    });
  }


  void _checkNameField(){
    String username = _nameController.text.trim();
    RegExp regrex = RegExp("^[a-z]+\$", caseSensitive: false);
    int length = username.length;
    String? error = null;
    if(!regrex.hasMatch(username) || length < 3 || length > 12 || username.isEmpty){
      error = "invalid username";
    }
    setState(() {
      _nameError = error;
    });
  }
}
