::mods_hookExactClass("items/supplies/dried_fish_item", function(o) {
	local create = o.create;
	o.create = function ()
	{
		create();
		this.m.Description = "Provisions. Fish is a common and filling food in coastal regions. It is dried to preserve it. Can be eaten in battle to provide up to 2 healing and fatigue recovery over ten turns, based on the amount remaining. Will be used as provisions if left in the company stash.";		this.m.Amount = 20.0;
	}

	o.onPutIntoBag <- function ()
	{
		this.onEquip();
	}

	o.onEquip <- function ()
	{
		this.food_item.onEquip();
		local skill = this.new("scripts/skills/actives/legend_eat_rations_skill");
		skill.setItem(this);
		this.addSkill(skill);
	}
});