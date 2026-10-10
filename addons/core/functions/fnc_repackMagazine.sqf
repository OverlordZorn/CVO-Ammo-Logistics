#include "\z\cvo_ammo_logistics\addons\core\script_component.hpp"
/*
 * Author: 24th Chorni Voron
 * Refills the magazine with loose ammo on the player.
 * If the process is interrupted, the magazine keeps the 
 * rounds loaded so far (based on elapsed time).
 * Magazines currently loaded in a weapon are never touched.
 *
 * Arguments:
 * 0: Magazine classname <STRING>
 * 1: Initial number of rounds in the magazine <NUMBER>
 *
 * Return Value:
 * Reload started <BOOL>
 *
 * Example:
 *["30Rnd_65x39_caseless_mag", 12] call cvo_ammo_logistics_core_fnc_repackMagazine
 *
 * Public: No
 */

params [
    ["_magClass", "", [""]],
    ["_ammoCount", 0, [0]]
];

private _ammoData = [_magClass] call FUNC(getAmmoData);
private _ammoClass = _ammoData get "item";
private _timePerRound = GVAR(timePerRound);

private _maxCount = getNumber (configFile >> "CfgMagazines" >> _magClass >> "count");
if (_maxCount <= 0) exitWith {
    [localize LSTRING(invalidMagazine)] call CBA_fnc_notify;
    false
};

private _roundsToLoad = _maxCount - _ammoCount;
if (_roundsToLoad <= 0) exitWith {
    [localize LSTRING(magazineFull)] call CBA_fnc_notify;
    false
};

private _hasMag = {
    _x params ["_class", "_ammo"];
    _class == _magClass && {_ammo == _ammoCount}
} count ([player] call FUNC(getInventoryMagazines)) > 0;

if (!_hasMag) exitWith {
    [localize LSTRING(magazineNotFound)] call CBA_fnc_notify;
    false
};

private _ammoAvailable = {_x == _ammoClass} count items player;

if (_ammoAvailable <= 0) exitWith {
    [localize LSTRING(noAmmo)] call CBA_fnc_notify;
    false
};

// Not enough for a full repack: warn the player and load what is possible
if (_ammoAvailable < _roundsToLoad) then {
    [localize LSTRING(notEnoughAmmo)] call CBA_fnc_notify;

    _roundsToLoad = _ammoAvailable;
};

private _applyRepack = {
    params ["_magClass", "_ammoCount", "_ammoClass", "_roundsLoaded"];

    if (_roundsLoaded <= 0) exitWith {};

    private _mags = ([player] call FUNC(getInventoryMagazines)) select {
        (_x select 0) == _magClass
    } apply {_x select 1};

    private _index = _mags find _ammoCount;
    if (_index == -1) exitWith {};
    _mags deleteAt _index;

    for "_i" from 1 to _roundsLoaded do {
        player removeItem _ammoClass;
    };

    player removeMagazines _magClass;
    {
        player addMagazine [_magClass, _x];
    } forEach _mags;

    player addMagazine [_magClass, _ammoCount + _roundsLoaded];
};

// Instant repacking, no progress bar needed (safeguard if the setting is overridden to 0)
if (_timePerRound <= 0) exitWith {
    [_magClass, _ammoCount, _ammoClass, _roundsToLoad] call _applyRepack;
    true
};

private _totalTime = _roundsToLoad * _timePerRound;

[
    _totalTime,
    [_magClass, _ammoCount, _maxCount, _ammoClass, _timePerRound, _roundsToLoad, _applyRepack],
    {
        // On finish: all rounds loaded
        (_this select 0) params ["_magClass", "_ammoCount", "_maxCount", "_ammoClass", "_timePerRound", "_roundsToLoad", "_applyRepack"];

        [_magClass, _ammoCount, _ammoClass, _roundsToLoad] call _applyRepack;
    },
    {
        // On fail / cancelled: load only the rounds completed so far
        _this params ["_args", "_elapsedTime"];
        _args params ["_magClass", "_ammoCount", "_maxCount", "_ammoClass", "_timePerRound", "_roundsToLoad", "_applyRepack"];

        private _roundsLoaded = (floor (_elapsedTime / _timePerRound)) min _roundsToLoad;

        if (_roundsLoaded > 0) then {
            [_magClass, _ammoCount, _ammoClass, _roundsLoaded] call _applyRepack;
            [format [localize LSTRING(repackInterrupted), _roundsLoaded]] call CBA_fnc_notify;
        } else {
            [localize LSTRING(repackCancelled)] call CBA_fnc_notify;
        };
    },
    format [localize LSTRING(loadingRounds), _roundsToLoad],
    {
        // Condition: abort if the magazine disappears or there are too few ammo items
        (_this select 0) params ["_magClass", "_ammoCount", "", "_ammoClass", "", "_roundsToLoad"];

        private _hasMag = {
            _x params ["_class", "_ammo"];
            _class == _magClass && {_ammo == _ammoCount}
        } count ([player] call FUNC(getInventoryMagazines)) > 0;

        _hasMag && {({_x == _ammoClass} count items player) >= _roundsToLoad}
    },
    ["isNotInside", "isNotSwimming"]
] call ace_common_fnc_progressBar;

true
