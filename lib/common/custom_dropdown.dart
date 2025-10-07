import 'package:flutter/material.dart';
import 'package:online_plants_app/core/theme/bloc/theme_manager.dart';
import 'package:online_plants_app/di/init_di.dart';

class CustomDropdown extends StatefulWidget {
  final List<String> items;
  final ValueChanged<String> onItemSelected;
  final double? width;
  final String? initial;

  const CustomDropdown(
      {super.key,
      required this.items,
      required this.onItemSelected,
      this.width,
      this.initial});

  @override
  CustomDropdownState createState() => CustomDropdownState();
}

class CustomDropdownState extends State<CustomDropdown>
    with SingleTickerProviderStateMixin {
  final _themeManager = dependencyLocator<ThemeManager>();
  OverlayEntry? _overlayEntry;
  bool _isDropdownOpen = false;
  String? _selectedItem;
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;
  late Animation<Offset> _slideAnimation;

  @override
  void initState() {
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 0),
      vsync: this,
    );
    _fadeAnimation = CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeInOut,
    );
    _slideAnimation =
        Tween<Offset>(begin: const Offset(0, -0.1), end: const Offset(0, 0))
            .animate(_fadeAnimation);
    super.initState();

    if (widget.items.isNotEmpty && (widget.initial ?? '').isEmpty) {
      _selectedItem = widget.items[0];
    }

    if ((widget.initial ?? '').isNotEmpty) {
      _selectedItem = widget.initial;
    }

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (((widget.items.isNotEmpty) || (_selectedItem != null)) && mounted) {
        widget.onItemSelected.call(_selectedItem ?? widget.items[0]);
      }
    });
  }

  void _toggleDropdown() {
    if (widget.items.length > 1) {
      if (_isDropdownOpen) {
        _closeDropdown();
      } else {
        _openDropdown();
      }
    }
  }

  void _openDropdown() {
    final overlay = Overlay.of(context);
    final renderBox = context.findRenderObject() as RenderBox;
    final position = renderBox.localToGlobal(Offset.zero);
    double top = position.dy + 10;
    if (position.dy + 200 >= MediaQuery.of(context).size.height) {
      top = position.dy - 180;
    }

    _overlayEntry = OverlayEntry(
      builder: (context) => Stack(
        children: [
          GestureDetector(
            onTap: _closeDropdown,
            child: Container(
              color: Colors.transparent,
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
            ),
          ),
          // Position the dropdown overlay
          Positioned(
            left: 16,
            right: 16,
            top: top, // Slight offset below the button
            // width: widget.width ?? renderBox.size.width
            child: Material(
              child: FadeTransition(
                opacity: _fadeAnimation,
                child: SlideTransition(
                  position: _slideAnimation,
                  child: _buildDropdown(),
                ),
              ),
            ),
          ),
        ],
      ),
    );

    overlay.insert(_overlayEntry!);
    if (mounted) {
      setState(() {
        _isDropdownOpen = true;
      });
    }
    _animationController.forward();
  }

  void _closeDropdown() {
    _animationController.reverse().then((_) {
      _overlayEntry?.remove();
      if (mounted) {
        setState(() {
          _isDropdownOpen = false;
        });
      }
    });
  }

  Widget _buildDropdown() {
    return Material(
      elevation: 0,
      child: Container(
        constraints: const BoxConstraints(
          minHeight: 10,
          maxHeight: 150,
        ),
        decoration: BoxDecoration(
            border: Border.all(color: Colors.black54, width: .5),
            color: Colors.white),
        child: ListView(
          padding: EdgeInsets.zero,
          shrinkWrap: true,
          children: widget.items.map((item) {
            List<String> parts = item.split(',');
            String value = parts[0];
            String? value2 = parts.length > 1 ? parts[1] : null;
            return InkWell(
              onTap: () {
                if (mounted) {
                  setState(() {
                    _selectedItem = item;
                  });
                  widget.onItemSelected(item);

                  _closeDropdown();
                }
              },
              child: Container(
                height: 50,
                alignment: Alignment.centerLeft,
                decoration: const BoxDecoration(
                    border: Border(
                        bottom: BorderSide(color: Colors.black38, width: .5))),
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(value,
                        style: const TextStyle(
                            color: Colors.black,
                            fontSize: 15,
                            fontWeight: FontWeight.w200)),
                    if (value2 != null && (value2).isNotEmpty)
                      Text(value2,
                          style: const TextStyle(
                              color: Colors.black,
                              fontSize: 15,
                              fontWeight: FontWeight.w200)),
                  ],
                ),
              ),
            );
          }).toList(),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: _toggleDropdown,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(_selectedItem ?? 'Select an item',
                style: TextStyle(
                    color: _themeManager.isDarkTheme
                        ? Colors.white
                        : Colors.black54,
                    fontSize: 15,
                    fontWeight: FontWeight.w300)),
            const SizedBox(
              width: 10,
            ),
            Icon(
              Icons.arrow_drop_down_sharp,
              size: 20,
              color: _themeManager.isDarkTheme ? Colors.white : Colors.black54,
            )
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _animationController.dispose();

    super.dispose();
  }
}
