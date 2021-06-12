this.legend_back_to_basics_effect <- this.inherit("scripts/skills/skill", {
	m = {},
	function create()
	{
		this.m.ID = "effects.legend_back_to_basics";
		this.m.Name = "Dodging incoming blows";
		this.m.Description = "This character has taken damage and reverted to their training, gaining additional melee defense";
		this.m.Icon = "ui/perks/holdtheline.png";
		this.m.IconMini = "mini_holdtheline_circle";
		this.m.Type = this.Const.SkillType.StatusEffect;
		this.m.IsActive = false;
		this.m.IsStacking = true;
		this.m.IsRemovedAfterBattle = true;
	}
	
	function onUpdate( _properties )
	{
		_properties.MeleeDefense += 5;
	}

	function onTurnStart()
	{
		this.removeSelf();
	}
});