turret_think(num)
{
	self notify("awe_turret_think");	// Make sure only one thread is running
	self endon("awe_turret_think");

	for(;;)
	{
		for(i = 0; i < level.awe_allplayers.size; i++)
		{
			if(isdefined(level.awe_allplayers[i]) && isAlive(level.awe_allplayers[i]) && level.awe_allplayers[i].sessionstate == "playing")
			{
				if(level.awe_allplayers[i] istouching(self))
				{
					level.awe_allplayers[i].awe_usingturret = num;
				}
				else
				{
					if(isdefined(level.awe_allplayers[i].awe_usingturret) && level.awe_allplayers[i].awe_usingturret == num)
						level.awe_allplayers[i].awe_usingturret = undefined;
					if(isdefined(level.awe_allplayers[i].awe_touchingturret) && level.awe_allplayers[i].awe_touchingturret == num)
						level.awe_allplayers[i].awe_touchingturret = undefined;
				}
			}
		}
		wait .2;
	}
}
