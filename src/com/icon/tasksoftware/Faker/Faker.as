package com.icon.tasksoftware.Faker
{
	import com.icon.tasksoftware.Faker.blueprints.OrganizationBlueprint;
	import com.icon.tasksoftware.Faker.blueprints.RoleBlueprint;
	import com.icon.tasksoftware.Faker.blueprints.TaskBlueprint;
	import com.icon.tasksoftware.Faker.blueprints.TeamBlueprint;
	import com.icon.tasksoftware.Faker.blueprints.UserBlueprint;
	import com.icon.tasksoftware.data.WebServiceEndpoints;
	import com.icon.tasksoftware.data.WebServiceRequest;
	import com.icon.tasksoftware.data.models.Organization;
	import com.icon.tasksoftware.data.models.Role;
	import com.icon.tasksoftware.data.models.Task;
	import com.icon.tasksoftware.data.models.Team;
	import com.icon.tasksoftware.data.models.User;

	public class Faker
	{
		private var _noun:Vector.<String> = Vector.<String>(["account", "achiever", "acoustics", "act", "action", "activity", "actor", "addition", "adjustment", "advertisement", "advice", "aftermath", "afternoon", "afterthought", "agreement", "air", "airplane", "airport", "alarm", "amount", "amusement", "anger", "angle", "animal", "answer", "ant", "ants", "apparatus", "apparel", "apple", "apples", "appliance", "approval", "arch", "argument", "arithmetic", "arm", "army", "art", "attack", "attempt", "attention", "attraction", "aunt", "authority", "babies", "baby", "back", "badge", "bag", "bait", "balance", "ball", "balloon", "balls", "banana", "band", "base", "baseball", "basin", "basket", "basketball", "bat", "bath", "battle", "bead", "beam", "bean", "bear", "bears", "beast", "bed", "bedroom", "beds", "bee", "beef", "beetle", "beggar", "beginner", "behavior", "belief", "believe", "bell", "bells", "berry", "bike", "bikes", "bird", "birds", "birth", "birthday", "bit", "bite", "blade", "blood", "blow", "board", "boat", "boats", "body", "bomb", "bone", "book", "books", "boot", "border", "bottle", "boundary", "box", "boy", "boys", "brain", "brake", "branch", "brass", "bread", "breakfast", "breath", "brick", "bridge", "brother", "brothers", "brush", "bubble", "bucket", "building", "bulb", "bun", "burn", "burst", "bushes", "business", "butter", "button", "cabbage", "cable", "cactus", "cake", "cakes", "calculator", "calendar", "camera", "camp", "can", "cannon", "canvas", "cap", "caption", "car", "card", "care", "carpenter", "carriage", "cars", "cart", "cast", "cat", "cats", "cattle", "cause", "cave", "celery", "cellar", "cemetery", "cent", "chain", "chair", "chairs", "chalk", "chance", "change", "channel", "cheese", "cherries", "cherry", "chess", "chicken", "chickens", "children", "chin", "church", "circle", "clam", "class", "clock", "clocks", "cloth", "cloud", "clouds", "clover", "club", "coach", "coal", "coast", "coat", "cobweb", "coil", "collar", "color", "comb", "comfort", "committee", "company", "comparison", "competition", "condition", "connection", "control", "cook", "copper", "copy", "cord", "cork", "corn", "cough", "country", "cover", "cow", "cows", "crack", "cracker", "crate", "crayon", "cream", "creator", "creature", "credit", "crib", "crime", "crook", "crow", "crowd", "crown", "crush", "cry", "cub", "cup", "current", "curtain", "curve", "cushion", "dad", "daughter", "day", "death", "debt", "decision", "deer", "degree", "design", "desire", "desk", "destruction", "detail", "development", "digestion", "dime", "dinner", "dinosaurs", "direction", "dirt", "discovery", "discussion", "disease", "disgust", "distance", "distribution", "division", "dock", "doctor", "dog", "dogs", "doll", "dolls", "donkey", "door", "downtown", "drain", "drawer", "dress", "drink", "driving", "drop", "drug", "drum", "duck", "ducks", "dust", "ear", "earth", "earthquake", "edge", "education", "effect", "egg", "eggnog", "eggs", "elbow", "end", "engine", "error", "event", "example", "exchange", "existence", "expansion", "experience", "expert", "eye", "eyes", "face", "fact", "fairies", "fall", "family", "fan", "fang", "farm", "farmer", "father", "father", "faucet", "fear", "feast", "feather", "feeling", "feet", "fiction", "field", "fifth", "fight", "finger", "finger", "fire", "fireman", "fish", "flag", "flame", "flavor", "flesh", "flight", "flock", "floor", "flower", "flowers", "fly", "fog", "fold", "food", "foot", "force", "fork", "form", "fowl", "frame", "friction", "friend", "friends", "frog", "frogs", "front", "fruit", "fuel", "furniture", "alley", "game", "garden", "gate", "geese", "ghost", "giants", "giraffe", "girl", "girls", "glass", "glove", "glue", "goat", "gold", "goldfish", "good-bye", "goose", "government", "governor", "grade", "grain", "grandfather", "grandmother", "grape", "grass", "grip", "ground", "group", "growth", "guide", "guitar", "gun", "hair", "haircut", "hall", "hammer", "hand", "hands", "harbor", "harmony", "hat", "hate", "head", "health", "hearing", "heart", "heat", "help", "hen", "hill", "history", "hobbies", "hole", "holiday", "home", "honey", "hook", "hope", "horn", "horse", "horses", "hose", "hospital", "hot", "hour", "house", "houses", "humor", "hydrant", "ice", "icicle", "idea", "impulse", "income", "increase", "industry", "ink", "insect", "instrument", "insurance", "interest", "invention", "iron", "island", "jail", "jam", "jar", "jeans", "jelly", "jellyfish", "jewel", "join", "joke", "journey", "judge", "juice", "jump", "kettle", "key", "kick", "kiss", "kite", "kitten", "kittens", "kitty", "knee", "knife", "knot", "knowledge", "laborer", "lace", "ladybug", "lake", "lamp", "land", "language", "laugh", "lawyer", "lead", "leaf", "learning", "leather", "leg", "legs", "letter", "letters", "lettuce", "level", "library", "lift", "light", "limit", "line", "linen", "lip", "liquid", "list", "lizards", "loaf", "lock", "locket", "look", "loss", "love", "low", "lumber", "lunch", "lunchroom", "machine", "magic", "maid", "mailbox", "man", "manager", "map", "marble", "mark", "market", "mask", "mass", "match", "meal", "measure", "meat", "meeting", "memory", "men", "metal", "mice", "middle", "milk", "mind", "mine", "minister", "mint", "minute", "mist", "mitten", "mom", "money", "monkey", "month", "moon", "morning", "mother", "motion", "mountain", "mouth", "move", "muscle", "music", "nail", "name", "nation", "neck", "need", "needle", "nerve", "nest", "net", "news", "night", "noise", "north", "nose", "note", "notebook", "number", "nut", "oatmeal", "observation", "ocean", "offer", "office", "oil", "operation", "opinion", "orange", "oranges", "order", "organization", "ornament", "oven", "owl", "owner", "page", "pail", "pain", "paint", "pan", "pancake", "paper", "parcel", "parent", "park", "part", "partner", "party", "passenger", "paste", "patch", "payment", "peace", "pear", "pen", "pencil", "person", "pest", "pet", "pets", "pickle", "picture", "pie", "pies", "pig", "pigs", "pin", "pipe", "pizzas", "place", "plane", "planes", "plant", "plantation", "plants", "plastic", "plate", "play", "playground", "pleasure", "plot", "plough", "pocket", "point", "poison", "police", "polish", "pollution", "popcorn", "porter", "position", "pot", "potato", "powder", "power", "price", "print", "prison", "process", "produce", "profit", "property", "prose", "protest", "pull", "pump", "punishment", "purpose", "push", "quarter", "quartz", "queen", "question", "quicksand", "quiet", "quill", "quilt", "quince", "quiver ", "rabbit", "rabbits", "rail", "railway", "rain", "rainstorm", "rake", "range", "rat", "rate", "ray", "reaction", "reading", "reason", "receipt", "recess", "record", "regret", "relation", "religion", "representative", "request", "respect", "rest", "reward", "rhythm", "rice", "riddle", "rifle", "ring", "rings", "river", "road", "robin", "rock", "rod", "roll", "roof", "room", "root", "rose", "route", "rub", "rule", "run", "sack", "sail", "salt", "sand", "scale", "scarecrow", "scarf", "scene", "scent", "school", "science", "scissors", "screw", "sea", "seashore", "seat", "secretary", "seed", "selection", "self", "sense", "servant", "shade", "shake", "shame", "shape", "sheep", "sheet", "shelf", "ship", "shirt", "shock", "shoe", "shoes", "shop", "show", "side", "sidewalk", "sign", "silk", "silver", "sink", "sister", "sisters", "size", "skate", "skin", "skirt", "sky", "slave", "sleep", "sleet", "slip", "slope", "smash", "smell", "smile", "smoke", "snail", "snails", "snake", "snakes", "sneeze", "snow", "soap", "society", "sock", "soda", "sofa", "son", "song", "songs", "sort", "sound", "soup", "space", "spade", "spark", "spiders", "sponge", "spoon", "spot", "spring", "spy", "square", "squirrel", "stage", "stamp", "star", "start", "statement", "station", "steam", "steel", "stem", "step", "stew", "stick", "sticks", "stitch", "stocking", "stomach", "stone", "stop", "store", "story", "stove", "stranger", "straw", "stream", "street", "stretch", "string", "structure", "substance", "sugar", "suggestion", "suit", "summer", "sun", "support", "surprise", "sweater", "swim", "swing", "system", "table", "tail", "talk", "tank", "taste", "tax", "teaching", "team", "teeth", "temper", "tendency", "tent", "territory", "test", "texture", "theory", "thing", "things", "thought", "thread", "thrill", "throat", "throne", "thumb", "thunder", "ticket", "tiger", "time", "tin", "title", "toad", "toe", "toes", "tomatoes", "tongue", "tooth", "toothbrush", "toothpaste", "top", "touch", "town", "toy", "toys", "trade", "trail", "train", "trains", "tramp", "transport", "tray", "treatment", "tree", "trees", "trick", "trip", "trouble", "trousers", "truck", "trucks", "tub", "turkey", "turn", "twig", "twist", "umbrella", "uncle", "underwear", "unit", "use", "vacation", "value", "van", "vase", "vegetable", "veil", "vein", "verse", "vessel", "vest", "view", "visitor", "voice", "volcano", "volleyball", "voyage", "walk", "wall", "war", "wash", "waste", "watch", "water", "wave", "waves", "wax", "way", "wealth", "weather", "week", "weight", "wheel", "whip", "whistle", "wilderness", "wind", "window", "wine", "wing", "winter", "wire", "wish", "woman", "women", "wood", "wool", "word", "work", "worm", "wound", "wren", "wrench", "wrist", "writer", "writing", "yak", "yam", "yard", "yarn", "year", "yoke", "zebra", "zephyr", "zinc", "zipper", "zoo"]);
		private var _prefix:Vector.<String> = Vector.<String>(["a", "an", "the", "my", "your", "our"]);
		private var _adjective:Vector.<String> = Vector.<String>(["adorable", "beautiful", "clean", "drab", "elegant", "fancy", "glamorous", "handsome", "long", "magnificent", "old-fashioned", "plain", "quaint", "sparkling", "ugliest", "unsightly", "wide-eyed", "red", "orange", "yellow", "green", "blue", "purple", "gray", "black", "white", "alive", "better", "careful", "clever", "dead", "easy", "famous", "gifted", "helpful", "important", "inexpensive", "mushy", "odd", "powerful", "rich", "shy", "tender", "uninterested", "vast", "wrong", "angry", "bewildered", "clumsy", "defeated", "embarrassed", "fierce", "grumpy", "helpless", "itchy", "jealous", "lazy", "mysterious", "nervous", "obnoxious", "panicky", "repulsive", "scary", "thoughtless", "uptight", "worried", "agreeable", "brave", "calm", "delightful", "eager", "faithful", "gentle", "happy", "jolly", "kind", "lively", "nice", "obedient", "proud", "relieved", "silly", "thankful", "victorious", "witty", "zealous", "broad", "chubby", "crooked", "curved", "deep", "flat", "high", "hollow", "low", "narrow", "round", "shallow", "skinny", "square", "steep", "straight", "wide", "big", "colossal", "fat", "gigantic", "great", "huge", "immense", "large", "little", "mammoth", "massive", "miniature", "petite", "puny", "scrawny", "short", "small", "tall", "teeny", "teeny-tiny", "tiny", "cooing", "deafening", "faint", "hissing", "loud", "melodic", "noisy", "purring", "quiet", "raspy", "screeching", "thundering", "voiceless", "whispering", "ancient", "brief", "early", "fast", "late", "long", "modern", "old", "old-fashioned", "quick", "rapid", "short", "slow", "swift", "young", "bitter", "delicious", "fresh", "greasy", "juicy", "hot", "icy", "loose", "melted", "nutritious", "prickly", "rainy", "rotten", "salty", "sticky", "strong", "sweet", "tart", "tasteless", "uneven", "weak", "wet", "wooden", "yummy", "boiling", "breeze", "broken", "bumpy", "chilly", "cold", "cool", "creepy", "crooked", "cuddly", "curly", "damaged", "damp", "dirty", "dry", "dusty", "filthy", "flaky", "fluffy", "freezing", "hot", "warm", "wet", "abundant", "empty", "few", "full", "heavy", "light", "many", "numerous", "sparse", "substantial"]);
		private var _verb:Vector.<String> = Vector.<String>(["accept", "add", "admire", "admit", "advise", "afford", "agree", "alert", "allow", "amuse", "analyze", "announce", "annoy", "answer", "apologize", "appear", "applaud", "appreciate", "approve", "argue", "arrange", "arrest", "arrive", "ask", "attach", "attack", "attempt", "attend", "attract", "avoid", "back", "bake", "balance", "ban", "bang", "bare", "bat", "bathe", "battle", "beam", "beg", "behave", "belong", "bleach", "bless", "blind", "blink", "blot", "blush", "boast", "boil", "bolt", "bomb", "book", "bore", "borrow", "bounce", "bow", "box", "brake", "branch", "breathe", "bruise", "brush", "bubble", "bump", "burn", "bury", "buzz", "calculate", "call", "camp", "care", "carry", "carve", "cause", "challenge", "change", "charge", "chase", "cheat", "check", "cheer", "chew", "choke", "chop", "claim", "clap", "clean", "clear", "clip", "close", "coach", "coil", "collect", "color", "comb", "command", "communicate", "compare", "compete", "complain", "complete", "concentrate", "concern", "confess", "confuse", "connect", "consider", "consist", "contain", "continue", "copy", "correct", "cough", "count", "cover", "crack", "crash", "crawl", "cross", "crush", "cry", "cure", "curl", "curve", "cycle", "dam", "damage", "dance", "dare", "decay", "deceive", "decide", "decorate", "delay", "delight", "deliver", "depend", "describe", "desert", "deserve", "destroy", "detect", "develop", "disagree", "disappear", "disapprove", "disarm", "discover", "dislike", "divide", "double", "doubt", "drag", "drain", "dream", "dress", "drip", "drop", "drown", "drum", "dry", "duet", "earn", "educate", "embarrass", "employ", "empty", "encourage", "end", "enjoy", "enter", "entertain", "escape", "examine", "excite", "excuse", "exercise", "exist", "expand", "expect", "explain", "explode", "extend", "face", "fade", "fail", "fancy", "fasten", "fax", "fear", "fence", "fetch", "file", "fill", "film", "fire", "fit", "fix", "flap", "flash", "float", "flood", "flow", "flower", "fold", "follow", "fool", "force", "form", "found", "frame", "frighten", "fry", "gather", "gaze", "glow", "glue", "grab", "grate", "grease", "greet", "grin", "grip", "groan", "guarantee", "guard", "guess", "guide", "hammer", "hand", "handle", "hang", "happen", "harass", "harm", "hate", "haunt", "head", "heal", "heap", "heat", "help", "hook", "hop", "hope", "hover", "hug", "hum", "hunt", "hurry", "identify", "ignore", "imagine", "impress", "improve", "include", "increase", "influence", "inform", "inject", "injure", "instruct", "intend", "interest", "interfere", "interrupt", "introduce", "invent", "invite", "irritate", "itch", "jail", "jam", "jog", "join", "joke", "judge", "juggle", "jump", "kick", "kill", "kiss", "kneel", "knit", "knock", "knot", "label", "land", "last", "laugh", "launch", "learn", "level", "license", "lick", "lie", "lighten", "like", "list", "listen", "live", "load", "lock", "long", "look", "love", "man", "manage", "march", "mark", "marry", "match", "mate", "matter", "measure", "meddle", "melt", "memorize", "mend", "mess up", "milk", "mine", "miss", "mix", "moan", "moor", "mourn", "move", "muddle", "mug", "multiply", "murder", "nail", "name", "need", "nest", "nod", "note", "notice", "number", "obey", "object", "observe", "obtain", "occur", "offend", "offer", "open", "order", "overflow", "owe", "own", "pack", "paddle", "paint", "park", "part", "pass", "paste", "pat", "pause", "peck", "pedal", "peel", "peep", "perform", "permit", "phone", "pick", "pinch", "pine", "place", "plan", "plant", "play", "please", "plug", "point", "poke", "polish", "pop", "possess", "post", "pour", "practice", "pray", "preach", "precede", "prefer", "prepare", "present", "preserve", "press", "pretend", "prevent", "prick", "print", "produce", "program", "promise", "protect", "provide", "pull", "pump", "punch", "puncture", "punish", "push", "question", "queue", "race", "radiate", "rain", "raise", "reach", "realize", "receive", "recognize", "record", "reduce", "reflect", "refuse", "regret", "reign", "reject", "rejoice", "relax", "release", "rely", "remain", "remember", "remind", "remove", "repair", "repeat", "replace", "reply", "report", "reproduce", "request", "rescue", "retire", "return", "rhyme", "rinse", "risk", "rob", "rock", "roll", "rot", "rub", "ruin", "rule", "rush", "sack", "sail", "satisfy", "save", "saw", "scare", "scatter", "scold", "scorch", "scrape", "scratch", "scream", "screw", "scribble", "scrub", "seal", "search", "separate", "serve", "settle", "shade", "share", "shave", "shelter", "shiver", "shock", "shop", "shrug", "sigh", "sign", "signal", "sin", "sip", "ski", "skip", "slap", "slip", "slow", "smash", "smell", "smile", "smoke", "snatch", "sneeze", "sniff", "snore", "snow", "soak", "soothe", "sound", "spare", "spark", "sparkle", "spell", "spill", "spoil", "spot", "spray", "sprout", "squash", "squeak", "squeal", "squeeze", "stain", "stamp", "stare", "start", "stay", "steer", "step", "stir", "stitch", "stop", "store", "strap", "strengthen", "stretch", "strip", "stroke", "stuff", "subtract", "succeed", "suck", "suffer", "suggest", "suit", "supply", "support", "suppose", "surprise", "surround", "suspect", "suspend", "switch", "talk", "tame", "tap", "taste", "tease", "telephone", "tempt", "terrify", "test", "thank", "thaw", "tick", "tickle", "tie", "time", "tip", "tire", "touch", "tour", "tow", "trace", "trade", "train", "transport", "trap", "travel", "treat", "tremble", "trick", "trip", "trot", "trouble", "trust", "try", "tug", "tumble", "turn", "twist", "type", "undress", "unfasten", "unite", "unlock", "unpack", "untidy", "use", "vanish", "visit", "wail", "wait", "walk", "wander", "want", "warm", "warn", "wash", "waste", "watch", "water", "wave", "weigh", "welcome", "whine", "whip", "whirl", "whisper", "whistle", "wink", "wipe", "wish", "wobble", "wonder", "work", "worry", "wrap", "wreck", "wrestle", "wriggle", "yawn", "yell", "zip", "zoom"]);
		private var _letter:Vector.<String> = Vector.<String>(["a", "b", "c", "d", "e", "f", "g", "h", "i", "j", "k", "l", "m", "n", "o", "p", "q", "r", "s", "t", "u", "v", "w", "x", "y", "z"]);
		private var _company_name_suffix:Vector.<String> = Vector.<String>([", LLC", " Corporation", ", Inc.", " Company", " Limited", ", Limited Liability Company", " Corp.", " Co.", " Ltd.", ", L.L.C."]);
		private var _user_first_name:Vector.<String> = Vector.<String>(["Sophia", "Emma", "Olivia", "Isabella", "Ava", "Lily", "Zoe", "Chloe", "Mia", "Madison", "Emily", "Ella", "Madelyn", "Abigail", "Aubrey", "Addison", "Avery", "Layla", "Hailey", "Amelia", "Hannah", "Charlotte", "Kaitlyn", "Harper", "Kaylee", "Sophie", "Mackenzie", "Peyton", "Riley", "Grace", "Brooklyn", "Sarah", "Aaliyah", "Anna", "Arianna", "Ellie", "Natalie", "Isabelle", "Lillian", "Evelyn", "Elizabeth", "Lyla", "Lucy", "Claire", "Makayla", "Kylie", "Audrey", "Maya", "Leah", "Gabriella", "Annabelle", "Savannah", "Nora", "Reagan", "Scarlett", "Samantha", "Alyssa", "Allison", "Elena", "Stella", "Alexis", "Victoria", "Aria", "Molly", "Maria", "Bailey", "Sydney", "Bella", "Mila", "Taylor", "Kayla", "Eva", "Jasmine", "Gianna", "Alexandra", "Julia", "Eliana", "Kennedy", "Brianna", "Ruby", "Lauren", "Alice", "Violet", "Kendall", "Morgan", "Caroline", "Piper", "Brooke", "Elise", "Alexa", "Sienna", "Reese", "Clara", "Paige", "Kate", "Nevaeh", "Sadie", "Quinn", "Isla", "Eleanor", "Aiden", "Jackson", "Ethan", "Liam", "Mason", "Noah", "Lucas", "Jacob", "Jayden", "Jack", "Logan", "Ryan", "Caleb", "Benjamin", "William", "Michael", "Alexander", "Elijah", "Matthew", "Dylan", "James", "Owen", "Connor", "Brayden", "Carter", "Landon", "Joshua", "Luke", "Daniel", "Gabriel", "Nicholas", "Nathan", "Oliver", "Henry", "Andrew", "Gavin", "Cameron", "Eli", "Max", "Isaac", "Evan", "Samuel", "Grayson", "Tyler", "Zachary", "Wyatt", "Joseph", "Charlie", "Hunter", "David", "Anthony", "Christian", "Colton", "Thomas", "Dominic", "Austin", "John", "Sebastian", "Cooper", "Levi", "Parker", "Isaiah", "Chase", "Blake", "Aaron", "Alex", "Adam", "Tristan", "Julian", "Jonathan", "Christopher", "Jace", "Nolan", "Miles", "Jordan", "Carson", "Colin", "Ian", "Riley", "Xavier", "Hudson", "Adrian", "Cole", "Brody", "Leo", "Jake", "Bentley", "Sean", "Jeremiah", "Asher", "Nathaniel", "Micah", "Jason", "Ryder", "Declan", "Hayden", "Brandon", "Easton", "Lincoln", "Harrison"]);
		private var _user_last_name:Vector.<String> = Vector.<String>(["Smith", "Johnson", "Williams", "Brown", "Jones", "Miller", "Davis", "García", "Rodríguez", "Wilson", "Martínez", "Anderson", "Taylor", "Thomas", "Hernández", "Moore", "Martin", "Jackson", "Thompson", "White", "López", "Lee", "González", "Harris", "Clark", "Lewis", "Robinson", "Walker", "Pérez", "Hall", "Young", "Allen", "Sánchez", "Wright", "King", "Scott", "Green", "Baker", "Adams", "Nelson", "Hill", "Ramírez", "Campbell", "Mitchell", "Roberts", "Carter", "Phillips", "Evans", "Turner", "Torres", "Parker", "Collins", "Edwards", "Stewart", "Flores", "Morris", "Nguyen", "Murphy", "Rivera", "Cook", "Rogers", "Morgan", "Peterson", "Cooper", "Reed", "Bailey", "Bell", "Gómez", "Kelly", "Howard", "Ward", "Cox", "Díaz", "Richardson", "Wood", "Watson", "Brooks", "Bennett", "Gray", "James", "Reyes", "Cruz", "Hughes", "Price", "Myers", "Long", "Foster", "Sanders", "Ross", "Morales", "Powell", "Sullivan", "Russell", "Ortiz", "Jenkins", "Gutiérrez", "Perry", "Butler", "Barnes", "Fisher"]);
		private var _user_name_suffix:Vector.<String> = Vector.<String>(["Jr.", "Sr.", "III"]);
		private var _user_email_extension:Vector.<String> = Vector.<String>(["yahoo.com", "hotmail.com", "aol.com", "gmail.com", "msn.com", "comcast.net", "hotmail.co.uk", "sbcglobal.net", "yahoo.co.uk", "yahoo.co.in", "bellsouth.net", "verizon.net", "earthlink.net", "cox.net",  "btinternet.com", "charter.net", "ntlworld.com"]);
		private var _lorem_sentence:Vector.<String> = Vector.<String>(["Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.", "Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.", "Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur.", "Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.", "Sed ut perspiciatis unde omnis iste natus error sit voluptatem accusantium doloremque laudantium, totam rem aperiam, eaque ipsa quae ab illo inventore veritatis et quasi architecto beatae vitae dicta sunt explicabo.", "Nemo enim ipsam voluptatem quia voluptas sit aspernatur aut odit aut fugit, sed quia consequuntur magni dolores eos qui ratione voluptatem sequi nesciunt.", "Neque porro quisquam est, qui dolorem ipsum quia dolor sit amet, consectetur, adipisci velit, sed quia non numquam eius modi tempora incidunt ut labore et dolore magnam aliquam quaerat voluptatem.", "Ut enim ad minima veniam, quis nostrum exercitationem ullam corporis suscipit laboriosam, nisi ut aliquid ex ea commodi consequatur?", "Quis autem vel eum iure reprehenderit qui in ea voluptate velit esse quam nihil molestiae consequatur, vel illum qui dolorem eum fugiat quo voluptas nulla pariatur?", "At vero eos et accusamus et iusto odio dignissimos ducimus qui blanditiis praesentium voluptatum deleniti atque corrupti quos dolores et quas molestias excepturi sint occaecati cupiditate non provident, similique sunt in culpa qui officia deserunt mollitia animi, id est laborum et dolorum fuga.", "Et harum quidem rerum facilis est et expedita distinctio.", "Nam libero tempore, cum soluta nobis est eligendi optio cumque nihil impedit quo minus id quod maxime placeat facere possimus, omnis voluptas assumenda est, omnis dolor repellendus.", "Temporibus autem quibusdam et aut officiis debitis aut rerum necessitatibus saepe eveniet ut et voluptates repudiandae sint et molestiae non recusandae.", "Itaque earum rerum hic tenetur a sapiente delectus, ut aut reiciendis voluptatibus maiores alias consequatur aut perferendis doloribus asperiores repellat."]);
		
		public function Faker(input:Class = null)
		{
			if(input == SingletonLock)
			{
				super();
			}
		}
		
		private static var _instance:Faker;
		public static function get instance():Faker
		{
			if(!_instance)
			{
				_instance = new Faker(SingletonLock)
			}
			
			return _instance;
		}
		
		public function GenerateResponse(request:WebServiceRequest):Object
		{
			var output:Object = null;
			
			switch(request.endpoint)
			{
				case WebServiceEndpoints.ORGANIZATION_CREATE:
					output = (request.data && request.data is Organization) ? request.data : OrganizationBlueprint.generate();
					break;
				case WebServiceEndpoints.ORGANIZATION_READ:
					output = (request.data && request.data is Organization) ? request.data : OrganizationBlueprint.generate();
					break;
				case WebServiceEndpoints.ORGANIZATION_UPDATE:
					output = (request.data && request.data is Organization) ? request.data : OrganizationBlueprint.generate();
					break;
				case WebServiceEndpoints.ORGANIZATION_DESTROY:
					output = (request.data && request.data is Organization) ? request.data : OrganizationBlueprint.generate();
					break;
				case WebServiceEndpoints.ORGANIZATION_INDEX:
					output = OrganizationBlueprint.generate(4 + Math.floor(Math.random() * 16));
					break;
				
				case WebServiceEndpoints.ROLE_CREATE:
					output = (request.data && request.data is Role) ? request.data : RoleBlueprint.generate();
					break;
				case WebServiceEndpoints.ROLE_READ:
					output = (request.data && request.data is Role) ? request.data : RoleBlueprint.generate();
					break;
				case WebServiceEndpoints.ROLE_UPDATE:
					output = (request.data && request.data is Role) ? request.data : RoleBlueprint.generate();
					break;
				case WebServiceEndpoints.ROLE_DESTROY:
					output = (request.data && request.data is Role) ? request.data : RoleBlueprint.generate();
					break;
				case WebServiceEndpoints.ROLE_INDEX:
					output = RoleBlueprint.generate(4 + Math.floor(Math.random() * 16));
					break;
				
				case WebServiceEndpoints.TASK_CREATE:
					output = (request.data && request.data is Task) ? request.data : TaskBlueprint.generate();
					break;
				case WebServiceEndpoints.TASK_READ:
					output = (request.data && request.data is Task) ? request.data : TaskBlueprint.generate();
					break;
				case WebServiceEndpoints.TASK_UPDATE:
					output = (request.data && request.data is Task) ? request.data : TaskBlueprint.generate();
					break;
				case WebServiceEndpoints.TASK_DESTROY:
					output = (request.data && request.data is Task) ? request.data : TaskBlueprint.generate();
					break;
				case WebServiceEndpoints.TASK_INDEX:
					output = TaskBlueprint.generate(4 + Math.floor(Math.random() * 16));
					break;
				
				case WebServiceEndpoints.TEAM_CREATE:
					output = (request.data && request.data is Team) ? request.data : TeamBlueprint.generate();
					break;
				case WebServiceEndpoints.TEAM_READ:
					output = (request.data && request.data is Team) ? request.data : TeamBlueprint.generate();
					break;
				case WebServiceEndpoints.TEAM_UPDATE:
					output = (request.data && request.data is Team) ? request.data : TeamBlueprint.generate();
					break;
				case WebServiceEndpoints.TEAM_DESTROY:
					output = (request.data && request.data is Team) ? request.data : TeamBlueprint.generate();
					break;
				case WebServiceEndpoints.TEAM_INDEX:
					output = TeamBlueprint.generate(4 + Math.floor(Math.random() * 16));
					break;
				
				case WebServiceEndpoints.USER_CREATE:
					output = (request.data && request.data is User) ? request.data : UserBlueprint.generate();
					break;
				case WebServiceEndpoints.USER_READ:
					output = (request.data && request.data is User) ? request.data : UserBlueprint.generate();
					break;
				case WebServiceEndpoints.USER_UPDATE:
					output = (request.data && request.data is User) ? request.data : UserBlueprint.generate();
					break;
				case WebServiceEndpoints.USER_DESTROY:
					output = (request.data && request.data is User) ? request.data : UserBlueprint.generate();
					break;
				case WebServiceEndpoints.USER_INDEX:
					output = UserBlueprint.generate(4 + Math.floor(Math.random() * 16));
					break;
			}
			
			return output;
		}
		
		private function capitalize(input:String):String
		{
			return input.substr(0, 1).toUpperCase() + input.substr(1, input.length - 1);
		}
		
		public function get noun():String
		{
			return capitalize(_noun[Math.floor(Math.random() * _noun.length)]);
		}
		
		public function get prefix():String
		{
			return capitalize(_prefix[Math.floor(Math.random() * _prefix.length)]);
		}
		
		public function get adjective():String
		{
			return capitalize(_adjective[Math.floor(Math.random() * _adjective.length)]);
		}
		
		public function get verb():String
		{
			return capitalize(_verb[Math.floor(Math.random() * _verb.length)]);
		}
		
		public function get letter():String
		{
			return capitalize(_letter[Math.floor(Math.random() * _letter.length)]);
		}
		
		public function get company_name_suffix():String
		{
			return _company_name_suffix[Math.floor(Math.random() * _company_name_suffix.length)];
		}
		
		public function get user_first_name():String
		{
			return capitalize(_user_first_name[Math.floor(Math.random() * _user_first_name.length)]);
		}
		
		public function get user_last_name():String
		{
			return capitalize(_user_last_name[Math.floor(Math.random() * _user_last_name.length)]);
		}
		
		public function get user_name_suffix():String
		{
			return capitalize(_user_name_suffix[Math.floor(Math.random() * _user_name_suffix.length)]);
		}
		
		public function get user_email_extension():String
		{
			return _user_email_extension[Math.floor(Math.random() * _user_email_extension.length)];
		}
		
		public function get lorem_sentence():String
		{
			return _lorem_sentence[Math.floor(Math.random() * _lorem_sentence.length)];
		}
		
		public function get lorem_paragraph():String
		{
			var sentences:uint = 2 + Math.floor(Math.random() * 4);
			var output:String = "";
			
			for(var i:int = 0; i < sentences; i++)
			{
				output += _lorem_sentence[Math.floor(Math.random() * _lorem_sentence.length)];
			}
			
			return output;
		}
		
		public function GenerateID():String
		{
			return Math.floor(Math.random() * 9999).toString();
		}
		
		public function GenerateCompanyName():String
		{
			var output:String = "";
			var random:Number = Math.random();
			
			if(random < 0.25)
			{
				output = noun + company_name_suffix;
			}
			else if(random < 0.5)
			{
				output = adjective + " "  + noun + company_name_suffix;
			}
			else if(random < 0.75)
			{
				output = noun + " " + noun + company_name_suffix;
			}
			else
			{
				output = letter + letter + letter + company_name_suffix;
			}
			
			return output;
		}
		
		public function GenerateTeamName():String
		{
			var output:String = "";
			var random:Number = Math.random();
			
			if(random < 0.25)
			{
				output = noun;
			}
			else if(random < 0.5)
			{
				output = adjective + " "  + noun;
			}
			else if(random < 0.75)
			{
				output = noun + " " + noun;
			}
			else
			{
				output = letter + letter + letter;
			}
			
			return output;
		}
		
		public function GenerateUserName():String
		{
			var output:String = "";
			var random:Number = Math.random();
			
			if(random < 0.50)
			{
				output = user_first_name + " " + user_last_name;
			}
			else if(random < 0.75)
			{
				output = capitalize(letter) + ". " + user_first_name + " " + user_last_name;
			}
			else
			{
				output = user_first_name + " " + capitalize(letter) + ". " + user_last_name;
			}
			
			if(Math.random() < 0.1) output = output + " " + user_name_suffix;
			
			return output;
		}
		
		public function GenerateUserEmail(name:String = null):String
		{
			var output:String = "";
			var random:Number = Math.random();
			
			if(random < 0.4 && name)
			{
				output = name.split(" ").join("").split(".").join("").toLowerCase() + "@" + user_email_extension;
			}
			else if(random < 0.6 && name)
			{
				output = name.split(".").join("").split(" ").join(".").toLowerCase() + "@" + user_email_extension;
			}
			else if(random < 0.8 && name)
			{
				var names:Array = name.toLowerCase().split(".").join("").split(" ");
				if(names.length == 2)
				{
					output = String(names[0]) + Math.floor(Math.random() * 100).toString() + "@" + user_email_extension;
				}
				else
				{
					if(String(names[0]).length == 1)
					{
						output = String(names[1]) + Math.floor(Math.random() * 100).toString() + "@" + user_email_extension;
					}
					else
					{
						output = String(names[0]) + Math.floor(Math.random() * 100).toString() + "@" + user_email_extension;
					}
				}
			}
			else if(random < 0.9)
			{
				output = adjective + noun + "@" + user_email_extension;
			}
			else
			{
				output = noun + Math.floor(Math.random() * 9999).toString() + "@" + user_email_extension;
			}
			
			return output;
		}
		
		public function GenerateTaskName():String
		{
			return verb + " " + noun;
		}
		
		public function GenerateRoleName():String
		{
			var output:String = "";
			var random:Number = Math.random();
			
			if(random < 0.5)
			{
				output = adjective + " " + noun;
			}
			else
			{
				output = noun;
			}
			
			return output;
		}
	}
}

internal class SingletonLock{}