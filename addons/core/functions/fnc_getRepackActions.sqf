#include "\z\cvo_ammo_logistics\addons\core\script_component.hpp"
/*
 * Author: 24th Chorni Voron
 * Builds the child actions of the "Repack magazines" self-interaction.
 * One entry per distinct partial magazine (class + ammo count).
 *
 * Arguments:
 * 0: Target <OBJECT>
 * 1: Player <OBJECT>
 *
 * Return Value:
 * Children actions <ARRAY>
 *
 * Public: No
 */

params ["_target", "_player"];

private _partial = [_player] call FUNC(getPartialMagazines);
private _unique = [];
{_unique pushBackUnique _x} forEach _partial;

private _actions = [];

{
    private _entry = _x;
    _entry params ["_class", "_count", "_max"];

    private _amount = {_x isEqualTo _entry} count _partial;
    private _name = getText (configFile >> "CfgMagazines" >> _class >> "displayName");
    private _text = format ["%1 (%2/%3)", _name, _count, _max];
    if (_amount > 1) then {
        _text = format ["%1 x%2", _text, _amount];
    };

    private _action = [
        format ["%1_%2_%3", QGVAR(repack), _class, _count],
        _text,
        "\a3\ui_f\data\IGUI\Cfg\simpleTasks\types\rearm_ca.paa",
        {
            params ["_target", "_player", "_params"];
            _params params ["_class", "_count"];
            [_class, _count, _player] call FUNC(repackMagazine);
        },
        {true},
        {},
        [_class, _count],
        "",
        2,
        [false, false, false, false, false],
        {
            params ["_target", "_player", "_params", "_actionData"];
            private _item = ([_params select 0] call FUNC(getAmmoData)) get "item";
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
