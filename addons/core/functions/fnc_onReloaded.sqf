/*
 * Author: Skippie [CVO]
 *
 * Handler for the "Reloaded" event. Handles magazines disappearing when empty
 * If the magazine that was just removed from the weapon is empty,
 * a new empty magazine of the same class is added to the unit's inventory.
 * If there is no room, it is placed on the ground next to the unit instead.
 */

params ["_unit", "", "", "", "_oldMagazine"];

// No old magazine (e.g. weapon was unloaded before reload)
if (_oldMagazine isEqualTo []) exitWith {};

_oldMagazine params ["_magClass", "_ammoCount"];

// Only handle empty magazines
if (_ammoCount > 0) exitWith {};

if (_unit canAdd _magClass) then {
    // Room in uniform / vest / backpack
    _unit addMagazine [_magClass, 0];
} else {
    // Inventory full: drop the empty mag on the ground
    private _holder = nearestObjects [_unit, ["GroundWeaponHolder"], 2] param [0, objNull];

    if (isNull _holder) then {
        _holder = createVehicle ["GroundWeaponHolder", getPosATL _unit, [], 0, "CAN_COLLIDE"];
    };

    // addMagazineAmmoCargo: [class, number of mags, rounds per mag]
    _holder addMagazineAmmoCargo [_magClass, 1, 0];
};
