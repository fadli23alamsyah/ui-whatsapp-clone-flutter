import 'package:flutter/material.dart';
import 'package:whatsapp_clone/constant.dart';
import 'package:whatsapp_clone/screens/call_tab.dart';
import 'package:whatsapp_clone/screens/camera_tab.dart';
import 'package:whatsapp_clone/screens/chats_tab.dart';
import 'package:whatsapp_clone/screens/status_tab.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({ Key? key }) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with SingleTickerProviderStateMixin{

  late TabController cTab;
  late ScrollController cScroll;
  int tabIndex = 1;

  @override
  void initState() {
    super.initState();
    cTab = TabController(length: 4, vsync: this, initialIndex: 1);
    cScroll = ScrollController();
  }

  @override
  void dispose() {
    cTab.dispose();
    super.dispose();
  }
  

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double yourWidth = width  / 5;

    cTab.addListener(() {
      setState(() {
        tabIndex = cTab.index;
      });
    });

    return Scaffold(
      backgroundColor: Colors.white,
      floatingActionButton: 
      (tabIndex == 1) ?
        FloatingActionButton(
          backgroundColor: mainColor,
          onPressed: (){},
          child: const Icon(Icons.add),
        ) : (tabIndex == 2) ?
        Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            FloatingActionButton(
              mini: true,
              backgroundColor: Colors.blueGrey[100],
              onPressed: (){},
              child: const Icon(Icons.edit, color: Colors.blueGrey,),
            ),
            const SizedBox(height: 15,),
            FloatingActionButton(
              backgroundColor: mainColor,
              onPressed: (){},
              child: const Icon(Icons.add_a_photo_rounded),
            ),
          ],
        ) : (tabIndex == 3) ?
        FloatingActionButton(
          backgroundColor: mainColor,
          onPressed: (){},
          child: const Icon(Icons.add_call),
        ) : null,
      body: NestedScrollView(
        floatHeaderSlivers: true,
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
          return <Widget>[
            SliverOverlapAbsorber(
              handle: NestedScrollView.sliverOverlapAbsorberHandleFor(context),
              sliver: SliverSafeArea(
                top: false,
                sliver: SliverAppBar(
                  pinned: true,
                  floating: true,
                  snap: true,
                  backgroundColor: mainColor,
                  title: const Text("Whyapp"),
                  actions: [
                    IconButton(
                      onPressed: (){}, 
                      // splashRadius: 20,
                      icon: const Icon(Icons.search)
                    ),
                    (tabIndex == 1)?
                    PopupMenuButton(
                      itemBuilder: (BuildContext context) {
                      return [
                        const PopupMenuItem(child: Text("New Group"),),
                        const PopupMenuItem(child: Text("New Broadcast"),),
                        const PopupMenuItem(child: Text("Whyapp Web"),),
                        const PopupMenuItem(child: Text("Settings"),),
                      ];
                    }) : const SizedBox(width: 0,),
                  ],
                  bottom: TabBar(
                    controller: cTab,
                    indicatorColor: Colors.white,
                    isScrollable: true,
                    tabs: <Widget>[
                        Container(
                          width: 35,
                          height:45,
                          alignment: Alignment.center,
                          child: const Icon(
                            Icons.camera_alt,
                          ),
                        ),
                        Container(
                          width: yourWidth,
                            height:45,
                            alignment: Alignment.center,
                            child: const Text("CHATS")),
                        Container(
                            width: yourWidth,
                            height:45,
                            alignment: Alignment.center,
                            child: const Text("STATUS")),
                        Container(
                            width: yourWidth,
                            height:45,
                            alignment: Alignment.center,
                            child: const Text("CALL"))
                      ],
                  ),
                ),
              ),
            )
          ];
        },
        body: TabBarView(
          controller: cTab,
          children: const [
            CameraTab(),
            ChatsTab(),
            StatusTab(),
            CallTab()
          ],
        ),
      ),
    );
  }
}