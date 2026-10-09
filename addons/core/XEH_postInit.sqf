#include "script_component.hpp"

if (!hasInterface) exitWith {};
// Add event handlers and handle player unit being changed mid game (by respawning or using selectPlayer command)
GVARMAIN(ReloadedEHID) = -1;
GVARMAIN(onMagazineUnloadedEHID) = -1;
GVARMAIN(player) = objNull;

[
    {!isNull player},
    {
        ["unit", {
            if (!isNull GVARMAIN(player)) then {
                if (GVARMAIN(ReloadedEHID) != -1) then {
                    GVARMAIN(player) removeEventHandler ["Reloaded", GVARMAIN(ReloadedEHID)];
                };
                if (GVARMAIN(onMagazineUnloadedEHID) != -1) then {
                    GVARMAIN(player) removeEventHandler ["MagazineUnloaded", GVARMAIN(onMagazineUnloadedEHID)];
                };
            };

            GVARMAIN(player) = player;
            GVARMAIN(ReloadedEHID) = player addEventHandler ["Reloaded", FUNC(onReloaded)];
            GVARMAIN(onMagazineUnloadedEHID) = player addEventHandler ["MagazineUnloaded", FUNC(onMagazineUnloaded)];
        }, true] call CBA_fnc_addPlayerEventHandler;
    }
] call CBA_fnc_waitUntilAndExecute;
