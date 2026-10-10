#include "\z\cvo_ammo_logistics\addons\core\script_component.hpp"
/*
 * Author: 24th Chorni Voron
 * Returns the ammo data used to repack a magazine, read from its CVO_Ammo class.
 * Falls back to CVO_Ammo_Default if the magazine has no valid reference.
 *
 * Arguments:
 * 0: Magazine classname <STRING>
 *
 * Return Value:
 * Ammo data <HASHMAP>
 * Keys:
 * "class"      <STRING> - CVO_Ammo class that was resolved
 * "item"       <STRING> - ammo item classname (basic and complex modes)
 * "itemTracer" <STRING> - tracer ammo item classname (complex mode only)
 * "convertMag" <ARRAY>  - classnames the empty magazine can be converted into
 *
 * Example:
 * private _ammoData = ["30Rnd_65x39_caseless_mag"] call cvo_ammo_logistics_core_fnc_getAmmoData;
 * private _item = _ammoData get "item";
 *
 * Public: No
 */

params [["_magClass", "", [""]]];

private _ref = getText (configFile >> "CfgMagazines" >> _magClass >> "cvo_ammo_logistics_ammoType");
private _cfg = configNull;

if (_ref != "") then {
    _cfg = configFile >> "CVO_Ammo" >> _ref;
};

if (!isClass _cfg) then {
    _cfg = configFile >> "CVO_Ammo" >> "CVO_Ammo_Default";
};

createHashMapFromArray [
    ["class", configName _cfg],
    ["item", getText (_cfg >> "item")],
    ["itemTracer", getText (_cfg >> "itemTracer")],
    ["convertMag", getArray (_cfg >> "convertMag")]
]
