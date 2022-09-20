import 'package:app_cats/features/cat_detail/shared/providers.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class HomePage extends ConsumerStatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  ConsumerState<HomePage> createState() => _HomePageState();
}

class _HomePageState extends ConsumerState<HomePage> {
  @override
  Widget build(BuildContext context) {
    final state = ref.watch(catsNotifierProvider);
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        padding: const EdgeInsets.all(8),
        child: state.maybeWhen(
          data: (cats) {
            return ListView.builder(
                itemBuilder: (_, index) => Column(
                      children: [
                        Text(
                          'Name: ${cats[index].name}',
                          style: const TextStyle(fontSize: 16),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        CachedNetworkImage(
                          imageUrl: cats[index].image?.url ?? '',
                          placeholder: (_, __) => const SizedBox(
                            height: 260,
                            width: double.infinity,
                            child: Center(
                              child: CircularProgressIndicator(),
                            ),
                          ),
                          errorWidget: (_, __, error) => const SizedBox(
                            height: 260,
                            width: double.infinity,
                            child: Icon(
                              Icons.error,
                            ),
                          ),
                          imageBuilder: (_, image) => Container(
                            height: 260,
                            width: double.infinity,
                            decoration: BoxDecoration(
                                image: DecorationImage(image: image)),
                          ),
                        ),
                      ],
                    ));
          },
          orElse: () => const SizedBox(),
        ),
      ),
    );
  }
}
