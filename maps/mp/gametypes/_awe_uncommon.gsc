isUo()
{
	return undefined;
}

aweIsInVehicle()
{
	return false;
}

aweSetTakeDamage(flag)
{
	return;
}

aweIsAds()
{
	return false;
}

aweShellshock(time)
{
	self shellshock("default", time);
}

shockme(damage, means)
{
	shocktime = 0.0;
	if(damage > 100)
		damage = 100;

	switch(means)
	{
		case "MOD_PROJECTILE":
		case "MOD_PROJECTILE_SPLASH":
		case "MOD_GRENADE_SPLASH":
		case "MOD_EXPLOSIVE":
			shocktime = (float)damage;
			shocktime = (shocktime / 100) * 3;
			shocktime = shocktime + 2;
			break;
		case "MOD_MELEE":
			shocktime = 3;
			break;
		case "MOD_FALLING":
			shocktime = 2;
			break;
		default:
			return;
			break;
	}
	self aweShellshock(shocktime);
}

aweGetWeaponBasedSmokeGrenadeCount(slot)
{
	return 0;
}

aweGetRankHeadIcon(player)
{
	headicon = "headicon_" + player.pers["team"];
	return game[headicon];
}

aweSetFatigue(value)
{
	return;
}

aweGetFatigue()
{
	return 0;
}
