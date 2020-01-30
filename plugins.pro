
TEMPLATE = subdirs

SUBDIRS += \
        sub_sdk \
        sub_match \
        sub_tuning_difference \
        sub_pyin \
        sub_nnls_chroma \
        sub_qm_vamp_plugins \
        sub_azi \
        sub_aubio \
        sub_silvet \
        sub_tipic \
        sub_segmentino \
        sub_examples \
        sub_ua \
        sub_bbc \
        sub_cq \
        sub_cepstral_pitchtracker \
        sub_simple_cepstrum \
        sub_libxtract \
        sub_beatroot \
        sub_marsyas \
        sub_fanchirp \
        sub_vampy \
        sub_tempogram
        
sub_sdk.file = vamp-plugin-sdk.pro
sub_match.file = match-vamp.pro
sub_pyin.file = pyin.pro
sub_tuning_difference.file = tuning-difference.pro
sub_nnls_chroma.file = nnls-chroma.pro
sub_qm_vamp_plugins.file = qm-vamp-plugins.pro
sub_azi.file = azi.pro
sub_aubio.file = vamp-aubio-plugins.pro
sub_silvet.file = silvet.pro
sub_tipic.file = tipic.pro
sub_segmentino.file = segmentino.pro
sub_examples.file = vamp-example-plugins.pro
sub_ua.file = ua-vamp-plugins.pro
sub_bbc.file = bbc-vamp-plugins.pro
sub_cq.file = constant-q-cpp.pro
sub_cepstral_pitchtracker.file = cepstral-pitchtracker.pro
sub_simple_cepstrum.file = vamp-simple-cepstrum.pro
sub_libxtract.file = vamp-libxtract-plugins.pro
sub_beatroot.file = beatroot-vamp.pro
sub_marsyas.file = marsyas-vamp.pro
sub_fanchirp.file = vamp-fanchirp.pro
sub_vampy.file = vampy.pro
sub_tempogram.file = vamp-tempogram.pro

CONFIG += ordered