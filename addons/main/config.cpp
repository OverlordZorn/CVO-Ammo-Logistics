#include "script_component.hpp"

class CfgPatches {
    class ADDON {
        name = ADDON_NAME;
        author = CVO_AUTHOR;
        authors[] = {"Skippie [CVO]"};
        url = GITHUBURL;

        requiredVersion = REQUIRED_VERSION;
        requiredAddons[] = {QGVARMAIN(ammo), QGVARMAIN(core)};
        
        units[] = {};
        weapons[] = {};

        skipWhenMissingDependencies = 0;

        VERSION_CONFIG;
    };
};
