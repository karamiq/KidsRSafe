import 'package:app/common_lib.dart';
import 'package:app/data/providers/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:app/data/models/user_model.dart';
import 'package:app/src/add/add_page.dart';

class EntryPoint extends StatefulHookConsumerWidget {
  const EntryPoint({super.key, required this.child});

  final Widget child;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _EntryPointState();
}

class _EntryPointState extends ConsumerState<EntryPoint> {
  final List<String> pagesIsNotKid = [
    RoutesDocument.home,
    RoutesDocument.search,
    'add', // Placeholder for FAB
    RoutesDocument.inbox,
    RoutesDocument.profile,
  ];
  final List<String> pagesIsKid = [
    RoutesDocument.home,
    RoutesDocument.search,
    RoutesDocument.inbox,
    RoutesDocument.profile,
  ];

  int _getSelectedIndex(bool isKid) {
    final location = GoRouterState.of(context).matchedLocation;
    print(location);
    if (isKid) {
      if (location.startsWith(RoutesDocument.home)) return 0;
      if (location.startsWith(RoutesDocument.search)) return 1;
      if (location.startsWith(RoutesDocument.inbox)) return 2;
      if (location.startsWith(RoutesDocument.profile)) return 3;
    } else {
      if (location.startsWith(RoutesDocument.home)) return 0;
      if (location.startsWith(RoutesDocument.search)) return 1;
      if (location.startsWith(RoutesDocument.inbox)) return 3;
      if (location.startsWith(RoutesDocument.profile)) return 4;
    }
    return 0;
  }

  void _onItemTapped(int index, BuildContext context, bool isKid) {
    if (!isKid && index == 2) {
      showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        builder: (context) => const AddPage(),
      );
      return;
    }
    final pages = isKid ? pagesIsKid : pagesIsNotKid;
    if (index >= 0 && index < pages.length && (isKid || index != 2)) {
      GoRouter.of(context).go(pages[index]);
    }
  }

  @override
  Widget build(BuildContext context) {
    final userRole = ref.watch(userProvider)?.role;
    final isKid = userRole == UserRole.kid;
    final selectedIndex = _getSelectedIndex(isKid);

    return Scaffold(
      body: widget.child,
      bottomNavigationBar: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          BottomNavigationBar(
            currentIndex: selectedIndex,
            onTap: (index) => _onItemTapped(index, context, isKid),
            type: BottomNavigationBarType.fixed,
            backgroundColor: Theme.of(context).colorScheme.surface,
            elevation: 0,
            selectedItemColor: Theme.of(context).colorScheme.primary,
            unselectedItemColor: Theme.of(context).colorScheme.onSurfaceVariant,
            showSelectedLabels: true,
            showUnselectedLabels: true,
            items: isKid
                ? const [
                    BottomNavigationBarItem(icon: Icon(Icons.home_rounded), label: 'Home'),
                    BottomNavigationBarItem(icon: Icon(Icons.search_rounded), label: 'Search'),
                    BottomNavigationBarItem(icon: Icon(Icons.mail_outline_rounded), label: 'Inbox'),
                    BottomNavigationBarItem(icon: Icon(Icons.account_circle_rounded), label: 'Profile'),
                  ]
                : [
                    const BottomNavigationBarItem(icon: Icon(Icons.home_rounded), label: 'Home'),
                    const BottomNavigationBarItem(icon: Icon(Icons.search_rounded), label: 'Search'),
                    const BottomNavigationBarItem(icon: SizedBox.shrink(), label: ''),
                    const BottomNavigationBarItem(icon: Icon(Icons.mail_outline_rounded), label: 'Inbox'),
                    const BottomNavigationBarItem(icon: Icon(Icons.account_circle_rounded), label: 'Profile'),
                  ],
          ),
          if (!isKid)
            Positioned(
              bottom: MediaQuery.of(context).padding.bottom,
              left: 0,
              right: 0,
              child: Center(
                child: Container(
                  height: 50,
                  width: 50,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.primary,
                    borderRadius: BorderSize.extraSmallRadius,
                    boxShadow: [
                      BoxShadow(
                        color: Theme.of(context).colorScheme.primary.withOpacity(0.3),
                        blurRadius: 8,
                        offset: const Offset(0, 4),
                      ),
                    ],
                    border: Border.all(
                      color: selectedIndex == 2
                          ? Theme.of(context).colorScheme.primary
                          : Theme.of(context).colorScheme.surface,
                      width: 2,
                    ),
                  ),
                  child: IconButton(
                    icon: const Icon(
                      Icons.add,
                      color: Colors.white,
                      size: 30,
                    ),
                    onPressed: () {
                      showModalBottomSheet(
                        context: context,
                        isScrollControlled: true,
                        builder: (context) => const AddPage(),
                      );
                    },
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
