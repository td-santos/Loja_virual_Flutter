import 'package:flutter/material.dart';
import 'package:virtual_store/models/section.dart';
import 'package:virtual_store/screens/home/components/item_tile.dart';
import 'package:virtual_store/screens/home/components/section_header.dart';

class SectionList extends StatelessWidget {

  final Section section;

  const SectionList({Key key, this.section}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16,vertical: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          SectionHeader(section: section),
          SizedBox(
            height: 150,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              itemCount: section.items.length,
              separatorBuilder: (_,__)=> SizedBox(width: 4,),
              itemBuilder: (_, index){
                return ItemTile(
                  item: section.items[index],
                );
              },
            )
          )
        ],
      ),
    );
  }
}