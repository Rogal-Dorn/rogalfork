::mods_hookNewObject("states/tactical_state", function(o) {

	o.onBattleEnded = function()
	{
		if (this.m.IsExitingToMenu)
		{
			return;
		}

		this.m.IsBattleEnded = true;
		local isVictory = this.Tactical.Entities.getCombatResult() == this.Const.Tactical.CombatResult.EnemyDestroyed || this.Tactical.Entities.getCombatResult() == this.Const.Tactical.CombatResult.EnemyRetreated;
		this.m.IsFogOfWarVisible = false;
		this.Tactical.fillVisibility(this.Const.Faction.Player, true);
		this.Tactical.getCamera().zoomTo(2.0, 1.0);
		this.Tooltip.hide();
		this.m.TacticalScreen.hide();
		this.Tactical.OrientationOverlay.removeOverlays();

		local dead = this.Tactical.getCasualtyRoster().getAll();
		foreach (d in dead)
		{
            this.logInfo(d.isCommander());
			if (d.isCommander())
			{
				this.World.State.setCommanderDied(true);
				isVictory = false;
				break;
			}
		}

		if (isVictory)
		{
			this.Music.setTrackList(this.Const.Music.VictoryTracks, this.Const.Music.CrossFadeTime);

			if (!this.isScenarioMode())
			{
				if (this.m.StrategicProperties != null && this.m.StrategicProperties.IsAttackingLocation)
				{
					this.World.Assets.addBusinessReputation(this.Const.World.Assets.ReputationOnVictoryVSLocation);
				}
				else
				{
					this.World.Assets.addBusinessReputation(this.Const.World.Assets.ReputationOnVictory);
				}

				this.World.Contracts.onCombatVictory(this.m.StrategicProperties != null ? this.m.StrategicProperties.CombatID : "");
				this.World.Events.onCombatVictory(this.m.StrategicProperties != null ? this.m.StrategicProperties.CombatID : "");
				this.World.Statistics.get().LastEnemiesDefeatedCount = this.m.MaxHostiles;
				this.World.Statistics.get().LastCombatResult = 1;
				local playerRoster = this.World.getPlayerRoster().getAll();

				foreach( bro in playerRoster )
				{
					if (bro.getPlaceInFormation() <= 26 && !bro.isPlacedOnMap() && bro.getTags().get("Devoured") == true)
					{
						bro.onDeath(null, null, null, this.Const.FatalityType.Devoured);
						this.World.getPlayerRoster().remove(bro);
					}
					else if (bro.getPlaceInFormation() <= 26)
					{
						bro.getLifetimeStats().BattlesWithoutMe = 0;
						bro.improveMood(this.Const.MoodChange.BattleWon, "Won a battle");
					}
					else if (bro.getMoodState() > this.Const.MoodState.Concerned && !bro.getCurrentProperties().IsContentWithBeingInReserve)
					{
						++bro.getLifetimeStats().BattlesWithoutMe;

						if (bro.getLifetimeStats().BattlesWithoutMe > this.Math.max(2, 6 - bro.getLevel()))
						{
							bro.worsenMood(this.Const.MoodChange.BattleWithoutMe, "Felt useless in reserve");
						}
					}
				}
			}
		}
		else
		{
			this.Music.setTrackList(this.Const.Music.DefeatTracks, this.Const.Music.CrossFadeTime);

			if (!this.isScenarioMode())
			{
				this.World.Assets.addBusinessReputation(this.Const.World.Assets.ReputationOnLoss);
				this.World.Contracts.onRetreatedFromCombat(this.m.StrategicProperties != null ? this.m.StrategicProperties.CombatID : "");
				this.World.Events.onRetreatedFromCombat(this.m.StrategicProperties != null ? this.m.StrategicProperties.CombatID : "");
				this.World.Statistics.get().LastEnemiesDefeatedCount = 0;
				this.World.Statistics.get().LastCombatResult = 2;
				local playerRoster = this.World.getPlayerRoster().getAll();

				foreach( bro in playerRoster )
				{
					if (bro.getPlaceInFormation() <= 26 && !bro.isPlacedOnMap() && bro.getTags().get("Devoured") == true)
					{
						bro.onDeath(null, null, null, this.Const.FatalityType.Devoured);
						this.World.getPlayerRoster().remove(bro);
					}
					else if (bro.getPlaceInFormation() <= 26 && bro.isPlacedOnMap() && (bro.getTags().get("Charmed") == true || bro.getTags().get("Sleeping") == true || bro.getTags().get("Nightmare") == true))
					{
						bro.onDeath(null, null, null, this.Const.FatalityType.Suicide);
						this.World.getPlayerRoster().remove(bro);
					}
					else if (bro.getPlaceInFormation() <= 26)
					{
						bro.getLifetimeStats().BattlesWithoutMe = 0;

						if (this.Tactical.getCasualtyRoster().getSize() != 0)
						{
							bro.worsenMood(this.Const.MoodChange.BattleLost, "Lost a battle");
						}
						else
						{
							bro.worsenMood(this.Const.MoodChange.BattleRetreat, "Retreated from battle");
						}
					}
					else if (bro.getMoodState() > this.Const.MoodState.Concerned && !bro.getCurrentProperties().IsContentWithBeingInReserve)
					{
						++bro.getLifetimeStats().BattlesWithoutMe;

						if (bro.getLifetimeStats().BattlesWithoutMe > this.Math.max(2, 6 - bro.getLevel()))
						{
							bro.worsenMood(this.Const.MoodChange.BattleWithoutMe, "Felt useless in reserve");
						}
					}
				}
			}
		}

		this.gatherBrothers(isVictory);
		this.gatherLoot();
		this.Time.scheduleEvent(this.TimeUnit.Real, 800, this.onBattleEndedDelayed.bindenv(this), isVictory);
	}

	o.gatherLoot = function()
	{
		local playerKills = 0;

		foreach( bro in this.m.CombatResultRoster )
		{
			playerKills = playerKills + bro.getCombatStats().Kills;
		}

		local EntireCompanyRoster = this.World.getPlayerRoster().getAll();
		local CannibalsInRoster = 0;
		local CannibalisticButchersInRoster = 0;
		local warlockInRoster = false;
		local betterZombieSalvage = false;

		foreach (bro in EntireCompanyRoster)
		{
			if (!bro.isAlive())
			{
				continue;
			}

			switch (bro.getBackground().getID())
			{
				case "background.vazl_cannibal":
					CannibalsInRoster += 1;
					break;
				
				case "background.butcher":
					if (bro.getSkills().hasSkill("trait.vazl_cannibalistic"))
					{
						CannibalisticButchersInRoster += 1;
					}
					break;
				
				case "background.legend_necro":
				case "background.legend_commander_necro":
					warlockInRoster = true;
					break;
			}

			if ( bro.getSkills().hasSkill("trait.legends_zombie_salvage"))
			{
				betterZombieSalvage = true;
			}
		}

		local loot = [];
		local size = this.Tactical.getMapSize();

		for( local x = 0; x < size.X; x = ++x )
		{
			for( local y = 0; y < size.Y; y = ++y )
			{
				local tile = this.Tactical.getTileSquare(x, y);

				if (tile.IsContainingItems)
				{
					foreach( item in tile.Items )
					{
						item.onCombatFinished();
						loot.push(item);
					}
				}



				if (warlockInRoster && tile.Properties.has("Corpse") && tile.Properties.get("Corpse").isHuman == 1)
				{
					local zombieLoot = false
					if (betterZombieSalvage)
					{
						zombieLoot = this.Math.rand(1, 100) <= 10;
					} else {
						zombieLoot = this.Math.rand(1, 100) <= 33;
					}

					if (zombieLoot)
					{
						local zloot = this.new("scripts/items/spawns/zombie_item");
						loot.push(zloot);
					}
				}


				if (this.Math.rand(1, 100) <= 8 && tile.Properties.has("Corpse") && tile.Properties.get("Corpse").isHuman == 1)
				{
					if (CannibalisticButchersInRoster >= 1)
					{
						local humanmeat = this.new("scripts/items/supplies/vazl_yummy_sausages");
						humanmeat.randomizeAmount();
						humanmeat.randomizeBestBefore();
						loot.push(humanmeat);
					}
					else if (CannibalisticButchersInRoster < 1 && CannibalsInRoster >= 1)
					{
						local humanmeat = this.new("scripts/items/supplies/vazl_human_parts");
						humanmeat.randomizeAmount();
						humanmeat.randomizeBestBefore();
						loot.push(humanmeat);
					}
				}


				if (tile.Properties.has("Corpse") && tile.Properties.get("Corpse").Items != null)
				{
					local items = tile.Properties.get("Corpse").Items.getAllItems();

					foreach( item in items )
					{
						item.onCombatFinished();

						if (!item.isChangeableInBattle() && item.isDroppedAsLoot())
						{
							if (item.getCondition() > 1 && item.getConditionMax() > 1 && item.getCondition() > item.getConditionMax() * 0.66 && this.Math.rand(1, 100) <= 66)
							{
								local c = this.Math.minf(item.getCondition(), this.Math.rand(this.Math.maxf(10, item.getConditionMax() * 0.35), item.getConditionMax()));
								item.setCondition(c);
							}

							item.removeFromContainer();
							loot.push(item);
						}
					}
				}
			}
		}

		if (this.m.StrategicProperties != null)
		{
			local player = this.World.State.getPlayer();

			foreach( party in this.m.StrategicProperties.Parties )
			{
				if (party.getTroops().len() == 0 && party.isAlive() && !party.isAlliedWithPlayer() && party.isDroppingLoot() && (playerKills > 0 || this.m.IsDeveloperModeEnabled))
				{
					party.onDropLootForPlayer(loot);
				}
			}

			foreach( item in this.m.StrategicProperties.Loot )
			{
				loot.push(this.new(item));
			}
		}

		this.m.CombatResultLoot.assign(loot);
		this.m.CombatResultLoot.sort();
	}

})