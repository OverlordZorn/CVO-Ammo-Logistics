class CVO_Magazines {
    class GVARMAG(Default);

    class GVARMAG(STANAG_556x45): GVARMAG(Default) {
        item = QGVAR(556x45);
        itemTracer = QGVAR(556x45_Tracer);
    };

    class GVARMAG(30Rnd_STANAG_65x39): GVARMAG(Default) {
        item = QGVAR(65x39);
        itemTracer = QGVAR(65x39_Tracer);
        convertMag[] = {
            "30Rnd_65x39_caseless_mag",
            "30Rnd_65x39_caseless_mag_Tracer",
            "ACE_30Rnd_65x39_caseless_mag_Tracer_Dim",
            "ACE_30Rnd_65_Creedmor_mag",
            "ACE_30Rnd_65x47_Scenar_mag"
        };
    };
};
