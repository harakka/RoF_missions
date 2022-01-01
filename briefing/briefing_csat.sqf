/* ===============================================
    GENERAL BRIEFING NOTES
     - Uses HTML style syntax. All supported tags can be found here - https://community.bistudio.com/wiki/createDiaryRecord
     - For images use <img image='FILE'></img> (for those familiar with HTML note it is image rather than src).
     - Note that using the " character inside the briefing block is forbidden use ' instead of ".
*/

/* ===============================================
    SITUATION
     - Outline of what is going on, where we are we and what has happened before the mission has started? This needs to contain any relevant background information.
     - Draw attention to friendly and enemy forces in the area. The commander will make important decisions based off this information.
     - Outline present weather conditions, players will typically assume that it is daylight with sunny weather.
*/

private _situation = ["diary", ["Situation","
<br/>
Thanks to recent intel from an insider informant, fresh anomaly maps and lucky coincidences, we have a brief window for transporting two Mi-24s' worth of Spetsnaz into the vicinity of a bandit base, located in a power plant complex deep in the Zone.
<br />
Our target is the laptop of a prominent bandit leader, expected to contain valuable information on his contacts and contraband logistics.
<br />
The bandit leader and their main force should be on a mission outside of the AO and are not expected to return today. The base should only have skeleton crew.
<br/><br/>
<font size='18'>ENEMY FORCES</font>
<br/>
Up to 5 infantry squads, no vehicles. Reinforcement capacity unknown.
<br/><br/>

<font size='18'>FRIENDLY FORCES</font>
<br/>
None.
<br/><br/>
<font size='18'>CONDITIONS</font>
<br/>
Extreme fog in the surrounding area, but the complex itself is currently above the fog. The power plant grounds has numerous dangerous anomalies, but the surrounding fields should be mostly safe. Avoid interiors other than the main bandit HQ.

"]];

/* ===============================================
    MISSION
     - Describe any objectives that the team is expected to complete.
     - Summarize(!) the overall task. This MUST be short and clear.
*/

private _mission = ["diary", ["Mission","
<br/>
* Find and seize the bandit leader's laptop.
<br/>
* Exfiltrate outside of the mission area.
<br/>
* Wait for helicopter transport...
"]];

/* ===============================================
    EXECUTION
     - Provide an outline as to what the commander of the player's command might give.
*/

private _execution = ["diary", ["Execution","
<br/>
<font size='18'>COMMANDER'S INTENT</font>
<br/>
Insert, infiltrate the bandit HQ, find the laptop and leave the AO.
<br/><br/>

<font size='18'>MOVEMENT PLAN</font>
<br/>
<br/><br/>
"]];

/* ===============================================
    ADMINISTRATION
     - Outline of logistics: available resources (equipment/vehicles) and ideally a summary of their capabilities.
     - Outline of how to use any mission specific features/scripts.
     - Seating capacities of each vehicle available for use.
*/

private _administration = ["diary", ["Administration","
<br/>
Everyone is equipped with an anomaly detector (enable from ACE self interact) that will start to beep when within 10m range of an anomaly.
<br />
** Rate of beeping indicates distance to an anomaly. Do not take risks with anomalies. If you hear continuous beeping, retrace your steps to safety.
<br />
Do not risk your life trying to retrieve fallen comrades from anomaly fields.
<br />"]];

player createDiaryRecord _administration;
player createDiaryRecord _execution;
player createDiaryRecord _mission;
player createDiaryRecord _situation;