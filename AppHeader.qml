import QtQuick 2.0
import QtQuick.Controls 2.0

Item {
    property alias playlistButtonStatus: playlist_button.status
    signal clickPlaylistButton
    Image {
        id: headerItem
        source: "qrc:/Image/title.png"
        SwitchButton {
            id: playlist_button
            anchors.left: parent.left
            anchors.leftMargin: 20
            anchors.verticalCenter: parent.verticalCenter
            icon_off: "qrc:/Image/drawer.png"
            icon_on: "qrc:/Image/back.png"
            onClicked: {
                clickPlaylistButton()
                if(playlistButtonStatus == 0){
                    playlistButtonStatus == 1
                    clickPlaylistButton()
                }
                else
                {
                    playlistButtonStatus == 0
                    clickPlaylistButton()
                }
            }
        }

        Text {
            anchors.left: playlist_button.right
            anchors.leftMargin: 5
            anchors.verticalCenter: parent.verticalCenter
            verticalAlignment: Text.AlignVCenter
            text: qsTr("Playlist")
            color: "white"
            font.pixelSize: 32
        }

        Text {
            id: headerTitleText
            text: qsTr("Media Player")
            anchors.centerIn: parent
            color: "white"
            font.pixelSize: 46
        }

        Image {
            id: vn_flag
            anchors.right: parent.right
            anchors.rightMargin: 20
            anchors.verticalCenter: parent.verticalCenter
            width: 50
            height: 50
            source: "qrc:/Image/vn.png"

            Rectangle{
                id: flag_vi
                width: 50
                height: 30
                anchors.verticalCenter: parent.verticalCenter
                border.color: "gray"
                border.width: 5
                color: "transparent"
                //                visible: ...
                states: [
                    State {
                        name: "default"
                        PropertyChanges {
                            target: flag_vi;
                            border.color: "grey"
                        }
                    },
                    State {
                        name: "clicked"
                        PropertyChanges {
                            target: flag_vi;
                            border.color: "green"
                        }
                    }
                ]
            }

            MouseArea {
                anchors.fill: parent
                onClicked: {
                    onClicked: trans.selectLanguage("VIE")
                    highlightFlag("vi");
                }
            }
        }

        Image {
            id: us_flag
            anchors.right: vn_flag.left
            anchors.rightMargin: 10
            anchors.verticalCenter: parent.verticalCenter
            width: 50
            height: 50
            source: "qrc:/Image/us.png"

            Rectangle{
                id: flag_en
                width: 50
                height: 30
                anchors.verticalCenter: parent.verticalCenter
                border.color: "gray"
                border.width: 5
                color: "transparent"
                //                visible: ...

                states: [
                    State {
                        name: "default"
                        PropertyChanges {
                            target: flag_en;
                            border.color: "grey"
                        }
                    },
                    State {
                        name: "clicked"
                        PropertyChanges {
                            target: flag_en;
                            border.color: "green"
                        }
                    }
                ]
            }

            MouseArea {
                anchors.fill: parent
                onClicked: {
                    onClicked: trans.selectLanguage("ENG")
                    highlightFlag("en");
                }
            }
        }
    }

    Component.onCompleted: {
        flag_en.state = "clicked";
    }

    function highlightFlag(lang)
    {
        switch (lang)
        {
        case "en":
            flag_en.state = "clicked";
            flag_vi.state = "default";
            break;
        case "vi":
            flag_vi.state = "clicked";
            flag_en.state = "default";
            break;
        }
    }
}
