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
    Q_INVOKABLE bool play(const QString &msg, int rateValue) {
        // char txt[] = "Testing 1 2 3. Using a callback, each phrase is returned separately.";
        // CPRCEN_engine_channel_speak(eng, chan, txt, strlen(txt), 1);

        // wrap text prosody tag to control speach rate
        QString msg_rate = QString("<s><prosody rate=\"%1\%\">%2 </prosody></s>").arg(QString::number(rateValue), msg);
        //qDebug() << msg_rate;
        
        // ignore subsequent play if the former is still playing
        if (player->state() == QAudio::State::ActiveState) return false;

        triggerNext = 0;
        // reset the channel before playing again
        CPRC_abuf * abuf = CPRCEN_engine_channel_speak(eng, chan, msg_rate.toStdString().c_str(), msg_rate.length(), 1);
        qDebug() << abuf;

        return true;
    }

Q_INVOKABLE bool stop() {
    qDebug()<< "tts_stop";
    int success = CPRCEN_engine_channel_reset(eng, chan);
    qDebug() <<"CHannel reset success " << success;
    return true;
    }
    
Q_INVOKABLE bool pause() {
    qDebug()<< "tts_pause";
    if (player->state() == QAudio::State::ActiveState){
        player->suspend();
    }
    else if (player->state() == QAudio::State::SuspendedState){
        player->resume();
    }
    else{
        qDebug() << player->state();
    }

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
    int triggerNext = 0;
    QThread * thread;
    QEventLoop * loop; // local loop to block the callback
    bool continue_play=true;
};
