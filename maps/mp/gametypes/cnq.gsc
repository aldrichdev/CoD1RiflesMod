/*
  ==============
	 Conquest TDM
	==============
	Objective: 	Score points and take ground for your team by eliminating players on the 
	opposing team and advancing spawn points.
	Map ends:	When one team reaches the score limit, or time limit is reached
	Respawning:	No wait / Near teammates based on objectives. Players generally spawn 
			behind their teammates relative to the direction of enemies, but the areas 
			that are used for spawning are determined by the current objective that was last taken.

  Developer:
  
    innocent bystander
    admin, after hourz
    bystander@after-hourz.com
  
  Visit www.after-hourz.com for kickass public COD servers and a great community.
  
  Credits:
  * Mark 'Slyk' Dittman - Mapper extrodanaire and the initial developer of 
    Conquest TDM on Spearhead.
  * [MC]Hammer - Some utility string transform code is incorporated, and his
    CoDaM HUD code was used and modifed for this gametype.
  * The whole After Hourz community, but especially Painkiller, Fart, Shep, 
    Kamikazee Driver, Poopybuttocks, and Shep for ideas, motivation and friendship.
  * Last but not least, many members of the COD community with help in learning this
    language and patiently answering my questions, including [MC]Hammer, 
    ScorpioMidget, Ravir, [IW]HkySk8r187, and others I probably fail to mention. 
    
    Thanks to you all!
    
	Level requirements
	------------------
		Spawnpoints:
			classname	=	mp_teamdeathmatch_spawn
			script_gameobjectname = cnq or conquest (optional). Set if you only want 
			these spawns used for the conquest game type, otherwise all TDM-spawn 
			gametypes will use it as well. targetname = Either "defenders#" or 
			"attackers#", where # is the objective you want this set of spawns to 
			be associated with, for example "attackers1", "defenders2". This is 
			the group number of the spawns, and is tied directly to the spawn 
			objective's script_idnumber (see below).Spawnpoints are team-based, 
			unlike regular TDM spawns. This is done through setting	a targetname. 
			Obtaining an objective with a particular idnumber will mean that all 
			the team spawns with this matching script_idnumber will be chosen to 
			spawn the player, and the script will place them near their team from 
			among the spawns in this numerical grouping.

		Spectator Spawnpoints:
			classname		mp_teamdeathmatch_intermission
			Spectators spawn from these and intermission is viewed from these positions.
			At least one is required, any more and they are randomly chosen between.

	  Objectives:
	    There are 2 types of objectives, spawn objectives and optional 
	    bonus objectives. All Objectives must be controlled in linear order, 
	    meaning you must control previous objectives to take other objectives. 
	    Spawn objectives allow teams to move their spawns forward toward the 
	    enemy base, while at the same time pushing back their opponents spawns.
	    Bonus objectives, if used in a given map, are at the ends of each chain 
	    and give a team a point bonus, and are not used to move spawn positions.
	  
	    Creating Spawn Objectives
	    =========================
	    
      Spawn Objective Triggers
      ------------------------
      Triggers are placed where you want players to take objectives. Typical
      triggers are modeled as switches, or some other player-activated thing.
      But you can really make it whatever you want that fits your map's style.
      Place the trigger in the map position you want it.
      
      * classname = trigger_use or trigger_multiple (depending on your map). 
        Most CNQ maps use trigger_use.
      * script_gameobjectname = cnq or conquest
      * delay = (time in sections between triggers OPTIONAL) - If you want to 
        delay an objective from being retaken, put an integer value in for this
        reprenting the number of seconds before the objective can be retaken by
        the other team. Default is immediately if not provided.
      * hintstring = (your descriptive text) This tells players what to do if 
        you choose to use trigger_use classes. Typical text would be something
        like "Press [Use} to take this objective!"
      
	    Spawn Objectives
	    ----------------	  
	    * classname = script_model
			* script_gameobjectname = cnq or conquest
			* targetname = spawnobjective
			* script_idnumber = an integer number. This is the numeric order of the 
			  spawn objective. Typically there are a number of spawn objectives that 
			  number starting with 1 and increasing	to the number of objectives in 
			  your map. Most CNQ maps have between 3 and 5 spawn objectives, but 
			  there's no real limit other than there must be at least 1. The number 
			  you give this sets the path of the battle in your map, as teams will 
			  have to progress up and down the chain of	spawn objectives.
			* script_objective_name = (your descriptive text) - Used in game 
			  messages to tell players the name of their next objective. If not 
			  supplied a default name is used.
			
			Targeting the trigger
			---------------------
			Select a script_model representing the objective. Then select the trigger
			you want it associated with, and press Control+K. This should draw a target
			line from the script_model to the trigger. Place the trigger where you want
			the playere to take their objective, and move the script model to be in the
			same position so it will appear in the players compass as the correct 
			location. You have just created an objective.	Repeat this process for more 
			objectives, just remember to increment the script_model.script_idnumber 
			with each new objective.

	    Creating Bonus Objectives
	    =========================
      Bonus Objectives are entirely option, and up to the mapper. They are not 
      used at all in spawn logic, but basically represent a point bonus to the 
      team that takes it. Typically they are placed in the final spawn 
      location of the opposing team, since there is no place to push them back.

			Bonus Objective Triggers
			----------------
      Triggers are placed where you want players to take objectives. Typical
      triggers are modeled as switches, or some other player-activated thing.
      But you can really make it whatever you want that fits your map's style.
      Place the trigger in the map position you want it.
      
      * classname = trigger_use or trigger_multiple (depending on your map). 
        Most CNQ maps use trigger_use.
      * script_gameobjectname = cnq or conquest
      * delay = (time in sections between triggers OPTIONAL) - If you want to 
        delay an bonus from being achieved again, put an integer value in for this
        reprenting the number of seconds before the bonus can be earned again.
        Default is 60 seconds if not provided.
      * hintstring = (your descriptive text) This tells players what to do if 
        you choose to use trigger_use classes. Typical text would be something
        like "Press [Use} to take this objective!"
			
	    Bonus Objectives
	    ----------------	  
	    * classname = script_model
			* script_gameobjectname = cnq or conquest
			* targetname = bonusobjective
			* script_team = defenders or attackers - Defines who's bonus objective this
			  is. There can be one per team.
			* script_objective_name = (your descriptive text) - Used in game 
			  messages to tell players the name of their next objective. If not 
			  supplied a default name is used.
	    		
			Targeting the trigger
			---------------------
			Select a script_model representing the objective. Then select the trigger
			you want it associated with, and press Control+K. This should draw a target
			line from the script_model to the trigger. Place the trigger where you want
			the playere to take their objective, and move the script model to be in the
			same position so it will appear in the players compass as the correct 
			location. You have just created an objective.	There can only be one bonus
			objective per team, created in this manner. 
			
	Level script requirements
	-------------------------
		Team Definitions:
			game["allies"] = "american";
			game["axis"] = "german";
			This sets the nationalities of the teams. Allies can be american, british, 
			or russian. Axis can be german.
	
			game["attackers"] = "allies";
			game["defenders"] = "axis";
			This sets which team is attacking and which team is defending. Attackers 
			take objectives, defenders take them back. 
	
		If using minefields or exploders:
			maps\mp\_load::main();
		
	Optional level script settings
	------------------------------
	  Custom callbacks:
	    A variety of callbacks exist so that mappers can have hooks into the game
	    logic for their own animations or other map-specific effects in the map 
	    script file. These are completely optional, and you do not have to 
	    provide them unless you desire such control.

      If you want this capability, in your map file create lines similar to 
      this for each callback you want to use:
      
      level.cnqCallbackSpawnObjectiveComplete = ::Your_Specific_Function_Name;
      level.cnqCallbackBonusObjectiveComplete =  ::Your_Other_Function_Name;

    Available callbacks are:
    
	  level.cnqCallbackStartMap() - if defined, called at the start of the map
    level.cnqCallbackEndMap() - if defined, called at the start of the map
    level.cnqCallbackSpawnObjectiveComplete(objective, player) - if defined, called
      when a player completes an objective. The callback will be passed a 
      handle to the objective that was taken, and the player than did it.
    level.cnqCallbackSpawnObjectiveRegen (objective) - if defined, called when
      a spawn objective is available to be taken again.
    level.cnqCallbackBonusObjectiveComplete(objective, player) - if defined, called
      when a player completes a bonus objective. The callback will be passed a 
      handle to the objective that was taken, and the player than did it.
    level.cnqCallbackBonusObjectiveRegen (objective) - if defined, called when
      a bonus objective is available to be taken again.

		Soldier Type and Variation:
			game["american_soldiertype"] = "airborne";
			game["american_soldiervariation"] = "normal";
			game["german_soldiertype"] = "wehrmacht";
			game["german_soldiervariation"] = "normal";
			This sets what models are used for each nationality on a particular map.
			
			Valid settings:
				american_soldiertype		airborne
				american_soldiervariation	normal, winter
				
				british_soldiertype		airborne, commando
				british_soldiervariation	normal, winter
				
				russian_soldiertype		conscript, veteran
				russian_soldiervariation	normal, winter
				
				german_soldiertype		waffen, wehrmacht, fallschirmjagercamo, fallschirmjagergrey, kriegsmarine
				german_soldiervariation		normal, winter

		Layout Image:
			game["layoutimage"] = "yourlevelname";
			This sets the image that is displayed when players use the "View Map" button in game.
			Create an overhead image of your map and name it "hud@layout_yourlevelname".
			Then move it to main\levelshots\layouts. This is generally done by taking a screenshot in the game.
			Use the outsideMapEnts console command to keep models such as trees from vanishing when noclipping outside of the map.
*/

