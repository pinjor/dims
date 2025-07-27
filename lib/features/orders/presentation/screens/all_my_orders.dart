import 'package:ecommerce/app/app_colors.dart';
import 'package:flutter/material.dart';

class MyOrderScreen extends StatefulWidget {
  const MyOrderScreen({super.key});

  @override
  State<MyOrderScreen> createState() => _MyOrderScreenState();
}

class _MyOrderScreenState extends State<MyOrderScreen> with SingleTickerProviderStateMixin {
  late TabController _tabController;
  final List<Map<String, dynamic>> allOrders = [
    {
      'id': '01123',
      'name': 'Rahim',
      'phone': '+8801825556666',
      'address': 'House # 38, Road # 11, Block # A\nBashundhara R/A, Dhaka',
      'date': 'Jul 15, 2025, 1:44 PM',
      'status': 'Delivered',
      'amount': '৳100.00',
      'message': 'Ship Your Product Today!',
    },
    {
      'id': '01123',
      'name': 'Popular Diagnostic Centre',
      'phone': 'Pharmacy',
      'address': 'Dhanmondi Branch',
      'date': 'Jul 15, 2025, 1:44 PM',
      'status': 'Cancelled',
      'amount': '৳100.00',
      'message': 'Give Your Product Fast!',
    },
    {
      'id': '01165',
      'name': 'Rahim',
      'phone': '+8801825556666',
      'address': 'House # 38, Road # 11, Block # A\nBashundhara R/A, Dhaka',
      'date': 'Jul 28, 2025, 1:44 PM',
      'status': 'Confirmed',
      'amount': '৳300.00',
      'message': 'Ship Your Product Today!',
    },
  ];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Order',style:
        TextStyle(fontSize: 20,color: appColors.themeColor),),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(48),
          child: Align(
            alignment: Alignment.topLeft,
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: TabBar(
                controller: _tabController,
                isScrollable: true,
                labelPadding: const EdgeInsets.symmetric(horizontal: 20),
                indicatorSize: TabBarIndicatorSize.tab,
                tabs: const [
                  Tab(text: 'All'),
                  Tab(text: 'Confirmed'),
                  Tab(text: 'Delivered'),
                  Tab(text: 'Cancelled'),
                ],
              ),
            ),
          ),
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          _buildOrderList(allOrders),
          _buildOrderList(allOrders.where((order) =>
          order['status'].toString().toLowerCase() == 'confirmed').toList()),
          _buildOrderList(allOrders.where((order) =>
          order['status'].toString().toLowerCase() == 'delivered').toList()),
          _buildOrderList(allOrders.where((order) =>
          order['status'].toString().toLowerCase() == 'cancelled').toList()),
        ],
      ),
    );
  }

  Widget _buildOrderList(List<Map<String, dynamic>> orders) {
    if (orders.isEmpty) {
      return const Center(
        child: Text(
          'No orders found',
          style: TextStyle(fontSize: 18, color: Colors.grey),
        ),
      );
    }

    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: orders.length,
      itemBuilder: (context, index) {
        final order = orders[index];
        return Card(
          margin: const EdgeInsets.only(bottom: 16),
          elevation: 2,
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Order ID # ${order['id']}',
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
                const SizedBox(height: 8),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      order['name'],
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                    if (order['phone'] != null) Text(order['phone']),
                    Text(order['address']),
                  ],
                ),
                const Divider(thickness: 1),
                const SizedBox(height: 8),
                Center(
                  child: Text(
                    order['message'],
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
                const SizedBox(height: 8),
                Table(
                  columnWidths: const {
                    0: FlexColumnWidth(1),
                    1: FlexColumnWidth(0.2),
                    2: FlexColumnWidth(2),
                  },
                  children: [
                    TableRow(
                      children: [
                        const Text('Date'),
                        const Text(':'),
                        Text(order['date']),
                      ],
                    ),
                    TableRow(
                      children: [
                        const Text('Status'),
                        const Text(':'),
                        Text(
                          order['status'],
                          style: TextStyle(
                            color: order['status'].toString().toLowerCase() == 'delivered'
                                ? Colors.green
                                : order['status'].toString().toLowerCase() == 'cancelled'
                                ? Colors.red
                                : Colors.orange,
                          ),
                        ),
                      ],
                    ),
                    TableRow(
                      children: [
                        const Text('Amount Payable'),
                        const Text(':'),
                        Text(order['amount']),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
