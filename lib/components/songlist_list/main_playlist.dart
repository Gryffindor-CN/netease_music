import 'package:flutter/material.dart';
import '../../model/model.dart';
import './main_playlist_item.dart';

class PlaylistList extends StatefulWidget {
  PlaylistList({
    Key key,
    this.playlists,
    this.onMoreClick,
    this.onAddClick,
    @required this.title,
  }) : super(key: key);
  final List<PlayList> playlists;
  final String title;
  final VoidCallback onMoreClick;
  final VoidCallback onAddClick;

  @override
  _PlaylistListState createState() => _PlaylistListState();
}

class _PlaylistListState extends State<PlaylistList> {
  @override
  Widget build(BuildContext context) {
    assert(widget.title != null, 'title can\'t be null');
    return Padding(
        padding: EdgeInsets.all(0.0),
        child: _ExpansionPlaylistGroup(
          widget.title,
          widget.playlists,
          onMoreClick: widget.onMoreClick,
          onAddClick: widget.onAddClick,
        ));
  }
}

class _ExpansionPlaylistGroup extends StatefulWidget {
  _ExpansionPlaylistGroup(this.title, this.list,
      {this.onMoreClick, this.onAddClick});
  final String title;
  final List<PlayList> list;
  final VoidCallback onMoreClick;
  final VoidCallback onAddClick;
  @override
  _ExpansionPlaylistGroupState createState() => _ExpansionPlaylistGroupState();
}

class _ExpansionPlaylistGroupState extends State<_ExpansionPlaylistGroup>
    with SingleTickerProviderStateMixin {
  static final Animatable<double> _easeInTween =
      CurveTween(curve: Curves.easeIn);
  static final Animatable<double> _quarterTween =
      Tween<double>(begin: 0.0, end: 0.25);

  AnimationController _controller;

  Animation<double> _iconTurns;
  Animation<double> _heightFactor;

  bool _expanded;
  List<Widget> children = [];

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 150));
    _iconTurns = _controller.drive(_quarterTween.chain(_easeInTween));
    _heightFactor = _controller.drive(_easeInTween);

    _expanded = PageStorage.of(context)?.readState(context) ?? true;
    if (_expanded) {
      _controller.value = 1.0;
    }
    widget.list.asMap().forEach((int index, item) {
      children.add(PlaylistItem(
        playlist: item,
        onTap: (int id) {
          // 跳转到歌单详情
        },
      ));
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _handleTap() {
    setState(() {
      _expanded = !_expanded;
      if (_expanded) {
        _controller.forward();
      } else {
        _controller.reverse().then<void>((_) {
          if (mounted) {
            setState(() {}); //Rebuild without widget.children.
          }
        });
      }
      PageStorage.of(context)?.writeState(context, _expanded);
    });
  }

  Widget _buildChildren(BuildContext context, Widget child) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        _buildTitle(context),
        ClipRect(
          child: Align(
            heightFactor: _heightFactor.value,
            child: child,
          ),
        )
      ],
    );
  }

  Widget _buildTitle(BuildContext context) {
    return InkWell(
      onTap: _handleTap,
      child: Container(
        height: 40,
        child: Row(
          children: <Widget>[
            RotationTransition(
                turns: _iconTurns,
                child: Icon(
                  Icons.chevron_right,
                  size: 25,
                  color: Color(0xff4d4d4d),
                )),
            SizedBox(width: 4),
            Text('${widget.title}',
                style: Theme.of(context)
                    .textTheme
                    .title
                    .copyWith(fontWeight: FontWeight.bold, fontSize: 16)),
            SizedBox(width: 4),
            Text(
              '(${children.length})',
              style: Theme.of(context).textTheme.caption,
            ),
            Spacer(),
            widget.onAddClick == null
                ? Container()
                : IconButton(
                    iconSize: 24,
                    padding: EdgeInsets.all(4),
                    icon: Icon(Icons.add),
                    onPressed: widget.onAddClick),
            IconButton(
                padding: EdgeInsets.all(4),
                icon: Icon(Icons.more_vert),
                onPressed: widget.onMoreClick),
            SizedBox(width: 8),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final bool closed = !_expanded && _controller.isDismissed;
    return AnimatedBuilder(
      animation: _controller.view,
      builder: _buildChildren,
      child: closed ? null : Column(children: children),
    );
  }
}