/*QUAKED mp_teamdeathmatch_spawn (0.0 0.0 1.0) (-16 -16 0) (16 16 72)
Players spawn away from enemies and near their team at one of these positions.
*/

/*QUAKED mp_teamdeathmatch_intermission (1.0 0.0 1.0) (-16 -16 -16) (16 16 16)
Intermission is randomly viewed from one of these positions.
Spectators spawn randomly at one of these positions.
*/

main()
{
	spawnpointname = "mp_teamdeathmatch_spawn";
	spawnpoints = getentarray(spawnpointname, "classname");
	
	if(!spawnpoints.size)
	{
		maps\mp\gametypes\_callbacksetup::AbortLevel();
		return;
	}

	for(i = 0; i < spawnpoints.size; i++)
		spawnpoints[i] placeSpawnpoint();

	level.callbackStartGameType = ::Callback_StartGameType;
	level.callbackPlayerConnect = ::Callback_PlayerConnect;
	level.callbackPlayerDisconnect = ::Callback_PlayerDisconnect;
	level.callbackPlayerDamage = ::Callback_PlayerDamage;
	level.callbackPlayerKilled = ::Callback_PlayerKilled;

	maps\mp\gametypes\_callbacksetup::SetupCallbacks();
	
	allowed[0] = "cnq";
	allowed[1] = "conquest";
	maps\mp\gametypes\_gameobjects::main(allowed);
	
	if(getCvar("scr_cnq_timelimit") == "")		// Time limit per map
		setCvar("scr_cnq_timelimit", "30");
	else if(getCvarFloat("scr_cnq_timelimit") > 1440)
		setCvar("scr_cnq_timelimit", "1440");
	level.timelimit = getCvarFloat("scr_cnq_timelimit");
//	setCvar("ui_cnq_timelimit", level.timelimit);
//	makeCvarServerInfo("ui_cnq_timelimit", "30");

	if(getCvar("scr_cnq_scorelimit") == "")		// Score limit per map
		setCvar("scr_cnq_scorelimit", "100");
	level.scorelimit = getCvarInt("scr_cnq_scorelimit");
//	setCvar("ui_cnq_scorelimit", level.scorelimit);
//	makeCvarServerInfo("ui_cnq_scorelimit", "100");

	if(getCvar("scr_forcerespawn") == "")		// Force respawning
		setCvar("scr_forcerespawn", "0");
	
	if(getCvar("scr_teambalance") == "")		// Auto Team Balancing
		setCvar("scr_teambalance", "0");
	level.teambalance = getCvarInt("scr_teambalance");
	level.teambalancetimer = 0;
	
////// Added by AWE ////	
	if(getCvar("scr_drophealth") == "")		// Free look spectator
		setCvar("scr_drophealth", "1");
////////////////////////

	killcam = getCvar("scr_killcam");
	if(killcam == "")				// Kill cam
		killcam = "1";
	setCvar("scr_killcam", killcam, true);
	level.killcam = getCvarInt("scr_killcam");
	
	if(getCvar("scr_drawfriend") == "")		// Draws a team icon over teammates
		setCvar("scr_drawfriend", "0");
	level.drawfriend = getCvarInt("scr_drawfriend");

	if(!isDefined(game["state"]))
		game["state"] = "playing";

	level.mapended = false;
	level.healthqueue = [];
	level.healthqueuecurrent = 0;
  level.objectivearray = [];
  level.objCount = [];
  level.objCount["attackers"] = 0;
  level.objCount["defenders"] = 0;

	level.team["allies"] = 0;
	level.team["axis"] = 0;
	
	if(level.killcam >= 1)
		setarchive(true);
}

Callback_StartGameType()
{

//////// Added by AWE //////////
	maps\mp\gametypes\_awe::Callback_StartGameType();
////////////////////////////////

	precacheString(&"MPSCRIPT_PRESS_ACTIVATE_TO_RESPAWN");
	precacheString(&"MPSCRIPT_KILLCAM");
	precacheString(&"TDM_KILL_AXIS_PLAYERS");
	precacheString(&"TDM_KILL_ALLIED_PLAYERS");


	// defaults if not defined in level script
	if(!isDefined(game["allies"]))
		game["allies"] = "american";
	if(!isDefined(game["axis"]))
		game["axis"] = "german";

	if(!isdefined(game["attackers"]))
		game["attackers"] = "allies";
	if(!isdefined(game["defenders"]))
		game["defenders"] = "axis";

	// server cvar overrides
	if(getCvar("scr_allies") != "")
		game["allies"] = getCvar("scr_allies");	
	if(getCvar("scr_axis") != "")
		game["axis"] = getCvar("scr_axis");
		
	if(!isdefined(game["cnq_attackers_obj_text"])) {
    if ( game["attackers"] == "allies" )
		  game["cnq_attackers_obj_text"] = (&"TDM_KILL_AXIS_PLAYERS");
		else 
		  game["cnq_attackers_obj_text"] = (&"TDM_KILL_ALLIED_PLAYERS");
  }
	if(!isdefined(game["cnq_defenders_obj_text"])) {
    if ( game["defenders"] == "allies" )
		  game["cnq_defenders_obj_text"] = (&"TDM_KILL_AXIS_PLAYERS");
		else 
		  game["cnq_defenders_obj_text"] = (&"TDM_KILL_ALLIED_PLAYERS");
  }

	if(!isDefined(game["layoutimage"]))
		game["layoutimage"] = "default";
	layoutname = "levelshots/layouts/hud@layout_" + game["layoutimage"];
	precacheShader(layoutname);
	setCvar("scr_layoutimage", layoutname);
	makeCvarServerInfo("scr_layoutimage", "");

	if(getcvar("scr_cnq_debug") == "")		// Debug messages
		setcvar("scr_cnq_debug", "0");

	if(getcvar("scr_cnq_player_objective_points") == "")		// Points to award player for achieving objective
		setcvar("scr_cnq_player_objective_points", "0");
	level.player_obj_points = getcvarint("scr_cnq_player_objective_points");

	if(getcvar("scr_cnq_team_objective_points") == "")		// Points to award team for achieving objective
		setcvar("scr_cnq_team_objective_points", "10");
	level.team_obj_points = getcvarint("scr_cnq_team_objective_points");

	if(getcvar("scr_cnq_player_bonus_points") == "")		// Points to award player for achieving bonus objective
		setcvar("scr_cnq_player_bonus_points", "0");
	level.player_bonus_points = getcvarint("scr_cnq_player_bonus_points");

	if(getcvar("scr_cnq_team_bonus_points") == "")		// Points to award team for achieving bonus objective
		setcvar("scr_cnq_team_bonus_points", "25");
	level.team_bonus_points = getcvarint("scr_cnq_team_bonus_points");

//	game["menu_serverinfo"] = "serverinfo_cnq";
	game["menu_team"] = "team_" + game["allies"] + game["axis"];
	game["menu_weapon_allies"] = "weapon_" + game["allies"];
	game["menu_weapon_axis"] = "weapon_" + game["axis"];
	game["menu_viewmap"] = "viewmap";
	game["menu_callvote"] = "callvote";
	game["menu_quickcommands"] = "quickcommands";
	game["menu_quickstatements"] = "quickstatements";
	game["menu_quickresponses"] = "quickresponses";

//	precacheMenu(game["menu_serverinfo"]);	
	precacheMenu(game["menu_team"]);
	precacheMenu(game["menu_weapon_allies"]);
	precacheMenu(game["menu_weapon_axis"]);
	precacheMenu(game["menu_viewmap"]);
	precacheMenu(game["menu_callvote"]);
	precacheMenu(game["menu_quickcommands"]);
	precacheMenu(game["menu_quickstatements"]);
	precacheMenu(game["menu_quickresponses"]);

	precacheShader("black");
	precacheShader("hudScoreboard_mp");
	precacheShader("gfx/hud/hud@mpflag_spectator.tga");
	precacheShader("gfx/hud/objective.tga");
	precacheShader("gfx/hud/objective_up.tga");
	precacheShader("gfx/hud/objective_down.tga");
	precacheShader("gfx/hud/death_suicide.tga");
	precacheShader("gfx/hud/headicon@re_objcarrier.tga");
	precacheStatusIcon("gfx/hud/hud@status_dead.tga");
	precacheStatusIcon("gfx/hud/hud@status_connecting.tga");
	precacheItem("item_health");

	maps\mp\gametypes\_teams::modeltype();
	maps\mp\gametypes\_teams::precache();
	maps\mp\gametypes\_teams::scoreboard();
	maps\mp\gametypes\_teams::initGlobalCvars();
	maps\mp\gametypes\_teams::initWeaponCvars();
	maps\mp\gametypes\_teams::restrictPlacedWeapons();
	thread maps\mp\gametypes\_teams::updateGlobalCvars();
	thread maps\mp\gametypes\_teams::updateWeaponCvars();

	setClientNameMode("auto_change");

  if (isdefined(level.cnqCallbackStartMap))
    [[level.cnqCallbackStartMap]]();

	thread startGame();
  thread startHud();
  thread startObjectives();
//	thread addBotClients(); // For development testing
	thread updateGametypeCvars();
}

