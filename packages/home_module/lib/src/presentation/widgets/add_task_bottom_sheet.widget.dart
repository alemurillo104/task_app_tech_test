import 'package:flutter/material.dart';
import 'package:common_module/common_module.dart';
import 'package:common_dependency_module/common_dependency_module.dart';
import '../blocs/addTask/add_task_bloc.dart';
import '../../domain/entities/task.entity.dart';
import '../../domain/mappers/task.enum.mapper.dart';

class AddTaskBottomSheetWidget extends StatefulWidget {
  final AddTaskBloc addTaskBloc;

  const AddTaskBottomSheetWidget({
    super.key,
    required this.addTaskBloc,
  });

  @override
  State<AddTaskBottomSheetWidget> createState() =>
      _AddTaskBottomSheetWidgetState();
}

class _AddTaskBottomSheetWidgetState extends State<AddTaskBottomSheetWidget> {
  final _nameController = TextEditingController();
  final _descriptionController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  final _statusTypes = <String>[
    'Pendiente',
    'Completado',
  ];
  String? _statusSelected;
  bool _disableButton = false;

  late final LoadingWidget loading;

  @override
  void initState() {
    loading = LoadingWidget(context);
    super.initState();
  }

  void get textValue {
    setState(() {
      _disableButton = _nameController.text.isNotEmpty &&
          _descriptionController.text.isNotEmpty &&
          _statusSelected != null;
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AddTaskBloc, AddTaskState>(
      bloc: widget.addTaskBloc,
      listener: (context, state) {
        switch (state.status) {
          case AddTaskStatus.success:
            loading.hideOverlay();
            logger.d('se agrego todo okay');
            Navigator.pop(context);
            break;
          case AddTaskStatus.loading:
            loading.showOverlay();
            break;
          case AddTaskStatus.failure:
            loading.hideOverlay();
            showDialogWidget(
              context,
              title: 'Ocurrio un error',
              description: 'Intentalo nuevamente en un momento.',
            );
            break;
          default:
        }
      },
      child: WillPopScope(
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
              child: Form(
                key: formKey,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 24),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          'Agregar tarea',
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
                    CustomTextFormFieldComponent(
                      controller: _nameController,
                      label: 'Nombre',
                      onChanged: (value) => textValue,
                    ),
                    const SizedBox(height: 12),
                    CustomTextFormFieldComponent(
                      controller: _descriptionController,
                      label: 'Descripcion',
                      onChanged: (value) => textValue,
                    ),
                    const SizedBox(height: 24),
                    const Text('Estado de la tarea'),
                    const SizedBox(height: 10),
                    DropdownInputWidget(
                      items: _statusTypes,
                      value: _statusSelected,
                      onChanged: (value) => setState(() {
                        _statusSelected = value!;
                        textValue;
                      }),
                    ),
                    const SizedBox(height: 24),
                    InkWell(
                      borderRadius: BorderRadius.circular(20),
                      onTap: !_disableButton
                          ? null
                          : () {
                              widget.addTaskBloc.add(
                                TaskAdded(
                                  Task(
                                    name: _nameController.text,
                                    description: _descriptionController.text,
                                    status: TaskStatusMapper
                                        .fromLiteralStringtoEnum(
                                      _statusSelected!,
                                    ),
                                  ),
                                ),
                              );
                            },
                      child: Container(
                        height: 50,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: !_disableButton
                              ? Colors.black12
                              : Colors.deepPurpleAccent,
                        ),
                        child: Center(
                          child: Text(
                            'Agregar nueva tarea',
                            style: TextStyle(
                              color:
                                  !_disableButton ? Colors.black : Colors.white,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
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
        ),
      ),
    );
  }
}
