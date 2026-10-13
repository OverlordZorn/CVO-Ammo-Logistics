#include "script_component.hpp"

class CfgPatches {
    class ADDON {
        name = ADDON_NAME;
        author = CVO_AUTHOR;
        authors[] = {"Skippie [CVO]"};
        url = GITHUBURL;

        requiredVersion = REQUIRED_VERSION;
        requiredAddons[] = {"cba_main", "ace_common", "ace_interact_menu", "ace_magazinerepack"};
        
        units[] = {};
        weapons[] = {};

        skipWhenMissingDependencies = 0;
        
        VERSION_CONFIG;
    };
};

#include "CVO_Magazines.hpp"
#include "CfgEventHandlers.hpp"
#include "CfgFunctions.hpp"
#include "CfgVehicles.hpp"
