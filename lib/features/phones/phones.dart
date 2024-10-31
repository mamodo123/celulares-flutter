import 'package:flutter/material.dart';
import 'package:phones/features/phones/models/phone.dart';

import '../../values/consts.dart';
import 'functions.dart';

class PhonesScreen extends StatefulWidget {
  final String? filter;

  const PhonesScreen({super.key, this.filter});

  @override
  State<PhonesScreen> createState() => _PhonesScreenState();
}

class _PhonesScreenState extends State<PhonesScreen> {
  late Future<List<Phone>> phonesWithDetailsFuture;

  @override
  void initState() {
    phonesWithDetailsFuture = fetchPhones(widget.filter);
    super.initState();
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
          return data.isEmpty
              ? const Center(
                  child: Text('Nenhum item encontrado'),
                )
              : ListView.builder(
                  itemCount: data.length,
                  itemBuilder: (context, index) {
                    final phone = data[index];
                    return GestureDetector(
                      onTap: () => openPhone(phone),
                      child: Card(
                        child: Padding(
                          padding: const EdgeInsets.all(10),
                          child: Row(
                            children: [
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      phone.nome,
                                      style: Theme.of(context)
                                          .textTheme
                                          .labelLarge,
                                    ),
                                    Text(phone.descricao.isEmpty
                                        ? 'Sem descrição'
                                        : phone.descricao.length > 50
                                            ? '${phone.descricao.substring(0, 50)}...'
                                            : phone.descricao),
                                  ],
                                ),
                              ),
                              Column(
                                children: [
                                  Image.network(
                                    '$imagesUrl${phone.destaque}',
                                    height: 100,
                                    errorBuilder: (BuildContext context,
                                        Object error, StackTrace? stackTrace) {
                                      return Container(
                                        width: 100,
                                        height: 100,
                                        color: Colors.white,
                                        child: const Placeholder(),
                                      );
                                    },
                                  ),
                                  Text('\$${phone.valor}'),
                                ],
                              )
                            ],
                          ),
                        ),
                      ),
                    );
                  });
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

  void openPhone(Phone phone) {
    Navigator.of(context).pushNamed('/home/phone', arguments: phone);
  }
}
