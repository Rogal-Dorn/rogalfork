this.sellsword_background <- this.inherit("scripts/skills/backgrounds/character_background", {
	m = {},
	function create()
	{
		this.character_background.create();
		this.m.ID = "background.sellsword";
		this.m.Name = "Sellsword";
		this.m.Icon = "ui/backgrounds/background_10.png";
		this.m.BackgroundDescription = "Sellswords are expensive, but a life of warfare has forged them into skilled fighters.";
		this.m.GoodEnding = "%name% the sellsword left the %companyname% and started his own mercenary company. As far as you know, it\'s a very successful venture and he often buddies up with the men of the %companyname% to work together.";
		this.m.BadEnding = "%name% left the %companyname% and started his own competing company. The two companies clashed on opposite sides of a battle between nobles. The sellsword died when a mercenary from the %companyname% stove his head in with a hedge knight\'s helmet.";
		this.m.HiringCost = 100;
		this.m.DailyCost = 35;
		this.m.Excluded = [
			"trait.weasel",
			"trait.night_blind",
			"trait.ailing",
			"trait.asthmatic",
			"trait.clubfooted",
			"trait.irrational",
			"trait.hesitant",
			"trait.loyal",
			"trait.tiny",
			"trait.fragile",
			"trait.clumsy",
			"trait.fainthearted",
			"trait.craven",
			"trait.bleeder",
			"trait.dastard",
			"trait.insecure"
		];
		this.m.Faces = this.Const.Faces.AllMale;
		this.m.Hairs = this.Const.Hair.AllMale;
		this.m.HairColors = this.Const.HairColors.All;
		this.m.Beards = this.Const.Beards.All;
		this.m.Body = "bust_naked_body_01";

		if (this.Const.LegendMod.Configs.LegendGenderEnabled())
		{
			local r = this.Math.rand(0, 1);
			if (r == 0)
			{
				this.m.Faces = this.Const.Faces.AllFemale;
				this.m.Hairs = this.Const.Hair.AllFemale;
				this.m.HairColors = this.Const.HairColors.Young;
				this.m.Beards = null;
				this.m.BeardChance = 1;
				this.m.Body = "bust_naked_body_03";
				this.m.IsFemaleBackground = true;
				this.m.BackgroundDescription = "Sellswords are expensive, but a life of warfare has forged them into skilled fighters.";
				this.m.GoodEnding = "%name% the sellsword left the %companyname% and started her own mercenary company. As far as you know, it\'s a very successful venture and she often buddies up with the mercenaries of the %companyname% to work together.";
				this.m.BadEnding = "%name% left the %companyname% and started her own competing company. The two companies clashed on opposite sides of a battle between nobles. The sellsword died when a mercenary from the %companyname% stove her head in with a hedge knight\'s helmet.";
			}
		}

		this.m.Level = this.Math.rand(2, 4);
		this.m.IsCombatBackground = true;

		this.m.Modifiers.Ammo = this.Const.LegendMod.ResourceModifiers.Ammo[1];
		this.m.Modifiers.ArmorParts = this.Const.LegendMod.ResourceModifiers.ArmorParts[1];
		this.m.Modifiers.Repair = this.Const.LegendMod.ResourceModifiers.Repair[1];
		this.m.Modifiers.Salvage = this.Const.LegendMod.ResourceModifiers.Salvage[1];
		this.m.Modifiers.Training = this.Const.LegendMod.ResourceModifiers.Training[2];
		this.m.PerkTreeDynamicMins.Defense = 3;
		this.m.PerkTreeDynamicMins.Enemy = 2;
		this.m.PerkTreeDynamic = {
			Weapon = [
				this.Const.Perks.SwordTree,
				this.Const.Perks.GreatSwordTree,
				this.Const.Perks.CrossbowTree
			],
			Defense = [
				this.Const.Perks.ShieldTree,
				this.Const.Perks.HeavyArmorTree
			],
			Traits = [
				this.Const.Perks.TrainedTree,
				this.Const.Perks.ViciousTree,
				this.Const.Perks.SturdyTree,
				this.Const.Perks.LargeTree
			],
			Enemy = [
				this.Const.Perks.BanditTree,
				this.Const.Perks.BarbarianTree
			],
			Class = []
		}
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
		if(this.m.IsFemaleBackground == true)
		{
			return "{%fullname%\'s worked as a sellsword since her father handed down his equipment. | %fullname% can\'t remember a time when she wasn\'t a sword for hire. | As a mercenary, %fullname% has never had to look long for work. | The literate talk about letting loose the dogs of war. %fullname% is one such hound. | In war, there is death and profit. %fullname% causes the former to earn the latter. | There has never been a better time for mercenaries like %name% to earn a crown or two. | After her husband ran off with her children, an angry %name% made a steady career as a nasty sellsword. | A decade ago %name% lost everything in a fire. She\'s been working as a sellsword ever since. | %name% always had the mind for violence and has pursued a long career as a sellsword. | Once dirt poor, %name% has earned a very tidy sum over the years as a sellsword. | %fullname% prefers to keep for herself whence she came, but her reputation as a sword for hire speaks for itself.} {Well experienced, she has traveled in the company of many outfits in her time. | Military campaigns are but notches in her belt. | From work as a lord\'s bodyguard to being an enforcer for a skeevy merchant, %name% has seen it all. | She once made a living off slaying the wild beasts that encroach on human settlements. | With a grim grin, she boasts she has slain all manner of living creatures. | Through plenty of use, the mercenary has learned a thing or two about weapons you didn\'t even know existed. | The sellsword is counting how many she has slain to this day and she appears to not be stopping any time soon. | With a sword and shield in hand, the mercenary appears to do what she does best for a living.} {The woman is no stranger to the fields of battle. | The woman is no stranger to the cruelties of war. | She is used to the harsh realities of mercenary life. | She is said to be a reliable cog in any shield wall. | Some say she can hold a battle line as well as an oak tree. | Rumors abound that the woman enjoys the sight of blood. | Without shame, she takes an uneasy pleasure in the misery of others on the battlefield. | Strangely, she seldom joins others around the campfire, instead keeping to herself. | The woman loves to tell a good tale about how she killed this thing or that. | Given a chance, the woman is quick to showcase a wide variety of fighting styles.} {As long as you have the coin, %name% is yours to command. | A true mercenary, %name% will fight anyone for the right price. | Displaying some fine sword skills, %name% says she can run any man through. | With but a hint of a nod, %name% agrees to join you if you have the crowns. | Excited for an opportunity to earn coin, %name% knocks her mug on the table.}";
		}

		return "{%fullname%\'s worked as a sellsword since his father handed down his equipment. | %fullname% can\'t remember a time when he wasn\'t a sword for hire. | As a mercenary, %fullname% has never had to look long for work. | The literate talk about letting loose the dogs of war. %fullname% is one such hound. | In war, there is death and profit. %fullname% causes the former to earn the latter. | There has never been a better time for mercenaries like %name% to earn a crown or two. | After his wife ran off with his children, an angry %name% made a steady career as a nasty sellsword. | A decade ago %name% lost everything in a fire. He\'s been working as a sellsword ever since. | %name% always had the mind for violence and has pursued a long career as a sellsword. | Once dirt poor, %name% has earned a very tidy sum over the years as a sellsword. | %fullname% prefers to keep for himself whence he came, but his reputation as a sword for hire speaks for itself.} {Well experienced, he has traveled in the company of many outfits in his time. | Military campaigns are but notches in his belt. | From work as a lord\'s bodyguard to being an enforcer for a skeevy merchant, %name% has seen it all. | He once made a living off slaying the wild beasts that encroach on human settlements. | With a grim grin, he boasts he has slain all manner of living creatures. | Through plenty of use, the mercenary has learned a thing or two about weapons you didn\'t even know existed. | The sellsword is counting how many he has slain to this day and he appears to not be stopping any time soon. | With a sword and shield in hand, the mercenary appears to do what he does best for a living.} {The man is no stranger to the fields of battle. | The man is no stranger to the cruelties of war. | He is used to the harsh realities of mercenary life. | He is said to be a reliable cog in any shield wall. | Some say he can hold a battle line as well as an oak tree. | Rumors abound that the man enjoys the sight of blood. | Without shame, he takes an uneasy pleasure in the misery of others on the battlefield. | Strangely, he seldom joins others around the campfire, instead keeping to himself. | The man loves to tell a good tale about how he killed this thing or that. | Given a chance, the man is quick to showcase a wide variety of fighting styles.} {As long as you have the coin, %name% is yours to command. | A true mercenary, %name% will fight anyone for the right price. | Displaying some fine swordsmanship, %name% says he can run any man through. | With but a hint of a nod, %name% agrees to join you if you have the crowns. | Excited for an opportunity to earn coin, %name% knocks his mug on the table.}";
	}

	function onSetAppearance()
	{
		local actor = this.getContainer().getActor();
		local tattoo_body = actor.getSprite("tattoo_body");
		local tattoo_head = actor.getSprite("tattoo_head");

		if (this.Math.rand(1, 100) <= 25)
		{
			local body = actor.getSprite("body");
			tattoo_body.setBrush("scar_02_" + body.getBrush().Name);
			tattoo_body.Visible = true;
		}

		if (this.Math.rand(1, 100) <= 30)
		{
			tattoo_head.setBrush("scar_02_head");
			tattoo_head.Visible = true;
		}
	}

	function updateAppearance()
	{
		local actor = this.getContainer().getActor();
		local tattoo_body = actor.getSprite("tattoo_body");

		if (tattoo_body.HasBrush)
		{
			local body = actor.getSprite("body");
			tattoo_body.setBrush("scar_02_" + body.getBrush().Name);
		}
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
				13,
				10
			],
			RangedSkill = [
				12,
				10
			],
			MeleeDefense = [
				5,
				8
			],
			RangedDefense = [
				5,
				8
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

		if (this.Math.rand(0, 3) == 3)
		{
			local actor = this.getContainer().getActor();
			actor.setTitle(this.Const.Strings.SellswordTitles[this.Math.rand(0, this.Const.Strings.SellswordTitles.len() - 1)]);
		}
	}

	function onAddEquipment()
	{
		local items = this.getContainer().getActor().getItems();
		local r;
		r = this.Math.rand(0, 9);

		if (r == 0)
		{
			items.equip(this.new("scripts/items/weapons/falchion"));
		}
		else if (r == 1)
		{
			items.equip(this.new("scripts/items/weapons/flail"));
		}
		else if (r == 2)
		{
			items.equip(this.new("scripts/items/weapons/hand_axe"));
		}
		else if (r == 3)
		{
			items.equip(this.new("scripts/items/weapons/greataxe"));
		}
		else if (r == 4)
		{
			items.equip(this.new("scripts/items/weapons/longsword"));
		}
		else if (r == 5)
		{
			items.equip(this.new("scripts/items/weapons/billhook"));
		}
		else if (r == 6)
		{
			items.equip(this.new("scripts/items/weapons/winged_mace"));
		}
		else if (r == 7)
		{
			items.equip(this.new("scripts/items/weapons/warhammer"));
		}
		else if (r == 8)
		{
			items.equip(this.new("scripts/items/weapons/boar_spear"));
		}
		else if (r == 9)
		{
			items.equip(this.new("scripts/items/weapons/crossbow"));
			items.equip(this.new("scripts/items/ammo/quiver_of_bolts"));
		}

		r = this.Math.rand(0, 5);

		if (r == 0)
		{
			items.equip(this.new("scripts/items/armor/patched_mail_shirt"));
		}
		else if (r == 1)
		{
			items.equip(this.new("scripts/items/armor/padded_leather"));
		}
		else if (r == 2)
		{
			items.equip(this.new("scripts/items/armor/basic_mail_shirt"));
		}
		else if (r == 3)
		{
			items.equip(this.new("scripts/items/armor/worn_mail_shirt"));
		}
		else if (r == 4)
		{
			items.equip(this.new("scripts/items/armor/leather_lamellar"));
		}
		else if (r == 5)
		{
			items.equip(this.new("scripts/items/armor/mail_shirt"));
		}

		r = this.Math.rand(0, 9);

		if (r == 0)
		{
			items.equip(this.new("scripts/items/helmets/nasal_helmet"));
		}
		else if (r == 1)
		{
			items.equip(this.new("scripts/items/helmets/padded_nasal_helmet"));
		}
		else if (r == 2)
		{
			items.equip(this.new("scripts/items/helmets/mail_coif"));
		}
		else if (r == 3)
		{
			items.equip(this.new("scripts/items/helmets/closed_mail_coif"));
		}
		else if (r == 4)
		{
			items.equip(this.new("scripts/items/helmets/reinforced_mail_coif"));
		}
		else if (r == 5)
		{
			items.equip(this.new("scripts/items/helmets/kettle_hat"));
		}
		else if (r == 6)
		{
			items.equip(this.new("scripts/items/helmets/padded_kettle_hat"));
		}
		else if (r == 7)
		{
			items.equip(this.new("scripts/items/helmets/hood"));
		}
	}

	function onAddLegendEquipment()
	{
		local items = this.getContainer().getActor().getItems();
		local r;
		r = this.Math.rand(0, 9);

		if (r == 0)
		{
			items.equip(this.new("scripts/items/weapons/falchion"));
		}
		else if (r == 1)
		{
			items.equip(this.new("scripts/items/weapons/flail"));
		}
		else if (r == 2)
		{
			items.equip(this.new("scripts/items/weapons/hand_axe"));
		}
		else if (r == 3)
		{
			items.equip(this.new("scripts/items/weapons/greataxe"));
		}
		else if (r == 4)
		{
			items.equip(this.new("scripts/items/weapons/longsword"));
		}
		else if (r == 5)
		{
			items.equip(this.new("scripts/items/weapons/billhook"));
		}
		else if (r == 6)
		{
			items.equip(this.new("scripts/items/weapons/winged_mace"));
		}
		else if (r == 7)
		{
			items.equip(this.new("scripts/items/weapons/warhammer"));
		}
		else if (r == 8)
		{
			items.equip(this.new("scripts/items/weapons/boar_spear"));
		}
		else if (r == 9)
		{
			items.equip(this.new("scripts/items/weapons/crossbow"));
			items.equip(this.new("scripts/items/ammo/quiver_of_bolts"));
		}


		local cloths = [
            [0, ""],
			[1, "cloth/legend_gambeson"],
			[0, "cloth/legend_gambeson_plain"],
			[0, "cloth/legend_gambeson_wolf"],
			[1, "cloth/legend_padded_surcoat"],
			[0, "cloth/legend_robes"],
			[0, "cloth/legend_robes_butcher"],
			[0, "cloth/legend_robes_nun"],
			[0, "cloth/legend_robes_smith"],
			[0, "cloth/legend_robes_wizard"],
			[0, "cloth/legend_sackcloth"],
			[0, "cloth/legend_sackcloth_patched"],
			[0, "cloth/legend_sackcloth_tattered"],
			[1, "cloth/legend_tunic"],
			[0, "cloth/legend_tunic_noble"]
		];
		local armor = this.Const.World.Common.pickLegendArmor(cloths)

		if (armor != null)
		{
			local chains = [
                [0, ""],
                [1, "chain/legend_armor_mail_shirt"],
				[1, "chain/legend_armor_mail_shirt_simple"],
				[0, "chain/legend_armor_rusty_mail_shirt"],
				[0, "chain/legend_armor_ancient_double_mail"],
				[0, "chain/legend_armor_ancient_mail"],
				[1, "chain/legend_armor_basic_mail"],
				[0, "chain/legend_armor_hauberk"],
				[0, "chain/legend_armor_hauberk_full"],
				[0, "chain/legend_armor_hauberk_sleevless"],
				[1, "chain/legend_armor_reinforced_mail"],
				[1, "chain/legend_armor_reinforced_mail_shirt"],
				[0, "chain/legend_armor_reinforced_rotten_mail_shirt"],
				[0, "chain/legend_armor_reinforced_worn_mail"],
				[1, "chain/legend_armor_reinforced_worn_mail_shirt"],
				[0, "chain/legend_armor_short_mail"]
			]

			local chain = this.Const.World.Common.pickLegendArmor(chains)
			if (chain != null)
			{
				armor.setUpgrade(chain)
			}

			local plates = [
                [1, ""],
				[0, "plate/legend_armor_leather_brigandine"],
				[0, "plate/legend_armor_leather_brigandine_hardened"],
				[0, "plate/legend_armor_leather_brigandine_hardened_full"],
				[0, "plate/legend_armor_leather_jacket"],
				[0, "plate/legend_armor_leather_jacket_simple"],
				[1, "plate/legend_armor_leather_lamellar"],
				[0, "plate/legend_armor_leather_lamellar_harness_heavy"],
				[0, "plate/legend_armor_leather_lamellar_harness_reinforced"],
				[0, "plate/legend_armor_leather_lamellar_heavy"],
				[0, "plate/legend_armor_leather_lamellar_reinforced"],
				[0, "plate/legend_armor_leather_noble"],
				[1, "plate/legend_armor_leather_padded"],
				[1, "plate/legend_armor_leather_riveted"],
				[1, "plate/legend_armor_leather_riveted_light"],
				[0, "plate/legend_armor_leather_scale"],
				[0, "plate/legend_armor_plate_ancient_chest"],
				[0, "plate/legend_armor_plate_ancient_harness"],
				[0, "plate/legend_armor_plate_ancient_mail"],
				[0, "plate/legend_armor_plate_ancient_scale"],
				[0, "plate/legend_armor_plate_ancient_scale_coat"],
				[0, "plate/legend_armor_plate_ancient_scale_harness"],
				[0, "plate/legend_armor_plate_chest"],
				[0, "plate/legend_armor_plate_chest_rotten"],
				[0, "plate/legend_armor_plate_cuirass"],
				[0, "plate/legend_armor_plate_full"],
				[0, "plate/legend_armor_scale"],
				[0, "plate/legend_armor_scale_coat"],
				[0, "plate/legend_armor_scale_coat_rotten"],
				[0, "plate/legend_armor_scale_shirt"]
			]
			local plate = this.Const.World.Common.pickLegendArmor(plates)
			if (plate != null)
			{
				armor.setUpgrade(plate)
			}

			items.equip(armor);
		}

		r = this.Math.rand(0, 9);

		if (r == 0)
		{
			items.equip(this.new("scripts/items/helmets/nasal_helmet"));
		}
		else if (r == 1)
		{
			items.equip(this.new("scripts/items/helmets/padded_nasal_helmet"));
		}
		else if (r == 2)
		{
			items.equip(this.new("scripts/items/helmets/mail_coif"));
		}
		else if (r == 3)
		{
			items.equip(this.new("scripts/items/helmets/closed_mail_coif"));
		}
		else if (r == 4)
		{
			items.equip(this.new("scripts/items/helmets/reinforced_mail_coif"));
		}
		else if (r == 5)
		{
			items.equip(this.new("scripts/items/helmets/kettle_hat"));
		}
		else if (r == 6)
		{
			items.equip(this.new("scripts/items/helmets/padded_kettle_hat"));
		}
		else if (r == 7)
		{
			items.equip(this.new("scripts/items/helmets/hood"));
		}
	}

});

