this.vazl_runed_butchers_cleaver <- this.inherit("scripts/items/weapons/runed/vazl_runed_weapon", {
	m = {},
	function create()
	{
		this.vazl_runed_weapon.create();
		this.m.ID = "weapon.vazl_runed_butchers_cleaver";
		this.m.Name = "Butcher\'s Cleaver";
		this.m.Description = "A tool with a thick rectangular blade used for hacking through meat and bone.";
		this.m.Categories = "Cleaver, One-Handed";
		this.m.IconLarge = "weapons/melee/runed_cleaver_02.png";
		this.m.Icon = "weapons/melee/runed_cleaver_02_70x70.png";
		this.m.SlotType = this.Const.ItemSlot.Mainhand;
		this.m.ItemType = this.Const.Items.ItemType.Weapon | this.Const.Items.ItemType.MeleeWeapon | this.Const.Items.ItemType.OneHanded;
		this.m.IsDoubleGrippable = true;
		this.m.AddGenericSkill = true;
		this.m.ShowQuiver = false;
		this.m.ShowArmamentIcon = true;
		this.m.ArmamentIcon = "runed_icon_cleaver_02";
		this.m.ShieldDamage = 0;
		this.m.Condition = 40.0;
		this.m.ConditionMax = 40.0;
		this.m.StaminaModifier = -6;
		this.m.Value = 110;
		this.m.RegularDamage = 20;
		this.m.RegularDamageMax = 35;
		this.m.ArmorDamageMult = 0.75;
		this.m.DirectDamageMult = 0.25;
	}

	function onEquip()
	{
		this.weapon.onEquip();
		local cleave = this.new("scripts/skills/actives/cleave");
		cleave.m.Icon = "skills/active_68.png";
		cleave.m.IconDisabled = "skills/active_68_sw.png";
		cleave.m.Overlay = "active_68";
		this.addSkill(cleave);
		local decapitate = this.new("scripts/skills/actives/decapitate");
		this.addSkill(decapitate);
	}

});