Callback_PlayerConnect()
{
	self.statusicon = "gfx/hud/hud@status_connecting.tga";
	self waittill("begin");
	self.statusicon = "";
	self.pers["teamTime"] = 0;
	
	iprintln(&"MPSCRIPT_CONNECTED", self);

	lpselfnum = self getEntityNumber();
	lpGuid = self getGuid();
	logPrint("J;" + lpGuid + ";" + lpselfnum + ";" + self.name + "\n");

	if(game["state"] == "intermission")
	{
		spawnIntermission();
		return;
	}
	
	level endon("intermission");

	if(isDefined(self.pers["team"]) && self.pers["team"] != "spectator")
	{
		self setClientCvar("ui_weapontab", "1");

		if(self.pers["team"] == "allies")
		{
			self.sessionteam = "allies";
			self setClientCvar("g_scriptMainMenu", game["menu_weapon_allies"]);
		}
		else
		{
			self.sessionteam = "axis";
			self setClientCvar("g_scriptMainMenu", game["menu_weapon_axis"]);
		}
			
		if(isDefined(self.pers["weapon"]))
			spawnPlayer();
		else
		{
			spawnSpectator();

			if(self.pers["team"] == "allies")
				self openMenu(game["menu_weapon_allies"]);
			else
				self openMenu(game["menu_weapon_axis"]);
		}
	}
	else
	{
		self setClientCvar("g_scriptMainMenu", game["menu_team"]);
		self setClientCvar("ui_weapontab", "0");

//		removed due to client download requirement for custom menu		
//		if(!isDefined(self.pers["skipserverinfo"]))
//			self openMenu(game["menu_serverinfo"]);

		if(!isdefined(self.pers["team"]))
			self openMenu(game["menu_team"]);

		self.pers["team"] = "spectator";
		self.sessionteam = "spectator";

		spawnSpectator();
	}

	for(;;)
	{
		self waittill("menuresponse", menu, response);
		
/*		if(menu == game["menu_serverinfo"] && response == "close")
		{
			self.pers["skipserverinfo"] = true;
			self openMenu(game["menu_team"]);
		}
*/
		if(response == "open" || response == "close")
			continue;

		if(menu == game["menu_team"])
		{
			switch(response)
			{
			case "allies":
			case "axis":
			case "autoassign":
				if(response == "autoassign")
				{
					numonteam["allies"] = 0;
					numonteam["axis"] = 0;

					players = getentarray("player", "classname");
					for(i = 0; i < players.size; i++)
					{
						player = players[i];
					
						if(!isDefined(player.pers["team"]) || player.pers["team"] == "spectator" || player == self)
							continue;
			
						numonteam[player.pers["team"]]++;
					}
					
					// if teams are equal return the team with the lowest score
					if(numonteam["allies"] == numonteam["axis"])
					{
						if(getTeamScore("allies") == getTeamScore("axis"))
						{
							teams[0] = "allies";
							teams[1] = "axis";
							response = teams[randomInt(2)];
						}
						else if(getTeamScore("allies") < getTeamScore("axis"))
							response = "allies";
						else
							response = "axis";
					}
					else if(numonteam["allies"] < numonteam["axis"])
						response = "allies";
					else
						response = "axis";
				}
				
				if(response == self.pers["team"] && self.sessionstate == "playing")
					break;

				if(response != self.pers["team"] && self.sessionstate == "playing")
					self suicide();

				self notify("end_respawn");

				self.pers["team"] = response;
				self.pers["teamTime"] = ((getTime() - level.starttime) / 1000);
				self.pers["weapon"] = undefined;
				self.pers["savedmodel"] = undefined;
				self.grenadecount = undefined;

				self setClientCvar("ui_weapontab", "1");

				if(self.pers["team"] == "allies")
				{
					self setClientCvar("g_scriptMainMenu", game["menu_weapon_allies"]);
					self openMenu(game["menu_weapon_allies"]);
				}
				else
				{
					self setClientCvar("g_scriptMainMenu", game["menu_weapon_axis"]);
					self openMenu(game["menu_weapon_axis"]);
				}
				break;

			case "spectator":
				if(self.pers["team"] != "spectator")
				{
					self.pers["team"] = "spectator";
					self.pers["teamTime"] = 0;
					self.pers["weapon"] = undefined;
					self.pers["savedmodel"] = undefined;
					self.grenadecount = undefined;
					
					self.sessionteam = "spectator";
					self setClientCvar("g_scriptMainMenu", game["menu_team"]);
					self setClientCvar("ui_weapontab", "0");
					spawnSpectator();
				}
				break;

			case "weapon":
				if(self.pers["team"] == "allies")
					self openMenu(game["menu_weapon_allies"]);
				else if(self.pers["team"] == "axis")
					self openMenu(game["menu_weapon_axis"]);
				break;
				
			case "viewmap":
				self openMenu(game["menu_viewmap"]);
				break;

			case "callvote":
				self openMenu(game["menu_callvote"]);
				break;
			}
		}		
		else if(menu == game["menu_weapon_allies"] || menu == game["menu_weapon_axis"])
		{
			if(response == "team")
			{
				self openMenu(game["menu_team"]);
				continue;
			}
			else if(response == "viewmap")
			{
				self openMenu(game["menu_viewmap"]);
				continue;
			}
			else if(response == "callvote")
			{
				self openMenu(game["menu_callvote"]);
				continue;
			}
			
			if(!isDefined(self.pers["team"]) || (self.pers["team"] != "allies" && self.pers["team"] != "axis"))
				continue;

			weapon = self maps\mp\gametypes\_teams::restrict(response);

			if(weapon == "restricted")
			{
				self openMenu(menu);
				continue;
			}
			
			if(isDefined(self.pers["weapon"]) && self.pers["weapon"] == weapon)
				continue;
			
			if(!isDefined(self.pers["weapon"]))
			{
				self.pers["weapon"] = weapon;
				spawnPlayer();
				self thread printJoinedTeam(self.pers["team"]);
			}
			else
			{
				self.pers["weapon"] = weapon;

				weaponname = maps\mp\gametypes\_teams::getWeaponName(self.pers["weapon"]);
				
				if(maps\mp\gametypes\_teams::useAn(self.pers["weapon"]))
					self iprintln(&"MPSCRIPT_YOU_WILL_RESPAWN_WITH_AN", weaponname);
				else
					self iprintln(&"MPSCRIPT_YOU_WILL_RESPAWN_WITH_A", weaponname);
			}
		}
		else if(menu == game["menu_viewmap"])
		{
			switch(response)
			{
			case "team":
				self openMenu(game["menu_team"]);
				break;
				
			case "weapon":
				if(self.pers["team"] == "allies")
					self openMenu(game["menu_weapon_allies"]);
				else if(self.pers["team"] == "axis")
					self openMenu(game["menu_weapon_axis"]);
				break;

			case "callvote":
				self openMenu(game["menu_callvote"]);
				break;
			}
		}
		else if(menu == game["menu_callvote"])
		{
			switch(response)
			{
			case "team":
				self openMenu(game["menu_team"]);
				break;
				
			case "weapon":
				if(self.pers["team"] == "allies")
					self openMenu(game["menu_weapon_allies"]);
				else if(self.pers["team"] == "axis")
					self openMenu(game["menu_weapon_axis"]);
				break;

			case "viewmap":
				self openMenu(game["menu_viewmap"]);
				break;
			}
		}
		else if(menu == game["menu_quickcommands"])
			maps\mp\gametypes\_teams::quickcommands(response);
		else if(menu == game["menu_quickstatements"])
			maps\mp\gametypes\_teams::quickstatements(response);
		else if(menu == game["menu_quickresponses"])
			maps\mp\gametypes\_teams::quickresponses(response);
	}
}

Callback_PlayerDisconnect()
{

///// Added by AWE ////////
	self maps\mp\gametypes\_awe::PlayerDisconnect();
///////////////////////////

	iprintln(&"MPSCRIPT_DISCONNECTED", self);
	
	lpselfnum = self getEntityNumber();
	lpGuid = self getGuid();
	logPrint("Q;" + lpGuid + ";" + lpselfnum + ";" + self.name + "\n");
}

