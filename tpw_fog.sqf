// Modified by harakka just to include snow + breath fog, removed dependency to TPW addon

/*
TPW FOG - Region specific climate: ground fog, foggy breath, snow in cold weather; heat haze in hot.
Version: 1.50
Authors: tpw, falcon_565,meatball, neoarmageddon
Date: 20170226
Requires: CBA A3, tpw_core.sqf
Compatibility: SP
	
Disclaimer: Feel free to use and modify this code, on the proviso that you post back changes and improvements so that everyone can benefit from them, and acknowledge the original author (tpw) in any derivative works. 

To use: 
1 - Save this script into your mission directory as eg tpw_fog.sqf
2 - Call it with 0 = [250,10,1,1,1,1,1,1] execvm "tpw_fog.sqf"; where 250 = radius around player to give units foggy breath (m). 10 = delay until functions start (sec), 1 = foggy breath, 1 = ground fog, 1 = rain fog, 1 = heat haze , 1 = snow, 1 = mist fx

The dust storm function can be invoked with [duration] spawn tpw_fog_fnc_duststorm; where duration is in minutes.

THIS SCRIPT WON'T RUN ON DEDICATED SERVERS
*/

if (isDedicated) exitWith {};
if (_this select 0 == 0) exitWith {};
if ((count _this) < 7) exitWith {hint "TPW FOG incorrect/no config, exiting."};
WaitUntil {!isNull FindDisplay 46};

// VARIABLES
tpw_fog_version = "1.50-a"; // version string
tpw_fog_radius = _this select 0; // units must be closer than this to show foggy breath. 
tpw_fog_delay = _this select 1; // delay
tpw_fog_breath = _this select 2; // foggy breath enabled
tpw_fog_groundfog = _this select 3; // ground fog enabled
tpw_fog_rainfog = _this select 4; // rain fog enabled
tpw_fog_heathaze = _this select 5; // heat haze enabled
tpw_fog_cansnow = _this select 6; // snow enabled
tpw_fog_mist = _this select 7; // ground mist fx level

tpw_fog_active = true; // global enable/disable
tpw_fog_debug = false; // debugging 

tpw_fog_snowflag = true;
tpw_fog_flag = true;
// BREATH FUNCTION
tpw_fog_fnc_breathe = 
	{
		{
		private _unit = _x;
		
		// Only bother if unit is alive, close to player and foggy conditions are met
		if ((alive _unit) && {tpw_fog_flag} && {_unit distance player < tpw_fog_radius} && {_unit == vehicle _unit}) then 
			{
			private _nexttime = _unit getVariable ["NextBreathTime", -1];
			if(_nexttime == -1) then 
				{
				_unit setVariable ["NextBreathTime", diag_tickTime + (random 3)];
				_unit addEventHandler ["SoundPlayed",{if (tpw_fog_flag && {_this select 1 < 3} && {getfatigue (_this select 0) > 0.25}) then {[_this select 0] spawn tpw_fog_fnc_exhale};}];
				};
			if (diag_tickTime >= _nextTime) then 
				{
				[_unit] spawn tpw_fog_fnc_exhale;
				_unit setVariable ["NextBreathTime", diag_tickTime + (3 / (1.1 - getfatigue _unit)) + random 1 ];
				};				
			};
		} count allunits; 
	};

// EXHALE FOGGY BREATH	
tpw_fog_fnc_exhale =
	{
	private _unit = _this select 0;
	private _source = "logic" createVehicleLocal (getpos _unit);
	if (_unit == player) then 
		{
		_source attachto [_unit,[0,0.1,0.04], "neck"];
		} 
	else 
		{
		_source attachto [_unit,[0,0.05,-0.08], "pilot"];
		};
	private _breathemitter = "#particlesource" createVehicleLocal getpos _source;
	_breathemitter setParticleParams [
	["\a3\Data_f\ParticleEffects\Universal\Universal", 16, 12, 13,0],
	"", 
	"Billboard", 
	0.5, 
	1.5, 
	[0,0,0],
	[0,0.0,-0.3], 
	1,1.275,1,0.2, 
	[0,0.2,0], 
	[[1,1,1,0.02], [1,1,1,0.01], [1,1,1,0]], 
	[1000], 
	1, 
	0.04, 
	"", 
	"", 
	_source
	];
	_breathemitter setParticleRandom [0.5, [0, 0, 0], [0.25, 0.25, 0.25], 0, 0.5, [0, 0, 0, 0.1], 0, 0, 10];
	_breathemitter setDropInterval 0.01; 
	sleep random 0.5;
	deletevehicle _source;
	deletevehicle _breathemitter;
	};	

//SNOW FX	

// Array of precalculated random position offsets
tpw_fog_fnc_snowpos = 
	{
	tpw_fog_snowpos = []; 
	for "_i" from 1 to 1000 do
		{
		private _dir = random 360;
		private _dist = random 20;
		tpw_fog_snowpos pushback [(_dist * sin _dir),(_dist * cos _dir),0];
		};
	};
	
