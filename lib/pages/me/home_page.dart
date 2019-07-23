import 'package:flutter/material.dart';
import '../../components/musicplayer/inherited_demo.dart';
import '../../router/Routes.dart';

class MeHomePage extends StatefulWidget {
  @override
  MeHomePageState createState() => MeHomePageState();
}

class MeHomePageState extends State<MeHomePage>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    return Navigator(
      initialRoute: '/',
      onGenerateRoute: (RouteSettings settings) {
        RoutePageBuilder builder;
        switch (settings.name) {
          case '/':
            builder = (_, __, ___) => MeHomeContainer(
                  pageContext: context,
                );
            break;
          default:
            throw Exception('Invalid route: ${settings.name}');
        }
        return PageRouteBuilder(
          pageBuilder: builder,
        );
      },
    );
  }
}

class MeHomeContainer extends StatefulWidget {
  final BuildContext pageContext;
  MeHomeContainer({Key key, this.pageContext}) : super(key: key);

  @override
  MeHomeContainerState createState() => MeHomeContainerState();
}

class MeHomeContainerState extends State<MeHomeContainer> {
  @override
  Widget build(BuildContext context) {
    final store = StateContainer.of(context);
    return Scaffold(
        backgroundColor: Theme.of(context).primaryColor,
        appBar: AppBar(
          elevation: 0.0,
          leading: Icon(Icons.mic),
          centerTitle: true,
          title: Text('我的音乐'),
          actions: (store.player != null && store.player.playingList.length > 0)
              ? <Widget>[
                  IconButton(
                    onPressed: () {
                      Routes.router
                          .navigateTo(widget.pageContext, '/albumcoverpage');
                    },
                    icon: Icon(Icons.equalizer),
                  )
                ]
              : [],
        ));
  }
}
