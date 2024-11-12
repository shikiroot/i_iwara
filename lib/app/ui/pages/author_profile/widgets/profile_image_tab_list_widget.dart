// import 'package:flutter/material.dart';
//
// class ProfileImageTabListWidget extends StatefulWidget {
//   final String tabKey;
//   final TabController tc;
//   final String userId;
//
//   const ProfileImageTabListWidget({
//     super.key,
//     required this.tabKey,
//     required this.tc,
//     required this.userId,
//   });
//
//   @override
//   _ProfileImageTabListWidgetState createState() => _ProfileImageTabListWidgetState();
//
// }
//
// class _ProfileImageTabListWidgetState extends State<ProfileImageTabListWidget> with AutomaticKeepAliveClientMixin {
//   @override
//   Widget build(BuildContext context) {
//     super.build(context);
//     final TabBar secondaryTabBar = TabBar(
//       controller: widget.tc,
//       labelColor: Colors.blue,
//       indicatorColor: Colors.blue,
//       indicatorSize: TabBarIndicatorSize.label,
//       indicatorWeight: 2.0,
//       isScrollable: false,
//       unselectedLabelColor: Colors.grey,
//       tabs: <Tab>[
//         // date
//         Tab(icon: Icon(Icons.calendar_today)),
//         // likes
//         Tab(icon: Icon(Icons.favorite)),
//         // views
//         Tab(icon: Icon(Icons.remove_red_eye)),
//         // popularity
//         Tab(icon: Icon(Icons.star)),
//         // trending
//         Tab(icon: Icon(Icons.trending_up)),
//       ],
//     );
//     return Column(
//       children: <Widget>[
//         secondaryTabBar,
//         Expanded(
//           child: TabBarView(
//             controller: widget.tc,
//             children: <Widget>[
//               // date
//               TabViewItem(Key(widget.tabKey + '0'), userId: widget.userId),
//               // likes
//               TabViewItem(Key(widget.tabKey + '1'), userId: widget.userId),
//               // views
//               TabViewItem(Key(widget.tabKey + '2'), userId: widget.userId),
//               // popularity
//               TabViewItem(Key(widget.tabKey + '3'), userId: widget.userId),
//               // trending
//               TabViewItem(Key(widget.tabKey + '4'), userId: widget.userId),
//             ],
//           ),
//         ),
//       ],
//     );
//   }
// }