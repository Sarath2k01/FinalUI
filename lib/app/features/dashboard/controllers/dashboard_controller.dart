part of dashboard;

class DashboardController extends GetxController {
  RxInt myindex = 0.obs;
  final scafoldKey = GlobalKey<ScaffoldState>();

  final dataProfil = const UserProfileData(
    image: AssetImage(ImageRasterPath.man),
    name: "Cloud Self Serve Portal",
  );

  final member = ["Avril Kimberly", "Michael Greg"];

  final dataTask = const TaskProgressData(totalTask: 5, totalCompleted: 1);

  final taskInProgress = [
    CardTaskData(
      label: "Team Sanity",
      jobDesk: "CI CD",
      dueDate: DateTime.now().add(const Duration(minutes: 50)),
    ),
    CardTaskData(
    label: "Team Sanity",
    jobDesk: "CI CD",
    dueDate: DateTime.now().add(const Duration(minutes: 50)),
  ),
  CardTaskData(
    label: "Team Sanity",
    jobDesk: "CI CD",
    dueDate: DateTime.now().add(const Duration(minutes: 50)),
  ),
    CardTaskData(
      label: "Regression",
      jobDesk: "PipeLine",
      dueDate: DateTime.now().add(const Duration(hours: 4)),
    ),
    CardTaskData(
      label: "Fraud & Security",
      jobDesk: "BlackDuck",
      dueDate: DateTime.now().add(const Duration(days: 2)),
    ),
    CardTaskData(
      label: "AIML",
      jobDesk: "AIML Team",
      dueDate: DateTime.now().add(const Duration(minutes: 50)),
    )
  ];

  final duplicatedTaskInProgress = [
  const DuplicateCardTaskData(
    label: "Total Machine Count",
    //jobDesk: "CI CD",
    //dueDate: DateTime.now().add(const Duration(minutes: 50)),
    numberOfMachines: 6,
  ),
  const DuplicateCardTaskData(
    label: "Machines Online",
    //jobDesk: "CI CD",
    //dueDate: DateTime.now().add(const Duration(minutes: 50)),
    numberOfMachines: 6,
  ),
  const DuplicateCardTaskData(
    label: "Machines Offline",
    //jobDesk: "CI CD",
    //dueDate: DateTime.now().add(const Duration(minutes: 50)),
    numberOfMachines: 6,
  ),
  // const DuplicateCardTaskData(
  //     label: "Regression",
  //     //jobDesk: "PipeLine",
  //     //dueDate: DateTime.now().add(const Duration(hours: 4)),
  //     numberOfMachines: 6,
  //   ),
  //   const DuplicateCardTaskData(
  //     label: "Fraud & Security",
  //     //jobDesk: "BlackDuck",
  //     //dueDate: DateTime.now().add(const Duration(days: 2)),
  //     numberOfMachines: 6,
  //   ),
  //   const DuplicateCardTaskData(
  //     label: "AIML",
  //     //jobDesk: "AIML Team",
  //     //dueDate: DateTime.now().add(const Duration(minutes: 50)),
  //     numberOfMachines: 6,
  //   )
];

  final weeklyTask = [
    const ListTaskAssignedData(
      icon: Icon(EvaIcons.monitor, color: Colors.blueGrey),
      label: "Load Balancer Issue Solved",
      jobDesk: "Not able to establish connection with MongoDB",
      // assignTo: "Alex Ferguso",
      editDate: 'May 14, 2023 @ 7:30 AM',
    ),
    const ListTaskAssignedData(
      icon: Icon(EvaIcons.monitor, color: Colors.blueGrey),
      label: "MongoDB Latency Issue",
      jobDesk: "Query Timeout",
      // assignTo: "Justin Beck",
      editDate: 'May 14, 2023 @ 7:30 AM',
    ),
    //  const ListTaskAssignedData(
    //   icon: Icon(EvaIcons.colorPalette, color: Colors.blue),  
    //   label: "UI UX ",
    //   jobDesk: "Design",
    // ),
    //  const ListTaskAssignedData(
    //   icon: Icon(EvaIcons.pieChart, color: Colors.redAccent),
    //   label: "Determine meeting schedule ",
    //   jobDesk: "System Analyst",
    // ),
  ];

  final taskGroup = [
    [
      ListTaskDateData(
        date: DateTime.now().add(const Duration(days: 2, hours: 10)),
        label: "5 posts on instagram",
        jobdesk: "Marketing",
      ),
      ListTaskDateData(
        date: DateTime.now().add(const Duration(days: 2, hours: 11)),
        label: "Platform Concept",
        jobdesk: "Animation",
      ),
    ],
    [
      ListTaskDateData(
        date: DateTime.now().add(const Duration(days: 4, hours: 5)),
        label: "UI UX Marketplace",
        jobdesk: "Design",
      ),
      ListTaskDateData(
        date: DateTime.now().add(const Duration(days: 4, hours: 6)),
        label: "Create Post For App",
        jobdesk: "Marketing",
      ),
    ],
    [
      ListTaskDateData(
        date: DateTime.now().add(const Duration(days: 6, hours: 5)),
        label: "2 Posts on Facebook",
        jobdesk: "Marketing",
      ),
      ListTaskDateData(
        date: DateTime.now().add(const Duration(days: 6, hours: 6)),
        label: "Create Icon App",
        jobdesk: "Design",
      ),
      ListTaskDateData(
        date: DateTime.now().add(const Duration(days: 6, hours: 8)),
        label: "Fixing Error Payment",
        jobdesk: "Programmer",
      ),
      ListTaskDateData(
        date: DateTime.now().add(const Duration(days: 6, hours: 10)),
        label: "Create Form Interview",
        jobdesk: "System Analyst",
      ),
    ]
  ];

  void onPressedProfil() {}

  void onSelectedMainMenu(int index, SelectionButtonData value) {
    myindex.value = index;
  }
  void onSelectedTaskMenu(int index, String label) {}

  void searchTask(String value) {}

  void onPressedTask(int index, ListTaskAssignedData data) {}
  void onPressedAssignTask(int index, ListTaskAssignedData data) {}
  void onPressedMemberTask(int index, ListTaskAssignedData data) {}
  void onPressedCalendar() {}
  void onPressedTaskGroup(int index, ListTaskDateData data) {}

  void openDrawer() {
    if (scafoldKey.currentState != null) {
      scafoldKey.currentState!.openDrawer();
    }
  }
}
