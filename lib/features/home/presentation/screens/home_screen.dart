import 'package:ecommerce/app/assets_path.dart';
import 'package:ecommerce/features/Dashboard/presentation/dashboard_screen.dart';
import 'package:ecommerce/features/Prescription/presentation/Prescription_screen.dart';
import 'package:ecommerce/features/common/ui/controllers/main_bottom_nav_controller.dart';
import 'package:ecommerce/features/common/ui/widgets/category_item_widget.dart';
import 'package:ecommerce/features/common/ui/widgets/product_item_widget.dart';
import 'package:ecommerce/features/home/ui/widgets/appbar_icon_button.dart';
import 'package:ecommerce/features/home/ui/widgets/home_carousle_slider.dart';
import 'package:ecommerce/features/home/ui/widgets/home_section_header.dart';
import 'package:ecommerce/features/home/ui/widgets/product_search_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  static const String name = '/home';


  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  // int _selectedIndex=0;
  //
  // static const List<Widget> _widgetOptions = <Widget>[
  //   Text('Index 0: Home', ),
  //   Text('Index 1: Business', ),
  //   Text('Index 2: School', ),
  // ];
  //
  // void _onItemTapped(int index) {
  //   setState(() {
  //     _selectedIndex = index;
  //   });
  // }

  int _selectedIndex=0;

  // static const List<Widget> _widgetOptions = <Widget>[
  //   Text('Index 1: Business', ),
  //   Text('Index 1: Business', ),
  //   Text('Index 2: School', ),
  // ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }






  final TextEditingController _searchBarController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      drawer: Drawer(
        width: 200,
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              decoration: BoxDecoration(color: Color(0xFF07ADAE)),
              child: const Text('Popular App'),
            ),
            ListTile(
              title: const Text('Dashboard'),
              selected: _selectedIndex == 0,
              onTap: () {
                // Update the state of the app
                _onItemTapped(0);

                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => DashboardScreen(),
                  ),
                );

              },
            ),
            ListTile(
              title: const Text('Prescription'),
              selected: _selectedIndex == 1,
              onTap: () {
                // Update the state of the app
                _onItemTapped(1);
                // Then close the drawer
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => PrescriptionScreen(),
                  ),
                );
              },
            ),
            ListTile(
              title: const Text('Pharmacy'),
              selected: _selectedIndex == 2,
              onTap: () {
                // Update the state of the app
                _onItemTapped(2);
                // Then close the drawer
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(

        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Column(

            children: [
              SizedBox(
                height: 16.0,
              ),
              ProductSearchBar(
                controller: _searchBarController,
              ),
              SizedBox(
                height: 16,
              ),
              HomeCarouselSlider(),
              SizedBox(
                height: 16,
              ),
              HomeScetionHeader(
                title: 'Category',
                onTap: () {
                  Get.find<MainButtomNavController>().moveToCategory();
                },
              ),
              SizedBox(
                height: 8,
              ),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: _getCategoryList(),
                ),
              ),
              SizedBox(
                height: 16,
              ),
              HomeScetionHeader(
                title: 'Popular',
                onTap: () {},
              ),
              SizedBox(
                height: 8,
              ),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: _getProductList(),
                ),
              ),
              SizedBox(
                height: 16,
              ),
              HomeScetionHeader(
                title: 'Special',
                onTap: () {},
              ),
              SizedBox(
                height: 8,
              ),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: _getProductList(),
                ),
              ),
              SizedBox(
                height: 16,
              ),
              HomeScetionHeader(
                title: 'New',
                onTap: () {},
              ),
              SizedBox(
                height: 8,
              ),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: _getProductList(),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  List<Widget> _getCategoryList() {
    List<Widget> categoryList = [];
    for (int i = 0; i < 10; i++) {
      categoryList.add(
        Padding(
          padding: const EdgeInsets.only(right: 16),
          child: CategoryItemWidget(),
        ),
      );
    }
    return categoryList;
  }

  List<Widget> _getProductList() {
    List<Widget> productList = [];
    for (int i = 0; i < 10; i++) {
      productList.add(
        Padding(
          padding: const EdgeInsets.only(right: 16),
          child: ProductItemWidget(),
        ),
      );
    }
    return productList;
  }

  AppBar _buildAppBar() {
    return AppBar(
      title: SvgPicture.asset(assetsPath.nav_logo_svg),
      leading: Builder(
        builder: (BuildContext context) {
          return IconButton(
            icon: Icon(Icons.menu),
            onPressed: () {
              Scaffold.of(context).openDrawer();  // Open the drawer when the menu icon is pressed
            },
          );
        },
      ),
      actions: [
        AppbarIconButton(
          icon: Icons.person_2_outlined,
          onTap: () {},
        ),
        SizedBox(
          width: 6.0,
        ),
        AppbarIconButton(
          icon: Icons.call,
          onTap: () {},
        ),
        SizedBox(
          width: 6.0,
        ),
        AppbarIconButton(
          icon: Icons.notifications_active_sharp,
          onTap: () {},
        ),
      ],
    );
  }
}
