/*
 * Author: 24th Chorni Voron
 *
 * Handler for the "MagazineUnloaded" event. Handles magazines disappearing when empty.
 * If the magazine that was just removed from the weapon is empty,
 * a new empty magazine of the same class is added to the unit's inventory.
 * If there is no room, it is placed on the ground next to the unit instead.
 */

params ["_unit", "", "", "_magazine"];

if (_magazine isEqualTo []) exitWith {};

_magazine params ["_magClass", "_ammoCount"];

// Only handle empty magazines
if (_ammoCount > 0) exitWith {};

if (_unit canAdd _magClass) then {
    _unit addMagazine [_magClass, 0];
} else {
    private _holder = nearestObjects [_unit, ["GroundWeaponHolder"], 2] param [0, objNull];

    if (isNull _holder) then {
        _holder = createVehicle ["GroundWeaponHolder", getPosATL _unit, [], 0, "CAN_COLLIDE"];
    };

    _holder addMagazineAmmoCargo [_magClass, 1, 0];
};
