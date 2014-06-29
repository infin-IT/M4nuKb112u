import QtQuick 2.1
import QtQuick.Window 2.1
import QtQuick.XmlListModel 2.0
import "Scaling.js" as S

Window {
    id:ok
    visible: true
    width:768
    height: 1366
    property string xmlPath: "http://192.168.0.102/DigitalSignage/agenda.xml"
    //property string xmlPath: "http://www.uksw.edu/id.php/info/feed/type/agenda"
    property string path: "http://192.168.0.102/DigitalSignage/Timeline/"
    property string loading_image: path+"images/loading/loading.gif"
    property double loading_image_scale: 0.5
    property string timeline_bg: path+"images/background/landscape4.jpg"
    property variant monthName: ["Januari","Februari","Maret","April","Mei","Juni","Juli","Agustus","September","Oktober","Nopember","Desember"]

    FontLoader
    {
        id:fon
        source: path+"fonts/Aaargh.ttf"
    }

    /*element drawing*/
    /*
      layer 0: -AnimatedLoading         id:animatedLoading
                 >loadingimgbackground  id:loadingImageBg
                 >loadingimg            id:loadingImage
               -Flickable               id:baseFlick
      layer 1: -Rectangle Base          id:baseRectangle
      layer 2: -timeline background     id:timelineBG
      layer 3: -Left Container          id:leftDockRect
                 >lvLeft
               -Right Container         id:rightDockRect
                 >lvRight
      layer 4: -Left ListView           id:
               -right ListView          id:
      layer 5: xml content              id:

      /*end of element drawing*/

    Image {
        id: timelineImageBg
        source: timeline_bg
        anchors.fill: parent
    }

    Rectangle
    {
        id:animatedLoading
        width:parent.width
        height: parent.height
        visible: false
        color:"transparent"
        z:10
        AnimatedImage {
            id: loadingImage
            source: loading_image
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.verticalCenter: parent.verticalCenter
            playing: true
            smooth: true
            scale: loading_image_scale
        }
    }
    Scrollbar
    {
        z:10
        id: scrollBar
        anchors.right: baseFlick.right; y: baseFlick.y
        width: 8; height: baseFlick.height
        flickableArea: baseFlick
    }
    Flickable
    {
        id:baseFlick
        anchors.fill: parent
        boundsBehavior: Flickable.DragAndOvershootBounds
        interactive: true
        flickableDirection: Flickable.VerticalFlick
        clip:true
        contentHeight:Math.max(lvLeft.contentHeight,lvRight.contentHeight+rightDockRect.anchors.topMargin)


        Rectangle
        {
            id:baseRectangle
            width:parent.width
            height:baseFlick.contentHeight
            visible: true
            color:"transparent"
            Rectangle
            {
                id:leftDockRect
                width: parent.width/2
                height: parent.height
                color: "transparent"
                anchors.left: parent.left
                ListView
                {
                    id:lvLeft
                    interactive: false
                    height:contentHeight
                    model: lmLeft
                    spacing: 50
                    delegate:delLeft
                }
            }
            Rectangle
            {
                id:rightDockRect
                width: parent.width/2
                height: parent.height
                color: "transparent"
                anchors.right: parent.right
                anchors.top:parent.top
                anchors.topMargin: S.scaleY(baseFlick,10)
                ListView
                {
                    id:lvRight
                    interactive: false
                    height:contentHeight
                    anchors.fill: parent
                    model: lmRight
                    spacing: 50
                    delegate: delRight

                }
            }
        }
    }

    ListModel{id:lmLeft}
    ListModel{id:lmRight}
    ListModel{id:unsortedModel}
    ListModel{id:passedModel}

    Component
    {
        id:delLeft
        Item
        {
            id: itemLeft
            width: leftDockRect.width
            height: Math.max(itemTextLeft.height*1.15+topSeparatorL.height,width/2)

            /*
       -----------------
       |     tsl    |  |
       |____________|__|
       |               |
       |     bsl       |
       -----------------
      */
            MouseArea
            {
                anchors.fill: parent;
                onClicked:
                {
                    loadView.setSource("AViewer.qml");
                    loadView.item.opacity=1;
                    loadView.item.openList(unsortedModel,id)
                }
            }
            Rectangle
            {
                id:topSeparatorL
                width: parent.width
                height: parent.width/6
                anchors.top: parent.top
                color:"yellow"
                /*********************Header Adapter**************************/
                Rectangle
                {
                    width:S.scaleX(parent,80)
                    height:parent.height
                    anchors.left: parent.left
                    color:"#0500ff"
                    Text {
                        id:date
                        text: dateTextLeft
                        color: "white"
                        font.pixelSize:50
                        anchors.left: parent.left
                        anchors.leftMargin: S.scaleX(parent,10)
                        anchors.top: parent.top
                        anchors.topMargin: 0
                        anchors.verticalCenter: parent.verticalCenter
                    }

                    Text {
                        id:day
                        text: dayTextLeft
                        color: "white"
                        font.pixelSize: 30
                        anchors.left: parent.left
                        anchors.leftMargin: date.width+date.anchors.leftMargin*1.5
                        anchors.top:parent.top
                        anchors.topMargin: date.anchors.topMargin
                    }

                    Text {
                        id:month
                        text: monthTextLeft
                        color: "white"
                        font.pixelSize:20
                        anchors.left: parent.left
                        anchors.leftMargin: day.anchors.leftMargin
                        anchors.top:parent.top
                        anchors.topMargin: day.height*1.5-height
                    }
                    Text
                    {
                        id:year
                        text: yearTextLeft
                        color: "white"
                        font.pixelSize:24
                        font.bold: true
                        anchors.left: parent.left
                        anchors.leftMargin: day.anchors.leftMargin+month.width*1.2
                        anchors.top:parent.top
                        anchors.topMargin: day.height*1.6-height
                    }
                }

            }
            Rectangle
            {
                id:bottomSeparatorL
                width: parent.width
                height: parent.height-topSeparatorL.height
                anchors.top: parent.top
                anchors.topMargin: topSeparatorL.height
                color:"transparent"
                /********CONTENT ADAPTER***********/
                Rectangle
                {
                    id:contentAdapterL
                    width: S.scaleX(parent,80)
                    height:parent.height
                    anchors.left: parent.left
                    color:"black"
                    Text
                    {
                        id:itemTextLeft
                        text:textLeft
                        color:"white"
                        width:parent.width
                        wrapMode: Text.WordWrap
                        anchors.horizontalCenter: parent.horizontalCenter
                        anchors.verticalCenter: parent.verticalCenter
                        anchors.left: parent.left
                        anchors.leftMargin: S.scaleX(parent,5)
                        font.family: fon.name
                        font.pixelSize:25
                    }
                }
            }
        }
    }

    Component
    {
        id:delRight
        Item
        {
            id: itemRight
            width: rightDockRect.width
            height: Math.max(itemTextRight.height*1.15+topSeparatorR.height,width/2)

            /*
       -----------------
       |     tsl    |  |
       |____________|__|
       |               |
       |     bsl       |
       -----------------
      */    MouseArea
            {
                anchors.fill: parent;
                onClicked:
                {
                    loadView.setSource("AViewer.qml");
                    loadView.item.opacity=1;
                    loadView.item.openList(unsortedModel,id)
                }
            }
            Rectangle
            {
                id:topSeparatorR
                width: parent.width
                height: parent.width/6
                anchors.top: parent.top
                color:"yellow"
                /*********************************Header Adapter******************************************************/
                Rectangle
                {
                    width:S.scaleX(parent,80)
                    height:parent.height
                    anchors.right: parent.right
                    color:"#0500ff"
                    Text {
                        id:dateR
                        text: dateTextRight
                        color:"white"
                        font.pixelSize:50
                        anchors.left: parent.left
                        anchors.leftMargin: S.scaleX(parent,10)
                        anchors.top: parent.top
                        anchors.topMargin: 0
                        anchors.verticalCenter: parent.verticalCenter
                    }

                    Text {
                        id:dayR
                        text: dayTextRight
                        color:"white"
                        font.pixelSize: 30
                        anchors.left: parent.left
                        anchors.leftMargin: dateR.width+dateR.anchors.leftMargin*1.5
                        anchors.top:parent.top
                        anchors.topMargin: dateR.anchors.topMargin
                    }

                    Text {
                        id:monthR
                        text: monthTextRight
                        color:"white"
                        font.pixelSize:20
                        anchors.left: parent.left
                        anchors.leftMargin: dayR.anchors.leftMargin
                        anchors.top:parent.top
                        anchors.topMargin: dayR.height*1.5-height
                    }
                    Text
                    {
                        id:yearR
                        text: yearTextRight
                        font.pixelSize: 24
                        font.bold: true
                        color:"white"
                        anchors.left: parent.left
                        anchors.leftMargin: dayR.anchors.leftMargin+monthR.width*1.2
                        anchors.top:parent.top
                        anchors.topMargin: dayR.height*1.6-height
                    }
                }

            }
            Rectangle
            {
                id:bottomSeparatorR
                width: parent.width
                height: parent.height-topSeparatorR.height
                anchors.top: parent.top
                anchors.topMargin: topSeparatorR.height
                color:"transparent"
                /********CONTENT ADAPTER***********/
                Rectangle
                {
                    id:contentAdapterR
                    width: S.scaleX(parent,80)
                    height:parent.height
                    anchors.right: parent.right
                    color:"black"
                    Text
                    {
                        id:itemTextRight
                        text:textRight
                        color:"white"
                        width:parent.width
                        wrapMode: Text.WordWrap
                        anchors.horizontalCenter: parent.horizontalCenter
                        anchors.verticalCenter: parent.verticalCenter
                        anchors.left: parent.left
                        anchors.leftMargin: S.scaleX(parent,5)
                        font.family: fon.name
                        font.pixelSize:25
                        //font.pointSize: 25
                        //smooth: true
                        //antialiasing: true
                        //horizontalAlignment: Text.AlignRight
                    }
                }
            }
        }
    }
    Loader
    {
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
    XmlListModel
    {
        id:xmlModel
        source: xmlPath
        query: "/rss/channel/item"
        XmlRole{name:"title";query:"title/string()"}
        XmlRole{name:"link";query:"link/string()"}
        XmlRole{name:"pDate";query:"pubDate/string()"}
        onStatusChanged:
        {
            if (status === XmlListModel.Ready)
            {
                getModel();
                sortModel();
                divModel()
                animatedLoading.visible=false;
            }
            else if(status === XmlListModel.Loading)
            {
                animatedLoading.visible=true;
            }
        }
    }

    function sortModel()
    {
        var n;
        var i;
        for (n=0; n < unsortedModel.count; n++)
            for (i=n+1; i < unsortedModel.count; i++)
            {
                if (unsortedModel.get(n).date< unsortedModel.get(i).date)
                {
                    unsortedModel.move(i, n, 1);
                    n=0;
                }
            }
        for(var z=0;z<unsortedModel.count;z++)
        {
            unsortedModel.get(z).id=z;
        }
    }

    function getTranslatedDay(dayName)
    {
        switch(dayName)
        {
        case "Sunday":return "Minggu"
        case "Monday":return "Senin"
        case "Tuesday":return "Selasa"
        case "Wednesday":return "Rabu"
        case "Thursday":return "Kamis"
        case "Friday":return "Jumat"
        case "Saturday":return "Sabtu"
        default: return dayName
        }
    }

    function getModel()
    {
        for(var i=0;i<xmlModel.count;i++)
        {
            var dateToParse = xmlModel.get(i).pDate;
            var a=dateToParse.split(' ');
            var rebuildDate =a[2]+' '+a[1]+' '+a[3];
            var nDate=new Date(rebuildDate);
            var isDay=Qt.formatDate(nDate,"dddd");
            var isDate=Qt.formatDate(nDate,"dd");
            var isMonth=Qt.formatDate(nDate,"M");
            var isYear=Qt.formatDate(nDate,"yyyy");
            var isLink=xmlModel.get(i).link;
            unsortedModel.append({"id":i,"date":nDate,"text":xmlModel.get(i).title,"dateText":isDate,"dayText":getTranslatedDay(isDay),"monthText":monthName[isMonth-1],"yearText":isYear,"link":isLink})
        }
    }

    function divModel()
    {
        for(var i=0;i<unsortedModel.count;i++)
        {
            if((i%2)===0)
            {
                lmLeft.append({"id":unsortedModel.get(i).id,"textLeft":unsortedModel.get(i).text,"dateTextLeft":unsortedModel.get(i).dateText,"dayTextLeft":unsortedModel.get(i).dayText,"monthTextLeft":unsortedModel.get(i).monthText,"yearTextLeft":unsortedModel.get(i).yearText,"linkLeft":unsortedModel.get(i).link});
            }
            else
            {
                lmRight.append({"id":unsortedModel.get(i).id,"textRight":unsortedModel.get(i).text,"dateTextRight":unsortedModel.get(i).dateText,"dayTextRight":unsortedModel.get(i).dayText,"monthTextRight":unsortedModel.get(i).monthText,"yearTextRight":unsortedModel.get(i).yearText,"linkRight":unsortedModel.get(i).link});
            }
        }
    }

}


