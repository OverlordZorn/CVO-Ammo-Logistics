#include "script_component.hpp"

if (!hasInterface) exitWith {};

[
    {!isNull player},
    {
        ["unit",{
            [player, "Reloaded", FUNC(onReloaded)] call CBA_fnc_addBISEventHandler;
            [player, "MagazineUnloaded", FUNC(onMagazineUnloaded)] call CBA_fnc_addBISEventHandler;
        }, true] call CBA_fnc_addPlayerEventHandler;
    }
] call CBA_fnc_waitUntilAndExecute;
