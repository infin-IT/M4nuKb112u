import QtQuick 2.0

Rectangle {
    z:-1
    anchors.fill: parent

    property string path: "http://192.168.0.102/DigitalSignage/BackgroundChanger/"
    property string bkgimg_path: "images/background/"
    property variant imagePath: [path+bkgimg_path+"background1.jpg",
                                 path+bkgimg_path+"background2.jpg",
                                 path+bkgimg_path+"background3.jpg",
                                 path+bkgimg_path+"background4.jpg",
                                 path+bkgimg_path+"background5.jpg",
                                 path+bkgimg_path+"background6.jpg"]

    property int ctrBackground: 1

    /*
        Background Image :
        bkgImage1 - Transition Image Temporary 1
        bkgImage2 - Transition Image Temporary 2
    */
        Image
        {
            id:bkgImage1
            height: parent.height
            width: bkgImage1.sourceSize.width * parent.height/bkgImage1.sourceSize.height
            anchors.horizontalCenter: parent.horizontalCenter
            x:0
            source: imagePath[0]

            NumberAnimation on opacity
            {
                id: image1in
                from: 0
                to: 1
                duration: 1000
            }

            NumberAnimation on opacity
            {
                id: image1out
                from:1
                to: 0
                duration: 1000
            }
        }

        Image {
            id: bkgImage2
            height: parent.height
            width: bkgImage1.sourceSize.width * parent.height/bkgImage1.sourceSize.height
            anchors.horizontalCenter: parent.horizontalCenter
            x:0
            source: imagePath[1]

            NumberAnimation on opacity
            {
                id: image2in
                from: 0
                to: 1
                duration: 1000
            }

            NumberAnimation on opacity
            {
                id: image2out
                from:1
                to: 0
                duration: 1000
            }

        }

        /*
        Background Image Transition Timer

        WARNING: Not supported in QT Design
        */
        Timer
        {
            interval: 10000
            repeat: true
            running: true
            onTriggered:
            {
                ctrBackground++
                //console.debug(ctrBackground)
                if (ctrBackground>imagePath.length-1) ctrBackground=0
                if (bkgImage1.opacity===1 && bkgImage2.opacity===1)
                {
                    image1out.start()
                }
                if (bkgImage2.opacity===1) //gbr2 didepan
                {
                    image1in.start()
                    image2out.start()
                    bkgImage1.source=imagePath[ctrBackground]
                }
                else
                {
                    image1out.start()
                    image2in.start()
                    bkgImage2.source=imagePath[ctrBackground]
                }
            }
        }

}
