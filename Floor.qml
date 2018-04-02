import QtQuick 2.0

GridView {

    count: ((width / cellWidth) + 1) * ((height / cellHeight) + 1)
    delegate: Rectangle {

    }
}

