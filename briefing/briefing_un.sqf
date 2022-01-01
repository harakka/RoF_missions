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
Due to a major shift in diplomatic relations, the Tanoan government is evicting the entire UN Peacekeeping Operation (UNFTAN) from the islands. During the last hours of withdrawal, collaborators within the Tanoan insurgency movement handed our platoon A FLIGHT RECORDER with very sensitive data on it. The Tanoan government does not want this flight recorder to leave the country, as the data on it is likely to have dire political consequences for the current regime.
<br/><br/>
We expect the government will try to detain our platoon with the help of local civil authorities and the Horizon Islands Defense Force. The government expects us to surrender when confronted. They would like this very much because shooting UN troops makes your banana republic look like the bad guys. What they may not know however, is that just moments ago the UNFTAN mission received THE MOST ROBUST MANDATE EVER from the Security Council.
<br/><br/>
Our orders from the company HQ (already off the island) are to hold onto the flight recorder, and take it out of the country by any means necessary (while still respecting the UN principles of peacekeeping, of course).
<br/><br/>
Our truck column has been <marker name='mkr_start'>stopped by a hastily set up IED attack</marker> and our trucks have been disabled. Expect company very soon.
<br/><br/>
<font size='18'>ENEMY FORCES</font>
<br/>
Gendarmerie reinforced by local units from Horizon Islands Defense Force. Assume all local forces to be hostile. Expect gendarmerie patrols and motorized infantry initially. Once they find out we're not surrendering, they are likely to escalate.
<br/><br/>

<font size='18'>FRIENDLY FORCES</font>
<br/>
An MI-8 transport helicopter and an attached security unit at <marker name='mkr_airport'>the airfield</marker>. All other UN forces in the area are in the process of evacuating or have already left.
"]];

/* ===============================================
    MISSION
     - Describe any objectives that the team is expected to complete.
     - Summarize(!) the overall task. This MUST be short and clear.
*/

private _mission = ["diary", ["Mission","
<br/>
1. Retrieve the flight recorder from <marker name='mkr_start'> the lead vehicle's wreck</marker>. This requires space in backpack, designate a carrier.
<br />
2. Make your way to <marker name='mkr_airport'>the airfield</marker>.
<br />
3. Take off in the UN transport helicopter with the flight recorder in your possession. 
"]];

/* ===============================================
    EXECUTION
     - Provide an outline as to what the commander of the player's command might give.
*/

private _execution = ["diary", ["Execution","
<br/>
<font size='18'>COMMANDER'S INTENT</font>
<br/>
Proceed at mission commander's discretion.
<br/><br/>

<font size='18'>MOVEMENT PLAN</font>
<br/>
None.
<br/><br/>

<font size='18'>FIRE SUPPORT PLAN</font>
<br/>
No supports available.
<br/><br/>

<font size='18'>SPECIAL TASKS</font>
<br/>
None.
"]];

/* ===============================================
    ADMINISTRATION
     - Outline of logistics: available resources (equipment/vehicles) and ideally a summary of their capabilities.
     - Outline of how to use any mission specific features/scripts.
     - Seating capacities of each vehicle available for use.
*/

private _administration = ["diary", ["Administration","
<br/>
The flight recorder is a large metal sphere painted in orange with a grey rim. If you can't find it, ask an adult.<br/>
If any soldiers can't fit on board the transport helicopter, they are to remain behind to ensure safe departure.<br/>
"]];

player createDiaryRecord _administration;
player createDiaryRecord _execution;
player createDiaryRecord _mission;
player createDiaryRecord _situation;