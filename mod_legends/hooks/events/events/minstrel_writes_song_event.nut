::mods_hookExactClass("events/events/minstrel_writes_song_event", function(o) {
	local create = o.create;
	o.create = function() {
		create();
		foreach (s in this.m.Screens) {
			if (s.ID == "A") {
				s.Text = "[img]gfx/ui/events/event_26.png[/img]{%minstrel% the minstrel picks up a lute. You\'ve no clue where the instrument came from, but within a few strokes it has drawn the attention of the rest of the company. The mercenary's head picks up, eyes closed, and begins to sing.%SPEECH_ON%I... -strum- joined a band of mercenaries, my coffers all gone... -strum-... they wanted a fighter, but all I had were songs. The end.%SPEECH_OFF%The company laughs as the fool throws the lute over his shoulder. | %minstrel% the minstrel produces a lute seeming out of thin air like a magician would a rabbit, gives it a practiced strum, then breaks into song.%SPEECH_ON%There once was a monster that terrorized fair Riggabong... -strum-... They called it, if I recall, a real problem... -strum strum-...\n\nThis beast could only feast on the ladies, but just the virgins oh yeah it had great taste!...-plucky strum-... but obviously that was not, for man or woman, a desired fate!...-sketchy strum, a new one-...\n\n So they hired Sir Galicock, the greatest sword-swinger in the land...-playful strum-...and so he went door to door, and vanquished every virgin a good swordsman can!...-a lingering, sad strum-... and the monster starved to death. The end.%SPEECH_OFF% | As a fire crackles and the men begin to get weary eyed in front of its flame, %minstrel% the minstrel clears their throat in a manner best described as \'everybody listen.\' Standing up, too, and raising a hand as though it carried a glass with which to toast.%SPEECH_ON%Aye, you are some of the finest men I\'ve ever met. I say that because I never knew my father and I spent all my years with the womenfolk.%SPEECH_OFF%He stares longingly into the distance.%SPEECH_ON%Damn, have I been with a lot of women.%SPEECH_OFF%And then he sits down. A moment of silence lingers in the air before it\'s broken with uproarious laughter. | %minstrel% the minstrel is looking for a lute. Upon not to being able to find it, they resort to an \'air lute\' instead, plucking playfully with a thumb.%SPEECH_ON%Hold on, that didn\'t sound quite right, lemme tune it.%SPEECH_OFF%Raising a hand and twisting his finger, then goes for another strum.%SPEECH_ON%The hell? That was worse than the first. Just a sec, I\'ll get it, I promise.%SPEECH_OFF%He tries again, but apparently this \'strum\' wasn\'t any good either.%SPEECH_ON%To hell with this piece of shite!%SPEECH_OFF%The minstrel jumps to their feet and repeatedly smashes the invisible lute against the ground before heaving it into the tall grass. He sweeps the sweat from his brow.%SPEECH_ON%You were right, dear father, I should have been a blacksmith.%SPEECH_OFF%And then %minstrel% storms off, confused laughter from the company crackling behind him. | While throwing dirt into the fire, %minstrel% the minstrel begins to speak, to whom nobody can be sure.%SPEECH_ON%The old gods said let there be light, did they not? \'Tis the first thing they did, so clearly light must be important.%SPEECH_OFF%He picks up a piece of dirt and seems to analyze it.%SPEECH_ON%So why is there so much pleasure to be found where a woman is darkest?%SPEECH_OFF%The initially confused onlookers burst into laughter. | %minstrel% the minstrel stands up and clacks their boots together.%SPEECH_ON%Shall I show you fools how to dance?%SPEECH_OFF%A few men look up and shake their heads.%SPEECH_ON%Oh come on. It\'s simple. Watch.%SPEECH_OFF%The minstrel raises a leg, it goes into an angle no human\'s leg should before planting back on the ground. %minstrel% twirls, arms up high. Then fans both arms out as if to fly. It\'s actually quite beautiful, though you\'d never admit as much to any living soul. You watch as the minstrel continues, leaning forward when suddenly rips a horrendous fart right into %otherbrother%\'s face.\n\n %minstrel% straightens up in an instant, as though the gas had fixed a bad back and then sought the immediate use of it.%SPEECH_ON%I, uh... well, that\'s all folks! So hopefully you got the moves down pat!%SPEECH_OFF% %minstrel% runs off, a particularly slighted and smelly man on his heels. The rest of the men bowl over with laughter.}";
			}
		}
	}
})