part of '../view/home_view.dart';

final class _HomeList extends StatelessWidget {
  const _HomeList({required this.homeList});

  final List<HomeModel> homeList;

  @override
  Widget build(BuildContext context) {
    return homeList.isNotEmpty
        ? ListView.builder(
            itemCount: homeList.length,
            padding: EdgeInsets.all(Paddings.high.padding),
            itemBuilder: (context, index) => Card(
              color: Colors.teal,
              child: ListTile(
                leading: Text('${index + 1}'),
                title: Text(homeList[index].name ?? ''),
              ),
            ),
          )
        : const Center(child: Text(ProductConstants.emptyMessage));
  }
}