Callback_PlayerDamage(eInflictor, eAttacker, iDamage, iDFlags, sMeansOfDeath, sWeapon, vPoint, vDir, sHitLoc)
{
	if(self.sessionteam == "spectator")
		return;

	// Don't do knockback if the damage direction was not specified
	if(!isDefined(vDir))
		iDFlags |= level.iDFLAGS_NO_KNOCKBACK;

	// check for completely getting out of the damage
	if(!(iDFlags & level.iDFLAGS_NO_PROTECTION))
	{
		if(isPlayer(eAttacker) && (self != eAttacker) && (self.pers["team"] == eAttacker.pers["team"]))
		{
			if(level.friendlyfire == "0")
			{
				return;
			}
			else if(level.friendlyfire == "1" && !isdefined(eAttacker.pers["awe_teamkiller"]) )
			{
				// Make sure at least one point of damage is done
				if(iDamage < 1)
					iDamage = 1;
	
				eAttacker maps\mp\gametypes\_awe::teamdamage(self, iDamage);
				self finishPlayerDamage(eInflictor, eAttacker, iDamage, iDFlags, sMeansOfDeath, sWeapon, vPoint, vDir, sHitLoc);

////////////// Added by AWE //////////////////
				self maps\mp\gametypes\_awe::DoPlayerDamage(eInflictor, eAttacker, iDamage, iDFlags, sMeansOfDeath, sWeapon, vPoint, vDir, sHitLoc);
//////////////////////////////////////////////

			}
			else if(level.friendlyfire == "2" || isdefined(eAttacker.pers["awe_teamkiller"]) )
			{
				eAttacker.friendlydamage = true;
		
				iDamage = iDamage * .5;
		
				// Make sure at least one point of damage is done
				if(iDamage < 1)
					iDamage = 1;
		
				eAttacker finishPlayerDamage(eInflictor, eAttacker, iDamage, iDFlags, sMeansOfDeath, sWeapon, vPoint, vDir, sHitLoc);
				eAttacker.friendlydamage = undefined;
				
				friendly = true;
			}
			else if(level.friendlyfire == "3")
			{
				eAttacker.friendlydamage = true;
		
				iDamage = iDamage * .5;
		
				// Make sure at least one point of damage is done
				if(iDamage < 1)
					iDamage = 1;

				self finishPlayerDamage(eInflictor, eAttacker, iDamage, iDFlags, sMeansOfDeath, sWeapon, vPoint, vDir, sHitLoc);
				eAttacker finishPlayerDamage(eInflictor, eAttacker, iDamage, iDFlags, sMeansOfDeath, sWeapon, vPoint, vDir, sHitLoc);
				eAttacker.friendlydamage = undefined;
				
				friendly = true;
			}
		}
		else
		{
			// Make sure at least one point of damage is done
			if(iDamage < 1)
				iDamage = 1;

			self finishPlayerDamage(eInflictor, eAttacker, iDamage, iDFlags, sMeansOfDeath, sWeapon, vPoint, vDir, sHitLoc);

////////////// Added by AWE //////////////////
			self maps\mp\gametypes\_awe::DoPlayerDamage(eInflictor, eAttacker, iDamage, iDFlags, sMeansOfDeath, sWeapon, vPoint, vDir, sHitLoc);
//////////////////////////////////////////////

		}
	}

	// Do debug print if it's enabled
	if(getCvarInt("g_debugDamage"))
	{
		println("client:" + self getEntityNumber() + " health:" + self.health +
			" damage:" + iDamage + " hitLoc:" + sHitLoc);
	}

	if(self.sessionstate != "dead")
	{
		lpselfnum = self getEntityNumber();
		lpselfname = self.name;
		lpselfteam = self.pers["team"];
		lpselfGuid = self getGuid();
		lpattackerteam = "";

		if(isPlayer(eAttacker))
		{
			lpattacknum = eAttacker getEntityNumber();
			lpattackGuid = eAttacker getGuid();
			lpattackname = eAttacker.name;
			lpattackerteam = eAttacker.pers["team"];
		}
		else
		{
			lpattacknum = -1;
			lpattackGuid = "";
			lpattackname = "";
			lpattackerteam = "world";
		}

		if(isDefined(friendly)) 
		{  
			lpattacknum = lpselfnum;
			lpattackname = lpselfname;
			lpattackGuid = lpselfGuid;
		}
		
		if (getcvar("sv_log_damage") != "0")
		  logPrint("D;" + lpselfGuid + ";" + lpselfnum + ";" + lpselfteam + ";" + lpselfname + ";" + lpattackGuid + ";" + lpattacknum + ";" + lpattackerteam + ";" + lpattackname + ";" + sWeapon + ";" + iDamage + ";" + sMeansOfDeath + ";" + sHitLoc + "\n");
	}
}

Callback_PlayerKilled(eInflictor, attacker, iDamage, sMeansOfDeath, sWeapon, vDir, sHitLoc)
{
	self endon("spawned");
	
	if(self.sessionteam == "spectator")
		return;

/////////// Added by AWE ///////////
	self thread maps\mp\gametypes\_awe::PlayerKilled(eInflictor, attacker, iDamage, sMeansOfDeath, sWeapon, vDir, sHitLoc);
////////////////////////////////////

	// If the player was killed by a head shot, let players know it was a head shot kill
	if(sHitLoc == "head" && sMeansOfDeath != "MOD_MELEE")
		sMeansOfDeath = "MOD_HEAD_SHOT";
		
	// send out an obituary message to all clients about the kill
////////// Removed by AWE ///////
//	obituary(self, attacker, sWeapon, sMeansOfDeath);
/////////////////////////////////
	
	self.sessionstate = "dead";
	self.statusicon = "gfx/hud/hud@status_dead.tga";
	self.headicon = "";
	self.grenadecount = undefined;
	if (!isdefined (self.autobalance))
		self.deaths++;

	lpselfnum = self getEntityNumber();
	lpselfname = self.name;
	lpselfguid = self getGuid();
	lpselfteam = self.pers["team"];
	lpattackerteam = "";

	attackerNum = -1;
	if(isPlayer(attacker))
	{
		if(attacker == self) // killed himself
		{
			doKillcam = false;
			if (!isdefined (self.autobalance))
				attacker.score--;
			
			if(isDefined(attacker.friendlydamage))
				clientAnnouncement(attacker, &"MPSCRIPT_FRIENDLY_FIRE_WILL_NOT"); 
		}
		else
		{
			attackerNum = attacker getEntityNumber();
			doKillcam = true;

			if(self.pers["team"] == attacker.pers["team"]) // killed by a friendly
			{
				attacker.score--;
				attacker maps\mp\gametypes\_awe::teamkill();
			}
			else
			{
				attacker.score++;

				teamscore = getTeamScore(attacker.pers["team"]);
				teamscore++;
				setTeamScore(attacker.pers["team"], teamscore);
			
				checkScoreLimit();
			}
		}

		lpattacknum = attacker getEntityNumber();
		lpattackguid = attacker getGuid();
		lpattackname = attacker.name;
		lpattackerteam = attacker.pers["team"];
	}
	else // If you weren't killed by a player, you were in the wrong place at the wrong time
	{
		doKillcam = false;
		
		self.score--;

		lpattacknum = -1;
		lpattackname = "";
		lpattackguid = "";
		lpattackerteam = "world";
	}

	logPrint("K;" + lpselfguid + ";" + lpselfnum + ";" + lpselfteam + ";" + lpselfname + ";" + lpattackguid + ";" + lpattacknum + ";" + lpattackerteam + ";" + lpattackname + ";" + sWeapon + ";" + iDamage + ";" + sMeansOfDeath + ";" + sHitLoc + "\n");

	// Stop thread if map ended on this death
	if(level.mapended)
		return;

	// Make the player drop his weapon

///// Removed by AWE /////
//	self dropItem(self getcurrentweapon());
//////////////////////////
	
	// Make the player drop health
	self dropHealth();
	self.autobalance = undefined;

///// Removed by AWE /////
//	body = self cloneplayer();
//////////////////////////

	delay = 2;	// Delay the player becoming a spectator till after he's done dying
	wait delay;	// ?? Also required for Callback_PlayerKilled to complete before respawn/killcam can execute

	if((getCvarInt("scr_killcam") <= 0) || (getCvarInt("scr_forcerespawn") > 0))
		doKillcam = false;
	
	if(doKillcam)
		self thread killcam(attackerNum, delay);
	else
		self thread respawn();
}

