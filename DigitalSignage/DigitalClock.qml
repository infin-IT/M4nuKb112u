import QtQuick 2.0
import "DigitalSignage.js" as Func

Rectangle
{
    id:containerMaster
    anchors.fill:parent
    color:"transparent"
    property string path: "http://192.168.0.102/DigitalSignage/DigitalClock/"

    FontLoader
    {
        id:argh
        source: path+"fonts/Aaargh.ttf"
    }

    //Waktu (Shadow)
    Text
    {
        id:txtWaktuShd
        color:"#888888"
        x:Func.scaleX(containerMaster,2)+1
        y:Func.scaleY(containerMaster,2)+1
        text:txtWaktu.text
        font.family: argh.name
        font.pixelSize: Func.scaleY(containerMaster,60)
    }

    //Waktu
    Text
    {
        id:txtWaktu
        color:"white"
        x:Func.scaleX(containerMaster,2)
        y:Func.scaleY(containerMaster,2)
        text:Qt.formatTime(new Date(),"hh:mm")
        font.family: argh.name
        font.pixelSize: Func.scaleY(containerMaster,60)
    }   

    // Digital Clock Timer per Minutes
    Timer
    {
        id:timerWaktu
        interval: 40000
        repeat: true
        running: true
        onTriggered:
        {
            if (txtWaktu.text==="00:00")
            {
                txtTanggal.text=Qt.formatDate(new Date(),"dddd, dd MMMM yyyy")
            }
            txtWaktu.text=Qt.formatTime(new Date(),"hh:mm")
        }
    }

    //Tanggal (Shadow)
    Text
    {
        id:txtTanggalShd
        y:Func.bottomOf(txtWaktu,-1*(Func.scaleY(containerMaster,10)))+1
        x:Func.scaleX(containerMaster,14)+1
        text:txtTanggal.text
        color:"#888888"
        font.family: argh.name
        font.pixelSize:Func.scaleY(containerMaster,10)
    }

    //Tanggal
    Text
    {
        id:txtTanggal
        y:Func.bottomOf(txtWaktu,-1*(Func.scaleY(containerMaster,10)))
        x:Func.scaleX(containerMaster,14)
        text:Qt.formatDate(new Date(),"dddd, dd MMMM yyyy")
        color:"white"
        font.family: argh.name
        font.pixelSize:Func.scaleY(containerMaster,10)
    }


    MouseArea
    {
        anchors.fill: parent
        drag.target: parent
    }
}

