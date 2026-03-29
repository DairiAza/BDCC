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

		"DIFTalkingDIFInit1": form("I thought I'd check in.", {starter=CHAR, reacter=CHAR}, "starter", "reacter"),
		"DIFTalkingDIFInit2": form("Hold on a second.", {starter=CHAR, reacter=CHAR}, "starter", "reacter"),
		"DIFTalkingDIFInit3": form("So ... you got a moment for me?", {starter=CHAR, reacter=CHAR}, "starter", "reacter"),
		"DIFTalkingDIFInit4": form("Wait a moment.", {starter=CHAR, reacter=CHAR}, "starter", "reacter"),
		"DIFTalkingDIFInit5": form("Got a minute to spare?", {starter=CHAR, reacter=CHAR}, "starter", "reacter"),
		"DIFTalkingDIFInit6": form("I figured we should catch up for a bit.", {starter=CHAR, reacter=CHAR}, "starter", "reacter"),
		"DIFTalkingDIFInit7": form("I thought now might be a good time.", {starter=CHAR, reacter=CHAR}, "starter", "reacter"),
	}
