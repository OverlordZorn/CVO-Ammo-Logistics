class CfgFunctions
{
    class ADDON
    {
        class COMPONENT
        {
            file = PATH_TO_FUNC;

            class getInventoryMagazines {};
            class getMagazineData {};
            class getPartialMagazines {};
            class getRepackActions {};
            class onMagazineUnloaded {};
            class onReloaded {};
            class removeVanillaEmptyMagazine {};
            class repackMagazine {};
            class returnEmptyMagazine {};
        };
        class init {
            file = PATH_TO_FUNC_SUB(init);
            
            // class function { /* preInit = 1; */ };
        };
        
    };
};