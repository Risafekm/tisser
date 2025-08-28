// features/lead/presentation/pages/add_edit_lead_page.dart
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tisser_app/features/auth/presentation/widgets/custom_button.dart';
import 'package:tisser_app/features/auth/presentation/widgets/my_textfield.dart';
import 'package:tisser_app/features/task/domain/entities/task_entities.dart';
import 'package:tisser_app/features/task/presentation/bloc/task_bloc.dart';
import 'package:tisser_app/features/task/presentation/bloc/task_event.dart';

class AddEditTaskPage extends StatefulWidget {
  final TaskEntity? task;

  const AddEditTaskPage({this.task, super.key});

  @override
  State<AddEditTaskPage> createState() => _AddEditTaskPageState();
}

class _AddEditTaskPageState extends State<AddEditTaskPage> {
  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();
  String _selectedStatus = 'New';

  final List<String> _statusOptions = ['New', 'Pending', 'Qualified', 'Closed'];

  @override
  void initState() {
    super.initState();
    if (widget.task != null) {
      _titleController.text = widget.task!.title;
      _descriptionController.text = widget.task!.description;
      _selectedStatus = widget.task!.status;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.task == null ? 'Add Task' : 'Edit Task'),
        backgroundColor: Colors.deepOrange,
        foregroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              MyTextFiled(
                controller: _titleController,
                text: 'Task Title',
                icon: Icons.title,
              ),
              const SizedBox(height: 16),
              MyTextFiled(
                controller: _descriptionController,
                text: 'Task Description',
                icon: Icons.description,
                maxLines: 3,
              ),
              const SizedBox(height: 16),
              DropdownButtonFormField(
                value: _selectedStatus,
                items:
                    _statusOptions.map((status) {
                      return DropdownMenuItem(
                        value: status,
                        child: Text(status),
                      );
                    }).toList(),
                onChanged: (value) {
                  setState(() {
                    _selectedStatus = value!;
                  });
                },
                decoration: const InputDecoration(
                  labelText: 'Status',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.stairs),
                ),
              ),
              const SizedBox(height: 24),
              CustomButton(
                title: widget.task == null ? 'Add Task' : 'Update Task',
                onPressed: () {
                  final lead = TaskEntity(
                    id: widget.task?.id,
                    title: _titleController.text,
                    description: _descriptionController.text,
                    status: _selectedStatus,
                    createdDate: widget.task?.createdDate ?? DateTime.now(),
                  );

                  if (widget.task == null) {
                    context.read<TaskBloc>().add(AddTaskEvent(lead));
                  } else {
                    context.read<TaskBloc>().add(UpdateTaskEvent(lead));
                  }

                  Navigator.pop(context);
                },
              ),
              const SizedBox(height: 50), // extra space for keyboard
            ],
          ),
        ),
      ),
    );
  }
}
