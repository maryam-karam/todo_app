import 'package:easy_date_timeline/easy_date_timeline.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/features/settings-provider.dart';
import 'package:todo_app/features/tasks/widgets/task_item_widget.dart';

class TasksView extends StatefulWidget {
  TasksView({super.key});

  @override
  State<TasksView> createState() => _TasksViewState();
}

class _TasksViewState extends State<TasksView> {
  DateTime focusTime = DateTime.now();

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    var mediaQuery = MediaQuery.of(context).size;
    var vm=Provider.of<SettingsProvider>(context);

    return Column(
      children: [
        Stack(
          clipBehavior: Clip.none,
          alignment: Alignment(0,2.5),
          children: [
            Container(
              width: mediaQuery.width,
              height: mediaQuery.height * 0.2,
              color: theme.primaryColor,
              padding: const EdgeInsets.symmetric(vertical: 40, horizontal: 40),
              child: Text(
                "To Do List",
                style: theme.textTheme.titleLarge,
              ),
            ),
            EasyInfiniteDateTimeLine(
              firstDate: DateTime(2024),
              focusDate: focusTime,
              lastDate: DateTime(2025),
              showTimelineHeader: false,
              timeLineProps: const EasyTimeLineProps(
                separatorPadding: 20,
              ),
              dayProps: EasyDayProps(
                height: 100,
                inactiveDayStyle: DayStyle(
                    decoration: BoxDecoration(
                  color: vm.isDark()?Color(0xff141922):Colors.white,
                  borderRadius: BorderRadius.circular(10),
                ),
                  dayNumStyle: theme.textTheme.bodyMedium?.copyWith(
                    color: vm.isDark()?Colors.white:Colors.black,
                  ),
                  dayStrStyle: theme.textTheme.bodySmall?.copyWith(
                    color: vm.isDark()?Colors.white:Colors.black,
                  ),
                  monthStrStyle: theme.textTheme.bodySmall?.copyWith(
                    color: vm.isDark()?Colors.white:Colors.black,
                  ),
                ),
                activeDayStyle: DayStyle(
                  dayNumStyle: theme.textTheme.bodyMedium?.copyWith(
                    color: vm.isDark()?Colors.amber:theme.primaryColor,
                  ),
                  dayStrStyle: theme.textTheme.bodySmall?.copyWith(
                    color: vm.isDark()?Colors.amber:theme.primaryColor,
                  ),
                  monthStrStyle: theme.textTheme.bodySmall?.copyWith(
                    color: vm.isDark()?Colors.amber:theme.primaryColor,
                  ),
                  decoration: BoxDecoration(
                      color:vm.isDark()?Color(0xff141922):Colors.white,
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(
                        color: Colors.black38,
                      )),
                ),
                todayStyle: DayStyle(
                  dayNumStyle: theme.textTheme.bodyMedium?.copyWith(
                    color: vm.isDark()?Colors.grey: Colors.grey,
                  ),
                  dayStrStyle: theme.textTheme.bodySmall?.copyWith(
                    color: vm.isDark()?Colors.grey: Colors.grey,
                  ),
                  monthStrStyle: theme.textTheme.bodySmall?.copyWith(
                    color: vm.isDark()?Colors.grey: Colors.grey,
                  ),
                  decoration: BoxDecoration(
                      color: vm.isDark() ? Color(0xff141922):Colors.white,
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(
                        color: Colors.black38,
                      )),
                ),
              ),
              onDateChange: (selectedDate) {
                setState(() {
                  focusTime = selectedDate;
                });
              },
            ),
          ],
        ),
        SizedBox(height: 60,),
        Expanded(
            child: ListView(
          children: [
            TaskItemWidget(),
            TaskItemWidget(),
            TaskItemWidget(),
            TaskItemWidget(),
            TaskItemWidget(),
            TaskItemWidget(),
          ],
        )),
      ],
    );
  }
}
