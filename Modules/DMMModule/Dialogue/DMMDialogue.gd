extends DialogueFormBank

func getForms() -> Dictionary:
	return {
		"DMMTalkingInit1": form("Hey, got a moment?", {reacter=CHAR, starter=CHAR}, "starter", "reacter"),		
		"DMMTalkingInit2": form("Hey there.", {reacter=CHAR, starter=CHAR}, "starter", "reacter"),
		"DMMTalkingInit3": form("Oh... hey.", {reacter=CHAR, starter=CHAR}, "starter", "reacter"),
		"DMMTalkingInit4": form("Hey, I was looking to run into you!", {reacter=CHAR, starter=CHAR}, "starter", "reacter"),

		"DMMTalkingDmmInit1": form("I thought I'd check in.", {starter=CHAR, reacter=CHAR}, "starter", "reacter"),
		"DMMTalkingDmmInit2": form("Just wanted to say hi.", {starter=CHAR, reacter=CHAR}, "starter", "reacter"),
		"DMMTalkingDmmInit3": form("So ... you got a moment for me?", {starter=CHAR, reacter=CHAR}, "starter", "reacter"),
		"DMMTalkingDmmInit4": form("I hope I'm not bothering you.", {starter=CHAR, reacter=CHAR}, "starter", "reacter"),
		"DMMTalkingDmmInit5": form("You got a minute to spare?", {starter=CHAR, reacter=CHAR}, "starter", "reacter"),
	}
