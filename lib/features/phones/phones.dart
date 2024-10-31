import 'package:flutter/material.dart';
import 'package:phones/features/phones/models/phone.dart';
import 'package:phones/features/phones/phoneList.dart';

import 'functions.dart';

enum SortCriteria { price, name }

class PhonesScreen extends StatefulWidget {
  final String? filter;

  const PhonesScreen({super.key, this.filter});

  @override
  State<PhonesScreen> createState() => _PhonesScreenState();
}

class _PhonesScreenState extends State<PhonesScreen> {
  late Future<List<Phone>> phonesWithDetailsFuture;
  SortCriteria? selectedCriteria;

  @override
  void initState() {
    phonesWithDetailsFuture = fetchPhones(widget.filter);
    selectedCriteria = SortCriteria.name;
    super.initState();
  }

  Future<List<Phone>> sortPhones(List<Phone> phones) async {
    if (selectedCriteria == SortCriteria.price) {
      phones.sort(
          (a, b) => (double.parse(a.valor) - double.parse(b.valor)).toInt());
    } else if (selectedCriteria == SortCriteria.name) {
      phones.sort((a, b) => a.nome.compareTo(b.nome));
    }
    return phones;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Phone>>(
      future: phonesWithDetailsFuture,
      builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          if (snapshot.error != null) {
            return Center(
                child: Text('Erro inesperado: \n${snapshot.error.toString()}'));
          }
          final data = snapshot.data as List<Phone>?;

          if (data == null) {
            return Container();
          }

          if (data.isEmpty) {
            return const Center(
              child: Text('Nenhum item encontrado'),
            );
          } else {
            return Column(
              children: [
                SizedBox(
                  height: 30,
                  child: Row(
                    children: [
                      const Text('Ordenação:'),
                      const Spacer(),
                      DropdownButton<SortCriteria>(
                        value: selectedCriteria,
                        items: const [
                          DropdownMenuItem(
                            value: SortCriteria.price,
                            child: Text('Preço'),
                          ),
                          DropdownMenuItem(
                            value: SortCriteria.name,
                            child: Text('Nome'),
                          ),
                        ],
                        onChanged: (SortCriteria? newValue) {
                          setState(() {
                            selectedCriteria = newValue;
                          });
                          phonesWithDetailsFuture =
                              Future.value(sortPhones(data));
                        },
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: FutureBuilder<List<Phone>>(
                    future: sortPhones(data),
                    builder: (context, sortedSnapshot) {
                      if (sortedSnapshot.connectionState ==
                          ConnectionState.done) {
                        final sortedData = sortedSnapshot.data ?? [];
                        return PhoneList(phones: sortedData);
                      } else {
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      }
                    },
                  ),
                ),
              ],
            );
          }
        } else if (snapshot.error != null) {
          return Center(
              child: Text('Erro inesperado: \n${snapshot.error.toString()}'));
        } else {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }
}
