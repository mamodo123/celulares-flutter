import 'package:flutter/material.dart';

import '../../values/consts.dart';
import 'models/phone.dart';

class PhoneList extends StatelessWidget {
  final List<Phone> phones;

  const PhoneList({super.key, required this.phones});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: phones.length,
        itemBuilder: (context, index) {
          final phone = phones[index];
          return GestureDetector(
            onTap: () => openPhone(phone, context),
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
                            style: Theme.of(context).textTheme.labelLarge,
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
                          errorBuilder: (BuildContext context, Object error,
                              StackTrace? stackTrace) {
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
  }

  void openPhone(Phone phone, BuildContext context) {
    Navigator.of(context).pushNamed('/home/phone', arguments: phone);
  }
}
