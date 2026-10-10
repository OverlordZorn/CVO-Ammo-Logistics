#include "\z\cvo_ammo_logistics\addons\core\script_component.hpp"
/*
 * Author: 24th Chorni Voron
 * Returns all magazines in the player's inventory that are partially loaded.
 * Magazines currently loaded in weapons are never included.
 *
 * Arguments:
 * None
 *
 * Return Value:
 * Partial magazines <ARRAY>
 * Each element: [class <STRING>, ammoCount <NUMBER>, maxCount <NUMBER>]
 *
 * Example:
 * [] call cvo_ammo_logistics_core_fnc_getPartialMagazines
 *
 * Public: No
 */

private _partialMags = [];

{
    _x params ["_magClass", "_ammoCount"];

    private _maxCount = getNumber (configFile >> "CfgMagazines" >> _magClass >> "count");

    if (_maxCount > 0 && {_ammoCount < _maxCount}) then {
        _partialMags pushBack [_magClass, _ammoCount, _maxCount];
    };
} forEach ([player] call FUNC(getInventoryMagazines));

_partialMags
