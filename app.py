import sys
import os

# IMPORT MODULES
from PySide6.QtGui import QGuiApplication
from PySide6.QtQml import QQmlApplicationEngine
from PySide6.QtCore import QObject, Slot, Signal

# Main Window Class
class MainWindow(QObject):
    def __init__(self):
        QObject.__init__(self)

    @Slot(str, str)
    def makeLink(self, source, destination):
        if(source and destination):
            sourceFileName = os.path.basename(source)

            destinationisfile = os.path.isfile(destination) 

            source = "'" + source + "'"
            print(source)

            if(destinationisfile):
                destination = "'" + destination + "'"
            else:
                destination = "'" + destination + sourceFileName +"'"    
            print(destination)
            os.system("echo Hello from the other side!")
        else:
            print("Login error!")    


# INSTACE CLASS
if __name__ == "__main__":
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
