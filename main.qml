import QtQuick 2.12
import QtQuick.Window 2.12
import QtQuick.Shapes 1.12 //as Shapes
import QtGraphicalEffects 1.12 as GraphicFX
import QtQuick.Layouts 1.12
import QtQuick.Controls 2.5
import QtQuick.Controls.Material 2.12
import Qt.labs.platform 1.1
import QtQuick.Dialogs 1.2

ApplicationWindow {
    id: root
    visible: true
    color: Material.background
    width: 1200
    height: 700
    title: qsTr("Snapora Logo")

    Material.theme: Material.Dark
    Material.accent: Material.Teal

    DropArea {
        id: dragArea
        z: 100
        anchors.fill: parent
        onEntered: {
            if( drag.hasUrls && drag.urls[0].toString().endsWith(".json")) {
                drag.accept();
            } else {
                console.log("No compatible File (drop Json-Snapora-Logo-File)")
            }
        }

        onDropped: {
            if( drop.hasUrls && drop.urls[0].toString().endsWith(".json")) {
                drop.accept();
                root.loadJsonFile(drop.urls[0]);
            } else {
                console.log("Dropped File not accepted");
            }
        }
    }

    Item {
        id: lp
        property real sscale: 1
        property color planetColor1: "#43e97b"
        property color planetColor2: "#38f9d7"
        property color sColor1: "#4facfe"
        property color sColor2: "#00f2fe"
        property color sideColor1: Qt.darker("#4facfe")
        property color sideColor2: Qt.darker("#00f2fe")
        property real radius: 100
        property real sHeight: 70
        property real sWidth: 300
        property real a: Math.PI*0.7
        property real a2: -Math.PI*0.2
        property real thick: 80
        property real skew: Math.PI*0.1//+(Math.sin(timer.time)*0.5+0.5)*0.2
        property real outerLengthFactor: 2.2
        property real innerLengthFactor: 0.9
        property real innerSteepness: 0.9
        property real innerFactor: 0.7
        property real sideSpring: 50
        property real stiffOrSpringyAdapt: 0.1
        property real aboveSphereAngle: 0.6
        property real aboveSphereStrenghtCenter: 0.7
        property real aboveSphereStrenghtOuter: 1.0
    }
    Item {
        id: cl
        property real sinSkew: Math.sin(lp.skew)
        property real cosSkew: Math.cos(lp.skew)
        property real controlLengthOuter: lp.radius * lp.outerLengthFactor
        property real controlLengthInner: lp.radius * lp.innerLengthFactor
        //property real angle: a*Math.PI
    }

    Item {
        id: lp1
        property real radius: 100
        property real sHeight: 70
        property real sWidth: 300
        property real a: Math.PI*0.7
        property real a2: -Math.PI*0.2
        property real thick: 80
        property real skew: Math.PI*0.065+(Math.sin(timer.time)*0.5+0.5)*0.2
        property real sinSkew: Math.sin(skew)
        property real cosSkew: Math.cos(skew)
        property real controlLengthOuter: radius*2.2
        property real controlLengthInner: radius*0.9
        property real innerSteepness: 0.9
        property real innerFactor: 0.7
        property real sideSpring: 50
        property real stiffOrSpringyAdapt: -0.1
    }
    Item {
        id: lp2
        property real radius: 100
        property real sHeight: 70
        property real sWidth: 300
        property real a: Math.PI*0.55
        property real a2: -Math.PI*0.25
        property real thick: 80
        property real skew: Math.PI*0.1+(Math.sin(timer.time)*0.5+0.5)*0.2
        property real sinSkew: Math.sin(skew)
        property real cosSkew: Math.cos(skew)
        property real controlLengthOuter: radius*2.2
        property real controlLengthInner: radius*0.9
        property real innerSteepness: 0.9
        property real innerFactor: 0.7
        property real sideSpring: 50
        property real stiffOrSpringyAdapt: -0.5
    }
    Item {
        id: lp3
        property real radius: 100
        property real sHeight: 70
        property real sWidth: 300
        property real a: Math.PI*0.85
        property real a2: -Math.PI*0.1
        property real thick: 80
        property real skew: Math.PI*0.1+(Math.sin(timer.time)*0.5+0.5)*0.2
        property real sinSkew: Math.sin(skew)
        property real cosSkew: Math.cos(skew)
        property real controlLengthOuter: radius*2.2
        property real controlLengthInner: radius*0.9
        property real innerSteepness: 0.9
        property real innerFactor: 0.7
        property real sideSpring: 50
        property real stiffOrSpringyAdapt: 0.9
    }
    Timer {
        id:timer
        running: true
        interval: 5
        repeat: true
        property real time: 0
        onTriggered: {
            time += interval*0.001
        }
    }
    Flickable {
        id: controls
        anchors.top: parent.top
        anchors.bottom: parent.bottom
        anchors.left: parent.left
        anchors.right: logoContainer.left
        anchors.margins: 10
        flickableDirection: Flickable.VerticalFlick
        contentHeight: innerControls.implicitHeight
        GridLayout {
            id: innerControls
            width: controls.width
            columns: 3
            //*
            RowLayout {
                Layout.alignment: Qt.AlignHCenter
                Layout.columnSpan: 3
                Button {
                    Layout.minimumWidth: 80
                    onClicked: colorDialogPlanet1.open();
                    contentItem: RowLayout {
                        Label {
                            id: btnLabelPlanet
                            text: "Planet1"
                        }
                        Rectangle {
                            height: btnLabelPlanet.implicitHeight
                            width: height
                            color: lp.planetColor1
                        }
                    }
                }
                Button {
                    Layout.minimumWidth: 80
                    onClicked: colorDialogPlanet2.open();
                    contentItem: RowLayout {
                        Label {
                            id: btnLabelP2
                            text: "Planet2"
                        }
                        Rectangle {
                            height: btnLabelP2.implicitHeight
                            width: height
                            color: lp.planetColor2
                        }
                    }
                }
                Item { width: 10 }
                Button {
                    Layout.minimumWidth: 80
                    onClicked: colorDialogS1.open();
                    contentItem: RowLayout {
                        Label {
                            id: btnLabelS1
                            text: "S1"
                        }
                        Rectangle {
                            height: btnLabelS1.implicitHeight
                            width: height
                            color: lp.sColor1
                        }
                    }
                }
                Button {
                    Layout.minimumWidth: 80
                    onClicked: colorDialogS2.open();
                    contentItem: RowLayout {
                        Label {
                            id: btnLabelS2
                            text: "S2"
                        }
                        Rectangle {
                            height: btnLabelS2.implicitHeight
                            width: height
                            color: lp.sColor2
                        }
                    }
                }
                Item { width: 10 }
                Button {
                    Layout.minimumWidth: 80
                    onClicked: colorDialogSide1.open();
                    contentItem: RowLayout {
                        Label {
                            id: btnLabelSi1
                            text: "Side1"
                        }
                        Rectangle {
                            height: btnLabelSi1.implicitHeight
                            width: height
                            color: lp.sideColor1
                        }
                    }
                }
                Button {
                    Layout.minimumWidth: 80
                    onClicked: colorDialogSide2.open();
                    contentItem: RowLayout {
                        Label {
                            id: btnLabelSi2
                            text: "Side2"
                        }
                        Rectangle {
                            height: btnLabelSi2.implicitHeight
                            width: height
                            color: lp.sideColor2
                        }
                    }
                }

                ColorDialog {
                    id: colorDialogPlanet1
                    title: "Planet 1"
                    color: lp.planetColor1
                    onCurrentColorChanged: lp.planetColor1 = currentColor
                    property color c1
                    onVisibleChanged: if(visible) c1 = color
                    onRejected: lp.planetColor1 = c1
                }
                ColorDialog {
                    id: colorDialogPlanet2
                    title: "Planet 2"
                    color: lp.planetColor2
                    onCurrentColorChanged: lp.planetColor2 = currentColor
                    property color c1
                    onVisibleChanged: if(visible) c1 = color
                    onRejected: lp.planetColor2 = c1
                }
                ColorDialog {
                    id: colorDialogS1
                    title: "S 1"
                    color: lp.sColor1
                    onCurrentColorChanged: lp.sColor1 = currentColor
                    property color c1
                    onVisibleChanged: if(visible) c1 = color
                    onRejected: lp.sColor1 = c1
                }
                ColorDialog {
                    id: colorDialogS2
                    title: "S 2"
                    color: lp.sColor2
                    onCurrentColorChanged: lp.sColor2 = currentColor
                    property color c1
                    onVisibleChanged: if(visible) c1 = color
                    onRejected: lp.sColor2 = c1
                }
                ColorDialog {
                    id: colorDialogSide1
                    title: "Side 1"
                    color: lp.sideColor1
                    onCurrentColorChanged: lp.sideColor1 = currentColor
                    property color c1
                    onVisibleChanged: if(visible) c1 = color
                    onRejected: lp.sideColor1 = c1
                }
                ColorDialog {
                    id: colorDialogSide2
                    title: "Side 2"
                    color: lp.sideColor2
                    onCurrentColorChanged: lp.sideColor2 = currentColor
                    property color c1
                    onVisibleChanged: if(visible) c1 = color
                    onRejected: lp.sideColor2 = c1
                }
            }//*/

            Label { text: "Radius:"}
            Slider {
                id: slidRadius
                Layout.fillWidth: true
                value: lp.radius
                onValueChanged: lp.radius = value
                from: 0
                to: 200
            }
            Label { text: slidRadius.value.toFixed(2); Layout.minimumWidth: 50}
            Label { text: "S Height:"}
            Slider {
                id: slidSHeight
                Layout.fillWidth: true
                value: lp.sHeight
                onValueChanged: lp.sHeight = value
                from: 0
                to: 150
            }
            Label { text: slidSHeight.value.toFixed(2); }
    //        Label { text: "S Width:"}
    //        Slider {
    //            id: slidSWidth
    //            Layout.fillWidth: true
    //            value: 300
    //            onValueChanged: lp.sWidth = value
    //            from: 0
    //            to: 500
    //        }
    //        Label { text: slidSWidth.value.toFixed(2); }
            Label { text: " Side Angle:"}
            Slider {
                id: slidSideAngle
                Layout.fillWidth: true
                value: lp.a
                onValueChanged: lp.a = value
                from: 0
                to: 360*Math.PI/180
            }
            Label { text: (slidSideAngle.value/Math.PI*180).toFixed(2); }
            Label { text: "Angle:"}
            Slider {
                id: slidAngle
                Layout.fillWidth: true
                value: lp.a2
                onValueChanged: lp.a2 = value
                from: -360*Math.PI/180
                to: 0
            }
            Label { text: (slidAngle.value/Math.PI*180).toFixed(2); }
            Label { text: "S Thickness:"}
            Slider {
                id: slidThick
                Layout.fillWidth: true
                value: lp.thick
                onValueChanged: lp.thick = value
                from: 0
                to: 300
            }
            Label { text: slidThick.value.toFixed(2); }
            Label { text: "Skew:"}
            Slider {
                id: slidSkew
                Layout.fillWidth: true
                value: lp.skew
                onValueChanged: lp.skew = value
                from: -90*Math.PI/180
                to: 360*Math.PI/180
            }
            Label { text: (slidSkew.value/Math.PI*180).toFixed(2); }
            Label { text: "Inner Steepness:"}
            Slider {
                id: slidInnerSteepness
                Layout.fillWidth: true
                value: lp.innerSteepness
                onValueChanged: lp.innerSteepness = value
                from: 0
                to: 1.5
            }
            Label { text: slidInnerSteepness.value.toFixed(3); }
            Label { text: "Inner Factor:"}
            Slider {
                id: slidInnerFactor
                Layout.fillWidth: true
                value: lp.innerFactor
                onValueChanged: lp.innerFactor = value
                from: 0.0
                to: 2.0
            }
            Label { text: slidInnerFactor.value.toFixed(2); }
            //        property real controlLengthOuter: radius*2.2
            //        property real controlLengthInner: radius*0.9

            Label { text: "Outer Length:"}
            Slider {
                id: slidOutFac
                Layout.fillWidth: true
                value: lp.outerLengthFactor
                onValueChanged: lp.outerLengthFactor = value
                from: -2
                to: 10
            }
            Label { text: slidOutFac.value.toFixed(3); }
            Label { text: "Inner Length:"}
            Slider {
                id: slidInFac
                Layout.fillWidth: true
                value: lp.innerLengthFactor
                onValueChanged: lp.innerLengthFactor = value
                from: -2
                to: 10
            }
            Label { text: slidInFac.value.toFixed(3); }
            Label { text: "Side Spring:"}
            Slider {
                id: slidSideSpring
                Layout.fillWidth: true
                value: lp.sideSpring
                onValueChanged: lp.sideSpring = value
                from: 0
                to: 200
            }
            Label { text: slidSideSpring.value.toFixed(2); }
            Label { text: "Stiff Spring adapt:"}
            Slider {
                id: slidSideSpringAdapt
                Layout.fillWidth: true
                value: lp.stiffOrSpringyAdapt
                onValueChanged: lp.stiffOrSpringyAdapt = value
                from: -1
                to: +1
            }
            Label { text: slidSideSpringAdapt.value.toFixed(2); }
            Label { text: "Above Sphere Angle:"}
            Slider {
                id: slidAboveSphereAngle
                Layout.fillWidth: true
                value: lp.aboveSphereAngle
                onValueChanged: lp.aboveSphereAngle = value
                from: 0.1
                to: Math.PI*2
            }
            Label { text: slidAboveSphereAngle.value.toFixed(2); }
            Label { text: "Above Sphere Strength Center:"}
            Slider {
                id: slidAboveSphereCtr
                Layout.fillWidth: true
                value: lp.aboveSphereStrenghtCenter
                onValueChanged: lp.aboveSphereStrenghtCenter = value
                from: 0
                to: 4
            }
            Label { text: slidAboveSphereCtr.value.toFixed(2); }
            Label { text: "Above Sphere Strength Outer:"}
            Slider {
                id: slidAboveSphereOut
                Layout.fillWidth: true
                value: lp.aboveSphereStrenghtOuter
                onValueChanged: lp.aboveSphereStrenghtOuter = value
                from: -1
                to: 1
            }
            Label { text: slidAboveSphereOut.value.toFixed(2); }
        }
    }

    function loadJsonFile(fileUrl) {
        console.log("Loading file: " + fileUrl)
        var request = new XMLHttpRequest();
        request.open("GET", fileUrl, false);
        request.send(null);
        var jsonString = request.responseText;
        //console.log("Content: " + jsonString)
        var jsonObject = JSON.parse(jsonString);
        for (var prop in lp) {
            if(typeof emptyDummy[prop] === "undefined" && typeof lp[prop] !== "function") {
                if(typeof jsonObject[prop] === "object") {
                    lp[prop] = Qt.rgba(jsonObject[prop].r, jsonObject[prop].g, jsonObject[prop].b, jsonObject[prop].a);
                } else {
                    // maybe an older version of the json has not all properties defined.
                    if(typeof jsonObject[prop] !== "undefined") {
                        lp[prop] = jsonObject[prop];
                    }
                }
            }
        }
    }

    Component.onCompleted: {
        if(typeof loadedFile !== "undefined") {
            loadJsonFile("file:///"+loadedFile);
        }
    }

    Item { id: emptyDummy }
    RoundButton {
        anchors.margins: 20
        anchors.right: parent.right
        anchors.bottom: parent.bottom
        Label { text: "Save"; anchors.centerIn: parent; Material.theme: Material.Light }
        highlighted: true
        onClicked: {
            logoImage.grabToImage(function(img) {
                var now = new Date();
                var dateString = "";

                dateString += now.getFullYear() + "-";
                dateString += (now.getMonth()+1) + "-";
                dateString += now.getDate() + "_";
                dateString += now.getHours() + "-";
                dateString += now.getMinutes() + "-";
                dateString += now.getSeconds();
                img.saveToFile("snapora-logo-"+dateString+".png");
                var jsonObject = ({});
                for (var prop in lp) {
                    if(typeof emptyDummy[prop] === "undefined")
                        jsonObject[prop] = lp[prop];
                }
                var jsonText = JSON.stringify(jsonObject)
                var request = new XMLHttpRequest();
                var path = currentPath;
                request.open("PUT", currentPath+"snapora-logo-"+dateString+".json", false);
                request.send(jsonText);
                return request.status;
            });
        }
    }
    RowLayout {
        anchors.top: parent.top
        anchors.right: parent.right
        anchors.left: controls.right
        Label { text: "Scale:" }
        Slider {
            Layout.fillWidth: true
            value: lp.sscale
            onValueChanged: lp.sscale = value
            from: 0.5
            to: 4.0
        }
        Label { text: lp.sscale.toFixed(2); Layout.minimumWidth: 50}
    }

    Rectangle {
        id: logoContainer
        anchors.margins: 10
        anchors.right: parent.right
        anchors.verticalCenter: parent.verticalCenter
//        anchors.top: parent.top
//        anchors.bottom: parent.bottom
        width: logoImage.width+4
        height: logoImage.height+4
        border.width: 1
        border.color: "black"
        color: "transparent"
        Item {
            id: logoImage
            anchors.centerIn: parent
            width: 512
            height: 512
            clip: true
            Item {
                anchors.centerIn: parent
                scale: lp.sscale
                Rectangle {
                    z:6
                    //opacity: 0.5
                    radius: lp.radius
                    width: radius*2.0
                    height: width
                    anchors.centerIn: parent
                    color: "blue"
                    gradient: LinearGradient {
                        GradientStop { color: lp.planetColor1; position: 0}
                        GradientStop { color: lp.planetColor2; position: 1}
                    }
                }
        //        GraphicFX.DropShadow {
        //            z:99
        //            id: theShadow
        //            width: 500
        //            height: 500
        //            x: -200
        //            y: -250
        //            horizontalOffset: 0
        //            verticalOffset: 0
        //            radius: 50.0
        //            samples: 17
        //            color: "#FF000000"
        //            source: shadowSource
        //            visible: false
        //            cached: false
        //        }
        //        GraphicFX.OpacityMask {
        //            width: 500
        //            height: 500
        //            x: -0
        //            y: -0
        //            source: theShadow
        //            maskSource: shapeSide
        //            cached: false
        //        }
                Shape {
                    id: shapeSide
                    z:7
                    x: parent.width*0.5
                    y: parent.height*0.5
                    //anchors.centerIn: parent
                    //opacity: 0.8
                    ShapePath {
                        id: sideS
                        fillGradient: LinearGradient {
                            spread: ShapeGradient.ReflectSpread
                            y1: -lp.radius; y2: lp.radius*2.0+lp.sHeight
                            GradientStop { color: lp.sideColor1; position: 0.2}
                            GradientStop { color: lp.sideColor2; position: 0.1}
                        }
                        strokeWidth: 0
                        strokeColor: "transparent"
                        startX: Math.sin(lp.a)*lp.radius; startY: Math.cos(lp.a)*lp.radius
                        PathCubic {
                            id: upperS
                            x: Math.sin(lp.a2)*(-lp.radius-lp.sHeight); y: Math.cos(lp.a2)*(-lp.radius-lp.sHeight)
                            control1X: sideS.startX*1.2; control1Y: sideS.startY*1.2
                            control2X: x+Math.cos(lp.a2)*lp.sideSpring; control2Y: y-Math.sin(lp.a2)*lp.sideSpring
                        }
                        PathCubic {
                            id: upperS2
                            x: 0; y: 0
                            control1X: upperToMiddelUpper.control1X; control1Y: upperToMiddelUpper.control1Y
                            control2X: upperToMiddelUpper.control2X*1.4; control2Y: upperToMiddelUpper.control2Y*1.4
                        }
                        PathCubic {
                            x: -upperS.x; y: -upperS.y
                            control1X: -upperS2.control2X; control1Y: -upperS2.control2Y
                            control2X: -upperS2.control1X; control2Y: -upperS2.control1Y
                        }
                        PathCubic {
                            x: -sideS.startX; y: -sideS.startY
                            control1X: -upperS.control2X; control1Y: -upperS.control2Y
                            control2X: -upperS.control1X; control2Y: -upperS.control1Y
                        }
                        PathCubic {
                            id: sideAboveSphere
                            x: 0; y: 0
                            control1X: -sideS.startX-Math.cos(lp.a)*lp.aboveSphereStrenghtOuter*lp.radius; control1Y: -sideS.startY+Math.sin(lp.a)*lp.aboveSphereStrenghtOuter*lp.radius
                            control2X: Math.cos(lp.skew+lp.aboveSphereAngle)*lp.aboveSphereStrenghtCenter*lp.radius; control2Y: Math.sin(lp.skew+lp.aboveSphereAngle)*lp.aboveSphereStrenghtCenter*lp.radius
                        }
                        PathCubic {
                            x: sideS.startX; y: sideS.startY
                            control1X: -sideAboveSphere.control2X; control1Y: -sideAboveSphere.control2Y
                            control2X: -sideAboveSphere.control1X; control2Y: -sideAboveSphere.control1Y
                        }
                    }
                }

                Item {
                    z: 8
                    // dummy item to avoid moving every path width*0.5 pixels to center it and give it a size
                    id: shadowSource
                    anchors.centerIn: parent
                    width: 500
                    height: 500
                    Shape {
                        id: outS
                        x: 250
                        y: 250
                        width: 500
                        height: 500
                        z:7
                        //opacity: 0.3
                        ShapePath {
                            id: sPath
                            //fillColor: "red"
                            fillGradient: LinearGradient {
                                spread: ShapeGradient.ReflectSpread
                                y1: -lp.radius; y2: lp.radius*2.0+lp.sHeight
                                GradientStop { color: lp.sColor1; position: 0.5}
                                GradientStop { color: lp.sColor2; position: 0.1}
                            }

                            strokeWidth: 0
                            strokeColor: "transparent"
                            //middle s lower
                            startX: -cl.sinSkew*lp.thick*0.5; startY: cl.cosSkew*lp.thick*0.5
                            PathCubic {
                                id: upperOuter
                                // middle s lower to upper
                                x: Math.sin(lp.a2)*(-lp.radius-lp.sHeight); y: Math.cos(lp.a2)*(-lp.radius-lp.sHeight)
                                control1X: sPath.startX-cl.cosSkew*cl.controlLengthOuter; control1Y: sPath.startY-cl.sinSkew*cl.controlLengthOuter
                                property real s: lp.stiffOrSpringyAdapt
                                control2X: (-lp.radius*1.2*s)-(Math.cos(lp.a2)*102*(1-s)); control2Y: y+Math.sin(lp.a2)*102*(1-s)
                            }
                            PathCubic {
                                id: upperToMiddelUpper
                                //upper to middle upper s
                                x: -sPath.startX; y: -sPath.startY
                                control1X: upperOuter.control2X*lp.innerFactor*cl.cosSkew; control1Y: upperOuter.control2Y*lp.innerSteepness
                                control2X: x-cl.cosSkew*cl.controlLengthInner; control2Y: y-cl.sinSkew*cl.controlLengthInner
                            }
                            PathCubic {
                                id: lowerOuter
                                // middle upper s to lower
                                x: -upperOuter.x; y: -upperOuter.y
                                control1X: -upperOuter.control1X; control1Y: -upperOuter.control1Y
                                control2X: -upperOuter.control2X; control2Y: -upperOuter.control2Y
                            }
                            PathCubic {
                                id: lowerToMiddleLower
                                // lower to middle s lower
                                x: -upperToMiddelUpper.x; y: -upperToMiddelUpper.y
                                control1X: -upperToMiddelUpper.control1X; control1Y: -upperToMiddelUpper.control1Y
                                control2X: -upperToMiddelUpper.control2X; control2Y: -upperToMiddelUpper.control2Y
                            }
                        }
                    }
                }
            }
        }
    }
}
