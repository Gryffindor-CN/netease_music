import 'package:flutter/material.dart';

class SearchPage extends StatefulWidget {
  @override
  SearchPageState createState() => SearchPageState();
}

class SearchPageState extends State<SearchPage> {
  final TextEditingController _textEditingController = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Container(
          width: 250.0,
          height: 36.0,
          child: TextField(
            onChanged: (value) {
              print(value);
            },
            controller: _textEditingController,
            autofocus: true,
            style: TextStyle(
              fontSize: 16.0,
            ),
            decoration: InputDecoration(
              contentPadding: EdgeInsets.symmetric(vertical: 2.0),
              prefixIcon: Icon(
                Icons.search,
                color: Colors.white24,
              ),
              hintText: 'Seach...',
              filled: true,
              border: OutlineInputBorder(
                  borderSide: BorderSide(
                    width: 0,
                    style: BorderStyle.none,
                  ),
                  borderRadius: BorderRadius.all(Radius.circular(40.0))),
              fillColor: Colors.white12,
              hintStyle: TextStyle(color: Colors.white30),
            ),
          ),
        ),
      ),
      body: CustomScrollView(physics: BouncingScrollPhysics(), slivers: [
        SearchHistory([
          Music(name: '喜帖街', id: 541641564),
          Music(name: '喜帖街', id: 541641564),
          Music(name: '喜帖街', id: 541641564),
          Music(name: '喜帖街', id: 541641564),
          Music(name: '喜帖街', id: 541641564),
          Music(name: '喜帖街', id: 541641564),
          Music(name: '喜帖街', id: 541641564),
          Music(name: '喜帖街', id: 541641564),
          Music(name: '喜帖街', id: 541641564),
          Music(name: '喜帖街', id: 541641564),
          Music(name: '喜帖街', id: 541641564),
        ]),
      ]
          // child: Column(
          //   children: <Widget>[
          //     SearchHistory([
          //       Music(name: '喜帖街', id: 541641564),
          //       Music(name: '喜帖街', id: 541641564),
          //       Music(name: '喜帖街', id: 541641564),
          //       Music(name: '喜帖街', id: 541641564),
          //       Music(name: '喜帖街', id: 541641564),
          //       Music(name: '喜帖街', id: 541641564),
          //       Music(name: '喜帖街', id: 541641564),
          //       Music(name: '喜帖街', id: 541641564),
          //       Music(name: '喜帖街', id: 541641564),
          //       Music(name: '喜帖街', id: 541641564),
          //     ])
          //   ],
          // ),
          ),
    );
  }
}

class Music {
  final String name;
  final int id;

  Music({@required this.name, @required this.id});
}

class SearchHistory extends StatelessWidget {
  final List<Music> songlist;
  SearchHistory(this.songlist);

  @override
  Widget build(BuildContext context) {
    // return Container(
    //   width: MediaQuery.of(context).size.width,
    //   padding: EdgeInsets.all(15.0),
    //   child: Column(
    //     children: <Widget>[
    //       Row(
    //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
    //         children: <Widget>[
    //           Text('历史记录'),
    //           IconButton(
    //             icon: Icon(Icons.delete_forever),
    //             onPressed: () {},
    //           )
    //         ],
    //       ),
    //       Container(
    //         height: 40.0,
    //         // width: 300.0,
    //         child: GridView.builder(
    //             scrollDirection: Axis.horizontal,
    //             itemCount: songlist.length,
    //             itemBuilder: (BuildContext context, int index) {
    //               return InkResponse(
    //                 onTap: () {},
    //                 child: Container(
    //                   alignment: Alignment.center,
    //                   padding: EdgeInsets.all(10.0),
    //                   decoration: BoxDecoration(
    //                       color: Colors.grey,
    //                       borderRadius:
    //                           BorderRadius.all(Radius.circular(10.0))),
    //                   child: Text(songlist[index].name),
    //                 ),
    //               );
    //             },
    //             gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
    //                 crossAxisCount: songlist.length,
    //                 mainAxisSpacing: 4.0,
    //                 crossAxisSpacing: 20.0)),
    //       )
    //     ],
    //   ),
    // );
    return SliverToBoxAdapter(
      child: Column(
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text('历史记录'),
              IconButton(
                icon: Icon(Icons.delete_forever),
                onPressed: () {},
              )
            ],
          ),
          Padding(
            padding: EdgeInsets.all(15.0),
            // height: 80.0,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              physics: BouncingScrollPhysics(),
              itemCount: songlist.length,
              itemBuilder: (BuildContext context, int index) {
                return Container(
                  width: 60.0,
                  height: 20.0,
                  margin: EdgeInsets.symmetric(horizontal: 12.0),
                  alignment: Alignment.center,
                  // padding: EdgeInsets.all(10.0),
                  decoration: BoxDecoration(color: Colors.grey),
                  child: Text(songlist[index].name),
                );
              },
            ),
          )
        ],
      ),
    );
    // return SliverGrid(

    //   gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
    //     maxCrossAxisExtent: 500.0,
    //     mainAxisSpacing: 0.0,
    //     crossAxisSpacing: 0.0,
    //     childAspectRatio: 1.0,
    //   ),
    //   delegate: SliverChildBuilderDelegate(
    //     (BuildContext context, int index) {
    //       return ;
    //     },
    //     childCount: 1,
    //   ),
    // );
  }
}
