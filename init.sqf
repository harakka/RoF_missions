STUI_Occlusion = false;

ha_superDebug = true;

if (isServer) then {
    // Set up the wreck
    wreck_01 setHit ["wheel_1_1_steering", 1]; 
    wreck_01 setHit ["wheel_1_2_steering", 1]; 
    wreck_01 setHit ["wheel_2_1_steering", 1]; 
    wreck_01 setHit ["wheel_2_2_steering", 1]; 
    wreck_01 setHit ["wheel_1_3_steering", 1]; 
    wreck_01 setHit ["wheel_2_3_steering", 1];
    wreck_01 setDamage 0.7;
    [wreck_01, 0, 90] call BIS_fnc_setPitchBank;
    _fire = "test_EmptyObjectForFireBig" createVehicle [0,0,0];
    _fire disableCollisionWith wreck_01;
    _fire setPos (getPos wreck_01);
    
    {(driver _x) action ["CollisionLightOn", _x]; _x setCollisionLight true; } forEach [cinemacopter_01, cinemacopter_02, cinemacopter_03];
    
    // Create flight recorder
    /* This stopped working for some reason, so, yay? We use the in-editor item for this instead
    item_objective = createVehicle ["WeaponHolderSimulated", [0,0,0], [], 0, "NONE"];
    item_objective addWeaponCargoGlobal ["rhs_item_flightrecorder",1];
    item_objective setPos getPos intro_target;
    */
    
    // Initialize state of public variables
    ha_objectiveHolder = objNull;
    ha_objectiveObject = item_objective_fuckit;
    publicVariable "ha_objectiveHolder";
    publicVariable "ha_objectiveObject";
        
    //deleteVehicle intro_target;
    
    {
        if (side _x == resistance) then {
            _x addMPEventHandler ["MPKilled", {
                params ["_unit", "_killer"];
                if ("rhs_item_flightrecorder" in items _unit) then {
                    if (ha_superDebug) then {hint format ["%1 died, dropping objective.", str _unit]};
                    ha_objectiveObject = createVehicle ["WeaponHolderSimulated", [0,0,0], [], 0, "NONE"];
                    ha_objectiveObject addWeaponCargoGlobal ["rhs_item_flightrecorder",1];
                    ha_objectiveObject setPos [getPos _unit select 0, getPos _unit select 1, 1.5];
                    _unit removeItems "rhs_item_flightrecorder";
                    ha_objectiveHolder = objNull;
                    publicVariable "ha_objectiveHolder";
                    publicVariable "ha_objectiveObject";
                };
            }];
        }
    } forEach allUnits;
    
    // Restore the objective into the world if it fell through
    [] spawn {
        while {true} do {
            waitUntil {sleep 5; ha_objectiveObject != objNull};
            if ((getPosATL ha_objectiveObject select 2) <= -1) then {
                ha_objectiveObject setPosATL [getPos ha_objectiveObject select 0, getPos ha_objectiveObject select 1, 2];
            };
        };
    };
    
};

// Add fire light effect to the wreck, local to each client
if (hasInterface) then {
    wreck_light = "#lightpoint" createVehicleLocal [0,0,0]; 
    wreck_light setLightBrightness 4.0; 
    wreck_light setLightAmbient [0, 0, 0]; 
    wreck_light setLightColor [1.0, 0.576, 0.16]; 
    wreck_light lightAttachObject [wreck_01, [0,0,0]];
};

//configfile >> "CfgWeapons" >> "rhs_item_flightrecorder"
//parents: ["ItemCore","Default"]
// https://community.bistudio.com/wiki/nearSupplies
// "\A3\ui_f\data\map\markers\military\circle_CA.paa"

if (hasInterface) then {
    
    // Event handler to track who has the objective item
    player addEventHandler ["Take", {
        params ["_unit", "_container", "_item"];
        if (ha_superDebug) then {hint format ["%1 has taken %2 from %3.", str _unit, str _item, str _container]};
        if (_item == "rhs_item_flightrecorder") then {
            ha_objectiveHolder = _unit;
            ha_objectiveObject = objNull;
            publicVariable "ha_objectiveHolder";
            publicVariable "ha_objectiveObject";
            {hint format["%1 has picked up the flight recorder.", ha_objectiveHolder];} remoteExec ["bis_fnc_call", 0];
        }
    }];
    
    // Event handler to track who has the objective item
    player addEventHandler ["Put", {
        params ["_unit", "_container", "_item"];
        if (ha_superDebug) then {hint format ["%1 has placed %2\ninto %3.", str _unit, str _item, str _container]};
        if (_item == "rhs_item_flightrecorder") then {
            ha_objectiveHolder = objNull;
            ha_objectiveObject = _container;
            publicVariable "ha_objectiveHolder";
            publicVariable "ha_objectiveObject";
        }
    }];
    
    // Draw objective position marker if it's on the ground
    addMissionEventHandler ["EachFrame", {
        if (!isNull ha_objectiveObject) then {
            drawIcon3D["", [1,1,1,1.0], getPosATLVisual ha_objectiveObject, 1, 1, 0, "Flight recorder",2 ,0.04 ,"PuristaMedium" ,"left" ,true];
        };
    }];
};
