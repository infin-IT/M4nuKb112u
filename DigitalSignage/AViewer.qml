import QtQuick 2.0
import "DigitalSignage.js" as S
Rectangle {
    signal isClosed()
    signal isFadeOut()
    signal openList(ListModel listMod,int index)
    property string infoSummary
    property string infoHeader
    property int indexNow
    property int countPage
    anchors.fill: parent
    color:"transparent"
    opacity: 0
    onOpenList:
    {        
        for(var i=0;i<listMod.count;i++)
        {            
            contentModel.append({"text":listMod.get(i).text,"url":listMod.get(i).link})
        }
        indexNow=index+1;
        countPage=listMod.count
        view.currentIndex=index
        infoHeader=contentModel.get(index).text
        var regIHead = /<div class="info-title">(.*?)<\/div>/ig;
        var regISum = /<div class="info-summary">(.*?)<\/div>/ig;
        S.request(listMod.get(index).link, function (o) {
            var inp=o.responseText
            infoSummary=S.regeXecutor(inp,regISum);
        });
    }
    Rectangle
    {
        anchors.fill: parent
        color:"black"
        opacity:.7
        MouseArea
        {
            anchors.fill: parent
        }
    }
    Rectangle
    {
        id: agendaAdapter
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.verticalCenter: parent.verticalCenter
        width:(3/4)*height
        height: parent.height*0.9
        color:"blue"
        Rectangle
        {
            id:header
            width:S.scaleX(parent,90)
            height: S.scaleY(parent,20)
            color:"green"
            anchors.top:parent.top
            anchors.topMargin: S.scaleY(parent,10)
            anchors.horizontalCenter: parent.horizontalCenter
            Text {
                id: textHeader
                text: qsTr(infoHeader)
                width:parent.width
                wrapMode: Text.WordWrap
            }
        }

        ListView {
                id: view
                width:header.width
                height: header.height*3
                anchors.top:parent.top
                anchors.topMargin:header.height+header.anchors.topMargin
                anchors.horizontalCenter: header.horizontalCenter

                orientation: ListView.Horizontal
                snapMode: ListView.SnapOneItem;
                flickDeceleration: 500
                cacheBuffer: width;
                preferredHighlightBegin: 0;
                preferredHighlightEnd: 0
                highlightRangeMode: ListView.StrictlyEnforceRange
                highlightFollowsCurrentItem: true
                clip:true
                spacing:50
                model: contentModel
                delegate: contentViewer
                onCurrentIndexChanged:
                {
                    indexNow=view.currentIndex+1
                    infoHeader=contentModel.get(view.currentIndex).text
                    var regISum = /<div class="info-summary">(.*?)<\/div>/ig;
                    S.request(contentModel.get(view.currentIndex).url, function (o) {
                        var inp=o.responseText
                        infoSummary=S.regeXecutor(inp,regISum);
                    });
                }

        }

        ListModel{id:contentModel}
        Rectangle
        {
            x:S.scaleX(parent,90)
            y:S.scaleY(parent,5)
            width:S.scaleY(parent,5)
            height:S.scaleY(parent,5)
            color:"red"
            MouseArea
            {
                anchors.fill:parent
                onClicked:isClosed()
            }
        }
        Rectangle
        {
            id:pageNumber
            width:S.scaleX(parent,10)
            height:S.scaleY(parent,3)
            color:"green"

            anchors.horizontalCenter: parent.horizontalCenter
            anchors.bottom: parent.bottom
            anchors.bottomMargin: S.scaleY(parent,5)
            Text {
                id: pageIndex
                color:"black"
                font.pixelSize: 20
                text: indexNow+"/"+countPage
                anchors.verticalCenter: parent.verticalCenter
                anchors.horizontalCenter: parent.horizontalCenter
            }
        }
    }

    Behavior on opacity
    {
        NumberAnimation
        {
            id:anim
            duration: 400;
            easing.type:Easing.InQuad
            onRunningChanged:
            {
                if(!anim.running&&!opacity)
                {
                    isFadeOut()
                }
            }
        }
    }
    Component
    {

        id:contentViewer
        Rectangle
        {
            id:contentContainer
            color:"lightsteelblue"
            width:view.width
            height: view.height
            Scrollbar
            {
                id: scrolBar
                anchors.right: contentContainer.right;
                y: contentFlick.y
                width: 8;
                height: contentFlick.height
                flickableArea: contentFlick
                z:10
            }

            Flickable
            {
                id:contentFlick
                anchors.top:parent.top
                anchors.topMargin: S.scaleY(parent,5)
                anchors.left: parent.left
                anchors.leftMargin: S.scaleX(parent,5)
                anchors.bottom: parent.bottom
                anchors.bottomMargin: S.scaleY(parent,10)
                anchors.right: parent.right
                anchors.rightMargin:S.scaleX(parent,5)
                boundsBehavior: Flickable.DragAndOvershootBounds
                interactive:
                {
                    if(contentHeight<height)return false;
                    else return true;
                }

                flickableDirection: Flickable.VerticalFlick
                clip:true
                Text {
                    id: textContent
                    text: qsTr(infoSummary)
                    width:parent.width
                    wrapMode: Text.WordWrap
                    color:"black"
                    onContentHeightChanged:
                    {
                        contentFlick.contentHeight=height
                    }
                }
            }
        }
    }

}
