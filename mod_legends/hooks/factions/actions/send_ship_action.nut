::mods_hookExactClass("factions/actions/send_ship_action", function(o)
{
	o.m.Dest <- null;

	local onUpdate = o.onUpdate;
	o.onUpdate = function ( _faction )
	{
		onUpdate(_faction);
		if (this.m.Settlement == null)
			return;
		if (this.m.Settlement.numShips() > 1)
			this.m.Score = 0;
	}

	o.onLegendExecute <- function ( _faction )
	{
		local spawnpoint = this.m.Settlement.getDeepOceanTile();
		if (spawnpoint == null)
		{
			return false;
		}

		local destination;
		foreach( a in this.m.Settlement.getAttachedLocations() )
		{
			if (a.isUsable())
			{
				destination = a.getTile();
				break;
			}
		}

		if (destination == null)
		{
			return false;
		}

		local party = _faction.spawnEntity(spawnpoint, "Ship", false, null, 0);
		party.getSprite("banner").Visible = false;
		party.getSprite("base").Visible = false;
		party.getSprite("body").setBrush("ship_03");
		party.getSprite("bodyUp").setBrush("ship_04");
		party.setShowName(false);
		party.setMirrored(true);
		party.setIgnoreCollision(true);
		party.setSlowerAtNight(false);
		party.setAttackable(false);
		party.setLeaveFootprints(false);
		party.setVisibilityMult(2.0);
		party.setDescription("A ship transporting goods and passengers.");
		party.setResources(this.Math.rand(1,10));

		local min = 1;
		switch (this.m.Settlement.getSize()) {
			case 1:
			 	min = 1;
				 break;
			case 2:
				min = 3;
				break;
			case 3:
				min = 5;
				break;
		}
		local max = min + this.Math.round(this.m.Settlement.getResources() * 0.05);
		if(::Legends.Mod.ModSettings.getSetting("WorldEconomy").getValue())
				{
					local town = this.m.Settlement;
					foreach (building in town.getBuildings())
					{
						local stash = building.getStash();
						if (stash != null)
						{
							foreach (item in stash.getItems())
							{
							if (item == null) continue;


								if (::Legends.Mod.ModSettings.getSetting("WorldEconomy").getValue())
								{
									if (item.isItemType(this.Const.Items.ItemType.TradeGood))
									{
										item.removeSelf();
										party.addToInventory(item);

									}
									else
									{
										local r = this.Math.rand(1,10);
										if (r == 1)
										{
										item.removeSelf();
										party.addToInventory(item);
										}
									}

								}
							}
						}
					}
					local resources = this.Math.max(1, this.Math.round(0.025 * town.getResources()));
					town.setResources(town.getResources() - resources);
					party.setResources(resources);
					this.logWarning("Exporting " + resources + " resources and " + party.getInventory().len() + "items from " + town.getName() + "via a ship bound for " + this.m.Dest.getName() + " town")
				}

				else
				{
				local r = this.Math.rand(min,max);
				for( local j = 0; j < r; j = ++j )
				{
					local items = [
						[2, "supplies/bread_item"],
						[2, "supplies/roots_and_berries_item"],
						[2, "supplies/dried_fruits_item"],
						[2, "supplies/ground_grains_item"],
						[2, "supplies/bread_item"],
						[2, "supplies/dried_fish_item"],
						[2, "supplies/beer_item"],
						[2, "supplies/bread_item"],
						[2, "supplies/goat_cheese_item"],
						[2, "supplies/legend_fresh_fruit_item"],
						[2, "supplies/legend_fresh_meat_item"],
						[2, "supplies/legend_pie_item"],
						[2, "supplies/legend_porridge_item"],
						[2, "supplies/legend_pudding_item"],
						[2, "supplies/mead_item"],
						[2, "supplies/medicine_item"],
						[2, "supplies/pickled_mushrooms_item"],
						[2, "supplies/preserved_mead_item"],
						[2, "supplies/smoked_ham_item"],
						[2, "supplies/wine_item"],
						[1, "trade/amber_shards_item"],
						[3, "trade/cloth_rolls_item"],
						[1, "trade/copper_ingots_item"],
						[2, "trade/dies_item"],
						[1, "trade/legend_cooking_spices_trade_item"],
						[1, "trade/furs_item"],
						[1, "trade/peat_bricks_item"],
						[3, "trade/quality_wood_item"],
						[2, "trade/salt_item"],
						[1, "trade/uncut_gems_item"],
						[1, "trade/legend_gold_ingots_item"],
						[1, "trade/legend_tin_ingots_item"],
						[1, "trade/legend_iron_ingots_item"]
					]

					local item = this.Const.World.Common.pickItem(items);
					party.addToInventory(item);
				}

		}

		local c = party.getController();
		c.getBehavior(this.Const.World.AI.Behavior.ID.Attack).setEnabled(false);
		c.getBehavior(this.Const.World.AI.Behavior.ID.Flee).setEnabled(false);
		local swim = this.new("scripts/ai/world/orders/swim_order");
		this.m.Dest = destination;
		swim.setDestination(destination);
		local despawn = this.new("scripts/ai/world/orders/despawn_order");
		local dock = this.new("scripts/ai/world/orders/legend_dock_order");
		c.addOrder(swim);
		c.addOrder(dock);
		c.addOrder(despawn);
	}

	local onExecute = o.onExecute;
	o.onExecute = function ( _faction )
	{
		//TODO, I want to have these generated only once a harbor town gets nice and fat and juicy,
		//have this ship going to another settlement to move goods around the map.
//		 if(::Legends.Mod.ModSettings.getSetting("WorldEconomy").getValue())
//		 {
//		 	local success = this.onLegendExecute( _faction);
//		 	if (success)
//		 		return;
//		 }

		onExecute(_faction);
	}
});