spawnPlayer()
{
	self notify("spawned");
	self notify("end_respawn");
	
	resettimeout();

	self.sessionteam = self.pers["team"];
	self.sessionstate = "playing";
	self.spectatorclient = -1;
	self.archivetime = 0;
	self.friendlydamage = undefined;
		
	spawnpointname = "mp_teamdeathmatch_spawn";
	spawnpoints = getentarray(spawnpointname, "classname");

  printObjectiveStates();

	if (isdefined(level.objectivearray))  {
	          
    locationToUse = getcvar("scr_cnq_initialobjective");
    
    for (n = 0; n < level.objectivearray.size; n++) {
      spawnObjective = level.objectivearray[n];
      if (isOff(spawnObjective))
        continue;
      locationToUse = spawnObjective.script_idnumber;
    }

    printDebug( "Basing spawns on objective #" + locationToUse);		
    teamRole = "";
    if (self.pers["team"] == game["attackers"])
      teamRole = "attackers";
    else
      teamRole = "defenders";

    spawngroup = teamRole + locationToUse;
    printDebug( "Attempting to use spawngroup " + spawngroup );		
   	spawnpoints = getentarray(spawngroup, "targetname");
	 	if (isdefined(spawnpoints)) {
  	  if (spawnpoints.size == 0)  {
        spawnpoints = getentarray(spawnpointname, "classname");
        printDebug( "0 spawns found, switching to regular TDM spawns" );		
   	  }

    } else {

      spawnpoints = getentarray(spawnpointname, "classname");
      printDebug( "No spawns found, switching to regular TDM spawns" );		

    }
	} 
  printDebug( "Found " + spawnpoints.size + " spawn points.");

  if (getcvar("scr_cnq_spawnmethod") == "random")
    spawnpoint = maps\mp\gametypes\_spawnlogic::getSpawnpoint_Random(spawnpoints);
  else
    spawnpoint = maps\mp\gametypes\_spawnlogic::getSpawnpoint_NearTeam(spawnpoints);


	if(isDefined(spawnpoint))
		self spawn(spawnpoint.origin, spawnpoint.angles);
	else
		maps\mp\_utility::error("NO " + spawnpointname + " SPAWNPOINTS IN MAP");

	self.statusicon = "";
	self.maxhealth = 100;
	self.health = self.maxhealth;
	
	if(!isDefined(self.pers["savedmodel"]))
		maps\mp\gametypes\_teams::model();
	else
		maps\mp\_utility::loadModel(self.pers["savedmodel"]);

	maps\mp\gametypes\_teams::givePistol();
	maps\mp\gametypes\_teams::giveGrenades(self.pers["weapon"]);
	
	self giveWeapon(self.pers["weapon"]);
	self giveMaxAmmo(self.pers["weapon"]);
	self setSpawnWeapon(self.pers["weapon"]);
	
  setObjectiveText(self);

	if(level.drawfriend)
	{
		if(self.pers["team"] == "allies")
		{
			self.headicon = game["headicon_allies"];
			self.headiconteam = "allies";
		}
		else
		{
			self.headicon = game["headicon_axis"];
			self.headiconteam = "axis";
		}
	}
	self maps\mp\gametypes\_awe::spawnPlayer();
}

spawnSpectator(origin, angles)
{
	self notify("spawned");
	self notify("end_respawn");

	resettimeout();

	self.sessionstate = "spectator";
	self.spectatorclient = -1;
	self.archivetime = 0;
	self.friendlydamage = undefined;

	if(self.pers["team"] == "spectator")
		self.statusicon = "";
	
	if(isDefined(origin) && isDefined(angles))
		self spawn(origin, angles);
	else
	{
         	spawnpointname = "mp_teamdeathmatch_intermission";
		spawnpoints = getentarray(spawnpointname, "classname");
		spawnpoint = maps\mp\gametypes\_spawnlogic::getSpawnpoint_Random(spawnpoints);
	
		if(isDefined(spawnpoint))
			self spawn(spawnpoint.origin, spawnpoint.angles);
		else
			maps\mp\_utility::error("NO " + spawnpointname + " SPAWNPOINTS IN MAP");
	}
	
	self setClientCvar("cg_objectiveText", &"TDM_ALLIES_KILL_AXIS_PLAYERS");
}

spawnIntermission()
{
	self notify("spawned");
	self notify("end_respawn");

	resettimeout();

	self.sessionstate = "intermission";
	self.spectatorclient = -1;
	self.archivetime = 0;
	self.friendlydamage = undefined;

	spawnpointname = "mp_teamdeathmatch_intermission";
	spawnpoints = getentarray(spawnpointname, "classname");
	spawnpoint = maps\mp\gametypes\_spawnlogic::getSpawnpoint_Random(spawnpoints);
	
	if(isDefined(spawnpoint))
		self spawn(spawnpoint.origin, spawnpoint.angles);
	else
		maps\mp\_utility::error("NO " + spawnpointname + " SPAWNPOINTS IN MAP");
}

respawn()
{
	if(!isDefined(self.pers["weapon"]))
		return;
	
	self endon("end_respawn");
	
	if(getCvarInt("scr_forcerespawn") > 0)
	{
		self thread waitForceRespawnTime();
		self thread waitRespawnButton();
		self waittill("respawn");
	}
	else
	{
		self thread waitRespawnButton();
		self waittill("respawn");
	}
	
	self thread spawnPlayer();
}

waitForceRespawnTime()
{
	self endon("end_respawn");
	self endon("respawn");
	
	wait getCvarInt("scr_forcerespawn");
	self notify("respawn");
}

waitRespawnButton()
{
	self endon("end_respawn");
	self endon("respawn");
	
	wait 0; // Required or the "respawn" notify could happen before it's waittill has begun

	self.respawntext = newClientHudElem(self);
	self.respawntext.alignX = "center";
	self.respawntext.alignY = "middle";
	self.respawntext.x = 320;
	self.respawntext.y = 70;
	self.respawntext.archived = false;
	self.respawntext setText(&"MPSCRIPT_PRESS_ACTIVATE_TO_RESPAWN");

	thread removeRespawnText();
	thread waitRemoveRespawnText("end_respawn");
	thread waitRemoveRespawnText("respawn");

	while(self useButtonPressed() != true)
		wait .05;
	
	self notify("remove_respawntext");

	self notify("respawn");	
}

removeRespawnText()
{
	self waittill("remove_respawntext");

	if(isDefined(self.respawntext))
		self.respawntext destroy();
}

waitRemoveRespawnText(message)
{
	self endon("remove_respawntext");

	self waittill(message);
	self notify("remove_respawntext");
}

killcam(attackerNum, delay)
{
	self endon("spawned");

//	previousorigin = self.origin;
//	previousangles = self.angles;
	
	// killcam
	if(attackerNum < 0)
		return;

	self.sessionstate = "spectator";
	self.spectatorclient = attackerNum;
	self.archivetime = delay + 7;

	// wait till the next server frame to allow code a chance to update archivetime if it needs trimming
	wait 0.05;

	if(self.archivetime <= delay)
	{
		self.spectatorclient = -1;
		self.archivetime = 0;
		self.sessionstate = "dead";
	
		self thread respawn();
		return;
	}

	if(!isDefined(self.kc_topbar))
	{
		self.kc_topbar = newClientHudElem(self);
		self.kc_topbar.archived = false;
		self.kc_topbar.x = 0;
		self.kc_topbar.y = 0;
		self.kc_topbar.alpha = 0.5;
		self.kc_topbar setShader("black", 640, 112);
	}

	if(!isDefined(self.kc_bottombar))
	{
		self.kc_bottombar = newClientHudElem(self);
		self.kc_bottombar.archived = false;
		self.kc_bottombar.x = 0;
		self.kc_bottombar.y = 368;
		self.kc_bottombar.alpha = 0.5;
		self.kc_bottombar setShader("black", 640, 112);
	}

	if(!isDefined(self.kc_title))
	{
		self.kc_title = newClientHudElem(self);
		self.kc_title.archived = false;
		self.kc_title.x = 320;
		self.kc_title.y = 40;
		self.kc_title.alignX = "center";
		self.kc_title.alignY = "middle";
		self.kc_title.sort = 1; // force to draw after the bars
		self.kc_title.fontScale = 3.5;
	}
	self.kc_title setText(&"MPSCRIPT_KILLCAM");

	if(!isDefined(self.kc_skiptext))
	{
		self.kc_skiptext = newClientHudElem(self);
		self.kc_skiptext.archived = false;
		self.kc_skiptext.x = 320;
		self.kc_skiptext.y = 70;
		self.kc_skiptext.alignX = "center";
		self.kc_skiptext.alignY = "middle";
		self.kc_skiptext.sort = 1; // force to draw after the bars
	}
	self.kc_skiptext setText(&"MPSCRIPT_PRESS_ACTIVATE_TO_RESPAWN");

	if(!isDefined(self.kc_timer))
	{
		self.kc_timer = newClientHudElem(self);
		self.kc_timer.archived = false;
		self.kc_timer.x = 320;
		self.kc_timer.y = 428;
		self.kc_timer.alignX = "center";
		self.kc_timer.alignY = "middle";
		self.kc_timer.fontScale = 3.5;
		self.kc_timer.sort = 1;
	}
	self.kc_timer setTenthsTimer(self.archivetime - delay);

	self thread spawnedKillcamCleanup();
	self thread waitSkipKillcamButton();
	self thread waitKillcamTime();
	self waittill("end_killcam");

	self removeKillcamElements();

	self.spectatorclient = -1;
	self.archivetime = 0;
	self.sessionstate = "dead";

	//self thread spawnSpectator(previousorigin + (0, 0, 60), previousangles);
	self thread respawn();
}

