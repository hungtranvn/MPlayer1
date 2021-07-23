#include "playlistmodel.h"

#include <QFileInfo>
#include <QUrl>
#include <QMediaPlaylist>

PlaylistModel::PlaylistModel(QObject *parent)
    : QAbstractListModel(parent)
{
}

int PlaylistModel::rowCount(const QModelIndex &parent) const
{
   Q_UNUSED(parent);
    return m_data.count();
}


QVariant PlaylistModel::data(const QModelIndex &index, int role) const
{
    if (index.row() < 0 || index.row() >= m_data.count())
        return QVariant();

    const Song &song = m_data[index.row()];
    if (role == TitleRole)
        return song.title();
    else if (role == SingerRole)
        return song.singer();
    else if (role == SourceRole)
        return song.source();
    else if (role == AlbumArtRole)
        return song.album_art();
    return QVariant();
}

void PlaylistModel::addSong(Song &song)
{
    beginInsertRows(QModelIndex(), rowCount(), rowCount());
    m_data << song;
    endInsertRows();
}

QHash<int, QByteArray> PlaylistModel::roleNames() const
{
    QHash<int, QByteArray> roles;
    roles[TitleRole] = "title";
    roles[SingerRole] = "singer";
    roles[SourceRole] = "source";
    roles[AlbumArtRole] = "album_art";
    return roles;
}

Song::Song(const QString &title, const QString &singer, const QString &source, const QString &albumArt)
{
    m_title = title;
    m_singer = singer;
    m_source = source;
    m_albumArt = albumArt;
}

QString Song::title() const
{
    return m_title;
}

QString Song::singer() const
{
    return m_singer;
}

QString Song::source() const
{
    return m_source;
}

QString Song::album_art() const
{
    return m_albumArt;
}
