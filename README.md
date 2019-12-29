# ksnotification
#### 1、借鉴iOS NotificationCenter实现消息广播，源码简洁明了只有80余行。
#### 2、简单4步实现消息的监听、广播、接收、销毁。
#### 3、除了简单易用还是简单易用


Use this package as a library
#### 1. Depend on it
Add this to your package's pubspec.yaml file:

dependencies:
  ksnotification: last

#### 2. Install it
You can install packages from the command line:

with Flutter:

$ flutter pub get

Alternatively, your editor might support flutter pub get. Check the docs for your editor to learn more.

#### 3. Import it
Now in your Dart code, you can use:


```
const String _kPriceChange = 'kPriceChange';

class _KSPackagesManagerPageState extends State<KSPackagesManagerPage> {
  String _price = '';

  @override
  void initState() {
    super.initState();
    /*1、添加监听*/
    KSNotificationCenter.shard()
        .addListener(_kPriceChange, _priceChangeCallback);
  }

  /*2、监听回调*/
  void _priceChangeCallback(dynamic price) {
    setState(() {
      _price = price;
    });
  }

  @override
  void dispose() {
    /*4、移除监听*/
    KSNotificationCenter.shard().removeListener(_kPriceChange, _priceChangeCallback);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    String iphone_price = '3889元';
    return Scaffold(
      appBar: KSAppBar.ks_init(title: widget.pageTitle),
      body: ListView(
        children: <Widget>[
          KSListTile.ks_init(title: _price, onTap: null),
          KSListTile.ks_init(
              title: '价格修改为（${iphone_price}）',
              onTap: () {
                /*3、发送消息*/
                KSNotificationCenter.shard().post(iphone_price, _kPriceChange);
              }),
        ],
      ),
    );
  }
}


```