waitKillcamTime()
{
	self endon("end_killcam");
	
	wait(self.archivetime - 0.05);
	self notify("end_killcam");
}

waitSkipKillcamButton()
{
	self endon("end_killcam");
	
	while(self useButtonPressed())
		wait .05;

	while(!(self useButtonPressed()))
		wait .05;
	
	self notify("end_killcam");	
}

removeKillcamElements()
{
	if(isDefined(self.kc_topbar))
		self.kc_topbar destroy();
	if(isDefined(self.kc_bottombar))
		self.kc_bottombar destroy();
	if(isDefined(self.kc_title))
		self.kc_title destroy();
	if(isDefined(self.kc_skiptext))
		self.kc_skiptext destroy();
	if(isDefined(self.kc_timer))
		self.kc_timer destroy();
}

spawnedKillcamCleanup()
{
	self endon("end_killcam");

	self waittill("spawned");
	self removeKillcamElements();
}

startGame()
{
	level.starttime = getTime();
	
	if(level.timelimit > 0)
	{
		level.clock = newHudElem();
		level.clock.x = 320;
		level.clock.y = 460;
		level.clock.alignX = "center";
		level.clock.alignY = "middle";
		level.clock.font = "bigfixed";
		level.clock setTimer(level.timelimit * 60);
	}
	
	for(;;)
	{
		checkTimeLimit();
		wait 1;
	}
}

endMap()
{

////// Added by AWE ///////////
	maps\mp\gametypes\_awe::endMap();
/////////////////////////////////

	game["state"] = "intermission";
	level notify("intermission");
	level notify( "end_map" );

  if (isdefined(level.cnqCallbackEndMap))
    [[level.cnqCallbackEndMap]]();

	alliedscore = getTeamScore("allies");
	axisscore = getTeamScore("axis");
	
	if(alliedscore == axisscore)
	{
		winningteam = "tie";
		losingteam = "tie";
		text = "MPSCRIPT_THE_GAME_IS_A_TIE";
	  soundAlias = "MP_announcer_round_draw";
	}
	else if(alliedscore > axisscore)
	{
		winningteam = "allies";
		losingteam = "axis";
		text = &"MPSCRIPT_ALLIES_WIN";
	  soundAlias = "MP_announcer_" + winningteam + "_win";
	}
	else
	{
		winningteam = "axis";
		losingteam = "allies";
		text = &"MPSCRIPT_AXIS_WIN";
	  soundAlias = "MP_announcer_" + winningteam + "_win";
	}
	
	if((winningteam == "allies") || (winningteam == "axis"))
	{
		winners = "";
		losers = "";
	}
	
	players = getentarray("player", "classname");
	for(i = 0; i < players.size; i++)
	{
		player = players[i];
		if((winningteam == "allies") || (winningteam == "axis"))
		{
			lpGuid = player getGuid();
			if((isDefined(player.pers["team"])) && (player.pers["team"] == winningteam))
					winners = (winners + ";" + lpGuid + ";" + player.name);
			else if((isDefined(player.pers["team"])) && (player.pers["team"] == losingteam))
					losers = (losers + ";" + lpGuid + ";" + player.name);
		}
		player playLocalSound( soundAlias );
		player closeMenu();
		player setClientCvar("g_scriptMainMenu", "main");
		player setClientCvar("cg_objectiveText", text);
		player spawnIntermission();
	}
	
	if((winningteam == "allies") || (winningteam == "axis"))
	{
		logPrint("W;" + winningteam + winners + "\n");
		logPrint("L;" + losingteam + losers + "\n");
	}
	
	wait 10;
	exitLevel(false);
}

checkTimeLimit()
{
	if(level.timelimit <= 0)
		return;
	
	timepassed = (getTime() - level.starttime) / 1000;
	timepassed = timepassed / 60.0;
	
	if(timepassed < level.timelimit)
		return;
	
	if(level.mapended)
		return;
	level.mapended = true;

	iprintln(&"MPSCRIPT_TIME_LIMIT_REACHED");
	level thread endMap();
}

checkScoreLimit()
{
	if(level.scorelimit <= 0)
		return;
	
	if(getTeamScore("allies") < level.scorelimit && getTeamScore("axis") < level.scorelimit)
		return;

	if(level.mapended)
		return;
	level.mapended = true;

	iprintln(&"MPSCRIPT_SCORE_LIMIT_REACHED");
	level thread endMap();
}

updateGametypeCvars()
{
	for(;;)
	{
		timelimit = getCvarFloat("scr_cnq_timelimit");
		if(level.timelimit != timelimit)
		{
			if(timelimit > 1440)
			{
				timelimit = 1440;
				setCvar("scr_cnq_timelimit", "1440");
			}
			
			level.timelimit = timelimit;
			setCvar("scr_cnq_timelimit", level.timelimit);
			level.starttime = getTime();
			
			if(level.timelimit > 0)
			{
				if(!isDefined(level.clock))
				{
					level.clock = newHudElem();
					level.clock.x = 320;
					level.clock.y = 440;
					level.clock.alignX = "center";
					level.clock.alignY = "middle";
					level.clock.font = "bigfixed";
				}
				level.clock setTimer(level.timelimit * 60);
			}
			else
			{
				if(isDefined(level.clock))
					level.clock destroy();
			}
			
			checkTimeLimit();
		}

		scorelimit = getCvarInt("scr_cnq_scorelimit");
		if(level.scorelimit != scorelimit)
		{
			level.scorelimit = scorelimit;
			setCvar("scr_cnq_scorelimit", level.scorelimit);
		}
		checkScoreLimit();

		drawfriend = getCvarFloat("scr_drawfriend");
		if(level.drawfriend != drawfriend)
		{
			level.drawfriend = drawfriend;
			
			if(level.drawfriend)
			{
				// for all living players, show the appropriate headicon
				players = getentarray("player", "classname");
				for(i = 0; i < players.size; i++)
				{
					player = players[i];
					
					if(isDefined(player.pers["team"]) && player.pers["team"] != "spectator" && player.sessionstate == "playing")
					{
						if(player.pers["team"] == "allies")
						{
							player.headicon = game["headicon_allies"];
							player.headiconteam = "allies";
						}
						else
						{
							player.headicon = game["headicon_axis"];
							player.headiconteam = "axis";
						}
					}
				}
			}
			else
			{
				players = getentarray("player", "classname");
				for(i = 0; i < players.size; i++)
				{
					player = players[i];
					
					if(isDefined(player.pers["team"]) && player.pers["team"] != "spectator" && player.sessionstate == "playing")
						player.headicon = "";
				}
			}
		}

		killcam = getCvarInt("scr_killcam");
		if (level.killcam != killcam)
		{
			level.killcam = getCvarInt("scr_killcam");
			if(level.killcam >= 1)
				setarchive(true);
			else
				setarchive(false);
		}
		
		teambalance = getCvarInt("scr_teambalance");
		if (level.teambalance != teambalance)
		{
			level.teambalance = getCvarInt("scr_teambalance");
			if (level.teambalance > 0)
			{
				level thread maps\mp\gametypes\_teams::TeamBalance_Check();
				level.teambalancetimer = 0;
			}
		}
		
		if (level.teambalance > 0)
		{
			level.teambalancetimer++;
			if (level.teambalancetimer >= 60)
			{
				level thread maps\mp\gametypes\_teams::TeamBalance_Check();
				level.teambalancetimer = 0;
			}
		}
		
		wait 1;
	}
}

printJoinedTeam(team)
{
	if(team == "allies")
		iprintln(&"MPSCRIPT_JOINED_ALLIES", self);
	else if(team == "axis")
		iprintln(&"MPSCRIPT_JOINED_AXIS", self);
}

dropHealth()
{

//// Added by AWE ////
	if ( !getcvarint("scr_drophealth") )
		return;
		
	if(isdefined(self.awe_nohealthpack))
		return;
	self.awe_nohealthpack = true;
//////////////////////

	if(isDefined(level.healthqueue[level.healthqueuecurrent]))
		level.healthqueue[level.healthqueuecurrent] delete();
	
	level.healthqueue[level.healthqueuecurrent] = spawn("item_health", self.origin + (0, 0, 1));
	level.healthqueue[level.healthqueuecurrent].angles = (0, randomint(360), 0);

	level.healthqueuecurrent++;
	
	if(level.healthqueuecurrent >= 16)
		level.healthqueuecurrent = 0;
}

addBotClients()
{
	wait 5;
	
	for(;;)
	{
		if(getCvarInt("scr_numbots") > 0)
			break;
		wait 1;
	}
	
	iNumBots = getCvarInt("scr_numbots");
	for(i = 0; i < iNumBots; i++)
	{
		ent[i] = addtestclient();
		wait 0.5;

		if(isPlayer(ent[i]))
		{
			if(i & 1)
			{
				ent[i] notify("menuresponse", game["menu_team"], "axis");
				wait 0.5;
				ent[i] notify("menuresponse", game["menu_weapon_axis"], "kar98k_mp");
			}
			else
			{
				ent[i] notify("menuresponse", game["menu_team"], "allies");
				wait 0.5;
				ent[i] notify("menuresponse", game["menu_weapon_allies"], "springfield_mp");
			}
		}
	}
}

