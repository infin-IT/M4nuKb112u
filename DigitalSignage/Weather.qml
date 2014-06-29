import QtQuick 2.0
import "Scaling.js" as Scales
import "Positioning.js" as Pos
import QtQuick.XmlListModel 2.0

Rectangle {
    id:containerMaster
    anchors.fill:parent
    color:"transparent"
    property string path: "http://192.168.0.102/DigitalSignage/Weather/"

    property string kota
    property string suhu
    property string condition
    property string kelembaban
    property string tekanan

    FontLoader
    {
        id:weatherFont
        source: path+"fonts/WeatherTime.ttf"
    }

    FontLoader
    {
        id:argh
        source: path+"fonts/Aaargh.ttf"
    }

    //Condition (Shadow)
    Text
    {
        id:txtConditionShd
        x:1
        y:Scales.scaleY(parent,10)+1
        color:"#888888"
        font.family: weatherFont.name
        font.pixelSize: Scales.scaleY(containerMaster,70)
        text: txtCondition.text
    }

    //Condition
    Text
    {
        id:txtCondition
        x:0
        y:Scales.scaleY(parent,10)
        color:"white"
        font.family: weatherFont.name
        font.pixelSize: Scales.scaleY(containerMaster,70)
    }

    //Timer Weather
    Timer
    {
        interval: 600000
        running: true
        repeat: true

        onTriggered:
        {
            weatherModel.source=""
            weatherModel.source="http://weather.yahooapis.com/forecastrss?w=1048262"
        }
    }


    //TemperatureIcon (Shadow)
    Text
    {
        id:txtTempIconShd
        color:"#888888"
        x:Scales.scaleX(containerMaster,30)+1
        y:Scales.scaleY(containerMaster,65)+1
        text:"k"
        font.family: weatherFont.name
        font.pixelSize: Scales.scaleY(containerMaster,25)
    }

    //TemperatureIcon
    Text
    {
        id:txtTempIcon
        color:"white"
        x:Scales.scaleX(containerMaster,30)
        y:Scales.scaleY(containerMaster,65)
        text:"k"
        font.family: weatherFont.name
        font.pixelSize: Scales.scaleY(containerMaster,25)
    }

    //Temperature (Shadow)
    Text
    {
        id:txtTempShd
        color:"#888888"
        x:Scales.scaleX(containerMaster,50)+1
        y:Scales.scaleY(containerMaster,59)+1
        text:txtTemp.text
        font.family: argh.name
        font.pixelSize: Scales.scaleY(containerMaster,25)
    }

    //Temperature
    Text
    {
        id:txtTemp
        color:"white"
        x:Scales.scaleX(containerMaster,50)
        y:Scales.scaleY(containerMaster,59)
        font.family: argh.name
        font.pixelSize: Scales.scaleY(containerMaster,25)
    }

    //CelciusIcon (Shadow)
    Text
    {
        id:txtCelcIconShd
        color:"#888888"
        x:Scales.scaleX(containerMaster,75)+1
        y:Scales.scaleY(containerMaster,65)+1
        text:"l"
        font.family: weatherFont.name
        font.pixelSize: Scales.scaleY(containerMaster,25)
    }

    //CelciusIcon
    Text
    {
        id:txtCelcIcon
        color:"white"
        x:Scales.scaleX(containerMaster,75)
        y:Scales.scaleY(containerMaster,65)
        text:"l"
        font.family: weatherFont.name
        font.pixelSize: Scales.scaleY(containerMaster,25)
    }

    XmlListModel {
        id: weatherModel
        source: "http://weather.yahooapis.com/forecastrss?w=1048262"
        //source: "http://192.168.0.102/DigitalSignage/forecastrss.xml"
        query: "/rss/channel"

        namespaceDeclarations: "declare namespace yweather = 'http://xml.weather.yahoo.com/ns/rss/1.0';"
        XmlRole { name: "kota"; query: "yweather:location/@city/string()" }
        XmlRole { name: "suhu"; query: "item/yweather:condition/@temp/string()" }
        XmlRole { name: "condition"; query: "item/yweather:condition/@code/string()" }
        XmlRole { name: "kelembaban"; query: "yweather:atmosphere/@humidity/string()" }
        XmlRole { name: "tekanan"; query: "yweather:atmosphere/@pressure/string()" }

        onStatusChanged:
        {
            if (status===XmlListModel.Ready)
            {
                kota=weatherModel.get(0).kota
                suhu=Math.round((5/9) * (weatherModel.get(0).suhu - 32))
                txtTemp.text=suhu
                condition=weatherModel.get(0).condition
                kelembaban=weatherModel.get(0).kelembaban
                tekanan=weatherModel.get(0).tekanan

                switch (condition)
                {
                case "0": //Tornado
                    txtCondition.text="d"
                    break
                case "1": //Tropical Storm
                    txtCondition.text="T"
                    break
                case "2": //Hurricane
                    txtCondition.text="e"
                    break
                case "3": //Severe Thunderstorms
                    txtCondition.text="V"
                    break
                case "4": //Thunderstorms
                    txtCondition.text="U"
                    break
                case "5": //Rain + Snow
                    txtCondition.text="X"
                    break
                case "6": //Rain + Sleet
                    txtCondition.text="X"
                    break
                case "7": //Rain + Sleet
                    txtCondition.text="X"
                    break
                case "8": //Freezing
                    txtCondition.text="o"
                    break
                case "9": //Drizzle
                    txtCondition.text="o"
                    break
                case "10": //Freezing Rain
                    txtCondition.text="X"
                    break
                case "11": //Shower
                    txtCondition.text="S"
                    break
                case "12": //Shower
                    txtCondition.text="S"
                    break
                case "16": //Snow
                    txtCondition.text="W"
                    break
                case "19": //Dust
                    txtCondition.text="E"
                    break
                case "20": //Foggy
                    txtCondition.text="O"
                    break
                case "21": //Haze
                    txtCondition.text="C"
                    break
                case "22": //Smoky
                    txtCondition.text="G"
                    break
                case "23": //Blustery
                    txtCondition.text="Z"
                    break
                case "24": //Windy
                    txtCondition.text="a"
                    break
                case "25": //Cold
                    txtCondition.text="b"
                    break
                case "26": //Cloudy
                    txtCondition.text="D"
                    break
                case "27": //mostly cloudy (night)
                    txtCondition.text="J"
                    break
                case "28": //mostly cloudy (day)
                    txtCondition.text="D"
                    break
                case "29": //partly cloudy (night)
                    txtCondition.text="J"
                    break
                case "30": //partly cloudy (day)
                    txtCondition.text="D"
                    break
                case "31": //clear (night)
                    txtCondition.text="I"
                    break
                case "32": //Sunny
                    txtCondition.text="A"
                    break
                case "33": //Fair (night)
                    txtCondition.text="L"
                    break
                case "34": //Fair (Day)
                    txtCondition.text="H"
                    break
                case "35": //Rain + Hail
                    txtCondition.text="X"
                    break
                case "36": //Hot
                    txtCondition.text="h"
                    break
                case "37": //isolated thunderstorms
                    txtCondition.text="T"
                    break
                case "38": //scattered thunderstorms
                    txtCondition.text="U"
                    break
                case "39": //scattered thunderstorms
                    txtCondition.text="U"
                    break
                case "40": //scattered Shower
                    txtCondition.text="S"
                    break
                case "44": //Partly Cloudy
                    txtCondition.text="D"
                    break
                case "45": //ThunderShower
                    txtCondition.text="V"
                    break
                case "46": //isolated thunderstorms
                    txtCondition.text="V"
                    break
                }
            }
        }

        //current condition
        /*
         <code number="0" description="tornado"/>
          <code number="1" description="tropical storm"/>
          <code number="2" description="hurricane"/>
          <code number="3" description="severe thunderstorms"/>
          <code number="4" description="thunderstorms"/>
          <code number="5" description="mixed rain and snow"/>
          <code number="6" description="mixed rain and sleet"/>
          <code number="7" description="mixed snow and sleet"/>
          <code number="8" description="freezing drizzle"/>
          <code number="9" description="drizzle"/>
          <code number="10" description="freezing rain"/>
          <code number="11" description="showers"/>
          <code number="12" description="showers"/>
          <code number="13" description="snow flurries"/>
          <code number="14" description="light snow showers"/>
          <code number="15" description="blowing snow"/>
          <code number="16" description="snow"/>
          <code number="17" description="hail"/>
          <code number="18" description="sleet"/>
          <code number="19" description="dust"/>
          <code number="20" description="foggy"/>
          <code number="21" description="haze"/>
          <code number="22" description="smoky"/>
          <code number="23" description="blustery"/>
          <code number="24" description="windy"/>
          <code number="25" description="cold"/>
          <code number="26" description="cloudy"/>
          <code number="27" description="mostly cloudy (night)"/>
          <code number="28" description="mostly cloudy (day)"/>
          <code number="29" description="partly cloudy (night)"/>
          <code number="30" description="partly cloudy (day)"/>
          <code number="31" description="clear (night)"/>
          <code number="32" description="sunny"/>
          <code number="33" description="fair (night)"/>
          <code number="34" description="fair (day)"/>
          <code number="35" description="mixed rain and hail"/>
          <code number="36" description="hot"/>
          <code number="37" description="isolated thunderstorms"/>
          <code number="38" description="scattered thunderstorms"/>
          <code number="39" description="scattered thunderstorms"/>
          <code number="40" description="scattered showers"/>
          <code number="41" description="heavy snow"/>
          <code number="42" description="scattered snow showers"/>
          <code number="43" description="heavy snow"/>
          <code number="44" description="partly cloudy"/>
          <code number="45" description="thundershowers"/>
          <code number="46" description="snow showers"/>
          <code number="47" description="isolated thundershowers"/>
          <code number="3200" description="not available"/>
              */
    }

}
