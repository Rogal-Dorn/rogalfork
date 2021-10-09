this.negotiator_follower <- this.inherit("scripts/retinue/follower", {
	m = {},
	function create()
	{
		this.follower.create();
		this.m.ID = "follower.negotiator";
		this.m.Name = "Meeting Point";
		this.m.Description = "The Negotiator plays a vital role in the future of the company. Having a dedicated meeting place where they can talk, barter and trade insults with prominant figures or their lackeys can help.";
		this.m.Image = "ui/campfire/legend_negotiator_01";
		this.m.Cost = 3500;
		this.m.Effects = [
			"Allows for more rounds of contract negotiations with your potential employers before they abort, and with only a 10% chance on a hit to relations",
			"Greater contract payment if negotiations are successful",
			"Makes good relations with any faction decay slower and bad relations recover faster"
		];
		this.m.Requirements = [
			{
				IsSatisfied = false,
				Text = "Have someone with the Pacifist perk. Guaranteed on Widow, Inventor, Tailor and many others"
			}
		];
	}

	function onUpdate()
	{
		if ("NegotiationAnnoyanceMult" in this.World.Assets.m)
			this.World.Assets.m.NegotiationAnnoyanceMult = 0.5;
		if ("AdvancePaymentCap" in this.World.Assets.m)
			this.World.Assets.m.AdvancePaymentCap = 0.75;

		if ("RelationDecayGoodMult" in this.World.Assets.m) {
			if (this.World.Assets.getOrigin().getID() == "scenario.sato_escaped_slaves") {
				this.World.Assets.m.RelationDecayGoodMult = 1.05;
			} else {
				this.World.Assets.m.RelationDecayGoodMult = 0.9;
			}
		}
		if ("RelationDecayBadMult" in this.World.Assets.m) {
			if (this.World.Assets.getOrigin().getID() == "scenario.sato_escaped_slaves") {
				this.World.Assets.m.RelationDecayBadMult = 0.95;
			} else {
				this.World.Assets.m.RelationDecayBadMult = 1.1;
			}
		}

	}

	function onNewDay()
	{
		this.onUpdate();
	}

	function onEvaluate()
	{
		local brothers = this.World.getPlayerRoster().getAll();

		foreach( bro in brothers )
		{
			if (bro.getSkills().hasSkill("perk.legend_pacifist"))
			{
				this.m.Requirements[0].IsSatisfied = true;
				return;
			}
		}
	}

});

