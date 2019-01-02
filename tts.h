#pragma once

#include <QObject>
#include <QDebug>
class tts : public QObject{
    Q_OBJECT
    Q_PROPERTY(QString userName READ userName WRITE setUserName NOTIFY userNameChanged)
    
public:
    explicit tts(QObject *parent = nullptr);
    QString userName();
    void setUserName(const QString &userName);
    Q_INVOKABLE bool echo(const QString &msg) {
            qDebug() << "Called the C++ method with" << msg;
            return true;
    }    
signals:
    void userNameChanged();
private:
    QString m_userName;
};
