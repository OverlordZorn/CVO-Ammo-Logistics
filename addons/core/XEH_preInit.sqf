#include "script_component.hpp"

ADDON = false;

#include "XEH_PREP.hpp"

[
    QGVAR(timePerRound),            // setting variable: "cvo_ammo_logistics_core_timePerRound"
    "SLIDER",
    CSTRING(timePerRound),
    CSTRING(settingsCategory),
    [0.5, 5, 1, 1, false],
    1,
    {},
    false
] call CBA_fnc_addSetting;

ADDON = true;