startObjectives() {

  startSpawnObjectives();
  startBonusObjectives();
  setObjectives();
  adjustObjectivesCount();
  
}


startSpawnObjectives() {
  
	if(getcvar("scr_cnq_initialobjective") == "") {	// Initial switch on, admin setting
    if (isdefined(game["cnq_initialobjective"])) { // Initial switch, optional mapper setting
      setcvar("scr_cnq_initialobjective", game["cnq_initialobjective"]);
    } else {
	    setcvar("scr_cnq_initialobjective", "1");
    }    
  }    

	level.conquest_objectives = getentarray("spawnobjective","targetname");
  printDebug ("Found " + level.conquest_objectives.size + " spawn objectives in this map.");
	for(i = 0; i < level.conquest_objectives.size; i++) 	{
    //first, find the triggers each objective targets and set them
    objective = level.conquest_objectives[i];
    flipOff(objective); //turn all off to start
  	targets = getentarray (objective.target,"targetname");
    for (t = 0; t < targets.size; t++) {
      if (targets[t].classname == "trigger_use" || targets[t].classname == "trigger_multiple") {
    		objective.trigger = targets[t];
      }
    }    
    if (!isdefined(objective.trigger)) continue;
    
    objective thread objective_think();
 	  level.objectivearray[objective.script_idnumber - 1] = objective;
	}

  found = 0;
  for (i = 0; i < level.objectivearray.size; i++) {
    if (level.objectivearray[i].script_idnumber <= getcvarint("scr_cnq_initialobjective")) {
      flipObjective(level.objectivearray[i]);
      found = 1;
    } else {
      break; 
    }
  }
}

startBonusObjectives() {

	level.bonus_objectives = getentarray("bonusobjective","targetname");
  printDebug ("Found " + level.bonus_objectives.size + " bonus objectives in this map.");
	for(i = 0; i < level.bonus_objectives.size; i++) 	{
    //first, find the triggers each objective targets and set them
    objective = level.bonus_objectives[i];
    if (isdefined (objective.target)) {
    	targets = getentarray (objective.target,"targetname");

      for (t = 0; t < targets.size; t++) {
        if (targets[t].classname == "trigger_use" || targets[t].classname == "trigger_multiple") {
      		objective.trigger = targets[t];
          objective thread bonus_objective_think();
          break;
      	}
      }    
    }
	}
    
}

objective_think() {

 for(;;) {
  
  delaytime = 0.5;

  self.trigger waittill("trigger", other);

  if (isPlayer(other)) {

    allSpawnObjectives = level.objectivearray;

    if (!isdefined(allSpawnObjectives))
      continue;
    
    for (n = 0; n < allSpawnObjectives.size; n++) {

      if (self.script_idnumber == allSpawnObjectives[n].script_idnumber) {

        if (other.pers["team"] == game["attackers"]) {

          // if it's already on, fugeddabowdit
          if (isOn(self)) {
            clientAnnouncement(other, "Your team has already taken this objective! Look at your compass or the scoreboard for your current objective.");
            continue;
          }
  
          //attackers can always turn on the 1st objective
          //otherwise, they can turn a objecetive on only if the previous one is also on.
          previousObjective = allSpawnObjectives[n-1];
          if ((n == 0) || (isdefined(previousObjective) && isOn(previousObjective))) {
            thread performObjectiveCompleteTasks(self, other, "spawn");
            if (isdefined(self.trigger.delay) && (self.trigger.delay > 0.5)) 
              delaytime = self.trigger.delay / 1000; //don't know why, but delay comes through as map # * 1000;
          } else {
            clientAnnouncement(other, "This is not your current objective! Look at your compass or the scoreboard for your current objective.");
          }

        } else {  //defenders

          // if it's already off, fugeddabowdit
          if (isOff(self))      {
            clientAnnouncement(other, "Your team has already taken this objective! Look at your compass or the scoreboard for your current objective.");
             continue;
          } 
  
          //defenders can always turn on the last objective and the next to be turned off
          previousObjective = allSpawnObjectives[n+1];
          if ((n == allSpawnObjectives.size - 1) || (isdefined(previousObjective) && isOff(previousObjective))) {
            thread performObjectiveCompleteTasks(self, other, "spawn");
             if (isdefined(self.trigger.delay))
              delaytime = self.trigger.delay / 1000; //don't know why, but delay comes through as map # * 1000;
          } else {
            clientAnnouncement(other, "This is not your current objective! Look at your compass or the scoreboard for your current objective.");
          }
        } // if other.per["team"]
      } //if self.script_idnumber
    }  //for loop	          
  }  //if isPlayer

  wait delaytime;
  if (isdefined(level.cnqCallbackSpawnObjectiveRegen))
    thread [[level.cnqCallbackSpawnObjectiveRegen]](self);
 } //outside for loop
}


bonus_objective_think() {

 self thread countdownUntilAvailable(60); //initial wait, so teams don't earn bonus in 1st minute before everyone is spawned in.
 
 for(;;) {
  
  self.trigger waittill("trigger", other);

  printDebug ("Bonus triggered by " + other.name + " playing for the " + other.pers["team"]);

  if (isPlayer(other)) {

    if (!isdefined(level.objectivearray))
      continue;

    teamRole = "attackers";
    if (other.pers["team"] == game["defenders"])
      teamRole = "defenders";
      
    if (isdefined(self.script_team) && (self.script_team == teamRole)) { //if it's their bonus objective
      if (level.objCount[teamRole] == level.objectivearray.size) { //and they control all the regular objectives
        if (self.isAvailable == 1) { //and it's not in a wait state
          self.isAvailable = 0;  
          thread performObjectiveCompleteTasks(self, other, "bonus");
          self thread countdownUntilAvailable();
        } else {
          clientAnnouncement(other, "This bonus objective cannot be taken yet. Look at your compass or the scoreboard for your current objective.");
        }
      } else {
          clientAnnouncement(other, "This is not your current objective! Look at your compass or the scoreboard for your current objective.");
      }
    } else {
      clientAnnouncement(other, "This is not your team's bonus objective! Look at your compass or the scoreboard for your current objective.");
    }
  }  //if isPlayer
  wait 0.5;
 } //outside for loop
}

countdownUntilAvailable(delayTime) {
 
 
 self.isAvailable = 0;
 if (!isdefined(delayTime)) {
  if (isdefined(self.trigger.delay) && (self.trigger.delay > 0.5)) {
    delayTime  = self.trigger.delay / 1000; //don't know why, but delay comes through as map # * 1000
  } else {
    delayTime = 60; 
  }
 }
 
 printDebug ("Delay time on trigger is " + delaytime + " seconds.");
 wait delayTime;
 self.isAvailable = 1;
 thread updatePlayerInfo();
 if (isdefined(level.cnqCallbackBonusObjectiveRegen))
   thread [[level.cnqCallbackBonusObjectiveRegen]](self);

}

flipObjective(spawnObjective) {
  if (isOn(spawnObjective)) {
    flipOff(spawnObjective);
  } else {
    flipOn(spawnObjective);
  }  
  printObjectiveStates();
}

getNumObjectivesControlled( team ) {

  if (team == game["attackers"])  
    return level.objCount["attackers"];
  else
    return level.objCount["defenders"];
  
}

setObjectives( ) {
  deleteObjectivesFromHud();
  addObjectiveToHud(getNextObjective(game["attackers"]), game["attackers"]);
  addObjectiveToHud(getNextObjective(game["defenders"]), game["defenders"]);
}

addObjectiveToHud(objective, team) {
 if (isdefined(objective)) {

   hudIndex = 0; //attackers
   if (team == game["defenders"])
    hudIndex = 1;

   objective_add(hudIndex, "current", objective.origin, "gfx/hud/objective.tga");
   objective_position(hudIndex, objective.origin);
   objective_team(hudIndex,team);
 }
}

deleteObjectivesFromHud() {
  objective_delete(0);
  objective_delete(1);
}

adjustObjectivesCount( ) {
 
  if ( isdefined(level.objCount) ) {

    if (isdefined(level.objCount["attackers"]) )
      level.objCount["attackers"] = 0;
    if ( isdefined(level.objCount["defenders"]) )
      level.objCount["defenders"] = 0;
      
    for (n = 0; n < level.objectivearray.size; n++) {
      if (isOn(level.objectivearray[n])) {
        level.objCount["attackers"] = level.objCount["attackers"] + 1;
      } else {
        level.objCount["defenders"] = level.objCount["defenders"] + 1;
      }
    }
  }
}

flipOff(objective) {
  objective.script_nodestate = "0";
}

flipOn(objective) {
  objective.script_nodestate = "1";
}

