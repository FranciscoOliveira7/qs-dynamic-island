pragma ComponentBehavior: Bound

import Quickshell
import Quickshell.Io
import QtQuick
import ".."

Item {
  id: root

  property string searchQuery: ""
  property int selectedIndex: 0
  readonly property bool isSelected: searchQuery.trim() !== ""

  implicitWidth: 420
  implicitHeight: panel.height

  readonly property bool isSearching: searchQuery.trim() !== ""

  // Call this from the viewHost Loader
  function forceInputFocus() {
      searchInput.forceActiveFocus();
  }

  property var filteredApps: {
    var q = searchQuery.trim().toLowerCase();
    var vals = DesktopEntries.applications.values;

    if (q !== "") {
      return vals.filter(function (e) {
        if (e.name.toLowerCase().indexOf(q) !== -1) {
          return true;
        }
        if (e.genericName && e.genericName.toLowerCase().indexOf(q) !== -1) {
          return true;
        }
        for (var i = 0; i < e.keywords.length; i++) {
          if (e.keywords[i].toLowerCase().indexOf(q) !== -1)
            return true;
        }
        return false;
      }).sort(function (a, b) {
        return a.name.localeCompare(b.name);
      });
    }

    var recent = AppLauncherState.recentIds;
    return vals.slice().sort(function (a, b) {
      var ai = recent.indexOf(a.id);
      var bi = recent.indexOf(b.id);
      if (ai !== -1 && bi !== -1)
        return ai - bi;
      if (ai !== -1)
        return -1;
      if (bi !== -1)
        return 1;
      return a.name.localeCompare(b.name);
    });
  }

  Process {
    running: false
    id: launchProcess
    command: [ "kitty" ]
  }

  function launchEntry(entry) {
    AppLauncherState.recordLaunch(entry.id);
    if (entry.runInTerminal) {
      const terminalCommand = ["kitty", "-e" ]
      const runWithTerminal = terminalCommand.concat(entry.command)
      launchProcess.command = runWithTerminal
    }
    else {
      launchProcess.command = entry.command
    }
      console.log(launchProcess.command)
    launchProcess.workingDirectory = entry.workingDirectory
    launchProcess.startDetached()
    // launchProcess.running = true
    AppLauncherState.hide();
  }

  function navigate(delta) {
    if (filteredApps.length === 0)
      return;
    selectedIndex = (selectedIndex + delta + filteredApps.length) % filteredApps.length;
    listView.positionViewAtIndex(selectedIndex, ListView.Contain);
  }

  function reset() {
    searchInput.text = "";
    root.searchQuery = "";
    root.selectedIndex = 0;
    searchInput.forceActiveFocus();
  }

  readonly property int maxVisible: 7
  readonly property int itemH: 48
  readonly property int panelW: root.implicitWidth - 20
  readonly property int panelH: 74 + Math.min(filteredApps.length, maxVisible) * itemH

  Rectangle {
    id: panel
    width: root.panelW
    height: root.panelH
    color: "transparent"

    anchors.horizontalCenter: parent.horizontalCenter
    anchors.top: parent.top
    anchors.topMargin: 10

    Column {
      anchors {
        top: parent.top
        left: parent.left
        right: parent.right
      }
      spacing: 10

      // SearchBox
      Rectangle {
        width: parent.width
        height: 44
        radius: 10
        color: Theme.base

        Row {
          anchors {
            fill: parent
            leftMargin: 14
            rightMargin: 14
          }
          spacing: 10

          Item {
            width: parent.width - 40
            height: parent.height

            TextInput {
              id: searchInput
              anchors.fill: parent
              color: Theme.textPrimary
              selectionColor: Theme.green
              focus: true
              font {
                pixelSize: 13
                family: "JetBrainsMono Nerd Font"
              }
              verticalAlignment: TextInput.AlignVCenter
              clip: true

              onTextEdited: root.searchQuery = text
              onAccepted: {
                if (root.filteredApps.length > 0)
                  root.launchEntry(root.filteredApps[root.selectedIndex]);
              }

              Keys.onPressed: function (event) {
                if (event.key === Qt.Key_Up) {
                  root.navigate(-1);
                  event.accepted = true;
                } else if (event.key === Qt.Key_Down) {
                  root.navigate(1);
                  event.accepted = true;
                } //else if (event.key === Qt.Key_Return || event.key === Qt.Key_Enter) {
                //   if (root.filteredApps.length > 0)
                //     root.launchEntry(root.filteredApps[root.selectedIndex]);
                //   event.accepted = true;
                //}
                else if (event.key === Qt.Key_Escape) {
                  AppLauncherState.hide();
                  event.accepted = true;
                }
              }
            }
          }
        }
      }

      // ── App list ───────────────────────────────────────────────────
      ListView {
        id: listView
        width: parent.width
        height: Math.min(root.filteredApps.length, root.maxVisible) * root.itemH
        model: root.filteredApps
        clip: true
        interactive: false

        // Wheel on list (belt-and-suspenders alongside panel MouseArea)
        MouseArea {
          anchors.fill: parent
          onWheel: function (wheel) {
            if (wheel.angleDelta.y < 0)
              root.navigate(1);
            else
              root.navigate(-1);
          }
        }

        Text {
          anchors.centerIn: parent
          visible: root.filteredApps.length === 0
          text: "No apps found"
          color: Theme.textPrimary
          opacity: 0.28
          font {
            pixelSize: 13
            family: "JetBrainsMono Nerd Font"
          }
        }

        // highlight: Rectangle {
        //   // anchors.fill: parent
        // }
        // highlightFollowsCurrentItem: true

        delegate: Item {
          id: appRow
          width: listView.width
          height: root.itemH

          required property int index
          required property var modelData
          readonly property bool sel: root.selectedIndex === index
          readonly property bool isRecent: !root.isSearching && AppLauncherState.recentIds.indexOf(appRow.modelData.id) !== -1 && AppLauncherState.recentIds.indexOf(appRow.modelData.id) < 5

          Rectangle {
            anchors {
              fill: parent
              topMargin: 2
              bottomMargin: 2
            }
            radius: 10
            color: appRow.sel ? Theme.textPrimary : "transparent"

            Row {
              anchors {
                fill: parent
                leftMargin: 8
                rightMargin: 8
              }
              spacing: 12

              // Icon bubble
              Rectangle {
                width: 36
                height: 36
                radius: 9
                anchors.verticalCenter: parent.verticalCenter
                // color: appRow.sel ? Theme.borderHover : Qt.rgba(1, 1, 1, 0.08)
                color: "transparent"

                Image {
                  id: appIcon
                  anchors.centerIn: parent
                  width: 28
                  height: 28
                  source: appRow.modelData.icon !== "" ? "image://icon/" + appRow.modelData.icon : ""
                  // sourceSize.width: 28
                  // sourceSize.height: 28
                  smooth: true
                  mipmap: true
                }

                Text {
                  anchors.centerIn: parent
                  visible: appIcon.status !== Image.Ready
                  text: appRow.modelData.name.charAt(0).toUpperCase()
                  font {
                    pixelSize: 15
                    family: "JetBrainsMono Nerd Font"
                    weight: Font.Bold
                  }
                  color: appRow.sel ? Theme.green : Theme.textPrimary
                }
              }

              // Name + subtitle
              Column {
                anchors.verticalCenter: parent.verticalCenter
                spacing: 2

                Text {
                  text: appRow.modelData.name
                  font {
                    pixelSize: 13
                    family: "JetBrainsMono Nerd Font"
                    weight: appRow.sel ? Font.Medium : Font.Normal
                  }
                  color: appRow.sel ? Theme.background : Theme.textPrimary
                }

                // "Recently used" pill OR generic name
                Row {
                  spacing: 6
                  visible: appRow.isRecent || appRow.modelData.genericName !== ""

                  Rectangle {
                    visible: appRow.isRecent
                    width: recentLabel.width + 8
                    height: 14
                    radius: 4
                    color: Qt.rgba(Theme.border.r, Theme.border.g, Theme.border.b, 0.22)
                    anchors.verticalCenter: parent.verticalCenter

                    Text {
                      id: recentLabel
                      anchors.centerIn: parent
                      text: "recent"
                      font {
                        pixelSize: 9
                        family: "JetBrainsMono Nerd Font"
                      }
                      color: Theme.border
                    }
                  }

                  Text {
                    visible: appRow.modelData.genericName !== ""
                    text: appRow.modelData.genericName
                    font {
                      pixelSize: 11
                      family: "JetBrainsMono Nerd Font"
                    }
                    color: appRow.sel ? Theme.background : Theme.textPrimary
                    opacity: 0.35
                    anchors.verticalCenter: parent.verticalCenter
                  }
                }
              }
            }

            MouseArea {
              anchors.fill: parent
              hoverEnabled: true
              onEntered: root.selectedIndex = appRow.index
              onClicked: root.launchEntry(appRow.modelData)
              onWheel: function (wheel) {
                if (wheel.angleDelta.y < 0)
                  root.navigate(1);
                else
                  root.navigate(-1);
              }
            }
          }
        }
      }
    }
  }
}
