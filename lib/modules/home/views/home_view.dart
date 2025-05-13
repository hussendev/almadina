import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../app/theme.dart';
import '../../../core/constants/app_strings.dart';
import '../../../core/constants/assets_path.dart';
import '../../../data/repositories/auth_repository.dart';
import '../../shared/widgets/custom_button.dart';
import '../../shared/widgets/loading_indicator.dart';
import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
   HomeView({Key? key}) : super(key: key);

  final authController= Get.put(AuthRepository());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            Image.asset(
              AssetsPath.homeBackground,
              width: 390.w,
              height: 990.h,
              fit: BoxFit.fill,
            ),
            _buildHomeContent(context),
            // if (controller.isLoading.value)
            //   const FullScreenLoader(
            //     message: 'جاري تسجيل الدخول...',
            //   ),
          ],
        ),
      ),

    );
  }

  Widget _buildHomeContent(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(24.0),
      child: Column(
        // mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Row(),
          SizedBox(height: MediaQuery.of(context).size.height * 0.2),
          SizedBox(
            height: 52,
            width: 275,
            child:  CustomButton(
              text: AppStrings.home,
              onPressed: (){},
              // onPressed: () => controller.login(),
              type: ButtonType.primary,
            ),
          ),
          SizedBox(height: 50.h),
          SizedBox(
            height: 52,
            width: 275,
            child:  CustomButton(
              text: AppStrings.discount,
              onPressed: (){},
              // onPressed: () => controller.login(),
              type: ButtonType.primary,
            ),
          ),
          SizedBox(height: 50.h),
          SizedBox(
            height: 52,
            width: 275,
            child:  CustomButton(
              text: AppStrings.logout,
              onPressed: ()async{
                await authController.logout();
              },
              // onPressed: () => controller.login(),
              type: ButtonType.primary,
            ),
          ),
          // _buildAppBar(),
          // SizedBox(height: 24.h),
          // _buildGreeting(),
          // SizedBox(height: 32.h),
          // Expanded(
          //   child: Stack(
          //     children: [
          //       // Background mosque silhouette
          //       Positioned(
          //         bottom: 0,
          //         right: 0,
          //         left: 0,
          //         child: Opacity(
          //           opacity: 0.1,
          //           child: Image.asset(
          //             AssetsPath.mosque,
          //             height: 200.h,
          //             fit: BoxFit.fitWidth,
          //           ),
          //         ),
          //       ),
          //       _buildMainContent(),
          //     ],
          //   ),
          // ),
        ],
      ),
    );
  }

  Widget _buildAppBar() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            Image.asset(
              'assets/images/logo.png',
              width: 40.w,
              height: 40.h,
            ),
            SizedBox(width: 10.w),
            const Text(
              AppStrings.appName,
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: AppTheme.primaryColor,
              ),
            ),
          ],
        ),
        Row(
          children: [
            IconButton(
              icon: const Icon(
                Icons.notifications_outlined,
                color: AppTheme.textColor,
              ),
              onPressed: () {},
            ),
            PopupMenuButton(
              icon: const Icon(
                Icons.more_vert,
                color: AppTheme.textColor,
              ),
              itemBuilder: (context) => [
                PopupMenuItem(
                  value: 1,
                  child: const Text(AppStrings.settings),
                  onTap: () {},
                ),
                PopupMenuItem(
                  value: 2,
                  child: const Text(AppStrings.logout),
                  onTap: () => controller.logout(),
                ),
              ],
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildGreeting() {
    final user = controller.user.value;
    final userName = user?.firstName ?? 'مستخدم';

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'مرحبا بك، $userName',
          style: TextStyle(
            fontSize: 24.sp,
            fontWeight: FontWeight.bold,
            color: AppTheme.textColor,
          ),
        ),
        SizedBox(height: 8.h),
        Text(
          'نتمنى لك يوماً سعيداً',
          style: TextStyle(
            fontSize: 16.sp,
            color: AppTheme.greyColor,
          ),
        ),
      ],
    );
  }

  Widget _buildMainContent() {
    // Return different content based on the selected tab
    switch (controller.selectedIndex.value) {
      case 0:
        return _buildHomeTab();
      case 1:
        return _buildProfileTab();
      case 2:
        return _buildSettingsTab();
      default:
        return _buildHomeTab();
    }
  }

  Widget _buildHomeTab() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'الخدمات المتاحة',
          style: TextStyle(
            fontSize: 20.sp,
            fontWeight: FontWeight.bold,
            color: AppTheme.textColor,
          ),
        ),
        SizedBox(height: 16.h),
        Expanded(
          child: GridView.builder(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 16.w,
              mainAxisSpacing: 16.h,
              childAspectRatio: 1.2,
            ),
            itemCount: 6,
            itemBuilder: (context, index) {
              // Define services with icons and titles
              final List<Map<String, dynamic>> services = [
                {'title': 'خدمة 1', 'icon': Icons.menu_book, 'color': AppTheme.primaryColor},
                {'title': 'خدمة 2', 'icon': Icons.location_on, 'color': AppTheme.secondaryColor},
                {'title': 'خدمة 3', 'icon': Icons.access_time_filled, 'color': AppTheme.primaryColor},
                {'title': 'خدمة 4', 'icon': Icons.mosque, 'color': AppTheme.secondaryColor},
                {'title': 'خدمة 5', 'icon': Icons.calendar_month, 'color': AppTheme.primaryColor},
                {'title': 'خدمة 6', 'icon': Icons.people, 'color': AppTheme.secondaryColor},
              ];

              return _buildFeatureCard(
                title: services[index]['title'],
                icon: services[index]['icon'],
                color: services[index]['color'],
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _buildProfileTab() {
    final user = controller.user.value;

    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(height: 24.h),
          CircleAvatar(
            radius: 50.r,
            backgroundColor: AppTheme.primaryColor,
            child: Icon(
              Icons.person,
              size: 60.sp,
              color: Colors.white,
            ),
          ),
          SizedBox(height: 16.h),
          Text(
            user?.firstName ?? 'مستخدم',
            style: TextStyle(
              fontSize: 24.sp,
              fontWeight: FontWeight.bold,
              color: AppTheme.textColor,
            ),
          ),
          SizedBox(height: 8.h),
          Text(
            user?.mobile ?? '',
            style: TextStyle(
              fontSize: 16.sp,
              color: AppTheme.greyColor,
            ),
          ),
          SizedBox(height: 32.h),
          Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12.r),
            ),
            elevation: 4,
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: 8.h),
              child: Column(
                children: [
                  _buildProfileItem(
                    icon: Icons.edit,
                    title: 'تعديل الملف الشخصي',
                    onTap: () {},
                  ),
                  _buildProfileItem(
                    icon: Icons.lock,
                    title: 'تغيير كلمة المرور',
                    onTap: () {},
                  ),
                  _buildProfileItem(
                    icon: Icons.notifications,
                    title: 'الإشعارات',
                    onTap: () {},
                  ),
                  _buildProfileItem(
                    icon: Icons.help_outline,
                    title: 'المساعدة والدعم',
                    onTap: () {},
                  ),
                  _buildProfileItem(
                    icon: Icons.logout,
                    title: 'تسجيل الخروج',
                    onTap: () => controller.logout(),
                    isLast: true,
                    isLogout: true,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSettingsTab() {
    return ListView(
      padding: EdgeInsets.symmetric(vertical: 16.h),
      children: [
        Text(
          'الإعدادات',
          style: TextStyle(
            fontSize: 20.sp,
            fontWeight: FontWeight.bold,
            color: AppTheme.textColor,
          ),
        ),
        SizedBox(height: 24.h),
        Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12.r),
          ),
          elevation: 4,
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: 8.h),
            child: Column(
              children: [
                _buildSettingsItem(
                  icon: Icons.language,
                  title: 'اللغة',
                  subtitle: 'العربية',
                  onTap: () {},
                ),
                _buildSettingsItem(
                  icon: Icons.dark_mode,
                  title: 'المظهر',
                  subtitle: 'الوضع النهاري',
                  onTap: () {},
                ),
                _buildSettingsItem(
                  icon: Icons.notifications_active,
                  title: 'الإشعارات',
                  subtitle: 'مفعلة',
                  onTap: () {},
                ),
              ],
            ),
          ),
        ),
        SizedBox(height: 16.h),
        Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12.r),
          ),
          elevation: 4,
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: 8.h),
            child: Column(
              children: [
                _buildSettingsItem(
                  icon: Icons.help_outline,
                  title: 'عن التطبيق',
                  onTap: () {},
                ),
                _buildSettingsItem(
                  icon: Icons.privacy_tip_outlined,
                  title: 'سياسة الخصوصية',
                  onTap: () {},
                ),
                _buildSettingsItem(
                  icon: Icons.star_outline,
                  title: 'تقييم التطبيق',
                  onTap: () {},
                  isLast: true,
                ),
              ],
            ),
          ),
        ),
        SizedBox(height: 16.h),
        Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12.r),
          ),
          elevation: 4,
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: 8.h),
            child: Column(
              children: [
                _buildSettingsItem(
                  icon: Icons.logout,
                  title: 'تسجيل الخروج',
                  onTap: () => controller.logout(),
                  isLast: true,
                  isLogout: true,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildFeatureCard({
    required String title,
    required IconData icon,
    required Color color,
  }) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: InkWell(
        onTap: () {},
        borderRadius: BorderRadius.circular(12.r),
        child: Padding(
          padding: EdgeInsets.all(16.r),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                icon,
                size: 40.sp,
                color: color,
              ),
              SizedBox(height: 12.h),
              Text(
                title,
                style: TextStyle(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.bold,
                  color: AppTheme.textColor,
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildProfileItem({
    required IconData icon,
    required String title,
    required VoidCallback onTap,
    bool isLast = false,
    bool isLogout = false,
  }) {
    final Color itemColor = isLogout ? Colors.red : AppTheme.primaryColor;

    return Column(
      children: [
        ListTile(
          leading: Icon(
            icon,
            color: itemColor,
          ),
          title: Text(
            title,
            style: TextStyle(
              color: itemColor,
              fontWeight: FontWeight.w500,
            ),
          ),
          trailing: const Icon(
            Icons.arrow_forward_ios,
            size: 16,
            color: AppTheme.greyColor,
          ),
          onTap: onTap,
        ),
        if (!isLast)
          const Divider(
            height: 1,
            indent: 70,
          ),
      ],
    );
  }

  Widget _buildSettingsItem({
    required IconData icon,
    required String title,
    String? subtitle,
    required VoidCallback onTap,
    bool isLast = false,
    bool isLogout = false,
  }) {
    final Color itemColor = isLogout ? Colors.red : AppTheme.primaryColor;

    return Column(
      children: [
        ListTile(
          leading: Icon(
            icon,
            color: itemColor,
          ),
          title: Text(
            title,
            style: TextStyle(
              color: itemColor,
              fontWeight: FontWeight.w500,
            ),
          ),
          subtitle: subtitle != null ? Text(subtitle) : null,
          trailing: const Icon(
            Icons.arrow_forward_ios,
            size: 16,
            color: AppTheme.greyColor,
          ),
          onTap: onTap,
        ),
        if (!isLast)
          const Divider(
            height: 1,
            indent: 70,
          ),
      ],
    );
  }

  Widget _buildBottomNavigationBar() {
    return Obx(() {
      return BottomNavigationBar(
        currentIndex: controller.selectedIndex.value,
        onTap: controller.changeTabIndex,
        selectedItemColor: AppTheme.primaryColor,
        unselectedItemColor: AppTheme.greyColor,
        showUnselectedLabels: true,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'الرئيسية',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'الملف الشخصي',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: 'الإعدادات',
          ),
        ],
      );
    });
  }
}