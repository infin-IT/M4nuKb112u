import QtQuick 2.1
import QtQuick.Window 2.1
import "Scaling.js" as Scales

Window
{
    id: wdw
    visible: true
    width:432
    height:768


    color:"black"

    //BackgroundChanger Module
    //Rotating Background
    BackgroundChanger{}

    Loader
    {
        id:load1
        width: parent.width
        height: parent.height
        source: "MetroMenu.qml"
    }

    Loader
    {
        id:load2
        width: parent.width
        height: parent.height
    }

    Connections
    {
        target: load1.item

        onToTimeline:
        {
            //console.debug("halojohn>>>>>>>>>>>>>>>>>>>>>>")
            load1.setSource("Timeline.qml")
        }

    }
}


