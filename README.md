# ksnotification
#### 1、借鉴iOS NotificationCenter实现消息广播，源码简洁明了只有80余行。
#### 2、简单5步实现消息的监听、广播、接收、监听销毁。
#### 3、除了简单易用还是简单易用

Use this package as a library
#### 1. Depend on it
Add this to your package's pubspec.yaml file:

dependencies:
  ksnotification: ^0.0.4

#### 2. Install it
You can install packages from the command line:

with Flutter:

$ flutter pub get

Alternatively, your editor might support flutter pub get. Check the docs for your editor to learn more.

#### 3. Import it
Now in your Dart code, you can use:

import 'package:ksnotification/ksnotification.dart';


	/*1、接口实现*/
	class _MyHomePageState extends State<MyHomePage> implements KSObserver {
	  int _counter = 0;
	  static const String increment_counter = 'increment_counter';
	
	  @override
	  void initState() {
	    super.initState();
	    /*2、添加监听*/
	    KSNotificationCenter.shard().addObserver(this, increment_counter);
	  }
	
	  @override
	  void dispose() {
	    /*5、移除监听*/
	    KSNotificationCenter.shard().removeObserver(this, increment_counter);
	    super.dispose();
	  }
	
	  /*4、接收监听消息*/
	  @override
	  receiveNotify(Map message, String name) {
	    if (name == increment_counter){
	      int value = message['num'] as int;
	      setState(() {
	        _counter += value;
	      });
	    }
	  }
	
	  void _incrementCounter() {
	    /*3、发送通知广播*/
	    KSNotificationCenter.shard().post({'num':100}, increment_counter);
	  }
	
	  @override
	  Widget build(BuildContext context) {
	    return Scaffold(
	      appBar: AppBar(
	        title: Text(widget.title),
	      ),
	      body: Center(
	        child: Column(
	          mainAxisAlignment: MainAxisAlignment.center,
	          children: <Widget>[
	            Text(
	              'You have pushed the button this many times:',
	            ),
	            Text(
	              '$_counter',
	              style: Theme.of(context).textTheme.display1,
	            ),
	          ],
	        ),
	      ),
	      floatingActionButton: FloatingActionButton(
	        onPressed: _incrementCounter,
	        tooltip: 'Increment',
	        child: Icon(Icons.add),
	      ), // This trailing comma makes auto-formatting nicer for build methods.
	    );
	  }
	}
