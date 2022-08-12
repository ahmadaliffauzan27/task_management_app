import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:date_time_picker/date_time_picker.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:ionicons/ionicons.dart';
import 'package:task_management_app/app/routes/app_pages.dart';
import 'package:task_management_app/app/utils/style/Appcolors.dart';
import 'package:task_management_app/app/utils/widget/header.dart';
import 'package:task_management_app/app/utils/widget/sidebar.dart';

import '../../../data/controller/auth_controller.dart';
import '../controllers/task_controller.dart';

class TaskView extends GetView<TaskController> {

  final GlobalKey<ScaffoldState> _drawerKey = GlobalKey();
  final authCon = Get.find<AuthController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _drawerKey,
      drawer: const SizedBox(width: 150, child: Sidebar()),
      backgroundColor: AppColors.primaryBg,
      body: SafeArea(
        child: Row(
          children: [
          !context.isPhone ? const Expanded(
            flex: 2,
            child: Sidebar(),
            ): const SizedBox(),
          Expanded(
            flex: 15,
            child: Column(children: [
              !context.isPhone 
              ? const header()
              : Container(padding: EdgeInsets.all(20),
              child: Row(
                children: [
                  IconButton(
                    onPressed: () {
                      _drawerKey.currentState!.openDrawer();
                    }, 
                    icon: Icon(
                      Icons.menu, 
                      color: AppColors.primaryText,
                      ),
              ),
              const SizedBox(
                width: 15),
                const SizedBox(
                width: 15),
              Column(
              //mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
               Text(
                'Task Management', 
                style: TextStyle(
                  fontSize: 20,
                  color: AppColors.primaryText,
                  ),
                  ),
               Text(
                'Manage Task Made Easy', 
                style: TextStyle(
                  fontSize: 10  ,
                  color: AppColors.primaryText,
                  ),
                ),
              ]),
              const Spacer(),
              const Icon(
                Ionicons.notifications, color: AppColors.primaryText, size: 30,
              ),
              const SizedBox(
                width: 15),
              ClipRRect(
                borderRadius: BorderRadius.circular(30),
              child: const CircleAvatar(
                backgroundColor: Colors.amber, 
                radius: 25, 
                foregroundImage: NetworkImage('https://assets.pikiran-rakyat.com/crop/0x0:0x0/x/photo/2022/06/26/4162943265.jpg'),
              ),
              )
            ]),
          ),
                //content atau isi page
                Expanded(
                  child: Container(
                    padding: !context.isPhone 
                      ? const EdgeInsets.all(50)
                      : const EdgeInsets.all(20),
                      
                      margin: !context.isPhone 
                      ? const EdgeInsets.all(10)
                      : const EdgeInsets.all(0),
                      decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: !context.isPhone 
                      ? BorderRadius.circular(50)
                      : BorderRadius.circular(30),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                                    'My Task', 
                                  style: TextStyle(
                                    color: AppColors.primaryText, 
                                    fontSize: 30,
                                    ),
                                    ),
                                     const SizedBox(height: 20,
                                    ),
                          Expanded(
                            // stream user for get task list
                            child: StreamBuilder<DocumentSnapshot<Map<String, dynamic>>>(
                              stream: authCon.streamUsers(authCon.auth.currentUser!.email!),
                              builder: (context, snapshot) {
                                if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(child: CircularProgressIndicator());
                    }
                    // get task id
                    var taskId = (snapshot.data!.data() 
                    as Map<String, dynamic>)
                    ['task_id'] as List;
                                return ListView.builder(
                                  itemCount: taskId.length,
                                  clipBehavior: Clip.antiAlias,
                                    shrinkWrap: true, 
                                    itemBuilder: (context, index){
                                      return StreamBuilder<DocumentSnapshot<Map<String, dynamic>>>(
                                        stream: authCon.streamTask(taskId[index]),
                                        builder: (context, snapshot2) {
                                           if (snapshot2.connectionState == ConnectionState.waiting) {
                                             return const Center(child: CircularProgressIndicator());
                                            }

                                            // data task
                                            var dataTask = snapshot2.data!.data();

                                            // data user photo
                                            var dataUserList = (snapshot2.data!.data() 
                                            as Map<String, dynamic>)
                                            ['asign_to'] as List;

                                          return GestureDetector(
                                            onLongPress: () {
                                             // addEditTask(
                                             //   context: context, 
                                             //   type: 'Update', 
                                             //   docId: '2022-08-12T22:21:15.534325',
                                             //   );
                                            },
                                            child: Container(
                                              height: 200,
                                              decoration: BoxDecoration(
                                                borderRadius: BorderRadius.circular(20),
                                                color: AppColors.cardBg,
                                                ),
                                                margin: const EdgeInsets.all(10),
                                                padding: const EdgeInsets.all(20),
                                                child: Column(
                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                  children: [Row(
                                                    
                                                    children: [
                                                      StreamBuilder<DocumentSnapshot<Map<String, dynamic>>>(
                                                        stream: authCon.streamUsers(dataUserList[index]),
                                                        builder: (context, snapshot) {
                                                          return ClipRRect(
                                                            borderRadius: BorderRadius.circular(25),
                                                            child: const CircleAvatar(
                                                              backgroundColor: Colors.amber, 
                                                              radius: 20, 
                                                                          foregroundImage: NetworkImage('https://assets.pikiran-rakyat.com/crop/0x0:0x0/x/photo/2022/06/26/4162943265.jpg'),
                                                                          ),
                                                                          );
                                                        }
                                                      ),
                                                        Spacer(),
                                                        Container(
                                                          height: 25, 
                                                          width: 80, 
                                                          color: AppColors.primaryBg, 
                                                          child: Center(
                                                                      child: Text(
                                                                        '${dataTask!['status']} %', 
                                                    style: TextStyle(
                                                      color: AppColors.primaryText, 
                                                      
                                                      ),
                                                                        ),
                                                                        ),
                                                                        ),
                                                    ],
                                                  ),
                                                  Spacer(),
                                                  Container(
                                                  height: 25, 
                                                  width: 80, 
                                                  color: AppColors.primaryBg, 
                                                  child: Center(
                                                  child: Text(
                                                    '${dataTask['total_task_finished']} / ${dataTask['total_task']} Task',
                                                    style: TextStyle(
                                                      color: AppColors.primaryText, 
                                                      
                                                      ),
                                                  ),
                                                  ),
                                                  ),
                                                  Text(
                                                    dataTask['title'], 
                                                    style: TextStyle(
                                                      color: AppColors.primaryText, 
                                                      fontSize: 20,
                                                      ),
                                                      ),
                                                      Text(
                                                    dataTask['descriptions'], 
                                                    style: TextStyle(
                                                      color: AppColors.primaryText, 
                                                      fontSize: 15,
                                                      ),
                                                      ),
                                                        
                                                        ]),
                                            ),
                                          );
                                        }
                                      );
                                  
                                    },
                                      );
                              }
                            ),
                          ),
                        ],
                      ),
                    ),
                    ),
                ]),
            ),
        ],
        ),
      ),
      floatingActionButton: Align(
        alignment: Alignment(0.93, 0.93),
        child: FloatingActionButton.extended(
            onPressed: (){
           addEditTask(
            context: context, type: 'Add', docId: '',
             );
            }, 
            label: const Text(
              'Add Task',
              ), 
              icon: const Icon(
                Ionicons.add,
          ),
        ),
      ),
    );
  }

  addEditTask({BuildContext? context, String? type, String? docId}){
       Get.bottomSheet(
                SingleChildScrollView(
                  child: Container(
                    padding: const EdgeInsets.only(top: 10, left: 10, right: 10),
                    margin: context!.isPhone 
                      ? EdgeInsets.zero
                      : const EdgeInsets.only(
                        left: 150, right: 150,
                        ),
                    //height: Get.height,
                    decoration: const BoxDecoration(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(20), 
                        topRight: Radius.circular(20),
                         ), 
                      color: Colors.white,
                      ),
                      child: Form(
                        key: controller.formKey,

                        child: Column(
                          children: [
                            Text(
                              '$type Task',
                              style: const TextStyle(
                                color: AppColors.primaryText,
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                ),
                              ),
                              SizedBox(
                                height: 5,
                              ),
                            TextFormField(
                          decoration: InputDecoration(
                          hintText: 'Title',
                          border: OutlineInputBorder(borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        controller: controller.titleController,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Can not be empty';
                          }
                          return null;
                        },
                        ),
                        SizedBox(
                                height: 5,
                              ),
                        TextFormField(
                          keyboardType: TextInputType.multiline,
                          maxLines: 5,
                          decoration: InputDecoration(
                          hintText: 'Description',
                          border: OutlineInputBorder(borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        controller: controller.descriptionsController,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Can not be empty';
                          }
                          return null;
                        },
                        ),
                        SizedBox(
                                height: 5,
                              ),
                              DateTimePicker(
                                firstDate: DateTime.now(),
                                lastDate: DateTime(2100),
                                dateLabelText: 'Due Date',
                                decoration:InputDecoration(
                                  hintText: 'Due Date',
                          border: OutlineInputBorder(borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        controller: controller.dueDateController,
                                validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Can not be empty';
                          }
                          return null;
                        },
                        ),
                        SizedBox(
                                height: 5,
                              ),
                              ConstrainedBox(
                                constraints: 
                                BoxConstraints.tightFor(width: Get.width, height: 40),
                              child: ElevatedButton(
                                onPressed: () {
                                controller.saveUpdateTask(
                                  controller.titleController.text, 
                                  controller.descriptionsController.text,
                                  controller.dueDateController.text,
                                  docId!,
                                  type!,
                                  );
                              }, 
                              child: Text(type!),
                              ),
                              ),
                              SizedBox(
                                height: 5,
                              ),
                      ])
                      ,)
                    ),
                ),
                );
  }
}

