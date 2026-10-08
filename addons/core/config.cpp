#include "script_component.hpp"

class CfgPatches {
    class ADDON {
        name = "24th CVO Ammo Logistics";
        author = "24th Chorni Voron";
        url = "https://github.com/SkippieDippie/24th-CVO-Ammo-Logistics";

        requiredVersion = REQUIRED_VERSION;
        requiredAddons[] = {"CBA_main"};
        
        units[] = {};
        weapons[] = {};

        skipWhenMissingDependencies = 0;
    };
};

#include "CfgEventHandlers.hpp"
