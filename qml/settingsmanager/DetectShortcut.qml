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

import "../elements"
import "../shortcuts/mouseshortcuts.js" as AnalyseMouse

Rectangle {

    id: detect_top

    anchors.fill: parent
    color: "#ee000000"

    opacity: 0
    Behavior on opacity { NumberAnimation { duration: variables.animationSpeed } }
    visible: (opacity!=0)

    property string category: "key"

    signal gotNewShortcut(var sh)
    signal abortedShortcutDetection()

    // The top row displaying icons for the two categories
    Item {

        id: toprow

        // size and position
        anchors {
            left: parent.left
            right: parent.right
            top: parent.top
        }
        height: 150

        // This item contains the icon and is centered in the rectangle
        Item {

            // Centered, a little smaller in height than the parent
            x: (parent.width-width)/2
            y: (parent.height-height)/2
            width: categoryKey.width+categoryMouse.width+50
            height: 100

            // Mouse shortcut
            Image {
                id: categoryMouse
                opacity: detect_top.category=="mouse" ? 1 : 0.2
                width: 100
                height: 100
                source: "qrc:/img/settings/shortcuts/categorymouse.png"
            }

            // Keyboard shortcut
            Image {
                id: categoryKey
                opacity: detect_top.category=="key" ? 1 : 0.2
                x: categoryMouse.width+50
                width: 100
                height: 100
                source: "qrc:/img/settings/shortcuts/categorykeyboard.png"
            }

        }

    }

    // Separator line
    Rectangle {
        anchors {
            left: parent.left
            right: parent.right
            top: toprow.bottom
        }
        height: 1
        color: "white"
    }

    // The area in the middle displays the performed shortcut and is the hotarea for mouse shortcut detection
    Text {

        id: combo

        // position and size
        anchors {
            top: toprow.bottom
            left: parent.left
            right: parent.right
            bottom: bottomrow.top
        }

        verticalAlignment: Qt.AlignVCenter
        horizontalAlignment: Qt.AlignHCenter

        color: "white"
        font.pointSize: 30
        font.bold: true
        textFormat: Text.RichText
        wrapMode: Text.WrapAtWordBoundaryOrAnywhere

        // display either key or mouse combo
        text: strings.translateShortcut(currentCombo)

        property string currentCombo: "..."

        onTextChanged: {
            var already = shortcuts.setKeyShortcuts[combo.currentCombo]
            if(already !== undefined) {
                var count = already[0]
                alreadySet.shTxt = ""
                for(var i = 2; i < already.length; i+=2) {
                    var title = variables.shortcutTitles[already[i]]
                    if(title === undefined) title = already[i]
                    alreadySet.shTxt += title + "<br>"
                }
            } else
                alreadySet.shTxt = ""
        }

        Text {

            id: alreadySet

            anchors {
                right: parent.right
                top: parent.top
                rightMargin: 10
                topMargin: 10
            }

            color: "grey"
            font.pointSize: 15
            font.bold: true
            horizontalAlignment: Text.AlignHCenter

            property string shTxt: ""

            visible: (opacity!=0)
            opacity: shTxt==""?0:1
            Behavior on opacity { NumberAnimation { duration: 100 } }

            text: qsTr("Shortcut also already set for the following:") + "<br><br>" + shTxt

        }

    }

    // Separator line
    Rectangle {
        anchors {
            left: parent.left
            right: parent.right
            bottom: bottomrow.top
        }
        height: 1
        color: "white"
    }

    // An area at the bottom for cancel/ok buttons and instruction text
    Item {

        id: bottomrow

        // size and position
        anchors {
            left: parent.left
            right: parent.right
            bottom: parent.bottom
        }
        height: 150

        // Button to cancel
        CustomButton {

            id: cancelbut

            // size and position
            anchors {
                left: parent.left
                leftMargin: 5
                top: parent.top
                topMargin: 5
                bottom: parent.bottom
                bottomMargin: 5
            }
            width: parent.height*3

            // some font styling
            fontsize: 30
            fontBold: true

            text: em.pty+qsTr("Cancel")

            onClickedButton: {
                abortedShortcutDetection()
                hide()
            }

        }

        Text {

            // size and position
            anchors {
                left: cancelbut.right
                leftMargin: 10
                right: okbut.left
                rightMargin: 10
                top: parent.top
                bottom: parent.bottom
            }

            // some styling
            font.pointSize: 15
            font.bold: true
            wrapMode: Text.WordWrap
            horizontalAlignment: Qt.AlignHCenter
            verticalAlignment: Qt.AlignVCenter
            color: "white"

            text: em.pty+qsTr("Perform any mouse action or press any key combination.") + "\n"
                  + em.pty+qsTr("When your satisfied, click the button to the right.")

        }

        CustomButton {

            id: okbut

            // size and position
            anchors {
                right: parent.right
                rightMargin: 5
                top: parent.top
                topMargin: 5
                bottom: parent.bottom
                bottomMargin: 5
            }
            width: parent.height*3

            // some styling
            fontsize: 30
            fontBold: true

            text: em.pty+qsTr("Set shortcut")

            onClickedButton: {
                gotNewShortcut(combo.currentCombo)
                hide()
            }

        }

    }

    Connections {
        target: call
        onShortcut: {
            // ignore if not visible
            if(!detect_top.visible) return
            if(!combo.mouseEventInProgress) {
                combo.currentCombo = sh
                category = "key"
            }
        }
    }

    MouseArea {

        anchors.fill: combo

        hoverEnabled: true
        acceptedButtons: Qt.LeftButton|Qt.MiddleButton|Qt.RightButton

        property point pressedPosStart: Qt.point(-1,-1)
        property point pressedPosEnd: Qt.point(-1,-1)

        property bool mouseEventInProgress: false
        property int buttonId: 0

        onPositionChanged:
            handleMousePositionChange(mouse)
        onPressed: {
            buttonId = mouse.button
            mouseEventInProgress = true
            pressedPosStart = Qt.point(mouse.x, mouse.y)
            variables.shorcutsMouseGesturePointIntermediate = Qt.point(-1,-1)
        }
        onReleased: {
            var txt = AnalyseMouse.analyseMouseEvent(pressedPosStart, mouse, buttonId)
            if(txt !== "") {
                category = "mouse"
                combo.currentCombo = txt
            }
            pressedPosEnd = Qt.point(mouse.x, mouse.y)
            pressedPosStart = Qt.point(-1,-1)
            mouseEventInProgress = false
        }
        onWheel: {
            var txt = AnalyseMouse.analyseWheelEvent(wheel, true)
            if(txt !== "") {
                combo.currentCombo = txt
                wheelEventDone.start()
            }
        }
        Timer {
            id: wheelEventDone
            interval: 1000
            repeat: false
            onTriggered: {
                variables.wheelUpDown = 0
                variables.wheelLeftRight = 0
            }
        }

        function handleMousePositionChange(mouse) {

            if(pressedPosStart.x !== -1 || pressedPosStart.y !== -1) {
                var before = variables.shorcutsMouseGesturePointIntermediate
                if(variables.shorcutsMouseGesturePointIntermediate.x === -1 || variables.shorcutsMouseGesturePointIntermediate.y === -1)
                    before = pressedPosStart
                AnalyseMouse.analyseMouseGestureUpdate(mouse.x, mouse.y, before)
                var txt = AnalyseMouse.analyseMouseEvent(pressedPosStart, mouse, buttonId, true)
                if(txt !== "") {
                    category = "mouse"
                    combo.currentCombo = txt
                }
            }

        }

    }

    function show() {
        combo.currentCombo = "..."
        opacity = 1
    }

    function hide() {
        opacity = 0
    }


}
