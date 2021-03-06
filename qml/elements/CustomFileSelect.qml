/**************************************************************************
 **                                                                      **
 ** Copyright (C) 2018 Lukas Spies                                       **
 ** Contact: http://photoqt.org                                          **
 **                                                                      **
 ** This file is part of PhotoQt.                                        **
 **                                                                      **
 ** PhotoQt is free software: you can redistribute it and/or modify      **
 ** it under the terms of the GNU General Public License as published by **
 ** the Free Software Foundation, either version 2 of the License, or    **
 ** (at your option) any later version.                                  **
 **                                                                      **
 ** PhotoQt is distributed in the hope that it will be useful,           **
 ** but WITHOUT ANY WARRANTY; without even the implied warranty of       **
 ** MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the        **
 ** GNU General Public License for more details.                         **
 **                                                                      **
 ** You should have received a copy of the GNU General Public License    **
 ** along with PhotoQt. If not, see <http://www.gnu.org/licenses/>.      **
 **                                                                      **
 **************************************************************************/

import QtQuick 2.5

Rectangle {

    id: ele_top

    // default sizing
    width: 300
    height: 30

    // no bg color
    color: "transparent"

    // this will hold any changed filepath
    property string file: filepath.text

    Rectangle {

        id: ed1

        // some geometry
        x: 3
        y: (parent.height-height)/2
        height: 30
        width: parent.width-selbut.width-6

        // some styling
        color: colour.element_bg_color_disabled
        radius: 5
        border.width: 1
        border.color: colour.element_border_color_disabled

        // Rectangle that will hold the selected filename
        Text {
            id: filepath
            anchors.fill: parent
            anchors.leftMargin: 5
            anchors.rightMargin: 5
            color: colour.text
            verticalAlignment: Text.AlignVCenter
            clip: true
            elide: Text.ElideLeft

            // Empty info message displayed when no file is selected
            Text {
                anchors.fill: parent
                color: colour.text_inactive
                opacity: 0.7
                verticalAlignment: Text.AlignVCenter
                visible: filepath.text == ""
                clip: true
                text: em.pty+qsTr("Click here to select a configuration file")
            }

        }

        // Click on rectangle requests new file
        MouseArea {
            anchors.fill: parent
            hoverEnabled: true
            cursorShape: Qt.PointingHandCursor
            onClicked: getConfigFile()
        }

    }

    // Button to request new file
    CustomButton {
        id: selbut
        text: "..."
        x: ed1.x+ed1.width+3
        width: 50
        onClickedButton: getConfigFile()
    }

    // request user to select a new file
    function getConfigFile() {
        var startfolder = getanddostuff.getHomeDir()
        if(filepath.text != "")
            startfolder = filepath.text
        //: PhotoQt config file = configuration file
        var str = getanddostuff.getFilename(em.pty+qsTr("Select PhotoQt config file..."),startfolder,
                                            //: PhotoQt config file = configuration file
                                            em.pty+qsTr("PhotoQt Config Files") + " (*.pqt);;"
                                              + em.pty+qsTr("All Files") + " (*.*)")
        if(str !== "")
            filepath.text = str
    }

    // clear file selection
    function clearText() {
        filepath.text = ""
    }

}
