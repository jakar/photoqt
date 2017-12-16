import QtQuick 2.6

Item {

    // Element radius is the radius of "windows" (e.g., About or Quicksettings)
    // Item radius is the radius of smaller items (e.g., spinbox)
    readonly property int global_element_radius: 10
    readonly property int global_item_radius: 5

    property bool guiBlocked: false

    property int totalNumberImagesCurrentFolder: 0
    property int currentFilePos: -1
    property string currentFile: ""
    property string filter: ""

}
