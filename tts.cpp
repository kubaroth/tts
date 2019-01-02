#include "tts.h"
tts::tts(QObject *parent) : QObject(parent){}

QString tts::userName(){
    return m_userName;
}

void tts::setUserName(const QString &userName){
    if (userName == m_userName)
        return;

    m_userName = userName;
    emit userNameChanged();
}

