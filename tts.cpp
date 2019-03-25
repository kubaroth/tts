#include "tts.h"

#include <QDataStream>
#include <QAudioOutput>
#include <QStandardPaths>

void channel_callback(CPRC_abuf * abuf, void * userdata){

    tts * _tts = (tts *) userdata;
    QAudioOutput * player = _tts->player;

    // length of the adio in the buffer
    int len = CPRC_abuf_wav_sz(abuf) * 2;
    // pointer to the raw audio data;
    char * wav = (char *) CPRC_abuf_wav_data(abuf);

    qDebug() << "callback---------------";

    QByteArray * bytes = new QByteArray(wav,len);
    QBuffer *buffer = new QBuffer(bytes, player);
    buffer->open(QIODevice::ReadWrite);

    /// This is optimization for Android where loading the next phrase incures short but audable delay
    /// Here we preallocate all the date, enter the event loop.
    /// When the current playing phrase ends it triggers immediatly the next one.
//    if ((_tts->triggerNext == 1) or (player->state() == QAudio::State::SuspendedState) ){
    if (_tts->triggerNext == 1){
        _tts->loop->exec();
    }
    player->start(buffer);
    _tts->triggerNext=1;
}

tts::tts(QObject *parent) : QObject(parent){
    
    /// On start extract file from android assets and place them in the AppDataLocation
    /// C++ libraries can not access files from Qt/android resources directly
#ifdef Q_OS_ANDROID
    QString appDataLocation = QStandardPaths::writableLocation(QStandardPaths::StandardLocation::AppDataLocation);
    QString licAndroidPath = appDataLocation + "/license_eng.lic";
    QString voiceAndroidPath = appDataLocation + "/tts_eng.voice";

    QFile licFile;
    licFile.setFileName("assets:/tts_data/license_eng.lic");
    licFile.copy(licAndroidPath);
    QFile::setPermissions(licAndroidPath, QFile::WriteOwner | QFile::ReadOwner);

    QFile voiceFile;
    voiceFile.setFileName("assets:/tts_data/tts_eng.voice");
    voiceFile.copy(voiceAndroidPath);
    QFile::setPermissions(voiceAndroidPath, QFile::WriteOwner | QFile::ReadOwner);

    eng = CPRCEN_engine_load(licAndroidPath.toStdString().c_str(), voiceAndroidPath.toStdString().c_str());
#endif

#ifdef __linux__
    /// Init voice
    eng = CPRCEN_engine_load("license_eng.lic", "tts_eng.voice");
#endif
    chan = CPRCEN_engine_open_default_channel(eng);
    int freq = atoi(CPRCEN_channel_get_voice_info(eng, chan, "SAMPLE_RATE"));
    qDebug() << freq;

    /// Seting audio parms
    QAudioFormat * fmt = new QAudioFormat();
    fmt->setCodec("audio/pcm");
    fmt->setSampleRate(freq);  // 48000
    fmt->setSampleSize(16);
    fmt->setChannelCount(1);
    fmt->setSampleType(QAudioFormat::SignedInt);
    fmt->setByteOrder(QAudioFormat::LittleEndian);
    player = new QAudioOutput(*fmt, this);

    loop = new QEventLoop(this);

    /// Callbacks and signals
    CPRCEN_engine_set_callback(eng, chan, (void *)this, channel_callback);

    connect(player, &QAudioOutput::stateChanged, loop, &QEventLoop::quit );

}

tts::~tts(){
    delete player;
}

QString tts::userName(){
    return m_userName;
}

void tts::setUserName(const QString &userName){
    if (userName == m_userName)
        return;

    m_userName = userName;
    emit userNameChanged();
}

/*

<s><prosody volume="+6dB">
I am speaking this at approximately twice the original signal amplitude.
</prosody></s>


<s><prosody rate="80%">
This is spoken at a slower rate.
</prosody></s>

 */
