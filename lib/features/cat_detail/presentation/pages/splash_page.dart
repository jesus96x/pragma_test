import 'dart:developer';

import 'package:app_cats/features/cat_detail/application/cat_data_state.dart';
import 'package:app_cats/features/cat_detail/presentation/pages/home_page.dart';
import 'package:app_cats/features/cat_detail/shared/providers.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SplashPage extends ConsumerStatefulWidget {
  /// Constructor
  const SplashPage({Key? key}) : super(key: key);

  @override
  ConsumerState<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends ConsumerState<SplashPage> {
  Future<void> init() async {
    await ref.read(localStorageServiceProvider).init();
  }

  @override
  void initState() {
    Future.microtask(() => init());
    super.initState();
    Future.microtask(() => ref.read(catsNotifierProvider.notifier).getCats());
  }

  @override
  Widget build(BuildContext context) {
    ref.listen(
      catsNotifierProvider,
      (previus, CatDataState state) {
        state.maybeWhen(
          data: (_) => Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const HomePage()),
          ),
          error: (_) => log('Error $_'),
          orElse: () => const SizedBox(),
        );
      },
    );

    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        padding: const EdgeInsets.all(40),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                'Cambered',
                style: TextStyle(fontSize: 25),
              ),
              const SizedBox(height: 40),
              CachedNetworkImage(
                  imageUrl:
                      'https://www.educima.com/imagen-gato-negro-dm17884.jpg')
            ],
          ),
        ),
      ),
    );
  }
}
