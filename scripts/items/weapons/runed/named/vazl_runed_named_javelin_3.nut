this.vazl_runed_named_javelin_3 <- this.inherit("scripts/items/weapons/runed/vazl_runed_weapon", {
	m = {},
	function isAmountShown()
	{
		return true;
	}

	function getAmountString()
	{
		return this.m.Ammo + "/" + this.m.AmmoMax;
	}

	function create()
	{
		this.vazl_runed_weapon.create();
		this.m.Ammo = 5;
		this.m.AmmoMax = 5;
		this.m.ID = "weapon.vazl_runed_named_javelin_3";
		this.m.Description = "A couple of light throwing spears that are skillfully balanced to fly as straight as possible. Have limited range and are exhausting to throw, but may inflict devastating injuries.";
		this.m.Categories = "Throwing Weapon, One-Handed";
		this.m.SlotType = this.Const.ItemSlot.Mainhand;
		this.m.ItemType = this.Const.Items.ItemType.Named | this.Const.Items.ItemType.Weapon | this.Const.Items.ItemType.RangedWeapon | this.Const.Items.ItemType.Ammo | this.Const.Items.ItemType.Defensive;
		this.m.AddGenericSkill = true;
		this.m.ShowArmamentIcon = true;
		this.m.IsDroppedAsLoot = true;
		this.m.Value = 800;
		this.m.RangeMin = 1;
		this.m.RangeMax = 4;
		this.m.RangeIdeal = 4;
		this.m.StaminaModifier = -6;
		this.m.RegularDamage = 30;
		this.m.RegularDamageMax = 45;
		this.m.ArmorDamageMult = 0.75;
		this.m.DirectDamageMult = 0.45;
		this.m.ShieldDamage = 0;
		this.m.IconLarge = "weapons/melee/javelins_01_named_03.png";
		this.m.Icon = "weapons/melee/javelins_01_named_03_70x70.png";
		this.m.ArmamentIcon = "icon_named_javelin_03";
	}


	function onEquip()
	{
		this.weapon.onEquip();
		this.addSkill(this.new("scripts/skills/actives/throw_javelin"));
	}

	function setAmmo( _a )
	{
		this.weapon.setAmmo(_a);

		if (this.m.Ammo > 0)
		{
			this.m.IconLarge = "weapons/melee/javelins_01_named_03.png";
			this.m.Icon = "weapons/melee/javelins_01_named_03_70x70.png";
			this.m.ArmamentIcon = "icon_named_javelin_03";
			this.m.ShowArmamentIcon = true;
		}
		else
		{
			this.m.IconLarge = "weapons/ranged/javelins_01_bag.png";
			this.m.Icon = "weapons/ranged/javelins_01_bag_70x70.png";
			this.m.ArmamentIcon = "icon_named_javelin_03";
			this.m.ShowArmamentIcon = false;
		}
	}

});
