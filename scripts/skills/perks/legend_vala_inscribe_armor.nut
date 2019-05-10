this.legend_vala_inscribe_armor <- this.inherit("scripts/skills/skill", {
	m = {},
	function create()
	{
		this.m.ID = "perk.legend_vala_inscribe_armor";
		this.m.Name = "Rune Sigils: Armors";
		this.m.Description = "";
		this.m.Icon = "ui/perks/legend_vala_inscribe_armor.png";
		this.m.Type = this.Const.SkillType.Perk | this.Const.SkillType.StatusEffect;
		this.m.Order = this.Const.SkillOrder.VeryLast + 3;
		this.m.IsActive = false;
		this.m.IsStacking = false;
		this.m.IsHidden = true;
		this.m.IsSerialized = true;
	}

	function onAdded()
	{
		local stash = this.World.Assets.getStash();
		stash.add(this.new("scripts/items/trade/uncut_gems_item"));
	}
});
