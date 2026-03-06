import 'package:calendar/widgets/festvial_card.dart';
import 'package:flutter/material.dart';

class FestivalAndSolarTermsScreen extends StatelessWidget {

  FestivalAndSolarTermsScreen({super.key});

  final  DateTime dateTime = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return Hero(tag: festivalHeroTag, child: Material(child: 
    CustomScrollView(
      slivers: [
        SliverAppBar(
          floating: true,
          pinned: true,
          expandedHeight: 120,
          flexibleSpace: FlexibleSpaceBar(
            title: Text('节日倒数'),
            centerTitle: false,
            titlePadding: .only(left: 16),
          ),
          title: Text('节日倒数'),
          centerTitle: true,
        ),
        SliverFillRemaining(
          hasScrollBody: true,
        )
      ],
    )));
  }
}