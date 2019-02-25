this.legend_ironmonger_background <- this.inherit("scripts/skills/backgrounds/character_background", {
	m = {},
	function create()
	{
		this.character_background.create();
		this.m.ID = "background.legend_ironmonger";
		this.m.Name = "Ironmonger";
		this.m.Icon = "ui/backgrounds/ironmonger.png";
		this.m.BackgroundDescription = "Ironmongers are stronger than average and good at maintaining equipment.";
		this.m.GoodEnding = "A more reliable sellsword than most, %name%\'s background as an ironmonger helped him to keep the %companyname%\'s equipment functioning. Having saved more than enough crowns, %name% retired and returned to blacksmithing, learning from a true master and becoming a paragon of the craft. Last you heard of him he was living in luxury, making custom weapons and armor for nobles.";
		this.m.BadEnding = "%name% the ironmonger stayed with the %companyname% for some time after your departure, but after a particularly nasty stretch of bad luck he saw the rot for what it was and jumped ship. Bad luck seemed to follow him, however, and he never managed to settle down. He burned through his leftover crowns in a few years. He died in poverty one winter, freezing overnight.";
		this.m.HiringCost = 300;
		this.m.DailyCost = 6;
		this.m.Excluded = [
			"trait.clumsy",
			"trait.asthmatic",
			"trait.fragile"

		];
		this.m.Titles = [
			"the Ironmonger",
			"the Metalsmith",
			"the Farrier",
			"the Scavenger",
			"the Iron-shaper",
			"the Student"
		];
		this.m.Faces = this.Const.Faces.AllMale;
		this.m.Hairs = this.Const.Hair.YoungMale;
		this.m.HairColors = this.Const.HairColors.Young;
		this.m.Beards = this.Const.Beards.All;
		this.m.Body = "bust_naked_body_01";
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
			},
			{
				id = 13,
				type = "text",
				icon = "ui/icons/xp_received.png",
				text = "[color=" + this.Const.UI.Color.PositiveValue + "]+10%[/color] faster equipment repair and [color=" + this.Const.UI.Color.PositiveValue + "]-10%[/color] tool usage"
			}
		];
	}

	function onBuildDescription()
	{
		return "{When one needs tools repaired but cannot afford a blacksmith, they seek out their local ironmonger. | A self taught smith working from scrap metal, the ironmonger works mostly with farm tools and horseshoes.}{No ironmonger can compare to the skills of a full fledged blacksmith, but it can be a lucrative profession in smaller villages. | Though lacking the skills of a fully trained blacksmith, ironmongers are vital for some settlements, too small or remote to merit a resident blacksmith.} {%name% was an ironmonger in %townname%. | %name% served for many years as an ironmonger in %townname%. | %name% was an ironmonger, like his father. | Urged by his parents to join the craft, %name% was an ironmonger for many years. | Not to be outdone by his overachieving militia brother, %name% taught him to smith and served as the local ironmonger.}{Unfortunately, a trained blacksmith arrived in town, and %name%\'s skills were quickly rendered obsolete. Facing poverty, he left home to join a company of sellswords. | %name%’s clients eventually dried up, and he was forced to leave home and seek new work. | %name% eventually left home due to a tragedy that he refused to speak of. Face grim, he seeks new employment.}";
	}

	function onChangeAttributes()
	{
		local c = {
			Hitpoints = [
				5,
				3
			],
			Bravery = [
				0,
				0
			],
			Stamina = [
				10,
				5
			],
			MeleeSkill = [
				3,
				2
			],
			RangedSkill = [
				-5,
				-5
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

	function onAddEquipment()
	{
		local items = this.getContainer().getActor().getItems();
		local r;
		r = this.Math.rand(0, 2);

		if (r == 0)
		{
			items.equip(this.new("scripts/items/armor/leather_tunic"));
		}
		else if (r == 1)
		{
			items.equip(this.new("scripts/items/armor/linen_tunic"));
		}
		else if (r == 2)
		{
			items.equip(this.new("scripts/items/armor/apron"));
		}
		else if (r == 3)
		{
			items.equip(this.new("scripts/items/armor/legend_blacksmith_apron"));
		}
	}

});