part of dashboard;

class _MainMenu extends StatelessWidget {
  const _MainMenu({
    required this.onSelected,
    Key? key,
  }) : super(key: key);

  final Function(int index, SelectionButtonData value) onSelected;

  @override
  Widget build(BuildContext context) {
    return SelectionButton(
      data: [
        SelectionButtonData(
          activeIcon: EvaIcons.home,
          icon: EvaIcons.homeOutline,
          label: "Home",
        ),
        // SelectionButtonData(
        //   activeIcon: EvaIcons.bell,
        //   icon: EvaIcons.bellOutline,
        //   label: "Notifications",
        // ),
        SelectionButtonData(
          activeIcon: EvaIcons.checkmarkCircle2,
          icon: EvaIcons.checkmarkCircle,
          label: "All Machines",
        ),
        // SelectionButtonData(
        //   activeIcon: EvaIcons.settings,
        //   icon: EvaIcons.settingsOutline,
        //   label: "Settings",
        // ),
        SelectionButtonData(
          activeIcon: EvaIcons.trendingUp,
          icon: EvaIcons.trendingUpOutline,
          label: "GGR",
        ),
        SelectionButtonData(
          activeIcon: EvaIcons.checkmarkCircle2,
          icon: EvaIcons.checkmarkCircle,
          label: "Jenkins",
        ),
        SelectionButtonData(
          activeIcon: EvaIcons.trendingUp,
          icon: EvaIcons.trendingUpOutline,
          label: "Selenoid",
        ),
        SelectionButtonData(
          activeIcon: EvaIcons.people,
          icon: EvaIcons.peopleOutline,
          label: "Teams",
        ),
        SelectionButtonData(
          activeIcon: EvaIcons.archive,
          icon: EvaIcons.archiveOutline,
          label: "MongoDB",
        ),
      ],
      onSelected: onSelected,
    );
  }
}
