import QtQuick 2.11
import QtQuick.Controls 2.4

ApplicationWindow {
    id: mainWindow
    visible: true
    width: 1920
    height: 1080
    visibility: "FullScreen"
    title: qsTr("Media Player")

    property double toWidth: mainWindow.width

    //shortcut
    Shortcut {
        sequence: "Ctrl+Q"
        onActivated: Qt.quit()
    }

    //Backgroud of Application
    Image {
        id: backgroud
        anchors.fill: parent
        source: "qrc:/Image/background.png"
    }
    //Header
    AppHeader{
        id: headerItem
        width: parent.width
        height: 141
        playlistButtonStatus: playlist.position > 0 ? 1 : 0
        onClickPlaylistButton: {
            if(playlistButtonStatus == 1){
                playlist.close()
                //animationI.running = true
                mediaInfoControl.width = mainWindow.width
                mainWindow.toWidth = mainWindow.width
                mediaInfoControl.anchors.left = parent.left
            }
            else{
                playlist.open()
                //animationII.running = true
                mediaInfoControl.anchors.left = playlist.Left
                mediaInfoControl.width = mainWindow.width - playlist.width
                mainWindow.toWidth = mainWindow.width - playlist.width

            }
        }
        // https://www.programmersought.com/article/6662653688/
    }

    //Playlist
    PlaylistView{
        id: playlist
        y: headerItem.height
        width: 675
        height: parent.height - headerItem.height
    }

    //Media Info
    MediaInfoControl{
        id: mediaInfoControl
        anchors.top: headerItem.bottom
        anchors.right: parent.right
        //anchors.left: parent.left
        anchors.bottom: parent.bottom
        width: parent.width

        NumberAnimation {
            id: animationI
            target: mediaInfoControl
            property: "width"
            duration: 200
            from: mediaInfoControl.width
            to: mainWindow.width
        }

        NumberAnimation {
            id: animationII
            target: mediaInfoControl
            property: "width"
            duration: 200
            from: mediaInfoControl.width
            to: mainWindow.width - playlist.width
        }
    }
}
