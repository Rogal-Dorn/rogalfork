::mods_hookExactClass("items/accessory/falcon_item", function(o) {
	local getTooltip = getTooltip;
	o.getTooltip = function ()
	{
		result = getTooltip();
		result.push({
			id = 15,
			type = "text",
			icon = "ui/icons/bravery.png",
			text = "Reduces the Resolve of any opponent engaged in melee by [color=" + this.Const.UI.Color.NegativeValue + "]-3[/color]"
		});
		return false;
	}

	function onUpdateProperties( _properties )
	{
		this.accessory.onUpdateProperties(_properties);
		_properties.Bravery += 4;
		_properties.Threat += 3;
	}
});