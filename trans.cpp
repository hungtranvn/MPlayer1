#include "trans.h"

Trans::Trans(QQmlEngine *engine)
{
    _translator = new QTranslator(this);
    _engine = engine;
}

void Trans::selectLanguage(QString language)
{
    // working folder
    QDir dir = QDir(qApp->applicationDirPath()).absolutePath();


    if (!_translator->load(
                // for example, in case of "vi" language the file would be
                // Media_vi.qm
                // extension is set automatically
                QString("Media_%1").arg(language),
                // look for the file in Translator folder within working directory
                QString("%1/Translator").arg(dir.path())
                )
            )
    {
        qDebug() << "Failed to load translation file, falling back to English";
    }
    // it's a global thing, we can use it anywhere (after #including <QGuiApplication>)
    qApp->installTranslator(_translator);
    _engine->retranslate();

    emit languageChanged();
}
