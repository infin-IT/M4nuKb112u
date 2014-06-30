import QtQuick 2.0
import "DigitalSignage.js" as Func

Rectangle {
    id:masterContainer
    anchors.fill:parent
    color:"transparent"
    property string uksw_news_link:"http://www.uksw.edu/id.php/info/archives/type/fokus"
    property string infoSummary
    property variant imageArray
    property int counterImage
    signal start()
    /* _________________________
      |                         |
      |        Image            | 70%
      |_________________________|
      | Title                   | 30%
      |_Short Definition________|
    */

    onStart:
    {
        var regImage = /<img(.*)class="info-thumbnail"\/>/ig;
        var reqSrc = /src="(.*?)"/ig;
        newsImage1.opacity=1
        newsImage2.opacity=0
        Func.request(uksw_news_link, function (o) {
            o.onreadystatechange=function()
            {
                if(o.readyState===4 && o.status===200)
                {
                    var inp=o.responseText
                    //console.debug(inp)

                    infoSummary=Func.regeXecutor(inp,regImage);
                    infoSummary=Func.regeXecutor(infoSummary,reqSrc)
                    imageArray = infoSummary.split(" ");
                    newsImage1.source=imageArray[0]
                }

            }

        });
    }


    Flickable
    {
        anchors.fill: parent
        clip: true
        Image
        {
            id:newsImage1
            width: parent.width
            height: newsImage1.sourceSize.height * parent.width/newsImage1.sourceSize.width

            Behavior on opacity
            {
                NumberAnimation{ duration: 1000}
            }
        }

        Image
        {
            id:newsImage2
            width: parent.width
            height: newsImage2.sourceSize.height * parent.width/newsImage2.sourceSize.width
            clip:true
            //source: imageArray[0]
            Behavior on opacity
            {
                NumberAnimation{ duration: 1000}
            }
        }
    }

    Timer
    {
        interval: 5000
        repeat: true
        running: true
        onTriggered:
        {

            counterImage++
            //console.debug(ctrBackground)
            if (counterImage>imageArray.length-1) counterImage=0

            if (newsImage1.opacity===1) //gbr1 didepan
            {
                newsImage1.opacity=0
                newsImage2.opacity=1
                newsImage2.source=imageArray[counterImage]
            }
            else
            {
                newsImage1.opacity=1
                newsImage2.opacity=0
                newsImage1.source=imageArray[counterImage]
            }
        }
    }

    Rectangle
    {
        anchors.right: parent.right
        anchors.rightMargin: 0
        anchors.left: parent.left
        anchors.leftMargin: 0
        anchors.bottom: parent.bottom
        anchors.bottomMargin: 0
        height: Func.scaleY(parent,30)
        color:"black"
        opacity:0.5

    }
}
