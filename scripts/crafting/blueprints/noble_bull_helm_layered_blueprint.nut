this.noble_bull_helm_layered_blueprint <- this.inherit("scripts/crafting/blueprint", {
	m = {},
	function create()
	{
		this.blueprint.create();
		this.m.ID = "blueprint.noble_bull_helm_blueprint_layered";
		this.m.Type = this.Const.Items.ItemType.Helmet;
		this.m.PreviewCraftable = this.new("scripts/items/legend_helmets/vanity/legend_helmet_faction_helmet");
		this.m.Cost = 5000;
		local ingredients = [
			{
				Script = "scripts/items/legend_helmets/vanity/legend_helmet_faction_helmet",
				Num = 1
			}
		];
		this.init(ingredients);
		local skills = [
			{
				Scripts = ["scripts/skills/backgrounds/legend_blacksmith_background"]
			}
		]
		this.initSkills(skills);
	}

	function isQualified()
	{
		return this.LegendsMod.Configs().LegendArmorsEnabled() && this.blueprint.isQualified();
	}


	function onCraft( _stash )
	{
		local item = this.new("scripts/items/legend_helmets/vanity/legend_helmet_faction_helmet");
		item.setVariant(3);
		_stash.add(item);
	}

});

