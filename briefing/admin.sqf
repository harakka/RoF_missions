
private _briefing = "ADMIN BRIEFING<br/><br/>";


/* In this briefing page you should provide the admin with any information that will aid them doing their job.
    - If mission has no automatic ending system. All conditions for the mission ending should be mentioned here so the session host knows what to do.


*/

// Insert custom text
_briefing = _briefing + "Mission is completed once players are outside the AO and have a laptop in their possession. There are no extraction helis coming.";

player createDiaryRecord ["diary", ["Admin",_briefing]];