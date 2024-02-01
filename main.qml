import QtQuick 2.15
import QtQuick.Window 2.15
import "ui/gauges"

Window {
    width: 1280
    height: 480
    visible: true
    title: qsTr("Peugout 308 Demo")
    color: "#1e1e2d"


    SpeedGauge{
        id: speedGauge
        width: 300
        height: 300
        anchors.left: parent.left
        anchors.leftMargin: parent.width * .25
        anchors.bottom: parent.bottom
        anchors.bottomMargin: parent.height * .25
    }

    RpmGauge{
        id: rpmGauge
        width: 300
        height: 300
        anchors.right : parent.right
        anchors.rightMargin : parent.width * .25
        anchors.bottom: parent.bottom
        anchors.bottomMargin: parent.height * .25
    }

}
