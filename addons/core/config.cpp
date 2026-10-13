#include "script_component.hpp"

class CfgPatches {
    class ADDON {
		name = ADDON_NAME;
		author = "$STR_mod_author";

        authors[] = {"Skippie [CVO]"};
        url = "$STR_mod_URL";

        VERSION_CONFIG;

        // Addon Specific Information
        // Minimum compatible version. When the game's version is lower, pop-up warning will appear when launching the game.
        requiredVersion = REQUIRED_VERSION;

        // Required addons, used for setting load order.
        // When any of the addons is missing, pop-up warning will appear when launching the game.
        requiredAddons[] = {QPVAR(main), "cba_main", "ace_common", "ace_interact_menu", "ace_magazinerepack"};
        
		// Optional. If this is 1, if any of requiredAddons[] entry is missing in your game the entire config will be ignored and return no error (but in rpt) so useful to make a compat Mod (Since Arma 3 2.14)
		skipWhenMissingDependencies = 1;

        // List of objects (CfgVehicles classes) contained in the addon. Important also for Zeus content (units and groups)
        units[] = {};

        // List of weapons (CfgWeapons classes) contained in the addon.
        weapons[] = {};

    };
};

class CVO_Magazines {
    class GVARMAG(Default) {
        item = "ACE_CableTie"; //placeholder
        itemTracer = "";
        itemQuickloader = "";
        convertMag[] = {};
        useBelt = 0;
    };
};

#include "CfgVehicles.hpp"
#include "CfgEventHandlers.hpp"
