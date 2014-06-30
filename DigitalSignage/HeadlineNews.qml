import QtQuick 2.0
import "Scaling.js" as Scales

Rectangle {
    id:masterContainer
    anchors.fill:parent
    /* _________________________
      |                         |
      |        Image            | 70%
      |_________________________|
      | Title                   | 30%
      |_Short Definition________|
    */

    Image
    {
        id:newsImage
        width: parent.width
        height: newsImage.sourceSize.height * parent.width/newsImage.sourceSize.width
    }

    Rectangle
    {
        anchors.bottom: parent.bottom
        anchors.bottomMargin: 0
        anchors.left: parent.left
        anchors.leftMargin: 0
        anchors.right: parent.right
        anchors.rightMargin: 0

        height: Scales.scaleY(parent,30)

    }
}
