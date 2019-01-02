#pragma once

#include <QObject>
#include <QDebug>

#include <cerevoice_eng_simp.h>
#include <cerevoice_aud.h>
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
    Q_INVOKABLE bool play() {    
        char txt[] = "Testing 1 2 3. Using a callback, each phrase is returned separately.";
        CPRCEN_engine_channel_speak(eng, chan, txt, strlen(txt), 1);

    }

Q_INVOKABLE bool stop() {    
    CPRC_sc_audio_stop(player);
    return true;        
    }
    
    
signals:
    void userNameChanged();
    
private:
    QString m_userName;
    int m_rate = 100;    
    /// TTS data definitions
    CPRCEN_engine * eng;
    CPRCEN_channel_handle chan;
    CPRC_sc_player * player;    
};
