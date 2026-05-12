extends DialogueFormBank

func getForms() -> Dictionary:
	return {
		"DIFTalkingInit1": form("Hey, got a moment?", {reacter=CHAR, starter=CHAR}, "starter", "reacter"),		
		"DIFTalkingInit2": form("Hey there.", {reacter=CHAR, starter=CHAR}, "starter", "reacter"),
		"DIFTalkingInit3": form("Oh... hey.", {reacter=CHAR, starter=CHAR}, "starter", "reacter"),
		"DIFTalkingInit4": form("Just the person I was looking for.", {reacter=CHAR, starter=CHAR}, "starter", "reacter"),
		"DIFTalkingInit5": form("There you are.", {reacter=CHAR, starter=CHAR}, "starter", "reacter"),
		"DIFTalkingInit6": form("We need to talk.", {reacter=CHAR, starter=CHAR}, "starter", "reacter"),
		"DIFTalkingInit7": form("I've been meaning to find you.", {reacter=CHAR, starter=CHAR}, "starter", "reacter"),
		"DIFTalkingInit8": form("I figured we should catch up for a bit.", {reacter=CHAR, starter=CHAR}, "starter", "reacter"),
		"DIFTalkingInit9": form("I thought now might be a good time.", {reacter=CHAR, starter=CHAR}, "starter", "reacter"),	
	}
