this.legend_donkey <- this.inherit("scripts/skills/backgrounds/character_background", {
	m = {},
	function create()
	{
		this.character_background.create();
		this.m.ID = "background.legend_donkey";
		this.m.Name = "Donkey";
		this.m.Icon = "ui/backgrounds/donkey.png";
		this.m.BackgroundDescription = "Caravan hands are used to long and exhausting travels.";
		this.m.GoodEnding = "%name% the donkey was retired to a lovely paddock and spent the days eating and carousing with other donkeys.";
		this.m.BadEnding = "%name% the donkey was sold to a trader, their caravan was attacked by orcs and the remains of %name% were never found";
		this.m.HiringCost = 5000;
		this.m.DailyCost = 1;
		this.m.Excluded = [
			"trait.tiny",
			"trait.clubfooted",
			"trait.bright",
			"trait.asthmatic"
		];
		this.m.Faces = this.Const.Faces.Donkey;
		this.m.Hairs = this.Const.Hair.None;
		this.m.HairColors = this.Const.HairColors.None;
		this.m.Body = "bust_naked_body_05";
		this.m.IsFemaleBackground = false;
		this.m.IsUntalented = true;
		this.m.Modifiers.Ammo = this.Const.LegendMod.ResourceModifiers.Ammo[4];
		this.m.Modifiers.ArmorParts = this.Const.LegendMod.ResourceModifiers.ArmorParts[5];
		this.m.Modifiers.Meds = this.Const.LegendMod.ResourceModifiers.Meds[4];
		this.m.Modifiers.Stash = this.Const.LegendMod.ResourceModifiers.Stash[5];
		this.m.Modifiers.Terrain = [
				0.0, // ?
				0.0, //ocean
				0.025,//plains
				0.01, //swamp
				0.01, //hills
				0.01, //forest
				0.01, //forest
				0.01, //forest_leaves
				0.01, //autumn_forest
				0.01, //mountains
				0.0, // ?
				0.025, //farmland
				0.011, // snow
				0.015, // badlands
				0.015, //highlands
				0.025, //stepps
				0.0 //ocean
			];
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
		return "{  %name% was raised to pull plows on a farm. |  %name% was reared by a traveling merchant. | A donkey's life is tough %name% has been used for many things. | Though the work is dangerous, being a caravan donkey allowed %name% to see the world. | When her former owner died, %name% was put up for sale. | Hardy and resolute, %name% was the pick of the bunch. | Sold from owner to owner %name% has worked for more caravans than most traders.} {But the trader she worked for turned out to be abusive, nary a whip away from being a slave driver. A farmer bought %name% to free her, but eventually the cost got too great and she was sold again. | One day, goods went missing and she was blamed for it, promptly ending her time with the caravan. | But a caravan needs protection for a reason, and an ambush by brigands proved why. %name% barely made it out alive. | Years on the road went without a hitch until a new caravan master died on the road and %name% was left tied to a wagon without food until rescued. | Caravans are frequently attacked, and in one battle as the caravan hands fell %name% ran into the night. | Sadly, with the expanding war the caravan\'s profits were marginal. %name% was let go as the merchants retired their wagons. | After seeing the foul work of beasts on a their caravan, it didn\'t take long for %name% to find a new owner. | But war deprived the caravan of stock and soon its driver took to selling the donkeys.  %name% was among the last to be sold. | Sadly, her caravan began to sell human chattel. While the profits were enormous, it garnered the attention of a local militia - and their pitchforks. One ambush later and %name% was running for her life.} {Now %name% is being sold by a farmer for being too stubborn  | A donkey like %name% is no stranger to danger, making her a good fit for any mercenary group. | With her caravan days behind her, working for a sellsword was just another avenue for oats. | In %name%\'s mind, being a mercenary is a lot like being a caravanner. Just more carrots. | Well versed to traveling, %name% seems like a natural fit to the tasks already befit for a mercenary. | Years of road travel have molded %name% into quite the durable figure. Any group of mercenaries could use more donkeys like her.}";
	}

	function onChangeAttributes()
	{
		local c = {
			Hitpoints = [
				100,
				120
			],
			Bravery = [
				0,
				0
			],
			Stamina = [
				40,
				50
			],
			MeleeSkill = [
				0,
				0
			],
			RangedSkill = [
				-20,
				-20
			],
			MeleeDefense = [
				0,
				0
			],
			RangedDefense = [
				0,
				0
			],
			Initiative = [
				0,
				0
			]
		};
		return c;
	}
	function onAdded()
	{
		this.character_background.onAdded();
		this.m.Container.add(this.new("scripts/skills/injury_permanent/legend_donkey_injury"));
		this.m.Container.add(this.new("scripts/skills/actives/legend_donkey_kick"));
		this.m.Container.add(this.new("scripts/skills/traits/legend_appetite_donkey"));
	}	


	function onAddEquipment()
	{
		local talents = this.getContainer().getActor().getTalents();
		talents.resize(this.Const.Attributes.COUNT, 0);
		talents[this.Const.Attributes.Hitpoints] = 3;
		talents[this.Const.Attributes.Fatigue] = 3;
		this.getContainer().getActor().fillTalentValues(1, true);

	}

});
