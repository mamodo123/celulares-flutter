import 'package:flutter/material.dart';

import '../features/phones/phones.dart';
import '../features/profile/profile.dart';
import '../features/search/search.dart';

const homeItems = [
  HomeItem(PhonesScreen(), Icons.phone_android, 'Celulares'),
  HomeItem(SearchScreen(), Icons.search, 'Procurar'),
  HomeItem(ProfileScreen(), Icons.person, 'Perfil'),
];

class HomeItem {
  final Widget screen;
  final IconData icon;
  final String title;

  const HomeItem(this.screen, this.icon, this.title);
}
