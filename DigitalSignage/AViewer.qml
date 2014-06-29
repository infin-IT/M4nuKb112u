import QtQuick 2.0
import "Scaling.js" as S

Rectangle {
    signal isClosed()
    signal isFadeOut()
    signal openList(ListModel listMod,int index)
    property string infoSummary
    property string infoHeader
    anchors.fill: parent
    color:"transparent"
    opacity: 0
    onOpenList:
    {
        /*console.log("singKepijett:"+index)
        for(var i=0;i<listMod.count;i++)
        {
            console.log(listMod.get(i).text)
        }*/

        request(listMod.get(index).link, function (o) {
            var inp=o.responseText
            var regIHead = /<div class="info-title">(.*?)<\/div>/ig;
            infoHeader=regeXecutor(inp,regIHead);
            var regISum = /<div class="info-summary">(.*?)<\/div>/ig;
            infoSummary=regeXecutor(inp,regISum);
        });

    }

    function regeXecutor(input,regex)
    {
        var match;
        var result ="";
        input = input.replace(new RegExp('[\r\n]', 'gi'), '');
        while (match = regex.exec(input)) { result += match[1]; }
        return result;
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

        Rectangle
        {
            width:header.width
            height: header.height*3
            color:"lightsteelblue"
            anchors.top:parent.top
            anchors.topMargin:header.height+header.anchors.topMargin
            anchors.horizontalCenter: header.horizontalCenter
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
                        console.log("aaaa"+height)
                        contentFlick.contentHeight=height
                    }
                }
            }
        }
        Rectangle
        {
            x:S.scaleX(parent,90)
            y:S.scaleY(parent,12)
            width:S.scaleY(parent,5)
            height:S.scaleY(parent,5)
            color:"red"
            MouseArea
            {
                anchors.fill:parent
                onClicked:isClosed()
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
    function request(url, callback) {
        var xhr = new XMLHttpRequest();
        xhr.onreadystatechange = (function(myxhr) {
            return function() {
                callback(myxhr);
                if(xhr.readyState==4)
                {
                    console.log("wes-----------------------------------------------------"+xhr.readyState+"        "+textContent.contentHeight)
                    contentFlick.contentHeight=textContent.contentHeight;
                }
            }
        })(xhr);
        xhr.open('GET', url, true);
        xhr.send('');
    }

}
