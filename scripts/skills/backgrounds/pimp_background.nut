this.pimp_background <- this.inherit("scripts/skills/backgrounds/character_background", {
	m = {},
	function create()
	{
		this.character_background.create();
		this.m.ID = "background.pimp";
		this.m.Name = "Pimp";
		this.m.Icon = "ui/backgrounds/background_56.png";
		this.m.HiringCost = 60;
		this.m.DailyCost = 6;
		this.m.Excluded = [
			"trait.huge",
			"trait.fear_undead",
			"trait.fear_beasts",
			"trait.fear_greenskins",
			"trait.hate_undead",
			"trait.hate_greenskins",
			"trait.hate_beasts",
			"trait.iron_jaw",
			"trait.clubfooted",
			"trait.insecure",
			"trait.brute",
			"trait.athletic",
			"trait.iron_lungs",
			"trait.strong",
			"trait.tough",
			"trait.cocky",
			"trait.dexterous",
			"trait.dumb",
			"trait.deathwish",
			"trait.bloodthirsty"
		];
		this.m.Faces = this.Const.Faces.AllMale;
		this.m.Hairs = this.Const.Hair.TidyMale;
		this.m.HairColors = this.Const.HairColors.All;
		this.m.Beards = this.Const.Beards.Tidy;

		this.m.IsOutlawBackground = true;
		this.m.AlignmentMin = this.Const.LegendMod.Alignment.Dreaded;
		this.m.AlignmentMax = this.Const.LegendMod.Alignment.Notorious;
		this.m.Modifiers.Barter = this.Const.LegendMod.ResourceModifiers.Barter[2];
		this.m.Modifiers.Stash = this.Const.LegendMod.ResourceModifiers.Stash[1];
		this.m.Modifiers.Meds = this.Const.LegendMod.ResourceModifiers.Meds[1];
		this.m.Modifiers.Scout = this.Const.LegendMod.ResourceModifiers.Scout[2];
		this.m.PerkTreeDynamic = {
			Weapon = [
				this.Const.Perks.StavesTree,
				this.Const.Perks.ThrowingTree,
				this.Const.Perks.DaggerTree
			],
			Defense = [
				this.Const.Perks.LightArmorTree
			],
			Traits = [
				this.Const.Perks.ViciousTree,
				this.Const.Perks.OrganisedTree,
				this.Const.Perks.DeviousTree
			],
			Enemy = [
					this.Const.Perks.NoblesTree,
					this.Const.Perks.BanditTree
					],
			Class = [this.Const.Perks.FistsClassTree],
			Magic = []
		}
		this.m.Bodies = this.Const.Bodies.Thick;
	}

	function getTooltip()
	{
		return [
			{
				id = 1,
				type = "title",
				text = this.getName()
			},
			{
				id = 2,
				type = "description",
				text = this.getDescription()
			}
		];
	}

	function onBuildDescription()
	{
		return "";
	}

	function onChangeAttributes()
	{
		local c = {
			Hitpoints = [
				0,
				0
			],
			Bravery = [
				5,
				5
			],
			Stamina = [
				0,
				0
			],
			MeleeSkill = [
				-5,
				-5
			],
			RangedSkill = [
				0,
				0
			],
			MeleeDefense = [
				2,
				7
			],
			RangedDefense = [
				2,
				7
			],
			Initiative = [
				0,
				7
			]
		};
		return c;
	}

	function onAddEquipment()
	{
		local items = this.getContainer().getActor().getItems();
		local r;
		items.equip(this.new("scripts/items/armor/noble_tunic"));
		items.equip(this.Const.World.Common.pickHelmet([
			[1, "feathered_hat"]
		]));
	}

	function onAddLegendEquipment()
	{
		local items = this.getContainer().getActor().getItems();
		items.equip(this.new("scripts/items/legend_armor/cloth/legend_tunic_noble"));
		items.equip(this.Const.World.Common.pickHelmet([
			[1, "feathered_hat"]
		]));
	}
});

