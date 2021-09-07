part of carp_study_app;

class HorizontalBar extends StatelessWidget {
  final List<String>? names;
  final List<int>? values;
  final List<Color>? colors;

  HorizontalBar({this.names, this.values, this.colors});

  List<MyAsset> _assetList() {
    List<MyAsset> assetList = [];
    for (int i = 0; i < this.names!.length; i++) {
      print('assets');
      print(values!.elementAt(i));
      print(colors!.elementAt(i));
      print(names!.elementAt(i));
      assetList
          .add(MyAsset(size: values!.elementAt(i), color: colors!.elementAt(i), name: names!.elementAt(i)));
    }
    return assetList;
  }

  Widget build(BuildContext context) {
    AssetLocalizations locale = AssetLocalizations.of(context)!;
    double width = MediaQuery.of(context).size.width;
    if (names!.isEmpty)
      return Center(child: Text(locale.translate("No data yet")));
    else
      return Center(
        child: MyAssetsBar(
            width: width * .9,
            background: Color(0xCFD8DC),
            order: OrderType.Descending,
            assets: _assetList()),
      );
  }
}

const double _kHeight = 25;
enum OrderType { Ascending, Descending, None }
/*Utils*/

class MyAsset {
  final int? size;
  final Color? color;
  final String? name;

  MyAsset({this.size, this.color, this.name});
}

class MyAssetsBar extends StatelessWidget {
  MyAssetsBar(
      {Key? key,
      required this.width,
      this.height = _kHeight,
      this.radius,
      required this.assets,
      this.order,
      this.background = Colors.grey})
      : super(key: key);

  final double width;
  final double height;
  final double? radius;
  final List<MyAsset> assets;
  final OrderType? order;
  final Color background;

  double _getValuesSum() {
    double sum = 0;
    assets.forEach((single) => sum += single.size!);
    return sum;
  }

  void orderMyAssetsList() {
    switch (order) {
      case OrderType.Ascending:
        {
          //From the smallest to the largest
          assets.sort((a, b) {
            return a.size!.compareTo(b.size!);
          });
          break;
        }
      case OrderType.Descending:
        {
          //From largest to smallest
          assets.sort((a, b) {
            return b.size!.compareTo(a.size!);
          });
          break;
        }
      case OrderType.None:
      default:
        {
          break;
        }
    }
  }

  //single.size : assetsSum = x : width
  Widget _createSingle(MyAsset singleAsset) {
    return SizedBox(
      width: singleAsset.size! != 0 ? singleAsset.size! * (width / _getValuesSum()) : 0,
      child: Container(color: singleAsset.color),
    );
  }

  @override
  Widget build(BuildContext context) {
    AssetLocalizations locale = AssetLocalizations.of(context)!;

    //Order assetsList
    orderMyAssetsList();

    final double rad = radius ?? (height / 2);
    // if (assets.isEmpty)
    //   return Center(child: Text(locale.translate("No data yet")));
    // else
    print("@@@@");
    print(assets);
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        ClipRRect(
          borderRadius: BorderRadius.all(Radius.circular(rad)),
          child: Container(
            decoration: BoxDecoration(color: background),
            width: width,
            height: height,
            child: Row(children: assets.map((singleAsset) => _createSingle(singleAsset)).toList()),
          ),
        ),
        SizedBox(height: 10),
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: assets
              .asMap()
              .entries
              .map(
                (entry) => Padding(
                  padding: EdgeInsets.symmetric(vertical: 3, horizontal: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Icon(Icons.circle, color: entry.value.color, size: 12.0),
                      Text(' ' + entry.value.name! + ' ' + entry.value.size.toString(),
                          style: legendStyle, textAlign: TextAlign.right),
                    ],
                  ),
                ),
              )
              .toList(),
        ),
      ],
    );
  }
}
