import QtQuick 2.6

MouseArea {

    anchors.fill: parent

    hoverEnabled: true
    propagateComposedEvents: true

    onPositionChanged: {
        handleMousePositionChange(mouse.x, mouse.y)
    }

    // We pass those on to below, to keep the main image movable
    onClicked: mouse.accepted = false
    onPressed: mouse.accepted = false
    onReleased: mouse.accepted = false
    onPressAndHold: mouse.accepted = false

    function handleMousePositionChange(xPos, yPos) {

        if(xPos > mainwindow.width-20)
            mainmenu.show()
        else
            mainmenu.hide()

        if(xPos < 20)
            metadata.show()
        else
            metadata.hide()

        if(yPos > mainwindow.height-20)
            call.show("thumbnails")
        else
            call.hide("thumbnails")

    }

}
