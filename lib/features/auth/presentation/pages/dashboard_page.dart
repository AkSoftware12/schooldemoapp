import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/constants/app_colors.dart';
import '../providers/auth_state_provider.dart';
import 'HomeScreen/home_screen.dart';

class DashboardPage extends ConsumerStatefulWidget {
  const DashboardPage({super.key});

  @override
  ConsumerState<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends ConsumerState<DashboardPage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  int _currentIndex = 0;

  final List<String> _titles = [
    'Dashboard',
    'Attendance',
    'Fee',
    'Library',
    'Profile',
  ];

  final List<Widget> _screens = [
    const HomeScreen(),
    const Center(child: Text("Attendance Screen")),
    const Center(child: Text("Fee Screen")),
    const Center(child: Text("Library Screen")),
    const Center(child: Text("Profile Screen")),
  ];


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      key: _scaffoldKey,
      drawer:  _buildRightDrawer(context,ref), // 👈 your main drawer
      appBar: _buildPremiumAppBar(),

      // 🔥 BODY
      body: _buildBody(),

      // 🔥 BOTTOM NAV
      bottomNavigationBar: _buildBottomNav(),
    );
  }

  // ================= BODY =================
  Widget _buildBody() {
    return _screens[_currentIndex];
  }


  // ================= BOTTOM NAV =================
  Widget _buildBottomNav() {
    return BottomNavigationBar(
      currentIndex: _currentIndex,
      selectedItemColor: AppColors.white,
      backgroundColor: AppColors.primary,
      unselectedItemColor: Colors.grey,
      type: BottomNavigationBarType.fixed,
      onTap: (index) {
        setState(() {
          _currentIndex = index;
        });
      },
      items: const [
        BottomNavigationBarItem(
          icon: Icon(Icons.dashboard),
          label: 'Dashboard',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.event_available),
          label: 'Attendance',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.payments),
          label: 'Fee',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.menu_book),
          label: 'Library',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.person),
          label: 'Profile',
        ),
      ],
    );
  }

  // ================= RIGHT DRAWER =================
  Widget _buildRightDrawer(BuildContext context, WidgetRef ref) {
    return Drawer(
      width: MediaQuery.of(context).size.width * 0.78,
      child: Column(
        children: [
          // 🔥 HEADER
          Container(
            width: double.infinity,
            padding: const EdgeInsets.fromLTRB(20, 40, 20, 24),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  AppColors.primary,
                  AppColors.primary.withOpacity(0.88),
                ],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
              borderRadius: const BorderRadius.only(
                bottomLeft: Radius.circular(30),
                bottomRight: Radius.circular(30),
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // 🔥 AVATAR
                Container(
                  padding: const EdgeInsets.all(4),
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.white,
                  ),
                  child: CircleAvatar(
                    radius: 36,
                    backgroundColor: Colors.white,
                    child: Icon(
                      Icons.school,
                      size: 38,
                      color: AppColors.primary,
                    ),
                  ),
                ),

                const SizedBox(height: 12),

                // 🔥 STUDENT NAME
                const Text(
                  'Aman Sharma',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 21,
                    fontWeight: FontWeight.w700,
                    letterSpacing: 0.4,
                  ),
                ),

                const SizedBox(height: 4),

                // 🔥 CLASS
                const Text(
                  'Class 10 • Section A',
                  style: TextStyle(
                    color: Colors.white70,
                    fontSize: 14,
                  ),
                ),

                const SizedBox(height: 18),

                // 🔥 CENTER INFO ROW
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    _centerInfoChip(Icons.badge, 'Roll No 23'),
                    const SizedBox(width: 10),
                    _centerInfoChip(Icons.school_outlined, 'CBSE'),
                  ],
                ),
              ],
            ),
          ),

          const SizedBox(height: 12),

          // 🔥 MENU ITEMS


          _drawerItem(
            icon: Icons.dashboard_outlined,
            title: 'Dashboard',
            onTap: () {
              Navigator.pop(context);
              setState(() {
                _currentIndex = 0;
              });
            },
          ),
          _drawerItem(
            icon: Icons.notifications_none,
            title: 'Notifications',
            onTap: () {},
          ),
          _drawerItem(
            icon: Icons.calendar_month,
            title: 'Attendance',
            onTap: () {},
          ),
          _drawerItem(
            icon: Icons.payments_outlined,
            title: 'Fees',
            onTap: () {},
          ),
          _drawerItem(
            icon: Icons.settings_outlined,
            title: 'Settings',
            onTap: () {},
          ),

          const Spacer(),

          // 🔥 LOGOUT
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                InkWell(
                  borderRadius: BorderRadius.circular(16),
                  onTap: () {
                    Navigator.pop(context);
                    ref.read(authStateProvider.notifier).state =
                        AuthStatus.loggedOut;
                  },
                  child: Container(
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    decoration: BoxDecoration(
                      color: Colors.red.withOpacity(0.08),
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: const Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.logout, color: Colors.red),
                        SizedBox(width: 8),
                        Text(
                          'Logout',
                          style: TextStyle(
                            color: Colors.red,
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 6),

                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(Icons.info_outline, size: 14, color: Colors.black),
                    const SizedBox(width: 6),
                    Text(
                      'v1.0.0',
                      style: const TextStyle(
                        color: Colors.black,
                        fontSize: 12,
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
    );
  }
  Widget _drawerItem({
    required IconData icon,
    required String title,
    required VoidCallback onTap,
  }) {
    return ListTile(
      leading: Icon(icon, color: AppColors.primary),
      title: Text(
        title,
        style: const TextStyle(
          fontSize: 15,
          fontWeight: FontWeight.w500,
        ),
      ),
      trailing: const Icon(Icons.arrow_forward_ios, size: 14),
      onTap: onTap,
    );
  }


  PreferredSizeWidget _buildPremiumAppBar() {
    return AppBar(
      backgroundColor: AppColors.primary,
      elevation: 6,
      centerTitle: true,
      iconTheme: IconThemeData(color: AppColors.white),

      // 🔥 Drawer Icon (Left)
      leading: IconButton(
        icon: const Icon(Icons.menu_rounded, size: 26),
        onPressed: () {
          _scaffoldKey.currentState?.openDrawer();
        },
      ),

      // 🔥 Title
      title: Text(
        _titles[_currentIndex],
        style:  TextStyle(
          fontWeight: FontWeight.w600,
          letterSpacing: 0.5,
          color: AppColors.white
        ),
      ),

      // 🔔 Notification Icon (Right)
      actions: [
        Padding(
          padding: const EdgeInsets.only(right: 12),
          child: Stack(
            alignment: Alignment.topRight,
            children: [
              IconButton(
                icon: const Icon(Icons.notifications_none_rounded, size: 26,color: AppColors.white
                ),
                onPressed: () {
                  _scaffoldKey.currentState?.openEndDrawer();
                },
              ),

              // 🔴 Notification Badge
              Positioned(
                right: 6,
                top: 6,
                child: Container(
                  height: 9,
                  width: 9,
                  decoration: const BoxDecoration(
                    color: Colors.red,
                    shape: BoxShape.circle,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _centerInfoChip(IconData icon, String text) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 7),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.18),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: Colors.white.withOpacity(0.25),
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 14, color: Colors.white),
          const SizedBox(width: 6),
          Text(
            text,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 12,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }


}
