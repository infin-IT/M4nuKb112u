import QtQuick 2.0
import "Scaling.js" as Scales
import "Positioning.js" as Pos

Rectangle
{
    property int space: 100
    id: containerMaster

    anchors.right: parent.right
    anchors.rightMargin: Scales.scaleX(parent,5)
    anchors.left: parent.left
    anchors.leftMargin: Scales.scaleX(parent,5)
    anchors.bottom: parent.bottom
    anchors.bottomMargin: Scales.scaleX(parent,5)
    anchors.top: parent.top
    anchors.topMargin: Scales.scaleX(parent,5)

    color:"transparent"
    property string path: "http://192.168.0.102/DigitalSignage/MetroMenu/"
    property string icon_path: "images/icon/"

    //Setting Fonts
    property string metrofont_color:"white"
    property string metrofont_font: segoeUI.name
    property string metrofont_size_h1:Scales.scaleY(parent,3)
    property string metrofont_size_p:Scales.scaleY(parent,1)

    FontLoader
    {
        source: path+"fonts/segoeui.ttf"
        id:segoeUI
    }


    signal toTimeline()

    /*
            Layout:

         [Digital Clock]+[Weather]
             __________________
            |                  | 1
            |    News Feed     |
            |__________________|
             ______  __________
          2 |      || Timeline | 3
            | MAP  ||          |
            |______||          |
             ______ |          |
          4 |      ||__________|
            |SIASAT| __________
            |______||    CC    | 5
                    |__________|
        */

    //CONTAINER 0
    Rectangle
    {
        id:container0
        x:0
        y:0
        width: parent.width
        height: Scales.scaleY(containerMaster,20)
        color:"transparent"

        //CONTAINER DIGITAL CLOCK
        Rectangle
        {
            id:containerDC
            x:0
            y:0
            width:Scales.scaleX(parent,70)
            height: parent.height
            color:"transparent"
            DigitalClock{}
        }

        //CONTAINER WEATHER
        Rectangle
        {
            id:containerW
            width:Scales.scaleX(parent,30)
            height: parent.height
            x:Pos.rightOf(containerDC,0)
            y:0
            color:"transparent"
            Weather{}
        }

    }

    //CONTAINER 1
    Rectangle
    {
        id:container1
        y:Pos.bottomOf(container0,0)
        anchors.left:parent.left
        anchors.leftMargin: 0
        anchors.right: parent.right
        anchors.rightMargin: 0
        height: Scales.scaleY(parent,20)
        color:"#603cba"
        antialiasing: true
        //border.color: "white"
        opacity: 1

        Text
        {
            anchors.centerIn: parent
            text:"News Feed"
            font.pixelSize:metrofont_size_h1
            font.family: metrofont_font
            color:metrofont_color
        }

        MouseArea
        {
            anchors.fill:parent
            onClicked:
            {
                load1.source= "Timeline.qml"
            }
        }
    }

    //CONTAINER 2
    Rectangle
    {
        id:container2
        y:Pos.bottomOf(container1,10)
        width: Scales.scaleX(parent,50)-10
        height: width
        color:"#b91d47"
        antialiasing: true
        //border.color: "black"
        opacity: 1



        Text
        {
            id:txtTitleContainer2
            anchors.horizontalCenter: parent.horizontalCenter
            y:Scales.scaleY(parent,60)
            text:"Map"
            font.pixelSize: metrofont_size_h1
            color:metrofont_color
            font.family: metrofont_font
        }

        Image
        {
            antialiasing: true
            anchors.horizontalCenter: parent.horizontalCenter
            y:Pos.topOf(txtTitleContainer2,height)
            source:path+icon_path+"map.png"
            width:Scales.scaleX(parent,40)
            height:width
        }


        MouseArea
        {
            anchors.fill:parent
            onClicked:
            {
                load1.source= "Timeline.qml"
            }
        }
    }

    //CONTAINER 3
    Rectangle
    {
        id:container3
        y:Pos.bottomOf(container1,10)
        x:Pos.rightOf(container2,10)
        width: Scales.scaleX(parent,50)
        height: Scales.scaleY(parent,33)-10
        color:"#00a300"
        antialiasing: true
        //border.color: "black"
        opacity: 1

        Text
        {
            anchors.centerIn: parent
            text:"Timeline"
            font.pixelSize: metrofont_size_h1
            color:metrofont_color
            font.family: metrofont_font
        }

        MouseArea
        {
            anchors.fill:parent
            onClicked:
            {
                toTimeline()
            }
        }
    }

    //CONTAINER 4
    Rectangle
    {
        id:container4
        y:Pos.bottomOf(container2,10)
        width: Scales.scaleX(parent,50)-10
        height: width
        color:"#00aba9"
        antialiasing: true
        //border.color: "black"
        opacity: 1

        Text
        {
            anchors.centerIn: parent
            text:"SIASAT"
            font.pixelSize: metrofont_size_h1
            color:metrofont_color
            font.family: metrofont_font
        }

        MouseArea
        {
            anchors.fill:parent
            onClicked:
            {
                load1.source= "Timeline.qml"
            }
        }
    }

    //CONTAINER 5
    Rectangle
    {
        id:container5
        y:Pos.bottomOf(container3,10)
        x:Pos.rightOf(container2,10)
        width: Scales.scaleX(parent,50)
        height: Scales.scaleY(parent,22)
        color:"#2d89ef"
        antialiasing: true
        //border.color: "black"
        opacity: 1

        Text
        {
            anchors.centerIn: parent
            text:"Campus Care"
            font.pixelSize: metrofont_size_h1
            font.family: metrofont_font
            color:metrofont_color
        }

        MouseArea
        {
            anchors.fill:parent
            onClicked:
            {
                load1.source= "Timeline.qml"
            }
        }
    }

}




