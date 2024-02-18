import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../../core/utils/enums/SortType.dart';
import '../../../blocs/bloc/products_bloc.dart';

class SortAndFilterWidget extends StatelessWidget {
  const SortAndFilterWidget({super.key});

  String getTitleForSortType(SortType sortType) {
    switch(sortType){
      case SortType.none:
        return "Don't sort";
      case SortType.albumId:
        return 'Sort by Album ID';

      case SortType.title:
        return 'Sort by Product Title';

    }
  }
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProductsBloc, ProductsState>(
        builder: (contextBloc, state) {
      if (state is ProductsLoadedState) {
        return Padding(
          padding: const EdgeInsets.all(10.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              DropdownButton<SortType>(
                value: state.selectedSortType,
                onChanged: (SortType? newValue) {
                  BlocProvider.of<ProductsBloc>(context).add(
                      SortProductsEvent(sortType: newValue ?? SortType.none));
                },
                items: SortType.values.map((SortType sortType) {
                  return DropdownMenuItem<SortType>(
                    value: sortType,
                    child: Text(getTitleForSortType(sortType)  ) );
                }).toList(),
              ),
              InkWell(
                onTap: (){
                  showAlbumsBottomSheet(context,state.allAlbumsId,(int? value){
                    BlocProvider.of<ProductsBloc>(context).add(
                        FilterByAlbumIdEvent(albumId: value ));
                  });
                },
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(4)),
                    border: Border.all(color: Colors.black,)
                  ),
                    child: Row(
                      children: [
                        Text("Tap To Filter by Album Id"),
                        Icon(Icons.navigate_next)
                      ],
                    )),
              )

            ],
          ),
        );
      }
      return Container();
    });
  }

}
void  showAlbumsBottomSheet(BuildContext context,List<int> uniqueAlbumIdsSet,Function(int?) onTap) {
  showModalBottomSheet(
    context: context,
    builder: (BuildContext context) {
      return Container(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                'All Albums',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: uniqueAlbumIdsSet.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    onTap: (){
                      onTap(uniqueAlbumIdsSet[index]);
                      Navigator.pop(context); // Close the bottom sheet

                    },
                    title: Text('Album ID: ${uniqueAlbumIdsSet.elementAt(index)}'),
                    // Add onTap functionality if needed
                  );
                },
              ),
            ),
            // Button to cancel the filter
            ElevatedButton(
              onPressed: () {
                onTap(null);


                Navigator.pop(context); // Close the bottom sheet
              },
              child: Text('Reset Filter'),
            ),
          ],
        ),
      );
    },
  );
}

