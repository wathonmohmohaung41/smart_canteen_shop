import 'package:flutter/material.dart';
import 'package:smart_canteen_shop/main.dart';

import 'overview_page.dart';
import 'menu_page.dart';
import 'orders_page.dart';
import 'seats_page.dart';
import 'wallet_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int currentIndex = 0;

  late final List<Widget> pages;

  @override
  void initState() {
    super.initState();

    pages = [
      OverviewPage(
        onTabChange: (index) {
          setState(() {
            currentIndex = index;
          });
        },
      ),
      const MenuPage(),
      const OrdersPage(),
      const SeatsPage(),
      const WalletPage(),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffFAFAFA),

      body: Column(
        children: [
          SafeArea(
            bottom: false,
            child: Container(
              color: const Color(0xffFAFAFA),
              child: Column(
                children: [
                  const SizedBox(height: 14),

                  // HEADER
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 14),
                    child: Row(
                      children: [
                        Container(
                          width: 52,
                          height: 52,
                          decoration: BoxDecoration(
                            color: const Color(0xff0F7B94),
                            borderRadius: BorderRadius.circular(18),
                          ),
                          child: const Icon(
                            Icons.storefront_outlined,
                            color: Colors.white,
                          ),
                        ),

                        const SizedBox(width: 12),

                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,

                            children: const [
                              Text(
                                "Moe's Burmese Kitchen",
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.w700,
                                  color: Colors.black87,
                                ),
                              ),

                              SizedBox(height: 3),

                              Text.rich(
                                TextSpan(
                                  children: [
                                    TextSpan(
                                      text: "Daw Moe Moe · ",
                                      style: TextStyle(
                                        fontSize: 12,
                                        color: Colors.grey,
                                      ),
                                    ),

                                    TextSpan(
                                      text: "Owner",
                                      style: TextStyle(
                                        fontSize: 12,
                                        color: Color(0xff0F7B94),
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),

                        InkWell(
                          borderRadius: BorderRadius.circular(26),
                          onTap: () {
                            showDialog(
                              context: context,
                              builder: (context) => AlertDialog(
                                title: const Text('Logout'),
                                content: const Text(
                                  'Are you sure you want to logout?',
                                ),
                                actions: [
                                  TextButton(
                                    onPressed: () {
                                      Navigator.pop(context);
                                    },
                                    child: const Text('Cancel'),
                                  ),
                                  ElevatedButton(
                                    onPressed: () {
                                      Navigator.pop(context);

                                      Navigator.pushAndRemoveUntil(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              const LoginPage(),
                                        ),
                                        (route) => false,
                                      );
                                    },
                                    child: const Text('Logout'),
                                  ),
                                ],
                              ),
                            );
                          },
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 16,
                              vertical: 10,
                            ),
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.grey.shade300),
                              borderRadius: BorderRadius.circular(26),
                            ),
                            child: Row(
                              children: const [
                                Icon(
                                  Icons.logout,
                                  size: 16,
                                  color: Colors.grey,
                                ),
                                SizedBox(width: 5),
                                Text(
                                  "Out",
                                  style: TextStyle(
                                    fontSize: 13,
                                    color: Colors.grey,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 18),

                  // TABS
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 14),
                    child: Container(
                      height: 48,
                      padding: const EdgeInsets.all(4),
                      decoration: BoxDecoration(
                        color: const Color(0xffF2F2F2),
                        borderRadius: BorderRadius.circular(30),
                      ),
                      child: ListView(
                        scrollDirection: Axis.horizontal,
                        children: [
                          _tab(Icons.show_chart, "Overview", 0),
                          _tab(Icons.restaurant, "Menu", 1),
                          _tab(Icons.inventory_2_outlined, "Orders", 2),
                          _tab(Icons.event_seat_outlined, "Seats", 3),
                          _tab(
                            Icons.account_balance_wallet_outlined,
                            "Wallet",
                            4,
                          ),
                        ],
                      ),
                    ),
                  ),

                  const SizedBox(height: 6),
                ],
              ),
            ),
          ),

          Expanded(child: pages[currentIndex]),
        ],
      ),
    );
  }

  Widget _tab(IconData icon, String title, int index) {
    final selected = currentIndex == index;

    return GestureDetector(
      onTap: () {
        setState(() {
          currentIndex = index;
        });
      },
      child: Container(
        margin: const EdgeInsets.only(right: 8),
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
        decoration: BoxDecoration(
          color: selected ? Colors.white : Colors.transparent,
          borderRadius: BorderRadius.circular(24),
        ),
        child: Row(
          children: [
            Icon(icon, size: 17),
            const SizedBox(width: 6),
            Text(
              title,
              style: TextStyle(
                fontWeight: selected ? FontWeight.w600 : FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
