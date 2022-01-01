// in case of fire, tell Bear

class baseMan {// Weaponless baseclass
    displayName = "Unarmed";
    // All randomized.
    uniform[] = {"rhs_uniform_gorka_r_g"};
    vest[] = {"rhs_6b23_digi_6sh92_spetsnaz2"};
    backpack[] = {"rhs_assault_umbts"};
    headgear[] = {"rhs_6b28_green", "rhs_6b28_green_bala", "rhs_6b28_green_ess", "rhs_6b28_green_ess_bala"};
    goggles[] = {};
    hmd[] = {"ACE_NVG_Wide"};
    // Leave empty to remove all. "Default" > leave original item.

    // All randomized
    primaryWeapon[] = {};
    scope[] = {};
    bipod[] = {};
    attachment[] = {};
    silencer[] = {};
    // Leave empty to remove all. "Default" for primaryWeapon > leave original weapon.

    // Only *Weapons[] arrays are randomized
    secondaryWeapon[] = {};
    secondaryAttachments[] = {};
    sidearmWeapon[] = {};
    sidearmAttachments[] = {};
    // Leave empty to remove all. "Default" for secondaryWeapon or sidearmWeapon > leave original weapon.

    // These are added to the uniform or vest
    magazines[] = {};
    items[] = {};
    // These are added directly into their respective slots
    linkedItems[] = {
        "ItemMap",
        "ItemCompass",
        "ItemGPS",
        "ItemWatch"
    };

    // These are put into the backpack
    backpackItems[] = {};

    // This is executed after unit init is complete. argument: _this = _unit.
    code = "if (random 1 < 0.5) then { _this addItem 'murshun_cigs_cigpack'; _this addItem 'murshun_cigs_matches'};";
    traits[] = {};
};
class r : baseMan
{
    displayName = "Rifleman";
    primaryWeapon[] = {"rhs_weap_asval_grip1"};
    scope[] = {"rhs_acc_pkas_asval"};
    bipod[] = {"rhs_acc_grip_ffg2"};
    attachment[] = {"rhs_acc_perst1ik_ris"};
    silencer[] = {};
    magazines[] =
    {
        LIST_8("rhs_20rnd_9x39mm_SP6"),
        LIST_2("rhs_mag_rgd5"),
        LIST_2("rhs_mag_rdg2_white")
    };
    items[] =
    {
        LIST_10("ACE_fieldDressing"),
        LIST_3("ACE_morphine"),
        LIST_1("ACE_epinephrine"),
        LIST_1("ACE_salineIV_500"),
    };
};
class m : r 
{
    displayName = "Medic";
    traits[] += {"medic"};
    backPack[] = {"rhs_medic_bag"};
    backpackItems[] = {
        LIST_1("ACE_surgicalKit"),
        LIST_1("ACE_personalAidKit"),
        LIST_20("ACE_fieldDressing"),
        LIST_10("ACE_morphine"),
        LIST_10("ACE_epinephrine"),
        LIST_6("ACE_salineIV_500"),
    };
};
class ftl : r
{
    displayName = "Fireteam Leader";
    vest[] = {"rhs_6b23_digi_6sh92_headset_spetsnaz"};
    items[] += {"ACE_Maptools"};
    linkedItems[] +=
    {
        "rhs_pdu4",
    };
};
class sl : ftl
{
    displayName = "Squad Leader";
    sidearmWeapon[] = {"rhs_weap_pya"};
    vest[] = {"rhs_6b23_digi_6sh92_Spetsnaz"};
    headgear[] = {"rhs_beret_mp1", "rhs_beret_mp2"};
    magazines[] +=
    {
        LIST_3("rhs_mag_9x19_17")
    };
};
class co : sl
{
    displayName = "Platoon Leader";
}
class rat : r
{
    displayName = "Rifleman (AT)";
    secondaryWeapon[] = {"rhs_weap_rpg26"};
};
class dm : r
{
    displayName = "Designated Marksman";
    primaryWeapon[] = {"40th_weap_svd_wood"};
    silencer[] = {};
    scope[] = {"rhs_acc_pso1m2"};
    bipod[] = {};
    magazines[] =
    {
        LIST_12("rhs_10Rnd_762x54mmR_7N1"),
        "rhs_mag_rgd5",
        LIST_2("rhs_mag_rdg2_white")
    };
};
class matg : r
{
    displayName = "MAT Gunner";
    secondaryWeapon[] = {"rhs_weap_rpg7"};
    secondaryAttachments[] = {"rhs_acc_pgo7v3"};
    backpack[] = {"rhs_rpg_empty"};
    magazines[] +=
    {
        "rhs_rpg7_PG7VR_mag",
        LIST_2("rhs_rpg7_PG7VL_mag")
    };
};
class matac : r
{
    displayName = "MAT Ammo Carrier";
    backpack[] = {"rhs_rpg_empty"};
    backpackItems[] =
    {
        "rhs_rpg7_PG7VR_mag",
        LIST_2("rhs_rpg7_PG7VL_mag")
    };
};
class matag : r
{
    displayName = "MAT Assistant Gunner";
    vest[] = {"rhs_6b23_digi_6sh92_headset"};
    backpack[] = {"rhs_rpg_empty"};
    linkedItems[] =
    {
        "ItemMap",
        "ItemCompass",
        "ItemWatch",
        "rhs_pdu4",
        "ItemGPS"
    };
    backpackItems[] =
    {
        "rhs_rpg7_PG7VR_mag",
        LIST_2("rhs_rpg7_PG7VL_mag")
    };
};
class sn : r
{
    displayName = "Sniper";
    traits[] += {"camouflageCoef"};
    headgear[] = {"rhs_beanie_green", "rhs_Booniehat_digi"};
    primaryWeapon[] = {"rhs_weap_svds"};
    sidearmWeapon[] = {"rhs_weap_pya"};
    silencer[] = {"rhs_acc_tgpv2"};
    scope[] = {"rhs_acc_1pn93_1"};
    bipod[] = {};
    items[] += {"rhs_acc_pso1m2"};
    magazines[] =
    {
        LIST_4("rhs_10Rnd_762x54mmR_7N14"),
        LIST_3("rhs_mag_9x19_17")
    };
};
class sp : r
{
    displayName = "Spotter";
    traits[] += {"camouflageCoef"};
    headgear[] = {"rhs_beanie_green", "rhs_Booniehat_digi"};
    vest[] = {"rhs_6sh92_radio"};
    linkedItems[] +=
    {
        "rhs_pdu4",
    };

};