import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:team_between_leaf/%08mainPage/clang_search_detail/search_bar.dart';
import 'package:team_between_leaf/%08mainPage/clang_search_detail/search_history.dart';
import 'package:team_between_leaf/%08mainPage/clang_search_detail/search_related.dart';
import 'package:team_between_leaf/%08mainPage/main_page_detail/main_screen.dart';
import 'package:team_between_leaf/core_services/provider.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  double _mainscreen = 1.0;
  double _searchscreen = 0.0;
  double _autosearchscreen = 0.0;

  @override
  Widget build(BuildContext context) {
    final searchProvider = Provider.of<SearchProvider>(context, listen: true);

    return Scaffold(
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 70),
            const SearchBarClang(),
            const SizedBox(height: 30),
            Expanded(
              child: Stack(
                children: [
                  AnimatedOpacity(
                    opacity: _mainscreen =
                        searchProvider.isMainScreenVisible ? 1.0 : 0.0,
                    duration: const Duration(milliseconds: 700),
                    child: Visibility(
                      visible: _mainscreen > 0,
                      child: const Column(
                        children: [
                          testMainPage(),
                        ],
                      ),
                    ),
                  ),
                  AnimatedOpacity(
                    opacity: _searchscreen =
                        searchProvider.isRecentLiveSearchVisible
                            ? 1.0
                            : 0.0, // 검색창 보이기
                    duration: const Duration(milliseconds: 700),
                    child: Visibility(
                      visible: _searchscreen > 0,
                      child: const Align(
                        alignment: Alignment.topCenter,
                        child: SingleChildScrollView(
                          child: Column(
                            children: [
                              SearchHistory(),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  AnimatedOpacity(
                    opacity: _autosearchscreen =
                        searchProvider.isRelatedSearchVisible ? 1.0 : 0.0,
                    duration: const Duration(milliseconds: 700),
                    child: Visibility(
                      visible: _autosearchscreen > 0,
                      child: const Align(
                        alignment: Alignment.topCenter,
                        child: SingleChildScrollView(
                          child: Column(
                            children: [
                              SearchRelated(),
                            ],
                          ),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
