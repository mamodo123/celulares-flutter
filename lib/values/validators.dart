String? nameValidator(String? name) {
  if (name == null || name.isEmpty) {
    return 'Nome não pode ser vazio';
  }
  final fixedName = name.trim();
  if (fixedName.split(' ').length < 2) {
    return 'Por favor, coloque seu nome completo';
  }
  return null;
}

String? emailValidator(String? email) {
  if (email == null || email.isEmpty) {
    return 'Email não pode ser vazio';
  }

  final emailRegex = RegExp(r'^[\w\.-]+@[a-zA-Z\d\.-]+\.[a-zA-Z]{2,}$');

  if (!emailRegex.hasMatch(email)) {
    return 'Formato de email inválido';
  }

  return null;
}

String? passValidator(String? pass) {
  if (pass == null || pass.isEmpty) {
    return 'Senha não pode ser vazia';
  }
  if (pass.length < 6) {
    return 'Senha muito pequena.';
  }
  if (!RegExp(r'[A-Z]').hasMatch(pass)) {
    return 'A senha deve conter pelo menos uma letra maiúscula.';
  }
  if (!RegExp(r'[0-9]').hasMatch(pass)) {
    return 'A senha deve conter pelo menos um número.';
  }
  if (!RegExp(r'[!@#\$&*~]').hasMatch(pass)) {
    return 'A senha deve conter pelo menos um símbolo especial (!@#\$&*~).';
  }
  return null;
}
