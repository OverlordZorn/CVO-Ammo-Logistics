class CfgMagazines {
    class CA_Magazine;

    class 30Rnd_556x45_Stanag: CA_Magazine {
        GVARMAIN(magazineData) = QGVARMAG(STANAG_556x45);
    };

    class 30Rnd_65x39_caseless_mag: CA_Magazine {
        GVARMAIN(magazineData) = QGVARMAG(30Rnd_STANAG_65x39);
    };
};
