import 'package:flutter/material.dart';

class MenuPage extends StatefulWidget {
  const MenuPage({super.key});

  @override
  State<MenuPage> createState() => _MenuPageState();
}

class _MenuPageState extends State<MenuPage> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController descController = TextEditingController();
  final TextEditingController pointsController = TextEditingController();

  bool isAvailable = true;

  String selectedCategory = "Main";

  final List<String> categories = [
    "Main",
    "Appetizer",
    "Salad",
    "Noodles",
    "Drinks",
    "Tea",
    "Snacks",
    "Desserts",
  ];

  final TextEditingController _searchController = TextEditingController();

  final List<Map<String, dynamic>> allItems = [
    {
      "name": "Mohinga",
      "desc": "Classic Burmese fish noodle soup",
      "points": "250",
      "available": false,
    },
    {
      "name": "Ohn No Khao Swè",
      "desc": "Coconut chicken noodle soup",
      "points": "300",
      "available": false,
    },
    {
      "name": "Tea Leaf Salad",
      "desc": "Fermented tea leaf salad with nuts",
      "points": "200",
      "available": true,
    },
    {
      "name": "Shan Noodles",
      "desc": "Rice noodles with tomato-based sauce",
      "points": "280",
      "available": true,
    },
    {
      "name": "Nan Gyi Thoke",
      "desc": "Noodle salad",
      "points": "100",
      "available": true,
    },
  ];

  List<Map<String, dynamic>> filteredItems = [];

  @override
  void initState() {
    super.initState();
    filteredItems = allItems;

    _searchController.addListener(_filterItems);
  }

  void _filterItems() {
    final query = _searchController.text.toLowerCase();

    setState(() {
      filteredItems = allItems.where((item) {
        final name = item["name"].toLowerCase();
        final desc = item["desc"].toLowerCase();

        return name.contains(query) || desc.contains(query);
      }).toList();
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.fromLTRB(14, 10, 14, 40),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Container(
                  height: 48,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(28),
                    border: Border.all(color: Colors.grey.shade300),
                  ),
                  child: TextField(
                    controller: _searchController, // ✅ CONNECTED
                    decoration: InputDecoration(
                      hintText: "Search menu...",
                      hintStyle: TextStyle(color: Colors.grey.shade500),
                      prefixIcon: Icon(
                        Icons.search,
                        color: Colors.grey.shade500,
                      ),
                      border: InputBorder.none,
                    ),
                  ),
                ),
              ),

              const SizedBox(width: 12),

              GestureDetector(
                onTap: _showAddMenuSheet, // ✅ OPEN FORM
                child: Container(
                  height: 48,
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  decoration: BoxDecoration(
                    color: const Color(0xff0F7B94),
                    borderRadius: BorderRadius.circular(28),
                  ),
                  child: const Row(
                    children: [
                      Icon(Icons.add, color: Colors.white),
                      SizedBox(width: 4),
                      Text(
                        "Add",
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                          fontSize: 16,
                        ),
                      ),
                      Padding(padding: const EdgeInsets.only(right: 5)),
                    ],
                  ),
                ),
              ),
            ],
          ),

          const SizedBox(height: 20),

          Text(
            "${filteredItems.length} items",
            style: TextStyle(
              color: Colors.grey.shade600,
              fontWeight: FontWeight.w600,
            ),
          ),

          const SizedBox(height: 16),

          ...filteredItems.asMap().entries.map(
            (entry) => _buildMenuCard(
              index: entry.key,
              name: entry.value["name"] ?? "",
              description: entry.value["desc"] ?? "",
              points: entry.value["points"] ?? "",
              available: entry.value["available"] ?? false,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMenuCard({
    required int index,
    required String name,
    required String description,
    required String points,
    required bool available,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 66,
                height: 66,
                decoration: BoxDecoration(
                  color: const Color(0xffFFF7EC),
                  borderRadius: BorderRadius.circular(18),
                ),
                child: const Icon(
                  Icons.restaurant,
                  color: Colors.orange,
                  size: 28,
                ),
              ),

              const SizedBox(width: 14),

              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            name,
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),

                        // ✅ SOLD OUT TAG (kept)
                        if (!available)
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 10,
                              vertical: 5,
                            ),
                            decoration: BoxDecoration(
                              color: const Color(0xffFFF4F4),
                              borderRadius: BorderRadius.circular(20),
                              border: Border.all(
                                color: const Color(0xffFFD7D7),
                              ),
                            ),
                            child: const Text(
                              "SOLD OUT",
                              style: TextStyle(
                                color: Colors.redAccent,
                                fontSize: 11,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                      ],
                    ),

                    const SizedBox(height: 6),

                    Text(
                      description,
                      style: TextStyle(
                        color: Colors.grey.shade600,
                        fontSize: 14,
                      ),
                    ),

                    const SizedBox(height: 10),

                    Row(
                      children: [
                        const Icon(
                          Icons.monetization_on,
                          size: 14,
                          color: Color(0xff0F7B94),
                        ),
                        const SizedBox(width: 3),
                        Text(
                          points,
                          style: const TextStyle(
                            color: Color(0xff0F7B94),
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),

          const SizedBox(height: 16),

          // ✅ BOTTOM ROW RESTORED
          Row(
            children: [
              Expanded(
                child: GestureDetector(
                  onTap: () {
                    setState(() {
                      // ✅ Toggle value
                      allItems[index]["available"] =
                          !allItems[index]["available"];
                      _filterItems(); // refresh filtered list
                    });
                  },
                  child: Container(
                    height: 40,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(24),
                      border: Border.all(
                        color: available
                            ? const Color(0xffCFEFD8)
                            : const Color(0xffFFCACA),
                      ),
                    ),
                    child: Center(
                      child: Text(
                        available ? "Available" : "Sold out",
                        style: TextStyle(
                          color: available
                              ? const Color(0xff6DAE83)
                              : Colors.red,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                ),
              ),

              const SizedBox(width: 10),

              // ✅ EDIT BUTTON
              GestureDetector(
                onTap: () {
                  _showEditMenuSheet(index);
                },
                child: Container(
                  width: 44,
                  height: 44,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(color: Colors.grey.shade200),
                  ),
                  child: const Icon(
                    Icons.edit_outlined,
                    color: Color(0xff0F7B94),
                    size: 20,
                  ),
                ),
              ),

              const SizedBox(width: 10),

              // ✅ DELETE BUTTON
              GestureDetector(
                onTap: () {
                  _showDeleteDialog(index);
                },
                child: Container(
                  width: 44,
                  height: 44,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(color: Colors.grey.shade200),
                  ),
                  child: const Icon(
                    Icons.delete_outline,
                    color: Colors.redAccent,
                    size: 20,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  void _showAddMenuSheet() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(30)),
      ),
      builder: (context) {
        return Padding(
          padding: EdgeInsets.only(
            left: 16,
            right: 16,
            top: 20,
            bottom: MediaQuery.of(context).viewInsets.bottom + 20,
          ),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Header
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      "Add menu item",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    IconButton(
                      icon: const Icon(Icons.close),
                      onPressed: () => Navigator.pop(context),
                    ),
                  ],
                ),

                const SizedBox(height: 16),

                // Name
                _buildInput(nameController, "Name", "e.g. Mohinga"),

                const SizedBox(height: 12),

                // Description
                _buildInput(descController, "Description", "Short description"),

                const SizedBox(height: 12),

                // ✅ CATEGORY DROPDOWN
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "Category",
                      style: TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(height: 6),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 12),
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey.shade400),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: DropdownButtonHideUnderline(
                        child: DropdownButton<String>(
                          value: selectedCategory,
                          isExpanded: true,
                          items: categories
                              .map(
                                (cat) => DropdownMenuItem(
                                  value: cat,
                                  child: Text(cat),
                                ),
                              )
                              .toList(),
                          onChanged: (value) {
                            setState(() {
                              selectedCategory = value!;
                            });
                          },
                        ),
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 12),

                // ✅ POINTS ONLY
                _buildInput(pointsController, "Points", "100"),

                const SizedBox(height: 12),

                // Checkbox
                Row(
                  children: [
                    Checkbox(
                      value: isAvailable,
                      onChanged: (value) {
                        setState(() {
                          isAvailable = value!;
                        });
                      },
                    ),
                    const Text("Available for sale"),
                  ],
                ),

                const SizedBox(height: 20),

                // ✅ ADD BUTTON (NO regenerate)
                SizedBox(
                  width: double.infinity,
                  height: 50,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xff0F7B94),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                    ),
                    onPressed: () {
                      // ✅ Add new item
                      setState(() {
                        allItems.add({
                          "name": nameController.text,
                          "desc": descController.text,
                          "category": selectedCategory,
                          "points": pointsController.text,
                          "available": isAvailable,
                        });

                        _filterItems();
                      });

                      // clear inputs
                      nameController.clear();
                      descController.clear();
                      pointsController.clear();

                      Navigator.pop(context);
                    },
                    child: const Text(
                      "Add to menu",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildInput(
    TextEditingController controller,
    String label,
    String hint,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w500),
        ),
        const SizedBox(height: 6),
        TextField(
          controller: controller,
          decoration: InputDecoration(
            hintText: hint,
            contentPadding: const EdgeInsets.symmetric(horizontal: 14),
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
          ),
        ),
      ],
    );
  }

  void _showEditMenuSheet(int index) {
    final item = allItems[index];

    // ✅ preload values
    nameController.text = item["name"] ?? "";
    descController.text = item["desc"] ?? "";
    pointsController.text = item["points"] ?? "";
    selectedCategory = item["category"] ?? "Main";
    isAvailable = item["available"] ?? true;

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(30)),
      ),
      builder: (context) {
        return Padding(
          padding: EdgeInsets.only(
            left: 16,
            right: 16,
            top: 20,
            bottom: MediaQuery.of(context).viewInsets.bottom + 20,
          ),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Header
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      "Edit menu item",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    IconButton(
                      icon: const Icon(Icons.close),
                      onPressed: () => Navigator.pop(context),
                    ),
                  ],
                ),

                const SizedBox(height: 16),

                _buildInput(nameController, "Name", "e.g. Mohinga"),
                const SizedBox(height: 12),

                _buildInput(descController, "Description", "Short description"),
                const SizedBox(height: 12),

                // ✅ CATEGORY DROPDOWN
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text("Category"),
                    const SizedBox(height: 6),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 12),
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey.shade400),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: DropdownButtonHideUnderline(
                        child: DropdownButton<String>(
                          value: selectedCategory,
                          isExpanded: true,
                          items: categories
                              .map(
                                (cat) => DropdownMenuItem(
                                  value: cat,
                                  child: Text(cat),
                                ),
                              )
                              .toList(),
                          onChanged: (value) {
                            setState(() {
                              selectedCategory = value!;
                            });
                          },
                        ),
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 12),

                _buildInput(pointsController, "Points", "100"),

                const SizedBox(height: 12),

                Row(
                  children: [
                    Checkbox(
                      value: isAvailable,
                      onChanged: (value) {
                        setState(() {
                          isAvailable = value!;
                        });
                      },
                    ),
                    const Text("Available for sale"),
                  ],
                ),

                const SizedBox(height: 20),

                // ✅ SAVE BUTTON
                SizedBox(
                  width: double.infinity,
                  height: 50,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xff0F7B94),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                    ),
                    onPressed: () {
                      setState(() {
                        allItems[index] = {
                          "name": nameController.text,
                          "desc": descController.text,
                          "category": selectedCategory,
                          "points": pointsController.text,
                          "available": isAvailable,
                        };

                        _filterItems();
                      });

                      Navigator.pop(context);
                    },
                    child: const Text(
                      "Save changes",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  void _showDeleteDialog(int index) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          title: const Text("Delete item"),
          content: const Text(
            "Are you sure you want to delete this menu item?",
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context); // ❌ Cancel
              },
              child: const Text("Cancel"),
            ),

            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.redAccent,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
              onPressed: () {
                setState(() {
                  allItems.removeAt(index); // ✅ Delete item
                  _filterItems(); // refresh list
                });

                Navigator.pop(context); // close dialog
              },
              child: const Text("Delete"),
            ),
          ],
        );
      },
    );
  }
}
