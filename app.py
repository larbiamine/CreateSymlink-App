import sys
import os
import subprocess
# IMPORT MODULES
from PySide6.QtGui import QGuiApplication
from PySide6.QtQml import QQmlApplicationEngine
from PySide6.QtCore import QObject, Slot, Signal

# Main Window Class
class MainWindow(QObject):
    def __init__(self):
        QObject.__init__(self)

    signalCreate = Signal(bool, str)
    @Slot(str, str, str)
    def makeLink(self, source, destination, type):
        if(type == "file"):
            print("type is a file")
            if(source and destination and source!=destination):
                source = "\"" + source + "\""
                destination = "\"" + destination + "\""       
                command = "mklink "+destination+" "+source
                os.system(command)
                result = "symbolic link created for \n"+destination+"\n <<===>> \n"+source
                self.signalCreate.emit(True, result)
            else:
                self.signalCreate.emit(False, "invalid source and destination")
                print("Error")  
        else:
            print("type is a folder")          
            if(source and destination and source!=destination):
                print('we here')
                destination = "\"" + destination + "/"+os.path.basename(source)+"\""   
                source = "\"" + source + "\""
                command = "mklink /J "+destination+" "+source
                os.system(command)
                print(command)
                result = "symbolic link created for \n"+destination+"\n <<===>> \n"+source
                self.signalCreate.emit(True, result)
            else:
                print("nah")    


# INSTACE CLASS

app = QGuiApplication(sys.argv)
engine = QQmlApplicationEngine()

# Get Context
main = MainWindow()
engine.rootContext().setContextProperty("backend", main)

# Load QML File
engine.load(os.path.join(os.path.dirname(__file__), "qml/main.qml"))

# Check Exit App
if not engine.rootObjects():
    sys.exit(-1)
sys.exit(app.exec())
