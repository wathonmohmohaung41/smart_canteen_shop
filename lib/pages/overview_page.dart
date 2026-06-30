import 'package:flutter/material.dart';
import 'orders_page.dart';
import 'menu_page.dart';
import 'seats_page.dart';

class OverviewPage extends StatelessWidget {
  final Function(int) onTabChange;

  const OverviewPage({super.key, required this.onTabChange});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.fromLTRB(14, 0, 14, 40),

      child: Column(
        children: [
          // =========================================
          // STATUS CARDS
          // =========================================
          Transform.translate(
            offset: const Offset(0, -15),
            child: GridView.count(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              crossAxisCount: 2,
              crossAxisSpacing: 12,
              mainAxisSpacing: 12,
              childAspectRatio: 1.05,
              children: [
                _buildStatusCard(
                  Icons.shopping_bag_outlined,
                  "Pending",
                  "0",
                  const Color(0xffFFF6EA),
                  Colors.orange,
                ),
                _buildStatusCard(
                  Icons.check_circle_outline,
                  "Ready",
                  "0",
                  const Color(0xffEDF9F0),
                  Colors.green,
                ),
                _buildStatusCard(
                  Icons.receipt_long_outlined,
                  "Today orders",
                  "1",
                  const Color(0xffEDF6FB),
                  Colors.blue,
                ),
                _buildStatusCard(
                  Icons.account_balance_wallet_outlined,
                  "Today (Ks)",
                  "0",
                  const Color(0xffEDF6FB),
                  Colors.lightBlue,
                ),
              ],
            ),
          ),

          // =========================================
          // SHOP WALLET
          // =========================================
          ClipRRect(
            borderRadius: BorderRadius.circular(24),
            child: Container(
              width: double.infinity,
              height: 200,
              color: const Color(0xff0F7B94),
              child: Stack(
                children: [
                  Positioned.fill(
                    child: Stack(
                      children: [
                        Positioned(
                          top: -35,
                          right: -45,
                          child: Container(
                            width: 170,
                            height: 170,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: Colors.white.withOpacity(0.06),
                            ),
                          ),
                        ),
                        Positioned(
                          bottom: -40,
                          right: -55,
                          child: Container(
                            width: 140,
                            height: 140,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: Colors.white.withOpacity(0.05),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

                  Padding(
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: const [
                            Icon(
                              Icons.auto_awesome,
                              color: Colors.white,
                              size: 14,
                            ),
                            SizedBox(width: 6),
                            Text(
                              "SHOP WALLET",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 14,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ],
                        ),

                        const SizedBox(height: 14),

                        Row(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            const Text(
                              "1,600",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 34,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(width: 6),
                            Padding(
                              padding: const EdgeInsets.only(bottom: 4),
                              child: Text(
                                "pts",
                                style: TextStyle(
                                  color: Colors.white.withOpacity(0.9),
                                  fontSize: 16,
                                ),
                              ),
                            ),
                          ],
                        ),

                        const SizedBox(height: 10),

                        Text(
                          "Tap Wallet tab to exchange for cash",
                          style: TextStyle(
                            color: Colors.white.withOpacity(0.85),
                            fontSize: 13,
                          ),
                        ),

                        const Spacer(),

                        InkWell(
                          borderRadius: BorderRadius.circular(30),
                          onTap: () {
                            onTabChange(4);
                          },
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 18,
                              vertical: 11,
                            ),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(30),
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: const [
                                Icon(
                                  Icons.swap_horiz,
                                  color: Color(0xff0F7B94),
                                  size: 18,
                                ),
                                SizedBox(width: 6),
                                Text(
                                  "Exchange",
                                  style: TextStyle(
                                    color: Color(0xff0F7B94),
                                    fontSize: 15,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),

          const SizedBox(height: 20),

          // =========================================
          // ACTION ITEMS
          // =========================================
          _buildActionTile(
            Icons.shopping_bag_outlined,
            "View orders",
            Colors.orange,
            () => onTabChange(2),
          ),

          const SizedBox(height: 14),

          _buildActionTile(
            Icons.restaurant,
            "Edit menu",
            Colors.teal,
            () => onTabChange(1),
          ),

          const SizedBox(height: 14),

          _buildActionTile(
            Icons.event_seat_outlined,
            "Manage seats",
            Colors.lightBlue,
            () => onTabChange(3),
          ),

          const SizedBox(height: 30),
        ],
      ),
    );
  }

  Widget _buildStatusCard(
    IconData icon,
    String title,
    String value,
    Color bgColor,
    Color iconColor,
  ) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 48,
            height: 48,
            decoration: BoxDecoration(
              color: bgColor,
              borderRadius: BorderRadius.circular(16),
            ),
            child: Icon(icon, color: iconColor, size: 22),
          ),
          const Spacer(),
          Text(
            value,
            style: const TextStyle(
              fontSize: 26,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            title,
            style: TextStyle(fontSize: 13, color: Colors.grey.shade600),
          ),
        ],
      ),
    );
  }

  Widget _buildActionTile(
    IconData icon,
    String title,
    Color iconColor,
    VoidCallback onTap,
  ) {
    return InkWell(
      borderRadius: BorderRadius.circular(24),
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(24),
          border: Border.all(color: Colors.grey.shade200),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.03),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Row(
          children: [
            Container(
              width: 52,
              height: 52,
              decoration: BoxDecoration(
                color: iconColor.withOpacity(0.08),
                borderRadius: BorderRadius.circular(16),
              ),
              child: Icon(icon, color: iconColor, size: 22),
            ),

            const SizedBox(width: 16),

            Expanded(
              child: Text(
                title,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),

            Icon(Icons.chevron_right, color: Colors.grey.shade400),
          ],
        ),
      ),
    );
  }
}
