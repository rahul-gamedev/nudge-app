import 'package:calendar_date_picker2/calendar_date_picker2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';
import 'package:nudge_app/domain/config/icon/icon_config.dart';
import 'package:nudge_app/domain/config/theme/app_color.dart';

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
          onPressed: () {
            final RenderBox button = context.findRenderObject() as RenderBox;
            final RenderBox overlay =
                Overlay.of(context).context.findRenderObject() as RenderBox;
            final position = button.localToGlobal(
              Offset.zero,
              ancestor: overlay,
            );
            final size = button.size;

            // Position menu at the right side of the screen
            final screenWidth = MediaQuery.of(context).size.width;

            showMenu(
              context: context,
              position: RelativeRect.fromLTRB(
                screenWidth - 170, // Position from right side (menu width ~160)
                position.dy + size.height,
                10, // Right padding
                0,
              ),
              elevation: 8,
              shadowColor: theme.shadowColor.withValues(alpha: .4),
              color: theme.scaffoldBackgroundColor,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              items: [
                PopupMenuItem(
                  value: 'journal',
                  child: Text(
                    'View Journal',
                    style: theme.textTheme.bodyMedium,
                  ),
                ),
                PopupMenuItem(
                  value: 'clear',
                  child: Text('Clear Chat', style: theme.textTheme.bodyMedium),
                ),
              ],
            ).then((value) {
              if (value != null) {
                // Handle menu item selection
                switch (value) {
                  case 'journal':
                    // Handle settings
                    break;
                  case 'clear':
                    // Handle profile
                    break;
                }
              }
            });
          },
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
    final dialogWidth =
        screenWidth * 0.85; // Slightly narrower for better aesthetics

    // Position directly below app bar
    final dialogPosition = Offset(
      (screenWidth - dialogWidth) / 2, // Center horizontally
      appBarOffset.dy + appBarSize.height + 4, // Below app bar with small gap
    );

    // Configure CalendarDatePicker2
    final config = CalendarDatePicker2Config(
      calendarType: CalendarDatePicker2Type.single,
      selectedDayHighlightColor: theme.primaryColor,
      weekdayLabels: ['S', 'M', 'T', 'W', 'T', 'F', 'S'],
      weekdayLabelTextStyle: TextStyle(
        color: AppColor.grey,
        fontWeight: FontWeight.bold,
        fontSize: 12,
      ),
      firstDayOfWeek: 0, // Monday
      controlsHeight: 40,
      selectedMonthTextStyle: TextStyle(
        color: theme.appBarTheme.foregroundColor,
      ),
      selectedYearTextStyle: TextStyle(
        color: theme.appBarTheme.foregroundColor,
      ),

      // // Add month builder for consistent styling
      // monthBuilder: ({
      //   decoration,
      //   isCurrentMonth,
      //   isDisabled,
      //   isSelected,
      //   required month,
      //   textStyle,
      // }) {
      //   // Style months to match years
      //   return Container(
      //     margin: EdgeInsets.symmetric(vertical: 4, horizontal: 8),
      //     decoration: BoxDecoration(
      //       color: isSelected == true ? theme.primaryColor : Colors.transparent,
      //       borderRadius: BorderRadius.circular(8),
      //       border:
      //           isCurrentMonth == true && isSelected != true
      //               ? Border.all(color: theme.primaryColor, width: 1)
      //               : null,
      //     ),
      //     child: Center(
      //       child: Text(
      //         DateFormat('MMM').format(DateTime(DateTime.now().year, month)),
      //         style:
      //             isSelected == true
      //                 ? TextStyle(
      //                   color: Colors.white,
      //                   fontWeight: FontWeight.bold,
      //                 )
      //                 : isDisabled == true
      //                 ? TextStyle(color: theme.disabledColor)
      //                 : isCurrentMonth == true
      //                 ? TextStyle(
      //                   color: theme.primaryColor,
      //                   fontWeight: FontWeight.bold,
      //                 )
      //                 : null,
      //       ),
      //     ),
      //   );
      // },

      // Update layout settings for better alignment
      centerAlignModePicker: true,
      dayTextStyle: theme.textTheme.bodyMedium!,
      selectedDayTextStyle: theme.textTheme.bodyMedium!.copyWith(
        color: Colors.white,
        fontWeight: FontWeight.bold,
      ),

      // Add header styling for consistency
      lastMonthIcon: Icon(Icons.chevron_left),
      nextMonthIcon: Icon(Icons.chevron_right),
    );

    // Show the calendar dialog
    final List<DateTime?>? results = await showDialog<List<DateTime?>>(
      context: context,
      useSafeArea: false,
      barrierColor: Colors.black.withValues(alpha: .5),
      builder: (BuildContext context) {
        return Stack(
          children: [
            // Barrier to detect taps outside dialog
            Positioned.fill(
              child: GestureDetector(
                onTap: () => Navigator.of(context).pop(),
                child: Container(color: Colors.transparent),
              ),
            ),

            // Calendar dialog
            Positioned(
              left: dialogPosition.dx,
              top: dialogPosition.dy,
              width: dialogWidth,
              child: AnimatedContainer(
                duration: Duration(milliseconds: 250),
                curve: Curves.easeOutCubic,
                child: Material(
                  borderRadius: BorderRadius.circular(16),
                  elevation: 8,
                  shadowColor: theme.shadowColor.withValues(alpha: .4),
                  color: theme.scaffoldBackgroundColor,
                  child: Padding(
                    padding: const EdgeInsets.all(12),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        // CalendarDatePicker2
                        CalendarDatePicker2(
                          config: config,
                          value: [selectedDate],
                          onValueChanged: (dates) {
                            if (dates.isNotEmpty) {
                              setState(() {
                                selectedDate = dates.first;
                              });
                              Navigator.of(context).pop(dates);
                            }
                          },
                        ),

                        // Today button remains the same...
                        Padding(
                          padding: const EdgeInsets.only(top: 4),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              TextButton(
                                onPressed: () {
                                  final today = DateTime.now();
                                  setState(() {
                                    selectedDate = today;
                                  });
                                  Navigator.of(context).pop([today]);
                                },
                                style: TextButton.styleFrom(
                                  foregroundColor: theme.primaryColor,
                                  padding: EdgeInsets.symmetric(
                                    horizontal: 12,
                                    vertical: 6,
                                  ),
                                  tapTargetSize:
                                      MaterialTapTargetSize.shrinkWrap,
                                ),
                                child: Text(
                                  "Today",
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                              ),
                            ],
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

    if (results != null && results.isNotEmpty && results.first != null) {
      setState(() {
        selectedDate = results.first!;
      });
    }
  }
}
