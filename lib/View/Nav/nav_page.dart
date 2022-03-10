import 'package:flutter/material.dart';
import 'package:gscm_store_owner/Constant/app_theme.dart';
import 'package:gscm_store_owner/View/Dashboard/dashboard_screen.dart';
import 'package:gscm_store_owner/View/Event/event_list_screen.dart';
import 'package:gscm_store_owner/View/Invoice/invoice_page.dart';
import 'package:gscm_store_owner/View/Product/product_list_screen.dart';
import 'package:gscm_store_owner/View/Profile/profile_screen.dart';

class NavPage extends StatefulWidget {
  const NavPage({Key? key}) : super(key: key);

  @override
  _NavPageState createState() => _NavPageState();
}

class _NavPageState extends State<NavPage> {
  int currentPage = 0;
  List<Widget> pages = [
    const DashboardScreen(key: PageStorageKey<String>('dashboard')),
    const InvoicePage(key: PageStorageKey<String>('invoice')),
    const ProductListScreen(key: PageStorageKey<String>('product')),
    const EventListScreen(key: PageStorageKey<String>('event')),
    const ProfileScreen(key: PageStorageKey<String>('profile')),
  ];
  final bucket = PageStorageBucket();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageStorage(
        bucket: bucket,
        child: pages[currentPage],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: currentPage,
        showUnselectedLabels: false,
        showSelectedLabels: true,
        elevation: 5,
        unselectedItemColor: kNeutralColor,
        fixedColor: kPrimaryColor,
        selectedFontSize: 12,
        unselectedFontSize: 12,
        iconSize: 24,
        onTap: (value) => setState(() {
          currentPage = value;
        }),
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Trang chủ',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.receipt),
            label: 'Hóa đơn',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_bag),
            label: 'Sản phẩm',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.event),
            label: 'Sự kiện',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.more),
            label: 'Thêm',
          )
        ],
      ),
    );
  }
}