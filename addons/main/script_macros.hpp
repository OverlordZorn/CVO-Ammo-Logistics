#include "\x\cba\addons\main\script_macros.hpp"
#include "\z\ace\addons\main\script_macros.hpp"
#include "script_macros_zrn.hpp"


#undef PREP

#ifdef DISABLE_COMPILE_CACHE
    #define PREP(fncName) TRIPLES(ADDON,fnc,fncName) = compile preprocessFileLineNumbers QPATHTOF(functions\DOUBLES(fnc,fncName).sqf)
#else
    #define PREP(fncName) [QPATHTOF(functions\DOUBLES(fnc,fncName).sqf), QUOTE(TRIPLES(ADDON,fnc,fncName))] call CBA_fnc_compileFunction
#endif

#define GVARMAG(var1) TRIPLES(PREFIX,magData,var1)
#define QGVARMAG(var1) QUOTE(GVARMAG(var1))
