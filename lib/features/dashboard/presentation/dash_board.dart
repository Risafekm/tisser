import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tisser_app/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:tisser_app/features/auth/presentation/bloc/auth_events.dart';
import 'package:tisser_app/features/auth/presentation/pages/login_page.dart';
import 'package:tisser_app/features/task/presentation/bloc/task_bloc.dart';
import 'package:tisser_app/features/task/presentation/bloc/task_state.dart';

class DashBoard extends StatelessWidget {
  const DashBoard({super.key});

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: const SystemUiOverlayStyle(
        statusBarColor: Colors.deepOrange, // notch/status bar background
        statusBarIconBrightness: Brightness.light, // icons white
      ),
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(90),
          child: Padding(
            padding: const EdgeInsets.only(top: 30),
            child: AppBar(
              title: const Text(
                'Dashboard',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              backgroundColor: Colors.white,
              foregroundColor: Colors.deepOrange,
              elevation: 1,
              actions: [
                IconButton(
                  onPressed: () {
                    context.read<AuthBloc>().add(SignOutEvent());
                    Navigator.of(context).pushReplacement(
                      MaterialPageRoute(builder: (context) => LoginScreen()),
                    );
                  },
                  icon: const Icon(Icons.logout),
                ),
              ],
            ),
          ),
        ),
        body: BlocBuilder<TaskBloc, TaskState>(
          builder: (context, state) {
            int totalTaskCount = 0;
            Map<String, int> statusCounts = {
              'New': 0,
              'Pending': 0,
              'Qualified': 0,
              'Closed': 0,
            };

            if (state is TaskLoaded) {
              totalTaskCount = state.tasks.length;
              for (var task in state.tasks) {
                if (statusCounts.containsKey(task.status)) {
                  statusCounts[task.status] = statusCounts[task.status]! + 1;
                }
              }
            }

            return SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Task Overview',
                      style: GoogleFonts.lora(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                    const SizedBox(height: 16),
                    // Total Task Count Card
                    Card(
                      elevation: 4,
                      child: Container(
                        height: 110, // reduced 10px height
                        width: double.infinity,
                        padding: const EdgeInsets.all(16),
                        child: Row(
                          children: [
                            const Icon(
                              Icons.task,
                              size: 36, // slightly smaller icon
                              color: Colors.deepOrange,
                            ),
                            const SizedBox(width: 16),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Text(
                                  'Total Tasks',
                                  style: TextStyle(
                                    fontSize: 15, // reduced font size
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                Text(
                                  '$totalTaskCount',
                                  style: const TextStyle(
                                    fontSize: 26, // reduced from 32 → 26
                                    fontWeight: FontWeight.bold,
                                    color: Colors.deepOrange,
                                  ),
                                ),
                              ],
                            ),
                            const Spacer(),
                            const Icon(
                              Icons.arrow_forward_ios,
                              size: 18,
                              color: Colors.grey,
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 24),
                    const Text(
                      'Tasks by Status',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 16),
                    GridView.count(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      crossAxisCount: 2,
                      crossAxisSpacing: 16, // reduced spacing
                      mainAxisSpacing: 16,
                      childAspectRatio:
                          1.04, // makes card smaller (height reduced)
                      children: [
                        _buildStatusCard(
                          'New',
                          statusCounts['New']!,
                          Colors.blue,
                          Icons.fiber_new,
                        ),
                        _buildStatusCard(
                          'Pending',
                          statusCounts['Pending']!,
                          Colors.orange,
                          Icons.access_time,
                        ),
                        _buildStatusCard(
                          'Qualified',
                          statusCounts['Qualified']!,
                          Colors.green,
                          Icons.check_circle,
                        ),
                        _buildStatusCard(
                          'Closed',
                          statusCounts['Closed']!,
                          Colors.red,
                          Icons.cancel,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildStatusCard(
    String status,
    int count,
    Color color,
    IconData icon,
  ) {
    return Card(
      elevation: 3,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(color: color, width: 1.5),
          borderRadius: BorderRadius.circular(14),
        ),
        child: Padding(
          padding: const EdgeInsets.all(12.0), // reduced padding
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Icon(icon, size: 28, color: color), // smaller icon
              const SizedBox(height: 10),
              Text(
                status,
                style: TextStyle(
                  fontSize: 14, // reduced from 16
                  fontWeight: FontWeight.w600,
                  color: color,
                ),
              ),
              const SizedBox(height: 6),
              Text(
                '$count',
                style: const TextStyle(
                  fontSize: 22, // reduced from 28
                  fontWeight: FontWeight.bold,
                  color: Colors.deepOrange,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
