import 'package:flutter/material.dart';

class SectionsAppBar extends StatelessWidget implements PreferredSizeWidget {
  final double height;

  const SectionsAppBar({
    super.key,
    this.height = 100,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: const Color(0xFF080C12),
      toolbarHeight: height,
      automaticallyImplyLeading: false, // Disable default back button behavior
      titleSpacing: 0,
      title: Column(
        children: [
          // Centered logo at the top
          Center(
            child: Image.asset(
              'assets/images/logo.png',
              height: 42,
            ),
          ),
          // Row containing back button and search field
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 5.0),
            child: Row(
              children: [
                IconButton(
                  icon: const Icon(Icons.chevron_left, color: Colors.white),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  padding: const EdgeInsets.only(left: 4.0, right: 0.0),
                  constraints: const BoxConstraints(),
                ),
                // Expanded search field to take remaining space
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(right: 8.0, left: 4.0),
                    child: SizedBox(
                      height: 26,
                      child: TextField(
                        style: const TextStyle(
                          color: Colors.black,
                          fontSize: 14,
                          fontStyle: FontStyle.italic,
                        ),
                        decoration: InputDecoration(
                          hintText: 'Search redxspot',
                          prefixIcon: const Icon(Icons.search, size: 18),
                          contentPadding: const EdgeInsets.symmetric(vertical: 5),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20),
                            borderSide: BorderSide.none,
                          ),
                          filled: true,
                          fillColor: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(height);
}