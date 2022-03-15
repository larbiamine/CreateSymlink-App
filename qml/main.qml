import QtQuick 6.2
import QtQuick.Window 2.15
import QtQuick.Controls 6
import QtQuick.Controls.Material 2.15
import QtQuick.Dialogs
import Qt.labs.platform as PlatformControls


import QtQuick.Layouts

ApplicationWindow{
    id: window 
    width: 400
    height: 580
    visible: true
    title: qsTr("SymLink Creation")

    // SET FLAGS
    flags: Qt.WindowCloseButtonHint | Qt.WindowMinimizeButtonHint | Qt.CustomizeWindowHint | Qt.MSWindowsFixedSizeDialogHint | Qt.WindowTitleHint

    // SET MATERIAL STYLE
    Material.theme: Material.Dark
    Material.accent: Material.LightBlue
    

    // CREATE TOP BAR
    Rectangle{
        id: topBar
        height: 40
        color: Material.color(Material.Blue)
        anchors{
            left: parent.left
            right: parent.right
            top: parent.top
            topMargin : 50
        }
       // radius: 10

        Text{
            text: qsTr("Create Symlink")
            anchors.verticalCenter: parent.verticalCenter
            horizontalAlignment: Text.AlignHCenter
            verticalAlignment: Text.AlignVCenter
            color: "#ffffff"
            anchors.horizontalCenter: parent.horizontalCenter
            font.pointSize: 10
        }
    }
    Text{
        id: chooseType
        text: qsTr("Choose Type")
        horizontalAlignment: Text.AlignHCenter
        verticalAlignment: Text.AlignVCenter
        color: "#ffffff"
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.top: topBar.bottom
        anchors.topMargin: 20
        font.pointSize: 12
    }
    RowLayout  {
        id : chooseTypeRadio
        spacing: 0

        RadioButton {
            id: fileradio
            text: qsTr("File")
        }

        RadioButton {
            id: directoryradio
            checked: true
            text: qsTr("Directory")
        }
        anchors.topMargin: 10 
        anchors.top: chooseType.bottom
        anchors.horizontalCenter: parent.horizontalCenter
    }


    // Source File
    MenuItem {
        color: "#5C6BC0"
        id: source
        text: "Source: (Choose..)"
        onTriggered: {
            if(fileradio.checked){
                sourceFileDialog.open()
            }else{
                sourceFolderDialog.open()
            }
        }
        width: 300
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.top: chooseTypeRadio.bottom
        anchors.topMargin: 50
    }



    FileDialog {
        id: sourceFileDialog
        title : "Open Source File"    
    }

    PlatformControls.FolderDialog {
        id: sourceFolderDialog
        title : "Open Source Folder"
        options : PlatformControls.FolderDialog.ShowDirsOnly
    }

    Text{
        text: qsTr(sourceFileDialog.currentFile.toString().replace(/^(file:\/{3})/,"") + sourceFolderDialog.currentFolder.toString().replace(/^(file:\/{3})/,""))
        horizontalAlignment: Text.AlignHCenter
        verticalAlignment: Text.AlignVCenter
        color: "#ffffff"
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.top: source.bottom
        font.pointSize: 10
    }

    // Destination File
    MenuItem {
        id: destination
        text: "Destination: (Choose..)"
        onTriggered: {
            if(directoryradio.checked){
                destinationFolderDialog.open()
            }else{
                destinationFileDialog.open()
            }
        }
        width: 300
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.top: source.bottom
        anchors.topMargin: 50
    }

    FileDialog {
        id: destinationFileDialog
        title : "Choose destination File"
        currentFile: sourceFileDialog.selectedFile
        fileMode : FileDialog.SaveFile
        
    }
    PlatformControls.FolderDialog {
        id: destinationFolderDialog
        title : "Open destination Folder"
        options : PlatformControls.FolderDialog.ShowDirsOnly
    }

    Text{
        id: destinationFileName
        text: {
            if(directoryradio.checked){
                qsTr(destinationFolderDialog.currentFolder.toString().replace(/^(file:\/{3})/,""))
            }else{
                qsTr(destinationFileDialog.currentFile.toString().replace(/^(file:\/{3})/,""))
            }
        }
        horizontalAlignment: Text.AlignHCenter
        verticalAlignment: Text.AlignVCenter
        color: "#ffffff"
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.top: destination.bottom
        font.pointSize: 10
    }

    Text{
        id: resulttext
        horizontalAlignment: Text.AlignHCenter
        verticalAlignment: Text.AlignVCenter
        
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.top: destinationFileName.bottom
        font.pointSize: 10
        anchors.topMargin: 10       
        anchors.bottomMargin: 10    
    }

    // BUTTON LOGIN
    Button{
        id: buttonLogin
        width: 300
        text: qsTr("Create")
        anchors.top: resulttext.bottom
        anchors.topMargin: 10          
        anchors.horizontalCenter: parent.horizontalCenter
        
        onClicked:{
            var type;
            if(fileradio.checked){
                type = "file"
                backend.makeLink(sourceFileDialog.currentFile.toString().replace(/^(file:\/{3})/,""), 
                            destinationFileDialog.currentFile.toString().replace(/^(file:\/{3})/,""),
                            type)                
            }else{
                type = "folder"
                backend.makeLink(sourceFolderDialog.currentFolder.toString().replace(/^(file:\/{3})/,""), 
                destinationFolderDialog.currentFolder.toString().replace(/^(file:\/{3})/,""),
                type)
            }
             

        } 
        
    }
    
    Connections {
        target: backend
        function onSignalCreate(boolValue, returned) {
            if(boolValue){
                resulttext.text = returned
                resulttext.color = "#007a6c"


            } else{
                resulttext.text = "Error " + returned
                resulttext.color = "#D84315"
            }
        }    
    }
}