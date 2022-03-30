import 'package:flutter/material.dart';

import '../../../config/colors.dart';
import '../../../widgets/cards/app_card.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({Key? key}) : super(key: key);

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  /// Search controller
  final TextEditingController _searchController = TextEditingController();

  /// Car code scan search result
  String _scanBarcode = "";

  /// On text changed
  void _onTextChangedSearch(String text) {}

  /// Reset search
  void _cancelSearch() {
    _searchController.text = "";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /// Search bar
            AppCard(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  /// Back arrow
                  IconButton(
                    onPressed: _cancelSearch,
                    icon: const Icon(Icons.search_off_sharp),
                  ),

                  /// Search TextField
                  Expanded(
                    child: TextField(
                      controller: _searchController,
                      onChanged: _onTextChangedSearch,
                      textInputAction: TextInputAction.search,
                      decoration: const InputDecoration(
                        hintText: "Search",
                        hintStyle: TextStyle(color: ColorsSet.grayLight),
                        border: InputBorder.none,
                        focusedBorder: InputBorder.none,
                        enabledBorder: InputBorder.none,
                        errorBorder: InputBorder.none,
                        disabledBorder: InputBorder.none,
                        contentPadding: EdgeInsets.all(4.0),
                      ),
                    ),
                  ),

                  /// Qrcode Search Icon
                  IconButton(
                    onPressed: () {},
                    icon: const Icon(Icons.qr_code_scanner),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
