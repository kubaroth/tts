#pragma once

#include <QObject>
#include <QDebug>

#include <QBuffer>
#include <QDataStream>
#include <QAudioFormat>
#include <QAudioOutput>
#include <QFile>
#include <QDir>

#include <QEventLoop>

#include <cerevoice_eng.h>


class tts : public QObject{
    Q_OBJECT
    Q_PROPERTY(QString userName READ userName WRITE setUserName NOTIFY userNameChanged)

public:
    explicit tts(QObject *parent = nullptr);
    virtual ~tts();
    QString userName();
    void setUserName(const QString &userName);
    Q_INVOKABLE bool echo(const QString &msg) {
        qDebug() << "Called the C++ method with" << msg;
        return true;
    }
    Q_INVOKABLE bool play(const QString &msg, int rateValue);

Q_INVOKABLE bool stop() {
    qDebug()<< "tts_stop";
    int success = CPRCEN_engine_channel_reset(eng, chan);
    player->stop();
    return true;
}

Q_INVOKABLE bool pause() {
    qDebug()<< "tts_pause " << player->state();

    return true;
    }

public slots:
    void echo_player(QAudio::State state){
        qDebug() << "echoPlayer " << state;
    }

signals:
    void userNameChanged();
    void quit();

private:
    QString m_userName;
    /// TTS data definitions
    CPRCEN_engine * eng;
    CPRCEN_channel_handle chan;

public:
    QAudioOutput *player;
    QAudioFormat * fmt;
    QThread * thread;
    QEventLoop * loop; // local loop to block the callback
    bool continue_play=true;
};
