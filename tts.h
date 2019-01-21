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
    Q_INVOKABLE bool play(const QString &msg) {
        // char txt[] = "Testing 1 2 3. Using a callback, each phrase is returned separately.";
        // CPRCEN_engine_channel_speak(eng, chan, txt, strlen(txt), 1);
        
        toggle = 0;
        CPRC_abuf * abuf = CPRCEN_engine_channel_speak(eng, chan, msg.toStdString().c_str(), msg.length(), 1);
        qDebug() << abuf;

        return true;
    }

Q_INVOKABLE bool stop() {    
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
    int m_rate = 100;    
    /// TTS data definitions
    CPRCEN_engine * eng;
    CPRCEN_channel_handle chan;

public:
    QAudioOutput *player;
    QAudioFormat * fmt;
    bool toggle = 0;
    QThread * thread;
    QEventLoop * loop; // local loop to block the callback

};
