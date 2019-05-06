this.perk_legend_specialist_lute_skill <- this.inherit("scripts/skills/skill", {
	m = {},
	function create()
	{
		this.m.ID = "perk.legend_specialist_lute_skill";
		this.m.Name = this.Const.Strings.PerkName.LegendSpecialistLuteSkill;
		this.m.Description = this.Const.Strings.PerkDescription.LegendSpecialistLuteSkill;
		this.m.Icon = "ui/perks/lute_02.png";
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
		if (item != null && !actor.getSkills().hasSkill("actives.legend_entice") && item.getID() == "weapon.lute")
		{
			_properties.MeleeSkill += 15;
			actor.addSkill(this.new("scripts/skills/actives/legend_entice"));
		}
		else if (actor.getSkills().hasSkill("actives.legend_entice") && !item.getID() == "weapon.lute")
		{
			actor.removeByID("actives.legend_entice");
		}
	}

});
