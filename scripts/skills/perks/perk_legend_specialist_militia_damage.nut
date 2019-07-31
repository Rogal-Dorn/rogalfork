this.perk_legend_specialist_militia_damage <- this.inherit("scripts/skills/skill", {
	m = {},
	function create()
	{
		this.m.ID = "perk.legend_specialist_militia_damage";
		this.m.Name = this.Const.Strings.PerkName.LegendSpecialistMilitiaDamage;
		this.m.Description = this.Const.Strings.PerkDescription.LegendSpecialistMilitiaDamage;
		this.m.Icon = "ui/perks/spear_01.png";
		this.m.Type = this.Const.SkillType.Perk;
		this.m.Order = this.Const.SkillOrder.Perk;
		this.m.IsActive = false;
		this.m.IsStacking = false;
		this.m.IsHidden = false;
	}

	function onUpdate( _properties )
	{
		local actor = this.getContainer().getActor();
		local item = actor.getItems().getItemAtSlot(this.Const.ItemSlot.Mainhand);
		if (item != null)
		{
			if(item.getID() == "weapon.militia_spear" || item.getID() == "weapon.legend_wooden_spear")
			{
			_properties.DamageRegularMin += 4;
			_properties.DamageRegularMax += 12;
			}
			if(item.getID() == "weapon.goblin_spear" || item.getID() == "weapon.fighting_spear" || item.getID() == "weapon.ancient_spear" || item.getID() == "weapon.named_spear" || item.getID() == "weapon.boar_spear" || item.getID() == "weapon.named_goblin_spear" || item.getID() == "weapon.throwing_spear")
			{
			_properties.DamageRegularMin += 1;
			_properties.DamageRegularMax += 3;
			}
		}
	}

});
