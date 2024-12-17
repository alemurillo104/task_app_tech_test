import 'package:flutter/material.dart';
import '../../domain/enums/task_status.enum.dart';
import '../../domain/mappers/task.enum.mapper.dart';

class FilterTaskBottomSheetWidget extends StatefulWidget {
  final String? currentTaskStatusSelected;
  final ValueChanged<TaskStatus> onFilterButtonPressed;
  final Function()? onClearFilterPressed;

  const FilterTaskBottomSheetWidget({
    super.key,
    required this.onFilterButtonPressed,
    this.onClearFilterPressed,
    required this.currentTaskStatusSelected,
  });

  @override
  State<FilterTaskBottomSheetWidget> createState() =>
      _FilterTaskBottomSheetWidgetState();
}

class _FilterTaskBottomSheetWidgetState
    extends State<FilterTaskBottomSheetWidget> {
  String? taskStatusSelected;

  List<String> statusList = [TaskStatus.pending, TaskStatus.completed]
      .map((task) => TaskStatusMapper.fromEnumtoLiteralString(task))
      .toList();
  bool _disableButton = false;

  void get textValue {
    setState(() {
      _disableButton = taskStatusSelected != null;
    });
  }

  @override
  void initState() {
    taskStatusSelected = widget.currentTaskStatusSelected;
    textValue;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8),
        child: ClipRRect(
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(24),
            topRight: Radius.circular(24),
          ),
          child: Padding(
            padding: const EdgeInsets.only(
              left: 10,
              right: 10,
              bottom: 29,
              top: 5,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 24),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Filtrar tareas',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                    IconButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      icon: const Icon(Icons.close),
                    )
                  ],
                ),
                const SizedBox(height: 10),
                RadioMenuButton(
                  value: statusList[0],
                  groupValue: taskStatusSelected,
                  onChanged: (value) {
                    taskStatusSelected = value;
                    textValue;
                  },
                  child: Text(statusList[0]),
                ),
                RadioMenuButton(
                  value: statusList[1],
                  groupValue: taskStatusSelected,
                  onChanged: (value) {
                    taskStatusSelected = value;
                    textValue;
                  },
                  child: Text(statusList[1]),
                ),
                const SizedBox(height: 24),
                InkWell(
                  borderRadius: BorderRadius.circular(20),
                  onTap: () {
                    if (widget.onClearFilterPressed != null) {
                      widget.onClearFilterPressed!();
                    }
                    textValue;
                    Navigator.pop(context);
                  },
                  child: Container(
                    height: 50,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: const Center(
                        child: Text(
                      'Limpiar filtros',
                      style: TextStyle(
                        color: Colors.deepPurpleAccent,
                        fontWeight: FontWeight.w500,
                      ),
                    )),
                  ),
                ),
                const SizedBox(height: 8),
                InkWell(
                  borderRadius: BorderRadius.circular(20),
                  onTap: !_disableButton
                      ? null
                      : () {
                          widget.onFilterButtonPressed(
                            TaskStatusMapper.fromLiteralStringtoEnum(
                              taskStatusSelected!,
                            ),
                          );
                          Navigator.pop(context);
                        },
                  child: Container(
                    height: 50,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: !_disableButton
                          ? Colors.black12
                          : Colors.blue.shade100,
                    ),
                    child: const Center(child: Text('Aplicar filtros')),
                  ),
                ),
                const SizedBox(
                  height: 12,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
