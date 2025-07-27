import 'package:ecommerce/app/assets_path.dart';
import 'package:ecommerce/features/cart/ui/screens/cart_list_screen.dart';
import 'package:ecommerce/features/common/ui/widgets/product_item_widget.dart';
import 'package:ecommerce/features/home/presentation/widgets/appbar_icon_button.dart';
import 'package:ecommerce/features/home/presentation/widgets/category_section.dart';
import 'package:ecommerce/features/home/presentation/widgets/home_section_header.dart';
import 'package:ecommerce/features/home/presentation/widgets/product_search_bar.dart';
import 'package:flutter/material.dart';
import '../../../Prescription/presentation/qr_scan_page.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  static const String name = '/home';


  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  //int _selectedIndex=0;



  // void _onItemTapped(int index) {
  //   setState(() {
  //     _selectedIndex = index;
  //   });
  // }






  final TextEditingController _searchBarController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      // drawer: Drawer(
      //   width: 200,
      //   child: ListView(
      //     padding: EdgeInsets.zero,
      //     children: [
      //       DrawerHeader(
      //         //decoration: BoxDecoration(color: Color(0xFF07ADAE)),
      //         child: AppLogoWidget(),
      //       ),
      //       ListTile(
      //         title: const Text('Pharmacy'),
      //         selected: _selectedIndex == 0,
      //         onTap: () {
      //           // Update the state of the app
      //           _onItemTapped(0);
      //           // Then close the drawer
      //           Navigator.pop(context);
      //         },
      //       ),
      //       ListTile(
      //         title: const Text('Dashboard'),
      //         selected: _selectedIndex == 1,
      //         onTap: () {
      //           // Update the state of the app
      //           _onItemTapped(1);
      //
      //           Navigator.push(
      //             context,
      //             MaterialPageRoute(
      //               builder: (context) => DashboardScreen(),
      //             ),
      //           );
      //
      //         },
      //       ),
      //       ListTile(
      //         title: const Text('Prescription'),
      //         selected: _selectedIndex == 2,
      //         onTap: () {
      //           // Update the state of the app
      //           _onItemTapped(2);
      //           // Then close the drawer
      //           Navigator.push(
      //             context,
      //             MaterialPageRoute(
      //               builder: (context) => QRScanPage(),
      //             ),
      //           );
      //         },
      //       ),
      //
      //     ],
      //   ),
      // ),
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
              CategorySection(),
              GestureDetector(
                  onTap: (){
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => QRScanPage(),
                      ),
                    );
                  },
                  child: Image.asset('assets/images/Banner.png',fit: BoxFit.cover,)),
              //HomeCarouselSlider(),
              SizedBox(
                height: 16,
              ),

              // HomeScetionHeader(
              //   title: 'Category',
              //   onTap: () {
              //     Get.find<MainButtomNavController>().moveToCategory();
              //   },
              // ),
              // SizedBox(
              //   height: 8,
              // ),
              // SingleChildScrollView(
              //   scrollDirection: Axis.horizontal,
              //   child: Row(
              //     children: _getCategoryList(),
              //   ),
              // ),
              SizedBox(
                height: 16,
              ),
              HomeScetionHeader(
                title: 'Flash Sale',
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
                title: 'Featured Products',
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

            ],
          ),
        ),
      ),
    );
  }

  // List<Widget> _getCategoryList() {
  //   List<Widget> categoryList = [];
  //   for (int i = 0; i < 10; i++) {
  //     categoryList.add(
  //       Padding(
  //         padding: const EdgeInsets.only(right: 16),
  //         child: CategoryItemWidget(),
  //       ),
  //     );
  //   }
  //   return categoryList;
  // }

  List<Widget> _getProductList() {
    List<Widget> productList = [];
    for (int i = 0; i < 10; i++) {
      productList.add(
        Padding(
          padding: const EdgeInsets.only(right: 8),
          child: ProductItemWidget(),
        ),
      );
    }
    return productList;
  }

  AppBar _buildAppBar() {
    return AppBar(
        automaticallyImplyLeading: false,
     toolbarHeight: 70, // Even taller AppBar
      title: Image.asset(
        assetsPath.nav_logo_svg,
        fit: BoxFit.fitWidth,
        height: 40,
      ),
      backgroundColor:Color(0x5000984A),
      actions: [
        AppbarIconButton(
          icon: Icons.shopping_cart,
          onTap: (){Navigator.pushReplacement(context,MaterialPageRoute(builder: (context)=> CartListScreen()));},
        ),
        SizedBox(
          width: 6.0,
        ),

      ],
    );
  }
}
