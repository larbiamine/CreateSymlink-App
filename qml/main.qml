import QtQuick 6.2
import QtQuick.Window 2.15
import QtQuick.Controls 6
import QtQuick.Controls.Material 2.15
import QtQuick.Dialogs
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
            margins: 50
        }
        radius: 10

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
            checked: true
            text: qsTr("File")
        }

        RadioButton {
            id: directoryradio
            text: qsTr("Directory")
        }
        anchors.topMargin: 10 
        anchors.top: chooseType.bottom
        anchors.horizontalCenter: parent.horizontalCenter
    }


    // Source File
    MenuItem {
        id: source
        text: "Source: (Choose..)"
        onTriggered: sourceFileDialog.open()
        width: 300
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.top: chooseTypeRadio.bottom
        anchors.topMargin: 50
    }
    FileDialog {
        id: sourceFileDialog
        title : "Open Source File"    
    }

    // FolderDialog {
    //     id: sourcefolderDialog
    //     title : "Open Source Folder"
    // }

    // if(fileradio.checked){
    //     sourceFileDialog.visible: true
    //     sourcefolderDialog.visible: false
    // }else{
    //     sourceFileDialog.visible:  false
    //     sourcefolderDialog.visible: true
    // }




    Text{
        text: qsTr(sourceFileDialog.currentFile.toString().replace(/^(file:\/{3})/,""))
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
        onTriggered: destinationFileDialog.open()
        width: 300
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.top: source.bottom
        anchors.topMargin: 50
    }

    FileDialog {
        id: destinationFileDialog
        title : "Choose destination File"
        fileMode : FileDialog.SaveFile
    }

    Text{
        id: destinationFileName
        // text: qsTr(destinationFileDialog.currentFile.toString().replace(/^(file:\/{3})/,""))
        text: qsTr(destinationFileDialog.selectedFile.toString().replace(/^(file:\/{3})/,""))
        horizontalAlignment: Text.AlignHCenter
        verticalAlignment: Text.AlignVCenter
        color: "#ffffff"
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.top: destination.bottom
        font.pointSize: 10
    }


    // BUTTON LOGIN
    Button{
        id: buttonLogin
        width: 300
        text: qsTr("Create")
        anchors.top: destinationFileName.bottom
        anchors.topMargin: 10        
        anchors.horizontalCenter: parent.horizontalCenter
        onClicked: backend.makeLink(sourceFileDialog.currentFile.toString().replace(/^(file:\/{3})/,""), 
                                    destinationFileDialog.currentFile.toString().replace(/^(file:\/{3})/,""))
        
    }
    
    Connections {
        target: backend
    }    
}
