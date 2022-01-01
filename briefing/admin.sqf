
private _briefing = "ADMIN BRIEFING<br/><br/>";


/* In this briefing page you should provide the admin with any information that will aid them doing their job.
    - If mission has no automatic ending system. All conditions for the mission ending should be mentioned here so the session host knows what to do.


*/

// Insert custom text
_briefing = _briefing + "The end mission triggers don't check for the flight recorder's existence, if it magically disappears or players forget to pick it off a body at some point you can just wing it and say someone has it as an admin decision.";

player createDiaryRecord ["diary", ["Admin",_briefing]];