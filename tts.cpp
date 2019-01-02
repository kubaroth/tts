#include "tts.h"

// A callback to pass to TTS
void channel_callback(CPRC_abuf * abuf, void * userdata) {
    /* The void pointer should be cast by the user to their chosen
    data type, here it is an audio player. */
    CPRC_sc_player * player = (CPRC_sc_player *) userdata;
    /* Disposable audio buffer, cleaned up automatically after playback. */
    CPRC_sc_audio * buf = CPRC_sc_audio_short_disposable(CPRC_abuf_wav_data(abuf),
    CPRC_abuf_wav_sz(abuf));
    /* Cue up the audio, it will be played when other audio has finished,
    or immediately if no audio is playing. */
    CPRC_sc_audio_cue(player, buf);
}

tts::tts(QObject *parent) : QObject(parent){
    
    /// Init voice
    eng = CPRCEN_engine_load("/home/kuba/PRJ/tts_spelling/license_eng.lic", "/home/kuba/PRJ/tts_spelling/tts_eng.voice");
    chan = CPRCEN_engine_open_default_channel(eng);
    int freq = atoi(CPRCEN_channel_get_voice_info(eng, chan, "SAMPLE_RATE"));
    player = CPRC_sc_player_new(freq);
    /* When setting the callback, the user data must be cast to void, the
    user casts it back in the callback function. */
    CPRCEN_engine_set_callback(eng, chan, (void *)player, channel_callback);
    
}

tts::~tts(){
    CPRC_sc_player_delete(player);
    CPRCEN_engine_delete(eng);    
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

