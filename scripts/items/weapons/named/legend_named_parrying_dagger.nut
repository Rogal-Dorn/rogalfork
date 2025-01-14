this.legend_named_parrying_dagger <- this.inherit("scripts/items/shields/named/named_shield", {
	m = {
		Variants = [],
		WeaponType = ::Const.Items.WeaponType.Dagger, // workaround: hardcode WeaponType since this is actually a shield

		// for offhand weapon
		RegularDamage = 20,
		RegularDamageMax = 40,
		ArmorDamageMult = 0.7,
		DirectDamageMult = 0.2,
		DirectDamageAdd = 0.0,
		ChanceToHitHead = 0,
	},
	function create()
	{
		this.named_shield.create();
		this.m.ID = "shield.legend_named_parrying_dagger";
		this.m.NameList = this.Const.Strings.DaggerNames;
		this.m.Description = "An exquisite offhand dagger for actively parrying an opponent.\n\n When parried or if an opponent misses you, their defences will be lowered.\n\n The \'Split Shield\' skill only does 20% damage against this dagger";
		this.m.AddGenericSkill = true;
		this.m.ShowOnCharacter = true;
		this.m.Variants = [2]
		this.m.Variant = this.m.Variants[this.Math.rand(0, this.m.Variants.len() -1)];
		this.m.ItemType = this.Const.Items.ItemType.Defensive | this.Const.Items.ItemType.Weapon | this.Const.Items.ItemType.Named;
		this.updateVariant();
		this.m.Value = 1000;
		this.m.MeleeDefense = 5;
		this.m.RangedDefense = 0;
		this.m.StaminaModifier = -2;
		this.m.Condition = 36;
		this.m.ConditionMax = 36;
		this.parryRandomize();
	}

	function parryRandomize()
	{
		local available = [];
		available.push(function ( _i )
		{
			local f = this.Math.rand(110, 130) * 0.01;
			_i.m.RegularDamage = this.Math.round(_i.m.RegularDamage * f);
			_i.m.RegularDamageMax = this.Math.round(_i.m.RegularDamageMax * f);
		});
		available.push(function ( _i )
		{
			_i.m.ArmorDamageMult = _i.m.ArmorDamageMult + this.Math.rand(10, 30) * 0.01;
		});
		available.push(function ( _i )
		{
			_i.m.DirectDamageAdd = _i.m.DirectDamageAdd + this.Math.rand(8, 16) * 0.01;
		});
		available.push(function ( _i )
		{
			_i.m.MeleeDefense = this.Math.round(_i.m.MeleeDefense * this.Math.rand(130, 150) * 0.01);
		});
		available.push(function ( _i )
		{
			_i.m.FatigueOnSkillUse = _i.m.FatigueOnSkillUse - this.Math.rand(1, 3);
		});
		available.push(function ( _i )
		{
			_i.m.Condition = this.Math.round(_i.m.Condition * this.Math.rand(150, 200) * 0.01) * 1.0;
			_i.m.ConditionMax = _i.m.Condition;
		});
		for( local n = 2; n != 0 && available.len() != 0; n = --n )
		{
			local r = this.Math.rand(0, available.len() - 1);
			available[r](this);
			available.remove(r);
		}
	}
	function updateVariant()
	{
		this.m.Sprite = "icon_legend_parrying_dagger_0" + this.m.Variant;
		this.m.SpriteDamaged = "icon_legend_parrying_dagger_0" + this.m.Variant + "_damaged";
		this.m.ShieldDecal = "icon_legend_parrying_dagger_0" + this.m.Variant + "_destroyed";
		this.m.IconLarge = "weapons/melee/legend_parrying_dagger_0" + this.m.Variant + ".png";
		this.m.Icon = "weapons/melee/legend_parrying_dagger_0" + this.m.Variant + "_70x70.png";
	}

	function playInventorySound( _eventType )
	{
		this.Sound.play(::Const.Sound.DefaultWeaponEquip[this.Math.rand(0, ::Const.Sound.DefaultWeaponEquip.len() - 1)], this.Const.Sound.Volume.Inventory);
	}

	function onEquip()
	{
		this.shield.onEquip();
		local stab = this.new("scripts/skills/actives/stab");
		stab.m.Order = this.Const.SkillOrder.UtilityTargeted + 1;
		this.addSkill(stab);
		this.addSkill(this.new("scripts/skills/actives/legend_en_garde_skill"));
		this.addSkill(this.new("scripts/skills/actives/puncture"));
		local parryDaggerEffect = this.new("scripts/skills/effects/legend_parrying_dagger_effect");
		parryDaggerEffect.m.Order = this.Const.SkillOrder.UtilityTargeted + 1;
		this.getContainer().getActor().getSkills().add(parryDaggerEffect);
		// Manually add the effect so that it will be ordered after perks in the skill container instead of before background
		// Even though this effect is being granted by equipping this weapon, we are adding it this way because of possible future plans to make legend_parrying_effect available not just by equipping this weapon.
		// Hence, making ordering it with the other effects/perks instead of the row above background (for item-granted effects) is for consistency
		local parrying = this.new("scripts/skills/effects/legend_parrying_effect");
		parrying.m.IsFromItem = true;
		parrying.m.Order = this.Const.SkillOrder.UtilityTargeted + 2;
		this.getContainer().getActor().getSkills().add(parrying);
	}

	function getTooltip()
	{
		local result = this.shield.getTooltip();
		local find;

		foreach(i, tooltip in result)
		{
			if (tooltip.id != 4 || tooltip.type != "progressbar") continue;

			find = i;
			break;
		}

		if (find != null)
		{
			if (this.m.RegularDamage > 0)
			{
				result.insert(find + 1, {
					id = 4,
					type = "text",
					icon = "ui/icons/regular_damage.png",
					text = "Damage of [color=" + this.Const.UI.Color.DamageValue + "]" + this.m.RegularDamage + "[/color] - [color=" + this.Const.UI.Color.DamageValue + "]" + this.m.RegularDamageMax + "[/color]"
				});
			}

			if (this.m.DirectDamageMult > 0)
			{
				result.insert(find + 2, {
					id = 64,
					type = "text",
					icon = "ui/icons/direct_damage.png",
					text = "[color=" + this.Const.UI.Color.DamageValue + "]" + this.Math.floor((this.m.DirectDamageMult + this.m.DirectDamageAdd) * 100) + "%[/color] of damage ignores armor"
				});
			}

			if (this.m.ArmorDamageMult > 0)
			{
				result.insert(find + 3, {
					id = 5,
					type = "text",
					icon = "ui/icons/armor_damage.png",
					text = "[color=" + this.Const.UI.Color.DamageValue + "]" + this.Math.floor(this.m.ArmorDamageMult * 100) + "%[/color] effective against armor"
				});
			}

			if (this.m.ChanceToHitHead > 0)
			{
				result.insert(find + 4, {
					id = 9,
					type = "text",
					icon = "ui/icons/chance_to_hit_head.png",
					text = "Chance to hit head [color=" + this.Const.UI.Color.PositiveValue + "]+" + this.m.ChanceToHitHead + "%[/color]"
				});
			}
		}

		return result;
	}

	function onUnequip()
	{
		local skill = this.getContainer().getActor().getSkills().getSkillByID("effects.legend_parrying");
		if (skill != null && skill.m.IsFromItem)
		{
			this.getContainer().getActor().getSkills().removeByID("effects.legend_parrying");
		}
		this.named_shield.onUnequip();
	}

	function getAmmoMax()
	{
		return 0;
	}

	// Hardcode this because the parrying dagger inherits from shield, but active skills may sometimes trigger WeaponType checks
	function isWeaponType( _t, _any = true, _only = false )
	{
		if (_any)
		{
			return _only ? this.m.WeaponType - (this.m.WeaponType & _t) == 0 : (this.m.WeaponType & _t) != 0;
		}
		else
		{
			return _only ? (this.m.WeaponType & _t) == this.m.WeaponType : (this.m.WeaponType & _t) == _t;
		}
	}

	function onSerialize( _out )
	{
		this.named_shield.onSerialize(_out);
		_out.writeU16(this.m.RegularDamage);
		_out.writeU16(this.m.RegularDamageMax);
		_out.writeF32(this.m.ArmorDamageMult);
		_out.writeF32(this.m.DirectDamageAdd);
	}

	function onDeserialize( _in )
	{
		this.named_shield.onDeserialize(_in);
		this.m.RegularDamage = _in.readU16();
		this.m.RegularDamageMax = _in.readU16();
		this.m.ArmorDamageMult = _in.readF32();
		this.m.DirectDamageAdd = _in.readF32();
	}

});

