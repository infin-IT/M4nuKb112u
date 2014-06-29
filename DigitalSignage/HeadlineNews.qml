import QtQuick 2.0

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

    }
}