// Array of exposed positions around player	
tpw_fog_fnc_expos =  
	{
	private _temppos = [];
	private _pos = eyepos player;
	for "_i" from 0 to count tpw_fog_snowpos - 1 do
		{
		private _offset = tpw_fog_snowpos select _i;
		private _lowpos = _pos vectoradd _offset;
		private _highpos = _lowpos vectoradd [0,0,30];

		// Emitter cover checks 
		if (!lineintersects [_lowpos,_highpos]) then
			{
			_temppos pushback (_lowpos vectoradd [0,0,(1 + random 3)]);
			};
		};
	tpw_fog_expos = _temppos;		
	};
// Additional snowflakes in 60 degree arc in front of moving player	
tpw_fog_fnc_singlepos = 
	{
	private _playdir = _this select 0;
	private _min = _playdir - 30;	
	private _dir = _min + random 60;
	private _dist = 5 + random 10;
	private _offset =  [(_dist * sin _dir),(_dist * cos _dir),0];
	private _pos = eyepos player;
	private _lowpos = _pos vectoradd _offset;
	private _highpos = _lowpos vectoradd [0,0,30];
	// Emitter cover checks 
	if (!lineintersects [_lowpos,_highpos]) then
		{
		[_lowpos vectoradd [0,0,(random 3)]] spawn tpw_fog_fnc_snowemitter;
		};
	};	

// Fixed emitter for fast vehicles
tpw_fog_fnc_fastsnow =
	{
	private _spd = abs (ceil speed player);
	private _dst = _spd / 5; // snow box further away if faster
	private _snowEmitter = "#particlesource" createVehicleLocal [0,0,0];
	private _logic	=  "logic" createVehicleLocal [0,0,0];
	_snowEmitter attachto [_logic, [0,0,0]];
	_logic attachto [vehicle player, [0,_dst,1]];
	_snowEmitter setParticleCircle [0.0, [0, 0, 0]];
	_snowEmitter setParticleRandom [0, [2,2,2], [0, 0, 0], 0, 0.01, [0, 0, 0, 0.1], 0, 0];
	_snowEmitter setParticleParams [["\A3\data_f\ParticleEffects\Universal\Universal", 16, 12, 1,0], "","Billboard", 10,10, [0,0,0], [0,0,0], 1, 0.0000001, 0, 20,[0.02],[[1,1,1,1]],[1000], 0.2, 0.2, "", "",_logic];
	_snowEmitter setDropInterval 0.2 / _spd; // more snow if faster  	
	sleep 1;
	deletevehicle _snowemitter;
	deletevehicle _logic;
	};	
	
// Snow particle emitter
tpw_fog_fnc_snowemitter =
	{
	private _pos = asltoatl (_this select 0);	
	drop [["\A3\data_f\ParticleEffects\Universal\Universal", 16, 12, 1,0], "","Billboard", 10,10, _pos, [0,0,0], 0, 0.01,0, 10,[0.05],[[1,1,1,1]],[0,0], 0.2, 0.2, "", "", ""];
	};

// Spawn snow around footbound player
tpw_fog_fnc_snowscan =
	{
	private _time = (_this select 0) + 0.49;
	private _spd = _this select 1;
	private _posct = count tpw_fog_expos;
	while {time < _time} do
		{
		[tpw_fog_expos select floor random _posct] spawn tpw_fog_fnc_snowemitter; // random snowdrop around player
		if (_spd > 6) then
			{
			[getdir player] spawn tpw_fog_fnc_singlepos; // random snowdrops in direction of movement
			sleep 0.01;
			};
		sleep 0.01;
		};			
	};

// Main snow loop	
tpw_fog_fnc_snow =
	{
	while {true} do
		{
		// Conditions for snow
		if (alive player && {(eyepos player) select 2 > 0} && {diag_fps > 25}) then 
			{
			
			// Player under cover?
			private _cover = false; 
			private _ep = eyepos player;
			private _epc = _ep vectoradd [0,0,30];
			if (lineintersects[_ep,_epc]) then
				{
				_cover = true;
				};
				
			// Periodically change snow density
			if (time > tpw_fog_snowtime) then
				{
				tpw_fog_snowtime = time + random 300;
				tpw_fog_snowdensity = ceil random 5;
				};
			
			// Complex snow for slow movers
			private _spd = abs (ceil speed player);
			if (_spd < 20) then 
				{
				// Update spawn positions only if player has moved sufficiently
				if (tpw_fog_lastpos distance player > 5) then
					{
					[] call tpw_fog_fnc_expos;
					tpw_fog_lastpos = getposasl player;
					};
				// Place snow drops in exposed areas
				for "_i" from 0 to tpw_fog_snowdensity do
					{	
					[time,_spd] spawn tpw_fog_fnc_snowscan;	
					};
				} else
				{
				// Simple snow emitter box for fast movers
				[] spawn tpw_fog_fnc_fastsnow;
				};
			};
		sleep 0.5;	
		};	
	};	

// RUN IT	
sleep tpw_fog_delay;

// Snow
tpw_fog_snowtime = time + random 300;
tpw_fog_snowdensity = ceil random 5;
tpw_fog_lastpos = getposasl player;
[] call tpw_fog_fnc_snowpos;
if (tpw_fog_snowflag) then
	{
	[] spawn tpw_fog_fnc_snow;
	};
sleep 0.1;

// Breath fog
[tpw_fog_fnc_breathe, 0.2] call cba_fnc_addPerFrameHandler;
sleep 0.1;

while {true} do
	{
	// dummy loop so script doesn't terminate
	sleep 10;
	};