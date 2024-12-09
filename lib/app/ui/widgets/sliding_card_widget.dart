import 'package:flutter/material.dart';
import 'package:get/get.dart';

/// TODO: SlidingCard 需要重构?
/// Effect similar to a sheet.
/// Use with Stack to occupy the entire area.
/// Example:
/// ```dart
/// Stack(
///   children: [
///     // List view
///     SingleChildScrollView(
///       child: Column(
///         children: List.generate(
///           20,
///           (index) => ListTile(title: Text('Item $index')),
///         ),
///       ),
///     ),
///     // SlidingCard
///     SlidingCard(
///       isVisible: _isCardVisible,
///       onDismiss: _dismissCard,
///       title: Row(
///         children: [
///           Title(
///             color: Colors.black,
///             child: Text('Card Title'),
///           ),
///           Spacer(),
///           IconButton(
///             icon: Icon(Icons.close),
///             onPressed: _dismissCard,
///           ),
///           Divider(),
///         ],
///       ),
///       child: SingleChildScrollView(
///         child: Column(
///           children: List.generate(
///             20,
///             (index) => ListTile(title: Text('Card Item $index')),
///           ),
///         ),
///       ),
///     ),
///   ],
/// )
/// ```
class SlidingCard extends StatefulWidget {
  final bool isVisible;
  final VoidCallback onDismiss;
  final Widget child;
  final Widget? title;
  final List<Widget>? actions;

  const SlidingCard({
    super.key,
    required this.isVisible,
    required this.onDismiss,
    required this.child,
    this.title,
    this.actions,
  });

  @override
  _SlidingCardState createState() => _SlidingCardState();
}

class _SlidingCardState extends State<SlidingCard>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<Offset> _slideAnimation;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    );

    _slideAnimation = Tween<Offset>(
      begin: const Offset(0, 1),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeInOut,
    ));

    _fadeAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeInOut,
    ));

    if (widget.isVisible) {
      _animationController.forward();
    }
  }

  @override
  void didUpdateWidget(covariant SlidingCard oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.isVisible != oldWidget.isVisible) {
      if (widget.isVisible) {
        _animationController.forward();
      } else {
        _animationController.reverse();
      }
    }
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  Future<void> _handleDismiss() async {
    await _animationController.reverse();
    widget.onDismiss();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animationController,
      builder: (context, child) {
        if (_animationController.value == 0 && !widget.isVisible) {
          return const SizedBox.shrink();
        }
        return Positioned.fill(
          child: GestureDetector(
            onVerticalDragUpdate: (details) {
              _animationController.value -=
                  details.primaryDelta! / MediaQuery.of(context).size.height;
            },
            onVerticalDragEnd: (details) {
              if (_animationController.value < 0.8) {
                _handleDismiss();
              } else {
                _animationController.forward();
              }
            },
            child: SlideTransition(
              position: _slideAnimation,
              child: FadeTransition(
                opacity: _fadeAnimation,
                child: SafeArea(
                  child: Card(
                    margin: EdgeInsets.zero,
                    shape: const RoundedRectangleBorder(
                      borderRadius:
                          BorderRadius.vertical(top: Radius.circular(20)),
                    ),
                    elevation: 8,
                    child: Column(
                      children: [
                        SizedBox(
                          height: 40,
                          child: Center(
                            child: Container(
                              width: 50,
                              height: 5,
                              decoration: BoxDecoration(
                                color: Colors.grey[400],
                                borderRadius: BorderRadius.circular(2.5),
                              ),
                            ),
                          ),
                        ),
                        if (widget.title != null) ...[
                          widget.title!,
                          const Divider(),
                        ],
                        // 添加一个最大高度限制
                        Expanded(
                          child: ConstrainedBox(
                            constraints: BoxConstraints(
                              maxHeight: MediaQuery.sizeOf(context).height,
                            ),
                            child: widget.child,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
