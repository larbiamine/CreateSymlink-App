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
    @Slot(str, str)
    def makeLink(self, source, destination):
        if(source and destination):
            source = "\"" + source + "\""
            destination = "\"" + destination + "\""       
            command = "mklink "+destination+" "+source
            os.system(command)
            result = "symbolic link created for \n"+destination+"\n <<===>> \n"+source
            self.signalCreate.emit(True, result)
        else:
            self.signalCreate.emit(False, "invalid source and destination")
            print("Error")    


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
