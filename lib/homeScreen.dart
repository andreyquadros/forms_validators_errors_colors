import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  TextEditingController _controllerNome = TextEditingController();
  TextEditingController _controllerEmail = TextEditingController();
  TextEditingController _controllerTelefone = TextEditingController();

  final _formKey = GlobalKey<FormState>();
  bool _emailValido = false;
  bool _formValido = false;

  bool validarEmail(String email) {
    if (email.contains('@')) {
      return false;
    }
    return true;
  }

  // bool validarNome(String nome) {
  //   if (nome.length > 2) {
  //     return false;
  //   }
  //   return true;
  // }

  void _atualizarFormularios() {
    _emailValido = validarEmail(_controllerEmail.text);
    _formKey.currentState!.validate();
  }

  @override
  void initState() {
    super.initState();
    _controllerEmail.addListener(_atualizarFormularios);
  }

  @override
  void dispose() {
    super.dispose();
    _controllerEmail.removeListener(_atualizarFormularios);
    _controllerEmail.dispose();
    _controllerNome.dispose();
    _controllerTelefone.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Página Inicial'),
      ),
      body: Column(
        children: [
          Form(
              key: _formKey,
              child: Padding(
                padding: const EdgeInsets.fromLTRB(32, 10, 32, 10),
                child: Column(
                  children: [
                    TextFormField(
                      controller: _controllerNome,
                      decoration: InputDecoration(
                        errorStyle: TextStyle(
                          color: _formValido ? Colors.blueAccent : Colors.red,
                        ),
                        errorBorder: OutlineInputBorder(borderSide: BorderSide(color: _formValido ? Colors.blueAccent : Colors.red, )),
                        label: Text('Nome Completo'),
                        border: OutlineInputBorder(),
                      ),
                      onChanged: (value){
                        setState(() {
                          _formValido = value.isNotEmpty;
                        });
                      },
                      validator: (String? nome) {
                        if (nome == null || nome!.isEmpty) {
                          return 'Por favor preencha o campo';
                        } else {
                          return 'Nome válido';
                        }
                      },
                    ),
                    SizedBox(height: 30,),
                    TextFormField(
                      controller: _controllerEmail,
                      decoration: InputDecoration(
                        errorStyle: TextStyle(
                          color: _formValido ? Colors.blueAccent : Colors.red,
                        ),
                        errorBorder: OutlineInputBorder(borderSide: BorderSide(color: _formValido ? Colors.blueAccent : Colors.red, )),
                        label: Text('E-mail'),
                        border: OutlineInputBorder(),
                      ),
                      onChanged: (value){
                        setState(() {
                          _formValido = value.isNotEmpty;
                        });
                      },
                      validator: (String? email) {
                        if (email == null && email!.isEmpty) {
                          return 'Por favor preencha o campo';
                        } else {
                          if (!validarEmail(email)) {
                            return 'E-mail Válido';
                          } else {
                            return 'E-mail Inválido';
                          }
                        }
                      },
                    ),
                  ],
                ),
              ))
        ],
      ),
    );
  }
}
