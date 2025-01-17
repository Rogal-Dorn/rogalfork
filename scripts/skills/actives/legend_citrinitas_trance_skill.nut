this.legend_citrinitas_trance_skill <- this.inherit("scripts/skills/actives/legend_trance_abstract_skill", {
	m = {},
	function create()
	{
		this.legend_trance_abstract_skill.create();
		this.m.ID = "actives.legend_citrinitas_trance";
		this.m.Name = "Citrinitas (Trance)";
		this.m.Icon = "skills/omen_active.png"; //todo: change icons, better description, sound on use
		this.m.IconDisabled = "skills/omen_active_sw.png";
		this.m.Overlay = "omen_active";
		this.m.SoundOnUse = [
			"sounds/combat/hawk_01.wav",
			"sounds/combat/hawk_02.wav"
		];

		this.m.Description = "Toggle Citrinitas On (Grants Drums of War and Drums of Life effects to all allies at the end of turn)";
		this.m.ToggleOnDescription = this.m.Description;
		this.m.ToggleOffDescription = "Toggle Citrinitas Off";
	}

	function applyDrums()
	{
		local myTile = _user.getTile();
		local actors = this.Tactical.Entities.getInstancesOfFaction(_user.getFaction());

		foreach( a in actors )
		{
			if (a.getID() == _user.getID())
			{
				continue;
			}

			if (a.getFatigue() == 0)
			{
				continue;
			}

			if (a.getFaction() == _user.getFaction())
			{
				// a.getSkills().add(this.new("scripts/skills/effects/legend_drums_of_life_effect"));
				a.getSkills().add(this.new("scripts/skills/effects/legend_drums_of_war_effect"));
			}
		}
		// this.getContainer().add(this.new("scripts/skills/effects/legend_drums_of_life_effect"));
		this.getContainer().add(this.new("scripts/skills/effects/legend_drums_of_war_effect"));
	}

	function doTranceEndTurn()
	{
		this.applyDrums();
	}

});
