this.cook_follower <- this.inherit("scripts/retinue/follower", {
	m = {},
	function create()
	{
		this.follower.create();
		this.m.ID = "follower.cook";
		this.m.Name = "Cooking Equipment";
		this.m.Description = "A good warm meal goes a long way towards healing body and mind. A cook can only do so much with whatever there is to hand in the wilderness, Having the proper equipment to prepare meals makes sure that no provisions go to waste.";
		this.m.Image = "ui/campfire/legend_cook_01";
		this.m.Cost = 1000;
		this.m.Effects = [
			"Makes all provisions last 3 extra days",
			"Increases hitpoint healing rate by 33%"
		];
		this.m.Requirements = [
			{
				IsSatisfied = false,
				Text = "Have someone who's learned the Camp Cook perk. Guaranteed on Bakers, Fishwives, Cannibals and Butchers, may be rarely found on many others"
			}
		];
	}

	function onUpdate()
	{
		if ("FoodAdditionalDays" in this.World.Assets.m)
			this.World.Assets.m.FoodAdditionalDays = 3;
		if ("HitpointsPerHourMult" in this.World.Assets.m)
			this.World.Assets.m.HitpointsPerHourMult = 1.33;
	}

	function onEvaluate()
	{
		// local uniqueProvisions = this.getAmountOfUniqueProvisions();
		local brothers = this.World.getPlayerRoster().getAll();
		
		foreach( bro in brothers )
		{
			if (bro.getSkills().hasSkill("perk.legend_camp_cook"))
			{
				this.m.Requirements[0].IsSatisfied = true;
				return;
			}
		}

	}

	// function getAmountOfUniqueProvisions()
	// {
	// 	local provisions = [];
	// 	local items = this.World.Assets.getStash().getItems();

	// 	foreach( item in items )
	// 	{
	// 		if (item != null && item.isItemType(this.Const.Items.ItemType.Food))
	// 		{
	// 			if (provisions.find(item.getID()) == null)
	// 			{
	// 				provisions.push(item.getID());
	// 			}
	// 		}
	// 	}

	// 	return provisions.len();
	// }

});

