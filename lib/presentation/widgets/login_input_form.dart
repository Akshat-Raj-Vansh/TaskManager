//@dart=2.9
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:taskmanager/constants/colors.dart';
import 'package:taskmanager/constants/constraints.dart';
import 'package:taskmanager/data/providers/auth.dart';
import 'package:taskmanager/presentation/widgets/login_rounded_button.dart';

class InputForm extends StatefulWidget {
  final String type;

  const InputForm({Key key, this.type}) : super(key: key);

  @override
  _InputFormState createState() => _InputFormState();
}

class _InputFormState extends State<InputForm> {
  final GlobalKey<FormState> _formKey = GlobalKey();
  final _usernameFocusNode = FocusNode();
  final _emailFocusNode = FocusNode();
  final _passwordFocusNode = FocusNode();
  var isLoading = false;

  Future<bool> _login(String email, String password) async {
    print(email);
    print(password);

    return await Provider.of<Auth>(context, listen: false)
        .login(email, password);
  }

  Future<bool> _signUp(String name, String email, String password) async {
    print(name);
    print(email);
    print(password);
    return await Provider.of<Auth>(context, listen: false)
        .signup(name, email, password);
  }

  Map<String, String> _authData = {
    'name': '',
    'email': '',
    'password': '',
  };

  @override
  void dispose() {
    _usernameFocusNode.dispose();
    _emailFocusNode.dispose();
    _passwordFocusNode.dispose();
    super.dispose();
  }

  void _submit() async {
    FocusScope.of(context).unfocus();
    bool success = true;
    setState(() {
      isLoading = true;
    });
    if (!_formKey.currentState.validate()) {
      return;
    }
    _formKey.currentState.save();
    try {
      if (widget.type == 'signup')
        success = await _signUp(
          _authData['name'],
          _authData['email'],
          _authData['password'],
        );
      else
        success = await _login(
          _authData['email'],
          _authData['password'],
        );
      if (!success)
        setState(() {
          isLoading = false;
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(
                'User Authentication failed! Invalid Username or password!',
                style: TextStyle(color: Colors.red),
              ),
            ),
          );
        });
    } catch (error) {
      print('LOGIN:' + error.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          InputContainer(
            child: TextFormField(
              cursorColor: kPrimaryColor,
              focusNode: _emailFocusNode,
              decoration: kEmailTextFieldDecoration,
              keyboardType: TextInputType.emailAddress,
              onFieldSubmitted: (_) {
                if (widget.type == 'signup')
                  FocusScope.of(context).requestFocus(_usernameFocusNode);
                else
                  FocusScope.of(context).requestFocus(_passwordFocusNode);
              },
              validator: (value) {
                if (value.isEmpty || !value.contains('@')) {
                  return 'Invalid email!';
                }
                return null;
              },
              onSaved: (value) {
                _authData['email'] = value;
              },
            ),
          ),
          if (widget.type == 'signup')
            InputContainer(
              child: TextFormField(
                cursorColor: kPrimaryColor,
                focusNode: _usernameFocusNode,
                decoration: kUsernameTextFieldDecoration,
                keyboardType: TextInputType.emailAddress,
                onFieldSubmitted: (_) {
                  FocusScope.of(context).requestFocus(_passwordFocusNode);
                },
                validator: (value) {
                  if (value.isEmpty) {
                    return 'Invalid Username!';
                  }
                  return null;
                },
                onSaved: (value) {
                  _authData['name'] = value;
                },
              ),
            ),
          InputContainer(
            child: TextFormField(
              cursorColor: kPrimaryColor,
              focusNode: _passwordFocusNode,
              decoration: kPasswordTextfieldDecoration,
              obscureText: true,
              validator: (value) {
                if (value.isEmpty || value.length < 5) {
                  return 'Password is too short!';
                }
                return null;
              },
              onSaved: (value) {
                _authData['password'] = value;
              },
            ),
          ),
          SizedBox(
            height: 10.0,
          ),
          isLoading
              ? Center(
                  child: CircularProgressIndicator(
                  color: kAccentColor,
                ))
              : RoundedButton(
                  title: widget.type == 'login' ? 'LOGIN' : 'SIGN UP',
                  onTap: _submit,
                ),
        ],
      ),
    );
  }
}

class InputContainer extends StatelessWidget {
  final Widget child;

  const InputContainer({
    @required this.child,
  });

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      padding: EdgeInsets.symmetric(
        horizontal: 20,
        vertical: 5,
      ),
      width: size.width * 0.8,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30.0),
        color: kPrimaryColor.withAlpha(50),
      ),
      child: child,
    );
  }
}
