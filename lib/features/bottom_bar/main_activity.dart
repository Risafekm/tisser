import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tisser_app/features/dashboard/presentation/dash_board.dart';
import 'package:tisser_app/features/task/presentation/pages/task_screen.dart';

// BLoC for bottom navigation
class BottomNavCubit extends Cubit<int> {
  BottomNavCubit() : super(0);

  void changeIndex(int index) {
    emit(index);
  }
}

class MainBottomBar extends StatelessWidget {
  MainBottomBar({super.key});

  final List<Widget> _pages = [
    DashBoard(),
    TasksPage(),
    const Center(child: Text('Saved Page')),
    const Center(child: Text('Profile Page')),
  ];

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => BottomNavCubit(),
      child: BlocBuilder<BottomNavCubit, int>(
        builder: (context, currentIndex) {
          return Scaffold(
            body: AnimatedSwitcher(
              duration: const Duration(milliseconds: 300),
              transitionBuilder: (Widget child, Animation<double> animation) {
                return FadeTransition(opacity: animation, child: child);
              },
              child: Container(
                key: ValueKey<int>(currentIndex),
                child: _pages[currentIndex],
              ),
            ),
            bottomNavigationBar: AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.2),
                    blurRadius: 10,
                    offset: const Offset(0, -2),
                  ),
                ],
              ),
              child: ClipRRect(
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(16),
                  topRight: Radius.circular(16),
                ),
                child: Theme(
                  data: Theme.of(context).copyWith(
                    splashFactory: NoSplash.splashFactory,
                    highlightColor: Colors.transparent,
                    splashColor: Colors.transparent,
                  ),
                  child: BottomNavigationBar(
                    currentIndex: currentIndex,
                    onTap: (index) {
                      context.read<BottomNavCubit>().changeIndex(index);
                    },
                    backgroundColor: Colors.white,
                    selectedItemColor: Colors.deepOrange,
                    unselectedItemColor: Colors.grey[600],
                    showUnselectedLabels: true,
                    type: BottomNavigationBarType.fixed,
                    elevation: 0,
                    selectedLabelStyle: const TextStyle(
                      fontWeight: FontWeight.w700,
                      fontSize: 14, // 🔥 Bigger label
                    ),
                    unselectedLabelStyle: const TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 13,
                    ),
                    items: [
                      _buildBottomNavItem(
                        icon: Icons.home_outlined,
                        activeIcon: Icons.home,
                        label: 'Home',
                        isSelected: currentIndex == 0,
                      ),
                      _buildBottomNavItem(
                        icon: Icons.school_outlined,
                        activeIcon: Icons.school,
                        label: 'Task',
                        isSelected: currentIndex == 1,
                      ),
                      _buildBottomNavItem(
                        icon: Icons.bookmark_outline,
                        activeIcon: Icons.bookmark,
                        label: 'Saved',
                        isSelected: currentIndex == 2,
                      ),
                      _buildBottomNavItem(
                        icon: Icons.person_outline,
                        activeIcon: Icons.person,
                        label: 'Profile',
                        isSelected: currentIndex == 3,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  BottomNavigationBarItem _buildBottomNavItem({
    required IconData icon,
    required IconData activeIcon,
    required String label,
    required bool isSelected,
  }) {
    return BottomNavigationBarItem(
      icon: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 10),
        decoration: BoxDecoration(
          color:
              isSelected
                  ? Colors.deepOrange.withOpacity(0.1)
                  : Colors.transparent,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Icon(
          isSelected ? activeIcon : icon,
          size: 28,
          color: isSelected ? Colors.deepOrange : Colors.grey[600],
        ),
      ),
      label: label,
    );
  }
}
