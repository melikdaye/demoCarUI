import QtQuick 2.15
import QtQuick.Controls 2.15
Rectangle {


        property real maxRpm: 9000
        property real currentRpm: rpmController.currentRpm
        color: "transparent"
        FontLoader { id: kanit ; source: "qrc:/ui/fonts/Kanit-Regular.ttf" }
        Canvas {
           id: rpmCanvas
           anchors.fill: parent



           onPaint: {
               var ctx = getContext("2d");

               ctx.clearRect(0,0,width,height);

               // Draw the background circle
               ctx.beginPath();
               ctx.arc(width / 2, height / 2, width / 2 - 10, 0, 2 * Math.PI);
               ctx.strokeStyle = "dimgrey";
               ctx.lineWidth = 5;
               ctx.fillStyle = "rgba(40, 40, 50, 1)";
               ctx.fill();
               ctx.stroke();


               // Draw the transparent green portion representing the maximum speed
               var angle = ((currentRpm < 1 ? currentRpm+1 : currentRpm) / maxRpm) * Math.PI;
               console.log(angle)
               ctx.beginPath();
               ctx.moveTo(width / 2, height / 2);
               ctx.arc(width / 2, height / 2, width / 2 - 10, 0.25 * Math.PI , 0.25 * Math.PI - angle,true);


               var gradient = ctx.createConicalGradient(width/2 , height/2, 0.25 * Math.PI + Math.PI);
               if(currentRpm <= 7000){
                   gradient.addColorStop(0, "rgba(0, 128, 0, 0)"); // Transparent black
                   gradient.addColorStop(1, "rgba(0, 255, 0, 0.75)"); // Transparent green
                   ctx.strokeStyle = "rgba(0, 255, 0, 1)";
               }
               else{
                   gradient.addColorStop(0, "rgba(128, 0, 0, 0)"); // Transparent black
                   gradient.addColorStop(1, "rgba(255, 0, 0, 0.75)"); // Transparent green
                   ctx.strokeStyle = "rgba(255, 0, 0, 1)";
               }
               ctx.fillStyle = gradient;
               ctx.lineWidth = 2;
               ctx.stroke();
               ctx.fill();

               // Draw the polar line with gradient color
                           var startX = width / 2;
                           var startY = height / 2;
                           var endX = width / 2 + Math.cos(0.25 * Math.PI - angle) * (width / 2 - 10);
                           var endY = height / 2 + Math.sin(0.25 * Math.PI - angle) * (width / 2 - 10);

                           gradient = ctx.createLinearGradient(startX, startY, endX, endY);
                            if(currentRpm <= 7000){
                           gradient.addColorStop(0, "rgba(0, 255, 0, 0)"); // Start with transparent white
                           gradient.addColorStop(1, "rgba(0, 255, 0, 1)"); // End with solid white
                            }
                            else{
                                gradient.addColorStop(0, "rgba(255, 0, 0, 0)"); // Start with transparent white
                                gradient.addColorStop(1, "rgba(255, 0, 0, 1)"); // End with solid white
                            }

                           ctx.beginPath();
                           ctx.moveTo(startX, startY);
                           ctx.lineTo(endX, endY);
                           ctx.strokeStyle = gradient;
                           ctx.lineWidth = 3;
                           ctx.stroke();

               // Draw the main ticks
                               var numMainTicks = 5;
                               var mainTickLength = width / 8;

                               for (var i = 0; i <= numMainTicks; i++) {
                                   var tickAngle = 0.25 * Math.PI - (i / numMainTicks) *  Math.PI;
                                   let startX = width / 2 + Math.cos(tickAngle) * (width / 2 - 15);
                                   let startY = height / 2 + Math.sin(tickAngle) * (width / 2 - 15);
                                   let endX = width / 2 + Math.cos(tickAngle) * (width / 2 - 10 - mainTickLength);
                                   let endY = height / 2 + Math.sin(tickAngle) * (width / 2 - 10 - mainTickLength);

                                   ctx.beginPath();
                                   ctx.moveTo(startX, startY);
                                   ctx.lineTo(endX, endY);
                                   let gradient = ctx.createLinearGradient(startX, startY, endX, endY);
                                   gradient.addColorStop(0, "lightgrey");
                                   gradient.addColorStop(1, "rgba(50, 50, 65, 0.75)");

                                   ctx.strokeStyle = gradient;
                                   ctx.lineWidth = 5;
                                   ctx.stroke();
                               }

                               // Draw the minor ticks with white to gray gradient
                               var numMinorTicks = 5;
                               var minorTickLength = 8;

                               for (let i = 0; i < numMainTicks; i++) {
                                   var startMinorAngle = 0.25 * Math.PI;

                                   for (var j = 0; j <= numMinorTicks; j++) {
                                       var minorTickAngle = startMinorAngle - (i*numMainTicks + j) / (numMainTicks*numMinorTicks) * Math.PI;
                                       var startMinorX = width / 2 + Math.cos(minorTickAngle) * (width / 2 - 25 - mainTickLength);
                                       var startMinorY = height / 2 + Math.sin(minorTickAngle) * (width / 2 - 25 - mainTickLength);
                                       var endMinorX = width / 2 + Math.cos(minorTickAngle) * (width / 2 - 25 - (minorTickLength + mainTickLength) );
                                       var endMinorY = height / 2 + Math.sin(minorTickAngle) * (width / 2 - 25 - (minorTickLength + mainTickLength) );

                                       let gradient = ctx.createLinearGradient(startMinorX, startMinorY, endMinorX, endMinorY);
                                       gradient.addColorStop(1, "white");
                                       gradient.addColorStop(0, "gray");

                                       ctx.beginPath();
                                       ctx.moveTo(startMinorX, startMinorY);
                                       ctx.lineTo(endMinorX, endMinorY);
                                       ctx.strokeStyle = gradient;
                                       ctx.lineWidth = 2;
                                       ctx.stroke();
                                   }
                               }



               // Draw the current speed in the center
                             ctx.font='50px "%1"'.arg(kanit.name)
                             ctx.fillStyle = "white";
                             ctx.textAlign = "center";
                             ctx.textBaseline = "middle";
                             ctx.fillText(currentRpm.toFixed(0), width / 2, height / 2);

                               ctx.font='20px "%1"'.arg(kanit.name)
                               ctx.fillStyle = "rgba(0, 256, 0, 0.75)";
                               ctx.textAlign = "center";
                               ctx.textBaseline = "middle";
                               ctx.fillText("RPM", width / 2, height / 2 + 75);



           }
     }

        Connections {
               target: rpmController
               onCurrentRpmChanged: rpmCanvas.requestPaint()
           }
}
