import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:qiitaapp/models/Item.dart';
import 'package:qiitaapp/models/user.dart';
import 'package:qiitaapp/qiita_repository.dart';
import 'package:qiitaapp/screens/sign_in/sign_in_screen.dart';
import 'package:qiitaapp/screens/user_screen.dart';

import 'item_screen.dart';

class ItemListScreen extends StatefulWidget {
  ItemListScreen({Key key}) : super(key: key);

  @override
  _ItemListScreenState createState() => _ItemListScreenState();
}

class _ItemListScreenState extends State<ItemListScreen> {
  int _currentPage = 1;
  bool _isLoading = false;
  List<Item> _itemList;
  Object _error;

  @override
  void initState() {
    super.initState();
    _loadItemList(1);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text('Qiita App'),
        actions: [
          FutureBuilder<User>(
            future: QiitaReposity().getAuthenticatedUser(),
            builder: (contex, snapshot) {
              final Widget icon = snapshot.hasData
                  ? _UserProfileIcon(
                      size: 32,
                      profileImageUrl: snapshot.data.profileImageUrl,
                    )
                  : Icon(Icons.person);
              return PopupMenuButton(
                  icon: icon,
                  onSelected: (value) {
                    if (value == 'profile') {
                      _onProfileMenuIsSelected(snapshot.data);
                    } else if (value == 'logout') {
                      _onLogoutMenuIsSelected();
                    }
                  },
                  itemBuilder: (context) {
                    return [
                      PopupMenuItem(
                        value: 'profile',
                        child: Text('プロフィール'),
                      ),
                      PopupMenuItem(
                        value: 'logout',
                        child: Text('ログアウト'),
                      )
                    ];
                  });
            },
          ),
        ],
      ),
      body: _buildBody(),
    );
  }

  Widget _buildBody() {
    if (_error != null) {
      return Center(
        child: Text(_error.toString()),
      );
    }

    if (_itemList != null) {
      return _ItemListView(
        itemList: _itemList,
        onTapItem: (item) {
          Navigator.of(context).push(
            MaterialPageRoute(builder: (_) => ItemScreen(item: item)),
          );
        },
        onTapUser: (user) {
          Navigator.of(context).push(
            MaterialPageRoute(builder: (_) => UserScreen(user: user)),
          );
        },
        onScrollEnd: () {
          if (_isLoading == false) {
            _loadItemList(_currentPage + 1);
          }
        },
      );
    }

    return Center(
      child: CircularProgressIndicator(),
    );
  }

  void _loadItemList(int page) async {
    setState(() {
      _isLoading = true;
    });

    try {
      final List<Item> itemList = await QiitaReposity().getItemList(page: page);
      setState(() {
        if (page == 1) {
          _itemList = itemList;
        } else {
          _itemList.addAll(itemList);
        }
      });
    } catch (e) {
      setState(() {
        _error = e;
      });
    }
    setState(() {
      _isLoading = false;
    });
  }

  void _onProfileMenuIsSelected(User user) {
    Navigator.of(context)
        .push(MaterialPageRoute(builder: (_) => UserScreen(user: user)));
  }

  void _onLogoutMenuIsSelected() async {
    await QiitaReposity().revokeSavedAccessToken();
    await QiitaReposity().deleteAccessToken();
    Navigator.of(context)
        .push(MaterialPageRoute(builder: (_) => SignInScreen()));
  }
}

class _ItemListView extends StatelessWidget {
  final List<Item> itemList;
  final Function(Item item) onTapItem;
  final Function(User user) onTapUser;
  final Function() onScrollEnd;

  const _ItemListView({
    Key key,
    this.itemList,
    this.onTapItem,
    this.onTapUser,
    this.onScrollEnd,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return NotificationListener<ScrollNotification>(
      onNotification: (ScrollNotification notification) {
        if (notification.metrics.extentAfter == 0.0) {
          onScrollEnd();
        }
        return true;
      },
      child: ListView.separated(
          itemBuilder: (context, index) {
            final Item item = itemList[index];
            return InkWell(
              onTap: () => onTapItem(item),
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 4),
                child: ListTile(
                  key: ValueKey(item.id),
                  leading: GestureDetector(
                    onTap: () => onTapUser(item.user),
                    child: _UserProfileIcon(
                      size: 48,
                      profileImageUrl: item.user.profileImageUrl,
                    ),
                  ),
                  title: Text(item.title),
                  subtitle: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Container(
                        width: 120,
                        child: Text(
                          item.user.id,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      SizedBox(
                        width: 8,
                      ),
                      Text(DateFormat.Md().add_jm().format(item.createdAt))
                    ],
                  ),
                  trailing: _LikeCountBadge(likesCount: item.likesCount),
                ),
              ),
            );
          },
          separatorBuilder: (context, index) {
            return Divider(
              height: 1,
            );
          },
          itemCount: itemList.length),
    );
  }
}

class _UserProfileIcon extends StatelessWidget {
  final double size;
  final String profileImageUrl;

  const _UserProfileIcon({
    Key key,
    this.size,
    this.profileImageUrl,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(4),
      child: Image.network(
        profileImageUrl,
        width: size,
        height: size,
        errorBuilder: (context, error, stackTrace) {
          return Container(
            width: size,
            height: size,
            color: Colors.grey,
          );
        },
      ),
    );
  }
}

class _LikeCountBadge extends StatelessWidget {
  final int likesCount;
  const _LikeCountBadge({Key key, this.likesCount}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipOval(
      child: Container(
        width: 20,
        height: 20,
        color: (likesCount > 0) ? Theme.of(context).primaryColor : Colors.grey,
        child: Center(
          child: Text(
            '$likesCount',
            style: TextStyle(color: Colors.white, fontSize: 12),
          ),
        ),
      ),
    );
  }
}
