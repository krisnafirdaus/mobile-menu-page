import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Mobile Menu Page',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blueGrey),
        useMaterial3: true,
      ),
      home: const MenuPage(),
    );
  }
}

class MenuPage extends StatefulWidget {
  const MenuPage({super.key});

  @override
  State<MenuPage> createState() => _MenuPageState();
}

class _MenuPageState extends State<MenuPage> {
  int? _selectedMenu;

  void _selectMenu(int menuNumber) {
    setState(() {
      _selectedMenu = menuNumber;
    });
  }

  void _printMenu(int menuNumber) {
    debugPrint('Menu $menuNumber');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: const Icon(Icons.add),
      ),
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            SliverToBoxAdapter(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: const [
                  _Header(),
                  SizedBox(height: 15),
                  _SummaryCards(),
                  SizedBox(height: 100),
                ],
              ),
            ),
            SliverPadding(
              padding: const EdgeInsets.fromLTRB(10, 0, 10, 24),
              sliver: SliverList.builder(
                itemCount: 20,
                itemBuilder: (context, index) {
                  final menuNumber = index + 1;
                  final isSelected = _selectedMenu == menuNumber;

                  return MenuItem(
                    menuNumber: menuNumber,
                    isSelected: isSelected,
                    onTap: () => _selectMenu(menuNumber),
                    onOkPressed: () => _printMenu(menuNumber),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _Header extends StatelessWidget {
  const _Header();

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        border: Border(bottom: BorderSide(color: Colors.black54)),
      ),
      padding: const EdgeInsets.fromLTRB(68, 24, 68, 18),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Main Page',
                  style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                    fontWeight: FontWeight.w600,
                    color: Colors.black,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  'Welcome',
                  style: Theme.of(
                    context,
                  ).textTheme.titleLarge?.copyWith(color: Colors.black87),
                ),
              ],
            ),
          ),
          TextButton(onPressed: () {}, child: const Text('Add')),
        ],
      ),
    );
  }
}

class _SummaryCards extends StatelessWidget {
  const _SummaryCards();

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        const sideSpace = 10.0;
        const itemGap = 15.0;
        final cardWidth =
            (constraints.maxWidth - (sideSpace * 2) - (itemGap * 2)) / 3;
        final cardHeight = cardWidth * 1.25;

        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: sideSpace),
          child: Row(
            children: [
              _SummaryCard(label: 'C1', width: cardWidth, height: cardHeight),
              const SizedBox(width: itemGap),
              _SummaryCard(label: 'C2', width: cardWidth, height: cardHeight),
              const SizedBox(width: itemGap),
              _SummaryCard(label: 'C3', width: cardWidth, height: cardHeight),
            ],
          ),
        );
      },
    );
  }
}

class _SummaryCard extends StatelessWidget {
  const _SummaryCard({
    required this.label,
    required this.width,
    required this.height,
  });

  final String label;
  final double width;
  final double height;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        border: Border.all(color: Colors.black54, width: 1.5),
      ),
      child: Text(
        label,
        style: Theme.of(context).textTheme.headlineSmall?.copyWith(
          color: Colors.black,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }
}

class MenuItem extends StatelessWidget {
  const MenuItem({
    super.key,
    required this.menuNumber,
    required this.isSelected,
    required this.onTap,
    required this.onOkPressed,
  });

  final int menuNumber;
  final bool isSelected;
  final VoidCallback onTap;
  final VoidCallback onOkPressed;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          InkWell(
            onTap: onTap,
            child: Container(
              height: 72,
              alignment: Alignment.centerLeft,
              padding: const EdgeInsets.symmetric(horizontal: 16),
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(color: Colors.black54, width: 1.5),
              ),
              child: Text(
                'Menu $menuNumber',
                style: Theme.of(
                  context,
                ).textTheme.titleLarge?.copyWith(color: Colors.black),
              ),
            ),
          ),
          if (isSelected)
            _InformationPanel(menuNumber: menuNumber, onOkPressed: onOkPressed),
        ],
      ),
    );
  }
}

class _InformationPanel extends StatelessWidget {
  const _InformationPanel({
    required this.menuNumber,
    required this.onOkPressed,
  });

  final int menuNumber;
  final VoidCallback onOkPressed;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 18),
      decoration: const BoxDecoration(
        color: Colors.white,
        border: Border(
          left: BorderSide(color: Colors.black54, width: 1.5),
          right: BorderSide(color: Colors.black54, width: 1.5),
          bottom: BorderSide(color: Colors.black54, width: 1.5),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  'Information',
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    color: Colors.black,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
              OutlinedButton(
                onPressed: onOkPressed,
                style: OutlinedButton.styleFrom(
                  foregroundColor: Colors.black,
                  side: const BorderSide(color: Colors.black54, width: 1.5),
                  shape: const RoundedRectangleBorder(),
                ),
                child: const Text('OK'),
              ),
            ],
          ),
          const SizedBox(height: 28),
          Text(
            'Name $menuNumber',
            style: Theme.of(
              context,
            ).textTheme.titleLarge?.copyWith(color: Colors.black),
          ),
          Text(
            'Address $menuNumber',
            style: Theme.of(
              context,
            ).textTheme.titleLarge?.copyWith(color: Colors.black),
          ),
        ],
      ),
    );
  }
}
