import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:nudge_app/domain/config/icon/icon_config.dart';
import 'package:intl/intl.dart';

class ChatAppBar extends StatefulWidget implements PreferredSizeWidget {
  final VoidCallback? onMenuPressed;

  const ChatAppBar({super.key, this.onMenuPressed});

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  State<ChatAppBar> createState() => _ChatAppBarState();
}

class _ChatAppBarState extends State<ChatAppBar> {
  DateTime selectedDate = DateTime.now();
  final GlobalKey _appBarKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final String formattedDate = DateFormat(
      'EEE, d MMM yyyy',
    ).format(selectedDate);

    return AppBar(
      key: _appBarKey,
      title: ElevatedButton.icon(
        onPressed: () => showCalendarDialog(context),
        label: Text(formattedDate, style: theme.textTheme.headlineSmall),
        icon: SvgPicture.asset(
          IconConfig.chevronDown,
          semanticsLabel: "Menu",
          colorFilter: ColorFilter.mode(
            theme.appBarTheme.foregroundColor!,
            BlendMode.srcIn,
          ),
          height: 18,
        ),
        iconAlignment: IconAlignment.end,
        style: ElevatedButton.styleFrom(
          backgroundColor: theme.appBarTheme.backgroundColor,
          elevation: 0,
          shadowColor: Colors.transparent,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        ),
      ),
      centerTitle: true,
      leadingWidth: 68,
      forceMaterialTransparency: true,
      leading: IconButton(
        onPressed: () {
          if (widget.onMenuPressed != null) {
            widget.onMenuPressed!();
          } else {
            Scaffold.of(context).openDrawer();
          }
        },
        icon: SvgPicture.asset(
          IconConfig.menu,
          semanticsLabel: "Menu",
          colorFilter: ColorFilter.mode(
            theme.appBarTheme.foregroundColor!,
            BlendMode.srcIn,
          ),
        ),
      ),
      actions: [
        IconButton(
          onPressed: () {},
          icon: SvgPicture.asset(
            IconConfig.ellipsis,
            colorFilter: ColorFilter.mode(
              theme.appBarTheme.foregroundColor!,
              BlendMode.srcIn,
            ),
          ),
          color: theme.appBarTheme.foregroundColor,
        ),
      ],
    );
  }

  void showCalendarDialog(BuildContext context) async {
    final theme = Theme.of(context);

    // Get the position of the app bar
    final RenderBox? renderBox =
        _appBarKey.currentContext?.findRenderObject() as RenderBox?;
    if (renderBox == null) return;

    final appBarSize = renderBox.size;
    final appBarOffset = renderBox.localToGlobal(Offset.zero);

    // Calculate position for the dialog
    final screenWidth = MediaQuery.of(context).size.width;
    final dialogWidth = screenWidth * 0.9; // 90% of screen width

    // Position directly below app bar
    final dialogPosition = Offset(
      (screenWidth - dialogWidth) / 2, // Center horizontally
      appBarOffset.dy + appBarSize.height + 8, // Below app bar with small gap
    );

    // Show our custom calendar dialog at specific position
    final DateTime? result = await showDialog<DateTime>(
      context: context,
      barrierColor:
          Colors.transparent, // Optional: makes background transparent
      useSafeArea: false, // Allow positioning outside safe area
      builder: (BuildContext context) {
        return Stack(
          children: [
            // Barrier to detect taps outside dialog
            Positioned.fill(
              child: GestureDetector(
                onTap: () => Navigator.of(context).pop(),
                child: Container(color: Colors.black54),
              ),
            ),

            // Calendar dialog
            Positioned(
              left: dialogPosition.dx,
              top: dialogPosition.dy,
              width: dialogWidth,
              child: Theme(
                data: theme.copyWith(
                  // All your existing theme customizations
                  colorScheme: theme.colorScheme.copyWith(
                    primary: theme.primaryColor,
                    onPrimary: Colors.white,
                    surface: theme.scaffoldBackgroundColor,
                    onSurface: theme.textTheme.bodyLarge!.color!,
                  ),
                  datePickerTheme: DatePickerThemeData(
                    // Your existing date picker theme
                    dayStyle: TextStyle(color: theme.colorScheme.onSurface),
                    dayForegroundColor: WidgetStateProperty.resolveWith<Color>((
                      states,
                    ) {
                      if (states.contains(WidgetState.selected)) {
                        return Colors.white;
                      }
                      return theme.colorScheme.onSurface;
                    }),
                    dayBackgroundColor: WidgetStateProperty.resolveWith<Color>((
                      states,
                    ) {
                      if (states.contains(WidgetState.selected)) {
                        return theme.primaryColor;
                      }
                      return Colors.transparent;
                    }),
                    todayForegroundColor: WidgetStateProperty.all(
                      theme.primaryColor,
                    ),
                    todayBackgroundColor: WidgetStateProperty.all(
                      Colors.transparent,
                    ),
                    todayBorder: BorderSide(
                      color: theme.primaryColor,
                      width: 1,
                    ),
                    dayShape: WidgetStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(8)),
                      ),
                    ),

                    headerHelpStyle: TextStyle(fontSize: 0),
                    headerForegroundColor: Colors.transparent,
                    headerHeadlineStyle: TextStyle(fontSize: 0),
                    headerBackgroundColor: Colors.transparent,
                  ),
                ),
                child: Material(
                  borderRadius: BorderRadius.circular(16),
                  elevation: 8,
                  color: theme.scaffoldBackgroundColor,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      vertical: 16.0,
                      horizontal: 8.0,
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        SizedBox(
                          height: 320,
                          child: CalendarDatePicker(
                            initialDate: selectedDate,
                            firstDate: DateTime(2020),
                            lastDate: DateTime(2030),
                            onDateChanged: (newDate) {
                              setState(() {
                                selectedDate = newDate;
                              });
                              Navigator.of(context).pop(newDate);
                            },
                            initialCalendarMode: DatePickerMode.day,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );

    if (result != null) {
      setState(() {
        selectedDate = result;
      });
    }
  }
}
