#include "\z\cvo_ammo_logistics\addons\core\script_component.hpp"
/*
 * Author: 24th Chorni Voron
 * Builds the child actions of the "Refill" and "Unload" submenus.
 * One entry per distinct magazine (class + ammo count).
 * Refill lists every magazine that is not full, unload lists every magazine that holds rounds.
 *
 * Arguments:
 * 0: Target <OBJECT>
 * 1: Player <OBJECT>
 * 2: Action params <ARRAY>
 *    0: Unload mode <BOOL> (default: false)
 *
 * Return Value:
 * Children actions <ARRAY>
 *
 * Public: No
 */

params ["_target", "_player", ["_params", []]];
_params params [["_unload", false, [false]]];

private _mags = if (_unload) then {
    // Every magazine that still holds rounds, full ones included
    ([_player] call FUNC(getInventoryMagazines)) select {
        (_x select 1) > 0
    } apply {
        _x params ["_class", "_count"];
        [_class, _count, getNumber (configFile >> "CfgMagazines" >> _class >> "count")]
    }
} else {
    [_player] call FUNC(getPartialMagazines)
};

private _unique = [];
{_unique pushBackUnique _x} forEach _mags;

private _actions = [];

{
    private _entry = _x;
    _entry params ["_class", "_count", "_max"];

    private _amount = {_x isEqualTo _entry} count _mags;
    private _name = getText (configFile >> "CfgMagazines" >> _class >> "displayName");
    private _text = format ["%1 (%2/%3)", _name, _count, _max];
    if (_amount > 1) then {
        _text = format ["%1 x%2", _text, _amount];
    };

    private _icon = ["\a3\ui_f\data\IGUI\Cfg\simpleTasks\types\rearm_ca.paa", "\a3\ui_f\data\IGUI\Cfg\simpleTasks\types\download_ca.paa"] select _unload;

    private _action = [
        format ["%1_%2_%3_%4", QGVAR(repack), _unload, _class, _count],
        _text,
        _icon,
        {
            params ["_target", "_player", "_params"];
            _params params ["_class", "_count", "_unload"];
            [_class, _count, _unload, _player] call FUNC(repackMagazine);
        },
        {true},
        {},
        [_class, _count, _unload],
        "",
        2,
        [false, false, false, false, false],
        {
            params ["_target", "_player", "_params", "_actionData"];
            _params params ["_class", "", "_unload"];

            // Unloading needs no ammo items, only refilling does
            if (_unload) exitWith {};

            private _item = ([_class] call FUNC(getAmmoData)) get "item";
            if !(_item in items _player) then {
                _actionData set [2, [
                    "\a3\ui_f\data\IGUI\Cfg\simpleTasks\types\rearm_ca.paa",
                    "#808080"
                ]];
            };
        }
    ] call ace_interact_menu_fnc_createAction;

    _actions pushBack [_action, [], _target];
} forEach _unique;

_actions
