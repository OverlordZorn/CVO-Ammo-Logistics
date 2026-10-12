#include "script_component.hpp"

class CfgPatches {
    class ADDON {
        name = "24th CVO Ammo Logistics";
        author = "24th Chorni Voron";
        authors[] = {"Skippie [CVO]"};
        url = "https://github.com/SkippieDippie/CVO-Ammo-Logistics";

        requiredVersion = REQUIRED_VERSION;
        requiredAddons[] = {"cvo_ammo_logistics_main", "cba_main", "ace_common", "ace_interact_menu", "ace_magazinerepack"};
        
        units[] = {};
        weapons[] = {};

        skipWhenMissingDependencies = 0;
        
        VERSION_CONFIG;
    };
};

class CVO_Magazines {
    class GVARMAG(Default) {
        item = "ACE_CableTie"; //placeholder
        itemTracer = "";
        itemQuickloader = "";
        convertMag[] = {};
    };
};

#include "CfgVehicles.hpp"
#include "CfgEventHandlers.hpp"