printObjectiveStates() 
{
  if (getcvar("scr_cnq_debug") != "1" )
    return;

  if (isdefined(level.objectivearray))  {
    for (n = 0; n < level.objectivearray.size; n++) {
      spawnObjective = level.objectivearray[n];
      if ( isdefined(spawnObjective)) {
        if (isOn(spawnObjective)) {
          printDebug ("Objective number " + spawnObjective.script_idnumber + " is on.");
        } else {
          printDebug ("Objective number " + spawnObjective.script_idnumber + " is off.");
        }  
      }	else {
        printDebug ("The spawnObjective at position " + n + " is not defined!!!!");
      }
    }
    
  } else {
    printDebug ("level.objectivearray is not defined!!!!");
  }
}

printDebug (text) {
  if (getcvar("scr_cnq_debug") == "1" ) {
    iprintln ("DEBUG: " + text);
  }
}

performObjectiveCompleteTasks(objective, player, objectiveType) {
  if (objectiveType == "spawn")
    flipObjective(objective);
  awardPoints(player, objectiveType);
  
  if (objectiveType == "spawn") {
    if (isdefined(level.cnqCallbackSpawnObjectiveComplete))
      thread [[level.cnqCallbackSpawnObjectiveComplete]](objective, player);
  } else {
    if (isdefined(level.cnqCallbackBonusObjectiveComplete))
      thread [[level.cnqCallbackBonusObjectiveComplete]](objective, player);
  }
  
  logAction(player);
	if(level.mapended) // if map is over, bail out
		return;

  updatePlayerInfo();
  displayGameMessage(objective, player, objectiveType);
}

updatePlayerInfo() {

  setObjectives();
  adjustObjectivesCount();
  setObjectiveTextAll();
  
}

displayGameMessage (objective, player, objectiveType) {
  
  if (isdefined (objective.script_objective_name))
    objectiveName = objective.script_objective_name;
  else 
    objectiveName = "the objective";

  message = player.name + " ^7has reached ^2" + objectiveName + "^7.";
  
  if (objectiveType == "spawn")
    message = message + " The " + getColor(player.pers["team"]) + maps\mp\_ahz_utility::toUpper(player.pers["team"]) + " ^7are advancing!!";

  if (objectiveType == "bonus")
    message = message + " The " + getColor(player.pers["team"]) + maps\mp\_ahz_utility::toUpper(player.pers["team"]) + " ^7have earned a bonus!!";

  iprintln (message); 
  
}

logAction(player) {
 	lpselfnum = player getEntityNumber();
	lpselfname = player.name;
	lpselfteam = player.pers["team"];
	lpselfguid = player getGuid();
	logPrint("A;" + lpselfguid + ";" + lpselfnum + ";" + lpselfteam + ";" + lpselfname + ";" + "cnq_objective" + "\n");
}

awardPoints(player, objectiveType) {

  if (objectiveType == "bonus") {
    playerPoints = level.player_bonus_points;
    teamPoints = level.team_bonus_points;
  } else {
    playerPoints = level.player_obj_points;
    teamPoints = level.team_obj_points;
  } 
  player.score = player.score + playerPoints;
  teamscore = getTeamScore(player.pers["team"]);
  teamscore = teamscore + teamPoints + playerPoints;
	setTeamScore(player.pers["team"], teamscore);
  checkScoreLimit();
}

playSound(soundAlias) {
  players = getentarray("player", "classname");
	for(i = 0; i < players.size; i++)	{
    players[i] playLocalSound( soundAlias );
	}
}

isOn(spawnObjective) {
  return (spawnObjective.script_nodestate == "1");
}

isOff(spawnObjective) {
  return (spawnObjective.script_nodestate == "0");
}

startHud() {
	level endon( "end_map" );
	for (;;) {
		showHud();
		wait 0.5;
	}  
}

showHud() {

  //Credit Where Credit Is Due Dept.
  //This code was originally from [MC]Hammer's CoDaM 
  //and modified to fit my needs for CNQ

	teams = [];
	teams[ 0 ] = game["attackers"];
	teams[ 1 ] = game["defenders"];
	_startat = 600;
	_bump = 2;
	_ybase = 25;
	
	//first, display the static icons for deaths and objectives
	if (!isdefined (level._score_icons) ) {
	  

  	_kills_icon = newHudElem();
		_kills_icon.x = _startat - 20;
	  _kills_icon.y = _ybase + 20 + _bump;
		_kills_icon.alignX = "center";
		_kills_icon.alignY = "middle";
		_kills_icon.sort = 1;

 		_kills_icon setShader( "gfx/hud/death_suicide.tga", 12, 12 );
		level._score_icons[0] = _kills_icon;

  	_obj_icon = newHudElem();
		_obj_icon.x = _startat - 20;
	  _obj_icon.y = _ybase + 40 + _bump;
		_obj_icon.alignX = "center";
		_obj_icon.alignY = "middle";
		_obj_icon.sort = 1;

 		_obj_icon setShader( "gfx/hud/headicon@re_objcarrier.tga", 12, 12 );
		level._score_icons[1] = _obj_icon;

  	for ( i = 0; i < teams.size; i++ ) {
  		if ( !isdefined( level._team_icons ) ||
  		     !isdefined( level._team_icons[ i ] ) )		{
  
  			_team_icon = newHudElem();
  			_team_icon.x = _startat + (i * 25);
  			_team_icon.y = _ybase;
  			_team_icon.alignX = "center";
  			_team_icon.alignY = "top";
  			_team_icon.sort = 1;
  
  			level._team_icons[ i ] = _team_icon;
   		} else
 		  	_team_icon = level._team_icons[ i ];

  	  _team_icon setShader( game[ "headicon_" + teams[ i ] ], 12, 12 );
	  }
	}

	for ( i = 0; i < teams.size; i++ ) 	{
	  
		if ( !isdefined( level._team_kills ) ||
		     !isdefined( level._team_kills[ i ] ) )
		{
			_team_kill = newHudElem();
			_team_kill.x = _startat + (i * 25);
			_team_kill.y = _ybase + 20;
			_team_kill.alignX = "center";
			_team_kill.alignY = "middle";
			_team_kill.sort = 10;
			_team_kill.color = ( 1, 1, 0 );
			_team_kill.fontScale = .9;

			level._team_kills[ i ] = _team_kill;
		}
		else
			_team_kill = level._team_kills[ i ];

		if ( !isdefined( level._team_objs ) ||
		     !isdefined( level._team_objs[ i ] ) )
		{
			_obj = newHudElem();
			_obj.x = _startat + (i * 25);
			_obj.y = _ybase + 40;
			_obj.alignX = "center";
			_obj.alignY = "middle";
			_obj.sort = 10;
			_obj.color = ( 1, 1, 0 );
			_obj.fontScale = .9;

			level._team_objs[ i ] = _obj;
		}
		else
			_obj = level._team_objs[ i ];
		
		_team = teams[ i ];
    _score = getTeamScore(_team);
    _numobjs =  getNumObjectivesControlled(_team);
    
		_team_kill setValue( _score );
		_obj setValue( _numobjs );
  }

	return;
}

getColor( team )
{
	color = "^7";
	switch ( team ) {
	  case "allies":
	  	color = "^4";
	  	break;
	  case "axis":
	  	color = "^1";
	  	break;
	}
	return ( color );
}


getNextObjective ( team ) {
 
	if (team == game["attackers"]) {
    	  
    for (i = 0; i < level.objectivearray.size; i++) {
      if (isOff(level.objectivearray[i])) {
        return level.objectivearray[i];
      }
    }
    teamRole = "attackers";

	} else {
	  
    for (i = level.objectivearray.size - 1; i >= 0; i--) {
      if (isOn(level.objectivearray[i])) {
        return level.objectivearray[i];
      }
    }
    teamRole = "defenders";

	}
  //no spawn objectives currently, so check for a bonus objective
  for (i = 0; i < level.bonus_objectives.size; i++) {
    
    available = 0;
    if (isdefined(level.bonus_objectives[i].isAvailable))
      available = level.bonus_objectives[i].isAvailable;
    
    if ( level.bonus_objectives[i].script_team == teamRole && (available == 1))
      return level.bonus_objectives[i];
  }
  //no current objective, return nil
	return undefined;
}

setObjectiveTextAll () {

	players = getentarray("player", "classname");
	for(i = 0; i < players.size; i++)
		setObjectiveText (players[i]);
  
}

setObjectiveText ( player ) {
 
  nextObj = getNextObjective (player.pers["team"]);

  if (isdefined(nextObj)) {
    
    if (isdefined (nextObj.script_objective_name))
      objectiveName = nextObj.script_objective_name;
    else 
      objectiveName = "the next objective";

    objText = maps\mp\_ahz_utility::toUpper(player.pers["team"]) + "^7 must take ^2" + objectiveName + "^7";

  } else {
   	if(player.pers["team"] == game["attackers"])
      objText = game["cnq_attackers_obj_text"];
    else if (player.pers["team"] == game["defenders"])
      objText = game["cnq_defenders_obj_text"];
    else
      objText = &"TDM_ALLIES_KILL_AXIS_PLAYERS";

  }

	player setClientCvar("cg_objectiveText", objText); 
  
}

