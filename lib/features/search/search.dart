import 'dart:async';

import 'package:flutter/material.dart';
import 'package:phones/features/phones/phones.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final TextEditingController _searchController = TextEditingController();
  Timer? _debounce;
  String? searching;
  final List<String> searchingHistory = [];

  void _onSearchChanged(String query) {
    if (_debounce?.isActive ?? false) _debounce!.cancel();

    _debounce = Timer(const Duration(milliseconds: 300), () {
      if (query.trim().isEmpty) {
        setState(() {
          searching = null;
        });
      } else {
        setState(() {
          searchingHistory.add(query);
          searching = query;
        });
      }
    });
  }

  void _clearSearch() {
    _searchController.clear();
    setState(() {
      searching = null;
    });
  }

  void _removeHistoryItem(String item) {
    setState(() {
      searchingHistory.remove(item);
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    _debounce?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextField(
          controller: _searchController,
          onChanged: _onSearchChanged,
          decoration: InputDecoration(
            hintText: 'Buscar celular',
            suffixIcon: IconButton(
              icon: Icon(searching != null && searching!.isNotEmpty
                  ? Icons.clear
                  : Icons.search),
              onPressed: searching != null && searching!.isNotEmpty
                  ? _clearSearch
                  : null,
            ),
          ),
        ),
        if (searching == null || searching!.isEmpty)
          Expanded(
            child: searchingHistory.isEmpty
                ? const Center(
                    child: Text('Nenhum item no histórico de busca'),
                  )
                : ListView.builder(
                    itemCount: searchingHistory.length,
                    itemBuilder: (context, index) {
                      final item =
                          searchingHistory[searchingHistory.length - 1 - index];
                      return ListTile(
                        title: Text(item),
                        trailing: IconButton(
                          icon: const Icon(Icons.clear),
                          onPressed: () => _removeHistoryItem(item),
                        ),
                        onTap: () {
                          _searchController.text = item;
                          _onSearchChanged(item);
                        },
                      );
                    },
                  ),
          ),
        if (searching != null && searching!.isNotEmpty)
          Expanded(
            child: PhonesScreen(
              filter: searching,
            ),
          ),
      ],
    );
  }
}
