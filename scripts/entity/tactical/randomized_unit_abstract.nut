this.randomized_unit_abstract <- this.inherit("scripts/entity/tactical/human", {
	m = {
		Outfits = [
			[1, "low_tier_unit_catchall_outfit_01"]
		],
		// Default perk lists will have every option available, apart from things that we never want. (Magic)
		ClassPerkList = [],  // Virtually always empty?
		DefensePerkList = [  // Doesn't affect base stats
			this.Const.Perks.HeavyArmorTree,
			this.Const.Perks.MediumArmorTree,
			this.Const.Perks.LightArmorTree,
			this.Const.Perks.ClothArmorTree
		],
		TraitsPerkList = [  
			this.Const.Perks.AgileTree,
			this.Const.Perks.IndestructibleTree,
			this.Const.Perks.MartyrTree,
			this.Const.Perks.ViciousTree,
			this.Const.Perks.DeviousTree,
			this.Const.Perks.InspirationalTree,
			this.Const.Perks.IntelligentTree,
			this.Const.Perks.CalmTree,
			this.Const.Perks.FastTree,
			this.Const.Perks.LargeTree,
			this.Const.Perks.OrganisedTree,
			this.Const.Perks.SturdyTree,
			this.Const.Perks.FitTree,
			this.Const.Perks.TrainedTree
		], 
		GuaranteedPerks = [], // this will just be perks and not a tree? rarely do we want guaranteed perks,
		WeaponsAndTrees = [ // All weapons have an equal chance, the number is % to roll on the dagger tree. Can add more chances for weapons by just adding more entries for now
			["scripts/items/weapons/knife", this.Const.Perks.DaggerTree, 100]
		]
		BasePower = this.Const.RandomizedPower.Low //Generally decides the cap
		PerkPower = this.m.BasePower, //How much we can purchase with left
	},

	function onInit() 
	{
		this.human.onInit();
		// baseProperties should be set inside of the abstracted unit
		// local b = this.m.BaseProperties;
	}

	function modifyAttributes( _attributes )
	{
		local b = this.m.BaseProperties;
		b.Hitpoints += this.Math.rand(_attributes.Hitpoints[0], _attributes.Hitpoints[1])
		b.Bravery += this.Math.rand(_attributes.Bravery[0], _attributes.Bravery[1])
		b.Stamina += this.Math.rand(_attributes.Stamina[0], _attributes.Stamina[1])
		b.MeleeSkill += this.Math.rand(_attributes.MeleeSkill[0], _attributes.MeleeSkill[1])
		b.RangedSkill += this.Math.rand(_attributes.RangedSkill[0], _attributes.RangedSkill[1])
		b.MeleeDefense += this.Math.rand(_attributes.MeleeDefense[0], _attributes.MeleeDefense[1])
		b.RangedDefense += this.Math.rand(_attributes.RangedDefense[0], _attributes.RangedDefense[1])
		b.Initiative += this.Math.rand(_attributes.Initiative[0], _attributes.Initiative[1])
	}


	function pickPerk( _purchaseLimit, _tree, _cap = 6)
	{
		if (_cap > 6) { _cap = 6 } //idk i'm being lazy below this is fine to do trust me
		for (i = 0; i < _cap; i++)
		{
			local row = _tree[i]
			if ( row.len() == 0) { continue; } //if empty we just cont
			local toAdd = this.new(row[0].Script)
			if (!this.m.Skills.hasSkill(toAdd.getID()))
			{
				this.m.Skills.add(toAdd)
				this.m.PerkPower--
			}
		}
	}

	function assignPerks()
	{
		// do *a* defense perk first
		// it'll end up picking like 1+ depending on base power, we the rest on traits
		local idx = this.Math.rand(0, this.m.DefensePerkList.len() - 1)
		pickPerk(this.m.PerkPower, this.m.DefensePerkList.Tree, (int(this.m.BasePower / 2) - 1) )
		// do traits perks second
		// i'm willing to spend the entirity of perk power in one tree, otherwise we're gonna repeat and remove the perk tree until we exhaust all options
		while (this.m.PerkPower > 0 || this.m.TraitsPerkList.len() == 0)
		{
			local idx = this.Math.rand(0, this.m.TraitsPerkList.len() - 1)
			local selectedTree = this.m.TraitsPerkList.remove(idx)
			modifyAttributes(selectedTree.Attributes)
			pickPerk(this.m.PerkPower, selectedTree.Tree, (int(this.m.BasePower / 2) - 1) )
		}
	}

	function assignOutfit()
	{
		foreach( item in this.Const.World.Common.pickOutfit(this.m.Outfits) ) 
		{
			this.m.Items.equip(item);
		}
	}

	// Full default is always a knife, with a 100% chance to select the weapon perks
	function assignWeapon()
	{
		local idx = this.Math.rand(0, this.m.WeaponsAndTrees.len() - 1)
		local selection = this.m.WeaponsAndTrees[idx]
		
		this.m.Items.equip( this.new( selection[0] ) )

		// IF we happen to pick the weapon perks
		if (this.Math.rand(0, 99) <= selection[2] - 1)
		{
			pickPerk( int(this.m.PerkPower / 2),  selection[1].Tree, int(this.m.BasePower / 2))
			modifyAttributes( selection[1].Attributes )
		}
	
	}

	function assignRandomEquipment()
	{
		assignWeapon(); // This assigns weapon perks too
		assignOutfit(); // This does not assign things like nimble, opposite of assignWeapon
		assignPerks();
	}
});