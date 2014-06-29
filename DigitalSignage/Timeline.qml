import QtQuick 2.1
import QtQuick.Window 2.1
import "Scaling.js" as S
import QtQuick.XmlListModel 2.0

Rectangle
{
    property int n;
    id:tlW
    width: (9/16)*Screen.height
    height: Screen.height
    visible: true
    color:"#EEF7F0"
    Image {
        id: img1
        source: "landscape4.jpg"
        height: parent.height
        width: img1.sourceSize.width * parent.height/img1.sourceSize.height
        anchors.verticalCenter: parent.verticalCenter
        anchors.horizontalCenter: parent.horizontalCenter
    }
    AnimatedImage {
        id: loading
        playing: true
        source: "loading.gif"
        height: S.scaleX(parent,20)

        width: S.scaleX(parent,20)
        anchors.verticalCenter: parent.verticalCenter
        anchors.horizontalCenter: parent.horizontalCenter
        visible: false
    }
    Flickable {
        id: flickable1
        anchors.right: parent.right
        anchors.rightMargin: 0
        anchors.left: parent.left
        anchors.leftMargin: 0
        anchors.bottom: parent.bottom
        anchors.bottomMargin: 0
        anchors.top: parent.top
        anchors.topMargin: 100
        boundsBehavior: Flickable.DragAndOvershootBounds
        interactive: true
        flickableDirection: Flickable.VerticalFlick
        clip:true
        contentHeight: parent.height*2

        /*main Rectangle (flickable)*/

        Rectangle
        {
            id: rectFlick
            width:flickable1.width
            height:parent.height*2
            color:"transparent"

            //Left Docking Rectangle
            Rectangle {
                id: rDockLeft
                width: parent.width/2-30
                height: parent.height
                color: "transparent"
                anchors.left: parent.left
                anchors.leftMargin: S.scaleX(parent,2)
                ListView {
                    id: lvLeft
                    interactive: false
                    anchors.fill: parent
                    delegate:Item{
                        width: rDockLeft.width
                        height: 200
                        Rectangle
                        {
                            width:rDockLeft.width
                            height: itemTitleLeft.height*1.5+90
                            color:"transparent"
                            MouseArea
                            {
                                anchors.fill: parent;
                                onClicked:
                                {
                                    loadView.setSource("AgendaViewer.qml");
                                    loadView.item.opacity=1;
                                    loadView.item.webAddress=wAddress;
                                }
                            }
                            Image {
                                id: bubleLeft
                                source: "bubble_left.png"
                                anchors.fill: parent
                            }
                            Text
                            {
                                id:dateLeft
                                x:S.scaleX(parent,5)
                                y:S.scaleY(parent,5)
                                font.pixelSize: S.scaleY(parent,22)
                                text:dateTextLeft
                            }
                            Text
                            {
                                id:dayLeft
                                x:S.scaleX(parent,25)
                                y:S.scaleY(parent,5)
                                font.pixelSize: 25
                                text:dayTextLeft
                            }
                            Text
                            {
                                id:monthLeft
                                x:S.scaleX(parent,25)
                                y:S.scaleY(parent,25)
                                font.pixelSize: 15
                                color: "#9A9A9A"
                                text:monthTextLeft
                            }
                            Text
                            {
                                id:yearLeft
                                x:monthLeft.x+monthLeft.width+S.scaleX(parent,1)
                                y:S.scaleY(parent,25)
                                font.pixelSize: 15
                                font.bold: true
                                text:yearTextLeft
                            }
                            Text
                            {
                                id:itemTitleLeft
                                x:S.scaleX(parent,5)
                                y:S.scaleY(parent,50)
                                text:itemText
                                color:"#A5A5A5"
                                width:parent.width-S.scaleX(parent,25)
                                wrapMode: Text.WordWrap
                            }
                        }
                    }
                    model: lmLeft
                }
            }


            /*Center Docking Rectangle*/

            Rectangle {
                id: rDockCenter
                width: S.scaleX(parent,3)
                height: parent.height
                color: "transparent"
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.leftMargin: S.scaleX(parent,2)

                ListView {
                    id: lvCenter
                    interactive: false
                    anchors.fill: parent
                    delegate: Item
                    {
                    width: S.scaleX(rDockCenter,100)
                    height: 200
                    anchors.horizontalCenter:parent.horizontalCenter
                    Rectangle {
                        y:50
                        width: S.scaleX(parent,20)
                        height: 200
                        color: "#37B0BA"
                        anchors.horizontalCenter:parent.horizontalCenter
                    }
                    Rectangle{
                        y:10
                        width: 20
                        height: 20
                        rotation: 45
                        color: "#37B0BA"
                        anchors.horizontalCenter:parent.horizontalCenter
                    }
                    Rectangle{
                        y:110
                        width: 20
                        height: 20
                        rotation: 45
                        color: "#37B0BA"
                        anchors.horizontalCenter:parent.horizontalCenter
                    }
                }
                model: lmLeft
            }
        }


        /*Right Docking Rectangle*/

        Rectangle {
            id: rDockRight
            width: parent.width/2-30
            height: parent.height
            color: "transparent"
            anchors.right: parent.right
            anchors.top:parent.top
            anchors.rightMargin: S.scaleX(parent,2)
            anchors.topMargin: 100
            ListView {
                id: lvRight
                interactive: false
                anchors.fill: parent
                delegate: Item {
                    width: rDockRight.width
                    height: 200
                    Rectangle
                    {
                        width:rDockRight.width
                        height: itemTitleRight.height*1.5+90
                        color:"transparent"
                        MouseArea
                        {
                            anchors.fill: parent;
                            onClicked:
                            {
                                loadView.setSource("AgendaViewer.qml");
                                loadView.item.opacity=1;
                                loadView.item.webAddress=wAddress;
                            }
                        }
                        Image {
                            id: bubleRight
                            source: "bubble_right.png"
                            anchors.fill: parent
                        }
                        Text
                        {
                            id:dateRight
                            x:S.scaleX(parent,10)
                            y:S.scaleY(parent,5)
                            font.pixelSize: S.scaleY(parent,22)
                            text:dateTextRight
                        }
                        Text
                        {
                            id:dayRight
                            x:S.scaleX(parent,30)
                            y:S.scaleY(parent,5)
                            font.pixelSize: 25
                            text:dayTextRight
                        }
                        Text
                        {
                            id:monthRight
                            x:S.scaleX(parent,30)
                            y:S.scaleY(parent,25)
                            font.pixelSize: 15
                            color: "#9A9A9A"
                            text:monthTextRight
                        }
                        Text
                        {
                            id:yearRight
                            x:monthRight.x+monthRight.width+S.scaleX(parent,1)
                            y:S.scaleY(parent,25)
                            font.pixelSize: 15
                            font.bold: true
                            text:yearTextRight
                        }
                        Text
                        {
                            id:itemTitleRight
                            x:S.scaleX(parent,10)
                            y:S.scaleY(parent,50)
                            text:itemText
                            color:"#A5A5A5"
                            width:parent.width-S.scaleX(parent,25)
                            wrapMode: Text.WordWrap
                        }
                    }
                }
                model: lmRight
            }
        }
    }
}

ListModel{id:lmLeft}
ListModel{id:lmRight}
ListModel{id:lmCenter}

function padDateTime(dt) { //Add a preceding zero to months and days < 10
    return dt < 10 ? "0"+dt : dt;
}
function divideModel()
{
    for(var i=0;i<xmlModel.count;i++)
    {
        var dateToParse = xmlModel.get(i).pDate;
        var a=dateToParse.split(' ');
        var rebuildDate =a[2]+' '+a[1]+' '+a[3];
        var nDate=new Date(rebuildDate);
        var getDay=Qt.formatDate(nDate,"dddd");
        var getDate=Qt.formatDate(nDate,"dd");
        var getMonth=Qt.formatDate(nDate,"MMMM");
        var getYear=Qt.formatDate(nDate,"yyyy");
        var webLink=xmlModel.get(i).link;
        console.log(webLink);
        if((i%2)===0)
        {
            lmLeft.append({"itemText":xmlModel.get(i).title,"dateTextLeft":getDate,"dayTextLeft":getDay,"monthTextLeft":getMonth,"yearTextLeft":getYear,"wAddress":webLink});
        }
        else
        {
            lmRight.append({"itemText":xmlModel.get(i).title,"dateTextRight":getDate,"dayTextRight":getDay,"monthTextRight":getMonth,"yearTextRight":getYear,"wAddress":webLink});
        }
    }
}

XmlListModel
{
    id:xmlModel
    source: "http://www.uksw.edu/id.php/info/feed/type/agenda"
    query: "/rss/channel/item"
    XmlRole{name:"title";query:"title/string()"}
    XmlRole{name:"link";query:"link/string()"}
    XmlRole{name:"pDate";query:"pubDate/string()"}
    onStatusChanged:
    {
        if (status === XmlListModel.Ready)
        {
            divideModel();
            loading.visible=false;
        }
        else if(status === XmlListModel.Loading)
        {
            loading.visible=true;
        }

    }

}
Loader{
    id:loadView
    anchors.fill:parent
}
Connections
{
    target: loadView.item
    onIsClosed:
    {
        loadView.item.opacity=0;
    }
    onIsFadeOut:
    {
        loadView.setSource("");
    }
}

}
