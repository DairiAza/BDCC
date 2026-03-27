extends DialogueFormBank

func getForms() -> Dictionary:
	return {
		"DIFTalkingInit1": form("Hey, got a moment?", {reacter=CHAR, starter=CHAR}, "starter", "reacter"),		
		"DIFTalkingInit2": form("Hey there.", {reacter=CHAR, starter=CHAR}, "starter", "reacter"),
		"DIFTalkingInit3": form("Oh... hey.", {reacter=CHAR, starter=CHAR}, "starter", "reacter"),
		"DIFTalkingInit4": form("Hey, I was looking to run into you!", {reacter=CHAR, starter=CHAR}, "starter", "reacter"),
		"DIFTalkingInit5": form("Oh, there you are.", {reacter=CHAR, starter=CHAR}, "starter", "reacter"),
		"DIFTalkingInit6": form("Hey, I wanted to talk to you for a moment.", {reacter=CHAR, starter=CHAR}, "starter", "reacter"),
		"DIFTalkingInit7": form("Hey, I was hoping to run into you.", {reacter=CHAR, starter=CHAR}, "starter", "reacter"),

		"DIFTalkingDIFInit1": form("I thought I'd check in.", {starter=CHAR, reacter=CHAR}, "starter", "reacter"),
		"DIFTalkingDIFInit2": form("Just wanted to say hi.", {starter=CHAR, reacter=CHAR}, "starter", "reacter"),
		"DIFTalkingDIFInit3": form("So ... you got a moment for me?", {starter=CHAR, reacter=CHAR}, "starter", "reacter"),
		"DIFTalkingDIFInit4": form("I hope I'm not bothering you.", {starter=CHAR, reacter=CHAR}, "starter", "reacter"),
		"DIFTalkingDIFInit5": form("You got a minute to spare?", {starter=CHAR, reacter=CHAR}, "starter", "reacter"),
		"DIFTalkingDIFInit6": form("I figured we could catch up for a bit.", {starter=CHAR, reacter=CHAR}, "starter", "reacter"),
		"DIFTalkingDIFInit7": form("I thought now might be a good time to talk.", {starter=CHAR, reacter=CHAR}, "starter", "reacter"),
	}
