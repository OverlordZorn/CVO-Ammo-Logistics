#include "script_component.hpp"

class CfgPatches {
    class ADDON {
        name = "24th CVO Ammo Logistics";
        author = "24th Chorni Voron";
        authors[] = {"Skippie [CVO]"};
        url = "https://github.com/SkippieDippie/24th-CVO-Ammo-Logistics";

        requiredVersion = REQUIRED_VERSION;
        requiredAddons[] = {"cba_main", "ace_common"};
        
        units[] = {};
        weapons[] = {};

        skipWhenMissingDependencies = 0;
    };
};

#include "CfgEventHandlers.hpp"
