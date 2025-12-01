#!/usr/bin/env bash
set -euo pipefail
script_dir=$(dirname "$(readlink -f "$0")")

EMOJI="$(sed '1,/^### DATA ###$/d' $0 | fuzzel --dmenu --config "$script_dir/fuzzel.conf" | cut -d ' ' -f 1 | tr -d '\n')"
wtype "$EMOJI"; wl-copy "$EMOJI"
exit
### DATA ###
😀 grinning face face smile happy joy :D grin smiley
😃 grinning face with big eyes face happy joy haha :D :) smile funny mouth open smiley smiling
😄 grinning face with smiling eyes face happy joy funny haha laugh like :D :) smile eye grin mouth open pleased smiley
😁 beaming face with smiling eyes face happy smile joy kawaii eye grin grinning
😆 grinning squinting face happy joy lol satisfied haha face glad XD laugh big closed eyes grin laughing mouth open smile smiling tightly
😅 grinning face with sweat face hot happy laugh sweat smile relief cold exercise mouth open smiling
🤣 rolling on the floor laughing face rolling floor laughing lol haha rofl laugh rotfl
😂 face with tears of joy face cry tears weep happy happytears haha crying laugh laughing lol tear
🙂 slightly smiling face face smile fine happy this
🙃 upside down face face flipped silly smile sarcasm
😉 winking face face happy mischievous secret ;) smile eye flirt wink winky
😊 smiling face with smiling eyes face smile happy flushed crush embarrassed shy joy ^^ blush eye proud smiley
😇 smiling face with halo face angel heaven halo innocent fairy fantasy smile tale
🥰 smiling face with hearts face love like affection valentines infatuation crush hearts adore eyes three
😍 smiling face with heart eyes face love like affection valentines infatuation crush heart eye shaped smile
🤩 star struck face smile starry eyes grinning excited eyed wow
😘 face blowing a kiss face love like affection valentines infatuation kiss blow flirt heart kissing throwing
😗 kissing face love like face 3 valentines infatuation kiss duck kissy whistling
☺️ smiling face face blush massage happiness happy outlined pleased relaxed smile smiley white
😚 kissing face with closed eyes face love like affection valentines infatuation kiss eye kissy
😙 kissing face with smiling eyes face affection valentines infatuation kiss eye kissy smile whistle whistling
😋 face savoring food happy joy tongue smile face silly yummy nom delicious savouring goofy hungry lick licking lips smiling um yum
😛 face with tongue face prank childish playful mischievous smile tongue cheeky out stuck
😜 winking face with tongue face prank childish playful mischievous smile wink tongue crazy eye joke out silly stuck
🤪 zany face face goofy crazy excited eye eyes grinning large one small wacky wild
😝 squinting face with tongue face prank playful mischievous smile tongue closed eye eyes horrible out stuck taste tightly
🤑 money mouth face face rich dollar money eyes sign
🤗 hugging face face smile hug hands hugs open smiling
🤭 face with hand over mouth face whoops shock surprise blushing covering eyes quiet smiling
🤫 shushing face face quiet shhh closed covering finger hush lips shh shush silence
🤔 thinking face face hmmm think consider chin shade thinker throwing thumb
🤐 zipper mouth face face sealed zipper secret hush lips silence zip
🤨 face with raised eyebrow face distrust scepticism disapproval disbelief surprise suspicious colbert mild one rock skeptic
😐 neutral face indifference meh :| neutral deadpan faced mouth straight
😑 expressionless face face indifferent - - meh deadpan inexpressive mouth straight unexpressive
😶 face without mouth face blank mouthless mute no quiet silence silent
😏 smirking face face smile mean prank smug sarcasm flirting sexual smirk suggestive
😒 unamused face indifference bored straight face serious sarcasm unimpressed skeptical dubious ugh side eye dissatisfied meh unhappy
🙄 face with rolling eyes face eyeroll frustrated eye roll
😬 grimacing face face grimace teeth #1 best awkward eek foot friend mouth mutual nervous snapchat
🤥 lying face face lie pinocchio liar long nose
😌 relieved face face relaxed phew massage happiness content pleased whew
😔 pensive face face sad depressed upset dejected sadface sorrowful
😪 sleepy face face tired rest nap bubble side sleep snot tear
🤤 drooling face face drool
😴 sleeping face face tired sleepy night zzz sleep snoring
😷 face with medical mask face sick ill disease covid cold coronavirus doctor medicine surgical
🤒 face with thermometer sick temperature thermometer cold fever covid ill
🤕 face with head bandage injured clumsy bandage hurt bandaged injury
🤢 nauseated face face vomit gross green sick throw up ill barf disgust disgusted green face
🤮 face vomiting face sick barf ill mouth open puke spew throwing up vomit
🤧 sneezing face face gesundheit sneeze sick allergy achoo
🥵 hot face face feverish heat red sweating overheated stroke
🥶 cold face face blue freezing frozen frostbite icicles ice
🥴 woozy face face dizzy intoxicated tipsy wavy drunk eyes groggy mouth uneven
😵 dizzy face spent unconscious xox dizzy cross crossed dead eyes knocked out spiral eyes
🤯 exploding head face shocked mind blown blowing explosion mad
🤠 cowboy hat face face cowgirl hat
🥳 partying face face celebration woohoo birthday hat horn party
😎 smiling face with sunglasses face cool smile summer beach sunglass best bright eye eyewear friends glasses mutual snapchat sun weather
🤓 nerd face face nerdy geek dork glasses smiling
🧐 face with monocle face stuffy wealthy rich
😕 confused face face indifference huh weird hmmm :/ meh nonplussed puzzled s
😟 worried face face concern nervous :( sad sadface
🙁 slightly frowning face face frowning disappointed sad upset frown unhappy
☹️ frowning face face sad upset frown megafrown unhappy white
😮 face with open mouth face surprise impressed wow whoa :O surprised sympathy
😯 hushed face face woo shh silence speechless stunned surprise surprised
😲 astonished face face xox surprised poisoned amazed drunk face gasp gasping shocked totally
😳 flushed face face blush shy flattered blushing dazed embarrassed eyes open shame wide
🥺 pleading face face begging mercy cry tears sad grievance eyes glossy puppy simp
😦 frowning face with open mouth face aw what frown yawning
😧 anguished face face stunned nervous pained
😨 fearful face face scared terrified nervous fear oops shocked surprised
😰 anxious face with sweat face nervous sweat blue cold concerned face mouth open rushed
😥 sad but relieved face face phew sweat nervous disappointed eyebrow whew
😢 crying face face tears sad depressed upset :'( cry tear
😭 loudly crying face sobbing face cry tears sad upset depressed bawling sob tear
😱 face screaming in fear face munch scared omg alone fearful home horror scream shocked
😖 confounded face face confused sick unwell oops :S mouth quivering scrunched
😣 persevering face face sick no upset oops eyes helpless persevere scrunched struggling
😞 disappointed face face sad upset depressed :( sadface
😓 downcast face with sweat face hot sad tired exercise cold hard work
😩 weary face face tired sleepy sad frustrated upset distraught wailing
😫 tired face sick whine upset frustrated distraught exhausted fed up
🥱 yawning face tired sleepy bored yawn
😤 face with steam from nose face gas phew proud pride triumph airing frustrated grievances look mad smug steaming won
😡 pouting face angry mad hate despise enraged grumpy pout rage red
😠 angry face mad face annoyed frustrated anger grumpy
🤬 face with symbols on mouth face swearing cursing cussing profanity expletive covering foul grawlix over serious
😈 smiling face with horns devil horns evil fairy fantasy happy imp purple red devil smile tale
👿 angry face with horns devil angry horns demon evil fairy fantasy goblin imp purple sad tale
💀 skull dead skeleton creepy death dead body danger face fairy grey halloween monster poison tale
☠️ skull and crossbones poison danger deadly scary death pirate evil body face halloween monster
💩 pile of poo hankey shitface fail turd shit comic crap dirt dog dung face monster poop smiling
🤡 clown face face
👹 ogre monster red mask halloween scary creepy devil demon japanese ogre creature face fairy fantasy oni tale
👺 goblin red evil mask monster scary creepy japanese goblin creature face fairy fantasy long nose tale tengu
👻 ghost halloween spooky scary creature disappear face fairy fantasy ghoul monster tale
👽 alien UFO paul weird outer space creature et extraterrestrial face fairy fantasy monster tale
👾 alien monster game arcade play creature extraterrestrial face fairy fantasy invader retro space tale ufo video
🤖 robot computer machine bot face monster
😺 grinning cat animal cats happy smile face mouth open smiley smiling
😸 grinning cat with smiling eyes animal cats smile eye face grin happy
😹 cat with tears of joy animal cats haha happy tears face laughing tear
😻 smiling cat with heart eyes animal love like affection cats valentines heart eye face loving cat shaped smile
😼 cat with wry smile animal cats smirk face ironic smirking
😽 kissing cat animal cats kiss closed eye eyes face
🙀 weary cat animal cats munch scared scream face fear horror oh screaming surprised
😿 crying cat animal tears weep sad cats upset cry face sad cat tear
😾 pouting cat animal cats face grumpy
🙈 see no evil monkey monkey animal nature haha blind covering eyes face forbidden gesture ignore mizaru not prohibited
🙉 hear no evil monkey animal monkey nature covering deaf ears face forbidden gesture kikazaru not prohibited
🙊 speak no evil monkey monkey animal nature omg covering face forbidden gesture hush iwazaru mouth mute not no speaking prohibited
💋 kiss mark face lips love like affection valentines heart kissing lipstick romance
💌 love letter email like affection envelope valentines heart mail note romance
💘 heart with arrow love like heart affection valentines cupid lovestruck romance
💝 heart with ribbon love valentines box chocolate chocolates gift valentine
💖 sparkling heart love like affection valentines excited sparkle sparkly stars heart
💗 growing heart like love affection valentines pink excited heartpulse multiple nervous pulse triple
💓 beating heart love like affection valentines pink heart alarm heartbeat pulsating wifi
💞 revolving hearts love like affection valentines heart two
💕 two hearts love like affection valentines heart pink small
💟 heart decoration purple-square love like
❣️ heart exclamation decoration love above an as dot heavy mark ornament punctuation red
💔 broken heart sad sorry break heart heartbreak breaking brokenhearted
❤️ red heart love like valentines black heavy
🧡 orange heart love like affection valentines
💛 yellow heart love like affection valentines bf gold snapchat
💚 green heart love like affection valentines nct
💙 blue heart love like affection valentines brand neutral
💜 purple heart love like affection valentines bts emoji
🤎 brown heart coffee
🖤 black heart evil dark wicked
🤍 white heart pure
💯 hundred points score perfect numbers century exam quiz test pass hundred 100 full keep symbol
💢 anger symbol angry mad comic pop sign vein
💥 collision bomb explode explosion blown bang boom comic impact red spark symbol
💫 dizzy star sparkle shoot magic circle comic symbol
💦 sweat droplets water drip oops comic drops plewds splashing symbol workout
💨 dashing away wind air fast shoo fart smoke puff blow comic dash gust running steam symbol vaping
🕳️ hole embarrassing
💣 bomb boom explode explosion terrorism comic
💬 speech balloon bubble words message talk chatting chat comic comment dialog
👁️‍🗨️ eye in speech bubble info am i witness
🗨️ left speech bubble words message talk chatting dialog
🗯️ right anger bubble caption speech thinking mad angry balloon zag zig
💭 thought balloon bubble cloud speech thinking dream comic
💤 zzz sleepy tired dream bedtime boring comic sign sleep sleeping symbol
👋 waving hand wave hands gesture goodbye solong farewell hello hi palm body sign
🤚 raised back of hand fingers raised backhand body
🖐️ hand with fingers splayed hand fingers palm body finger five raised
✋ raised hand fingers stop highfive palm ban body five high
🖖 vulcan salute hand fingers spock star trek between body finger middle part prosper raised ring split
👌 ok hand fingers limbs perfect ok okay body sign
🤏 pinching hand tiny small size amount body little
✌️ victory hand fingers ohyeah hand peace victory two air body quotes sign v
🤞 crossed fingers good lucky body cross finger hand hopeful index luck middle
🤟 love you gesture hand fingers gesture body i ily sign
🤘 sign of the horns hand fingers evil eye sign of horns rock on body devil finger heavy metal
🤙 call me hand hands gesture shaka body phone sign
👈 backhand index pointing left direction fingers hand left body finger point white
👉 backhand index pointing right fingers hand direction right body finger point white
👆 backhand index pointing up fingers hand direction up body finger middle point white
🖕 middle finger hand fingers rude middle flipping bird body dito extended fu medio middle finger reversed
👇 backhand index pointing down fingers hand direction down body finger point white
☝️ index pointing up hand fingers direction up body finger point secret white
👍 thumbs up thumbsup yes awesome good agree accept cool hand like +1 approve body ok sign thumb
👎 thumbs down thumbsdown no dislike hand -1 bad body bury disapprove sign thumb
✊ raised fist fingers hand grasp body clenched power pump punch
👊 oncoming fist angry violence fist hit attack hand body bro brofist bump clenched closed facepunch fisted punch sign
🤛 left facing fist hand fistbump body bump leftwards
🤜 right facing fist hand fistbump body bump rightwards right fist
👏 clapping hands hands praise applause congrats yay body clap golf hand round sign
🙌 raising hands gesture hooray yea celebration hands air arms banzai body both festivus hallelujah hand miracle person praise raised two
👐 open hands fingers butterfly hands open body hand hug jazz sign
🤲 palms up together hands gesture cupped prayer body dua facing
🤝 handshake agreement shake deal hand hands meeting shaking
🙏 folded hands please hope wish namaste highfive pray thank you thanks appreciate ask body bow five gesture hand high person prayer pressed together
✍️ writing hand lower left ballpoint pen stationery write compose body
💅 nail polish nail care beauty manicure finger fashion nail slay body cosmetics fingers nonchalant
🤳 selfie camera phone arm hand
💪 flexed biceps arm flex hand summer strong biceps bicep body comic feats flexing muscle muscles strength workout
🦾 mechanical arm accessibility body prosthetic
🦿 mechanical leg accessibility body prosthetic
🦵 leg kick limb body
🦶 foot kick stomp body
👂 ear face hear sound listen body ears hearing listening nose
🦻 ear with hearing aid accessibility body hard
👃 nose smell sniff body smelling sniffing stinky
🧠 brain smart intelligent body organ
🦷 tooth teeth dentist body
🦴 bone skeleton body
👀 eyes look watch stalk peek see body eye eyeballs face shifty wide
👁️ eye face look see watch stare body single
👅 tongue mouth playful body out taste
👄 mouth kiss body kissing lips
👶 baby child boy girl toddler newborn young
🧒 child gender-neutral young boy gender girl inclusive neutral person unspecified
👦 boy man male guy teenager child young
👧 girl female woman teenager child maiden virgin virgo young zodiac
🧑 person gender-neutral adult female gender inclusive male man men neutral unspecified woman women
👱 person blond hair hairstyle blonde haired man
👨 man mustache father dad guy classy sir moustache adult male men
🧔 man beard person bewhiskered bearded
👨‍🦰 man red hair hairstyle adult ginger haired male men redhead
👨‍🦱 man curly hair hairstyle adult haired male men
👨‍🦳 man white hair old elder adult haired male men
👨‍🦲 man bald hairless adult hair male men no
👩 woman female girls lady adult women yellow
👩‍🦰 woman red hair hairstyle adult female ginger haired redhead women
🧑‍🦰 person red hair hairstyle adult gender haired unspecified
👩‍🦱 woman curly hair hairstyle adult female haired women
🧑‍🦱 person curly hair hairstyle adult gender haired unspecified
👩‍🦳 woman white hair old elder adult female haired women
🧑‍🦳 person white hair elder old adult gender haired unspecified
👩‍🦲 woman bald hairless adult female hair no women
🧑‍🦲 person bald hairless adult gender hair no unspecified
👱‍♀️ woman blond hair woman female girl blonde person haired women
👱‍♂️ man blond hair man male boy blonde guy person haired men
🧓 older person human elder senior gender-neutral adult female gender male man men neutral old unspecified woman women
👴 old man human male men old elder senior adult elderly grandpa older
👵 old woman human female women lady old elder senior adult elderly grandma nanna older
🙍 person frowning worried frown gesture sad woman
🙍‍♂️ man frowning male boy man sad depressed discouraged unhappy frown gesture men
🙍‍♀️ woman frowning female girl woman sad depressed discouraged unhappy frown gesture women
🙎 person pouting upset blank face fed gesture look up
🙎‍♂️ man pouting male boy man gesture men
🙎‍♀️ woman pouting female girl woman gesture women
🙅 person gesturing no decline arms deal denied face forbidden gesture good halt hand not ok prohibited stop x
🙅‍♂️ man gesturing no male boy man nope denied forbidden gesture good halt hand men ng not ok prohibited stop
🙅‍♀️ woman gesturing no female girl woman nope denied forbidden gesture good halt hand ng not ok prohibited stop women
🙆 person gesturing ok agree ballerina face gesture hand hands head
🙆‍♂️ man gesturing ok men boy male blue human man gesture hand
🙆‍♀️ woman gesturing ok women girl female pink human woman gesture hand
💁 person tipping hand information attendant bellhop concierge desk female flick girl hair help sassy woman women
💁‍♂️ man tipping hand male boy man human information desk help men sassy
💁‍♀️ woman tipping hand female girl woman human information desk help sassy women
🙋 person raising hand question answering gesture happy one raised up
🙋‍♂️ man raising hand male boy man gesture happy men one raised
🙋‍♀️ woman raising hand female girl woman gesture happy one raised women
🧏 deaf person accessibility ear hear
🧏‍♂️ deaf man accessibility male men
🧏‍♀️ deaf woman accessibility female women
🙇 person bowing respectiful apology bow boy cute deeply dogeza gesture man massage respect sorry thanks
🙇‍♂️ man bowing man male boy apology bow deeply favor gesture men respect sorry thanks
🙇‍♀️ woman bowing woman female girl apology bow deeply favor gesture respect sorry thanks women
🤦 person facepalming disappointed disbelief exasperation face facepalm head hitting palm picard smh
🤦‍♂️ man facepalming man male boy disbelief exasperation face facepalm men palm
🤦‍♀️ woman facepalming woman female girl disbelief exasperation face facepalm palm women
🤷 person shrugging regardless doubt ignorance indifference shrug shruggie ¯\
🤷‍♂️ man shrugging man male boy confused indifferent doubt ignorance indifference men shrug
🤷‍♀️ woman shrugging woman female girl confused indifferent doubt ignorance indifference shrug women
🧑‍⚕️ health worker hospital dentist doctor healthcare md nurse physician professional therapist
👨‍⚕️ man health worker doctor nurse therapist healthcare man human dentist male md men physician professional
👩‍⚕️ woman health worker doctor nurse therapist healthcare woman human dentist female md physician professional women
🧑‍🎓 student learn education graduate pupil school
👨‍🎓 man student graduate man human education graduation male men pupil school
👩‍🎓 woman student graduate woman human education female graduation pupil school women
🧑‍🏫 teacher professor education educator instructor
👨‍🏫 man teacher instructor professor man human education educator male men school
👩‍🏫 woman teacher instructor professor woman human education educator female school women
🧑‍⚖️ judge law court justice scales
👨‍⚖️ man judge justice court man human law male men scales
👩‍⚖️ woman judge justice court woman human female law scales women
🧑‍🌾 farmer crops farm farming gardener rancher worker
👨‍🌾 man farmer rancher gardener man human farm farming male men worker
👩‍🌾 woman farmer rancher gardener woman human farm farming female women worker
🧑‍🍳 cook food kitchen culinary chef cooking service
👨‍🍳 man cook chef man human cooking food male men service
👩‍🍳 woman cook chef woman human cooking female food service women
🧑‍🔧 mechanic worker technician electrician person plumber repair tradesperson
👨‍🔧 man mechanic plumber man human wrench electrician male men person repair tradesperson
👩‍🔧 woman mechanic plumber woman human wrench electrician female person repair tradesperson women
🧑‍🏭 factory worker labor assembly industrial welder
👨‍🏭 man factory worker assembly industrial man human male men welder
👩‍🏭 woman factory worker assembly industrial woman human female welder women
🧑‍💼 office worker business accountant adviser analyst architect banker clerk manager
👨‍💼 man office worker business manager man human accountant adviser analyst architect banker businessman ceo clerk male men
👩‍💼 woman office worker business manager woman human accountant adviser analyst architect banker businesswoman ceo clerk female women
🧑‍🔬 scientist chemistry biologist chemist engineer lab mathematician physicist technician
👨‍🔬 man scientist biologist chemist engineer physicist man human lab male mathematician men research technician
👩‍🔬 woman scientist biologist chemist engineer physicist woman human female lab mathematician research technician women
🧑‍💻 technologist computer coder engineer laptop software technology
👨‍💻 man technologist coder developer engineer programmer software man human laptop computer blogger male men technology
👩‍💻 woman technologist coder developer engineer programmer software woman human laptop computer blogger female technology women
🧑‍🎤 singer song artist performer actor entertainer music musician rock rocker rockstar star
👨‍🎤 man singer rockstar entertainer man human actor aladdin bowie male men music musician rock rocker sane star
👩‍🎤 woman singer rockstar entertainer woman human actor female music musician rock rocker star women
🧑‍🎨 artist painting draw creativity art paint painter palette
👨‍🎨 man artist painter man human art male men paint palette
👩‍🎨 woman artist painter woman human art female paint palette women
🧑‍✈️ pilot fly plane airplane aviation aviator
👨‍✈️ man pilot aviator plane man human airplane aviation male men
👩‍✈️ woman pilot aviator plane woman human airplane aviation female women
🧑‍🚀 astronaut outerspace moon planets rocket space stars
👨‍🚀 man astronaut space rocket man human cosmonaut male men moon planets stars
👩‍🚀 woman astronaut space rocket woman human cosmonaut female moon planets stars women
🧑‍🚒 firefighter fire firetruck
👨‍🚒 man firefighter fireman man human fire firetruck male men
👩‍🚒 woman firefighter fireman woman human female fire firetruck women
👮 police officer cop law policeman policewoman
👮‍♂️ man police officer man police law legal enforcement arrest 911 cop male men policeman
👮‍♀️ woman police officer woman police law legal enforcement arrest 911 female cop policewoman women
🕵️ detective human spy eye or private sleuth
🕵️‍♂️ man detective crime male men sleuth spy
🕵️‍♀️ woman detective human spy detective female woman sleuth women
💂 guard protect british foot guardsman
💂‍♂️ man guard uk gb british male guy royal guardsman men
💂‍♀️ woman guard uk gb british female royal woman guardsman guardswoman women
👷 construction worker labor build builder face hard hat helmet safety
👷‍♂️ man construction worker male human wip guy build construction worker labor helmet men
👷‍♀️ woman construction worker female human wip build construction worker labor woman helmet women
🤴 prince boy man male crown royal king fairy fantasy men tale
👸 princess girl woman female blond crown royal queen blonde fairy fantasy tale tiara women
👳 person wearing turban headdress arab man muslim sikh
👳‍♂️ man wearing turban male indian hinduism arabs men
👳‍♀️ woman wearing turban female indian hinduism arabs woman women
👲 man with skullcap male boy chinese asian cap gua hat mao person pi
🧕 woman with headscarf female hijab mantilla tichel
🤵 man in tuxedo couple marriage wedding groom male men person suit
👰 bride with veil couple marriage wedding woman bride person
🤰 pregnant woman baby female pregnancy pregnant lady women
🤱 breast feeding nursing baby breastfeeding child female infant milk mother woman women
👼 baby angel heaven wings halo cherub cupid face fairy fantasy putto tale
🎅 santa claus festival man male xmas father christmas activity celebration men nicholas saint sinterklaas
🤶 mrs claus woman female xmas mother christmas activity celebration mrs. santa women
🦸 superhero marvel fantasy good hero heroine superpower superpowers
🦸‍♂️ man superhero man male good hero superpowers fantasy men superpower
🦸‍♀️ woman superhero woman female good heroine superpowers fantasy hero superpower women
🦹 supervillain marvel bad criminal evil fantasy superpower superpowers villain
🦹‍♂️ man supervillain man male evil bad criminal hero superpowers fantasy men superpower villain
🦹‍♀️ woman supervillain woman female evil bad criminal heroine superpowers fantasy superpower villain women
🧙 mage magic fantasy sorcerer sorceress witch wizard
🧙‍♂️ man mage man male mage sorcerer fantasy men wizard
🧙‍♀️ woman mage woman female mage witch fantasy sorceress wizard women
🧚 fairy wings magical fantasy oberon puck titania
🧚‍♂️ man fairy man male fantasy men oberon puck
🧚‍♀️ woman fairy woman female fantasy titania wings women
🧛 vampire blood twilight dracula fantasy undead
🧛‍♂️ man vampire man male dracula fantasy men undead
🧛‍♀️ woman vampire woman female fantasy undead unded women
🧜 merperson sea fantasy merboy mergirl mermaid merman merwoman
🧜‍♂️ merman man male triton fantasy men mermaid
🧜‍♀️ mermaid woman female merwoman ariel fantasy women
🧝 elf magical ears fantasy legolas pointed
🧝‍♂️ man elf man male ears fantasy magical men pointed
🧝‍♀️ woman elf woman female ears fantasy magical pointed women
🧞 genie magical wishes djinn djinni fantasy jinni
🧞‍♂️ man genie man male djinn fantasy men
🧞‍♀️ woman genie woman female djinn fantasy women
🧟 zombie dead fantasy undead walking
🧟‍♂️ man zombie man male dracula undead walking dead fantasy men
🧟‍♀️ woman zombie woman female undead walking dead fantasy women
💆 person getting massage relax face head massaging salon spa
💆‍♂️ man getting massage male boy man head face men salon spa
💆‍♀️ woman getting massage female girl woman head face salon spa women
💇 person getting haircut hairstyle barber beauty cutting hair hairdresser parlor
💇‍♂️ man getting haircut male boy man barber beauty men parlor
💇‍♀️ woman getting haircut female girl woman barber beauty parlor women
🚶 person walking move hike pedestrian walk walker
🚶‍♂️ man walking human feet steps hike male men pedestrian walk
🚶‍♀️ woman walking human feet steps woman female hike pedestrian walk women
🧍 person standing still stand
🧍‍♂️ man standing still male men stand
🧍‍♀️ woman standing still female stand women
🧎 person kneeling pray respectful kneel
🧎‍♂️ man kneeling pray respectful kneel male men
🧎‍♀️ woman kneeling respectful pray female kneel women
🧑‍🦯 person with probing cane blind accessibility white
👨‍🦯 man with probing cane blind accessibility male men white
👩‍🦯 woman with probing cane blind accessibility female white women
🧑‍🦼 person in motorized wheelchair disability accessibility
👨‍🦼 man in motorized wheelchair disability accessibility male men
👩‍🦼 woman in motorized wheelchair disability accessibility female women
🧑‍🦽 person in manual wheelchair disability accessibility
👨‍🦽 man in manual wheelchair disability accessibility male men
👩‍🦽 woman in manual wheelchair disability accessibility female women
🏃 person running move exercise jogging marathon run runner workout
🏃‍♂️ man running man walking exercise race running male marathon men racing runner workout
🏃‍♀️ woman running woman walking exercise race running female boy marathon racing runner women workout
💃 woman dancing female girl woman fun dance dancer dress red salsa women
🕺 man dancing male boy fun dancer dance disco men
🕴️ man in suit levitating suit business levitate hover jump boy hovering jabsco male men person rude walt
👯 people with bunny ears perform costume dancer dancing ear partying wearing women
👯‍♂️ men with bunny ears male bunny men boys dancer dancing ear man partying wearing
👯‍♀️ women with bunny ears female bunny women girls dancer dancing ear partying people wearing
🧖 person in steamy room relax spa hamam sauna steam steambath
🧖‍♂️ man in steamy room male man spa steamroom sauna hamam men steam steambath
🧖‍♀️ woman in steamy room female woman spa steamroom sauna hamam steam steambath women
🧗 person climbing sport bouldering climber rock
🧗‍♂️ man climbing sports hobby man male rock bouldering climber men
🧗‍♀️ woman climbing sports hobby woman female rock bouldering climber women
🤺 person fencing sports fencing sword fencer
🏇 horse racing animal betting competition gambling luck jockey race racehorse
⛷️ skier sports winter snow ski
🏂 snowboarder sports winter ski snow snowboard snowboarding
🏌️ person golfing sports business ball club golf golfer
🏌️‍♂️ man golfing sport ball golf golfer male men
🏌️‍♀️ woman golfing sports business woman female ball golf golfer women
🏄 person surfing sport sea surf surfer
🏄‍♂️ man surfing sports ocean sea summer beach male men surfer
🏄‍♀️ woman surfing sports ocean sea summer beach woman female surfer women
🚣 person rowing boat sport move paddles rowboat vehicle
🚣‍♂️ man rowing boat sports hobby water ship male men rowboat vehicle
🚣‍♀️ woman rowing boat sports hobby water ship woman female rowboat vehicle women
🏊 person swimming sport pool swim swimmer
🏊‍♂️ man swimming sports exercise human athlete water summer male men swim swimmer
🏊‍♀️ woman swimming sports exercise human athlete water summer woman female swim swimmer women
⛹️ person bouncing ball sports human basketball player
⛹️‍♂️ man bouncing ball sport basketball male men player
⛹️‍♀️ woman bouncing ball sports human woman female basketball player women
🏋️ person lifting weights sports training exercise bodybuilder gym lifter weight weightlifter workout
🏋️‍♂️ man lifting weights sport gym lifter male men weight weightlifter workout
🏋️‍♀️ woman lifting weights sports training exercise woman female gym lifter weight weightlifter women workout
🚴 person biking bicycle bike cyclist sport move bicyclist
🚴‍♂️ man biking bicycle bike cyclist sports exercise hipster bicyclist male men
🚴‍♀️ woman biking bicycle bike cyclist sports exercise hipster woman female bicyclist women
🚵 person mountain biking bicycle bike cyclist sport move bicyclist biker
🚵‍♂️ man mountain biking bicycle bike cyclist transportation sports human race bicyclist biker male men
🚵‍♀️ woman mountain biking bicycle bike cyclist transportation sports human race woman female bicyclist biker women
🤸 person cartwheeling sport gymnastic cartwheel doing gymnast gymnastics
🤸‍♂️ man cartwheeling gymnastics cartwheel doing male men
🤸‍♀️ woman cartwheeling gymnastics cartwheel doing female women
🤼 people wrestling sport wrestle wrestler wrestlers
🤼‍♂️ men wrestling sports wrestlers male man wrestle wrestler
🤼‍♀️ women wrestling sports wrestlers female woman wrestle wrestler
🤽 person playing water polo sport
🤽‍♂️ man playing water polo sports pool male men
🤽‍♀️ woman playing water polo sports pool female women
🤾 person playing handball sport ball
🤾‍♂️ man playing handball sports ball male men
🤾‍♀️ woman playing handball sports ball female women
🤹 person juggling performance balance juggle juggler multitask skill
🤹‍♂️ man juggling juggle balance skill multitask juggler male men
🤹‍♀️ woman juggling juggle balance skill multitask female juggler women
🧘 person in lotus position meditate meditation serenity yoga
🧘‍♂️ man in lotus position man male meditation yoga serenity zen mindfulness men
🧘‍♀️ woman in lotus position woman female meditation yoga serenity zen mindfulness women
🛀 person taking bath clean shower bathroom bathing bathtub hot
🛌 person in bed bed rest accommodation hotel sleep sleeping
🧑‍🤝‍🧑 people holding hands friendship couple date gender hand hold inclusive neutral nonconforming
👭 women holding hands pair friendship couple love like female people human date hand hold lesbian lgbt pride two woman
👫 woman and man holding hands pair people human love date dating like affection valentines marriage couple female hand heterosexual hold male men straight women
👬 men holding hands pair couple love like bromance friendship people human date gay hand hold lgbt male man pride two
💏 kiss pair valentines love like dating marriage couple couplekiss female gender heart kissing male man men neutral romance woman women
👩‍❤️‍💋‍👨 kiss woman man love couple couplekiss female heart kissing male men romance women
👨‍❤️‍💋‍👨 kiss man man pair valentines love like dating marriage couple couplekiss gay heart kissing lgbt male men pride romance two
👩‍❤️‍💋‍👩 kiss woman woman pair valentines love like dating marriage couple couplekiss female heart kissing lesbian lgbt pride romance two women
💑 couple with heart pair love like affection human dating valentines marriage female gender loving male man men neutral romance woman women
👩‍❤️‍👨 couple with heart woman man love female male men romance women
👨‍❤️‍👨 couple with heart man man pair love like affection human dating valentines marriage gay lgbt male men pride romance two
👩‍❤️‍👩 couple with heart woman woman pair love like affection human dating valentines marriage female lesbian lgbt pride romance two women
👪 family home parents child mom dad father mother people human boy female male man men woman women
👨‍👩‍👦 family man woman boy love father mother son
👨‍👩‍👧 family man woman girl home parents people human child daughter father female male men mother women
👨‍👩‍👧‍👦 family man woman girl boy home parents people human children child daughter father female male men mother son women
👨‍👩‍👦‍👦 family man woman boy boy home parents people human children child father female male men mother sons two women
👨‍👩‍👧‍👧 family man woman girl girl home parents people human children child daughters father female male men mother two women
👨‍👨‍👦 family man man boy home parents people human children child father fathers gay lgbt male men pride son two
👨‍👨‍👧 family man man girl home parents people human children child daughter father fathers gay lgbt male men pride two
👨‍👨‍👧‍👦 family man man girl boy home parents people human children child daughter father fathers gay lgbt male men pride son two
👨‍👨‍👦‍👦 family man man boy boy home parents people human children child father fathers gay lgbt male men pride sons two
👨‍👨‍👧‍👧 family man man girl girl home parents people human children child daughters father fathers gay lgbt male men pride two
👩‍👩‍👦 family woman woman boy home parents people human children child female lesbian lgbt mother mothers pride son two women
👩‍👩‍👧 family woman woman girl home parents people human children child daughter female lesbian lgbt mother mothers pride two women
👩‍👩‍👧‍👦 family woman woman girl boy home parents people human children child daughter female lesbian lgbt mother mothers pride son two women
👩‍👩‍👦‍👦 family woman woman boy boy home parents people human children child female lesbian lgbt mother mothers pride sons two women
👩‍👩‍👧‍👧 family woman woman girl girl home parents people human children child daughters female lesbian lgbt mother mothers pride two women
👨‍👦 family man boy home parent people human child father male men son
👨‍👦‍👦 family man boy boy home parent people human children child father male men sons two
👨‍👧 family man girl home parent people human child daughter father female male
👨‍👧‍👦 family man girl boy home parent people human children child daughter father male men son
👨‍👧‍👧 family man girl girl home parent people human children child daughters father female male two
👩‍👦 family woman boy home parent people human child female mother son women
👩‍👦‍👦 family woman boy boy home parent people human children child female mother sons two women
👩‍👧 family woman girl home parent people human child daughter female mother women
👩‍👧‍👦 family woman girl boy home parent people human children child daughter female male mother son
👩‍👧‍👧 family woman girl girl home parent people human children child daughters female mother two women
🗣️ speaking head user person human sing say talk face mansplaining shout shouting silhouette speak
👤 bust in silhouette user person human shadow
👥 busts in silhouette user person human group team bust people shadows silhouettes two users
👣 footprints feet tracking walking beach body clothing footprint footsteps print tracks
🐵 monkey face animal nature circus head
🐒 monkey animal nature banana circus cheeky
🦍 gorilla animal nature circus
🦧 orangutan animal ape
🐶 dog face animal friend nature woof puppy pet faithful
🐕 dog animal nature friend doge pet faithful dog2 doggo
🦮 guide dog animal blind accessibility eye seeing
🐕‍🦺 service dog blind animal accessibility assistance
🐩 poodle dog animal 101 nature pet miniature standard toy
🐺 wolf animal nature wild face
🦊 fox animal nature face
🦝 raccoon animal nature curious face sly
🐱 cat face animal meow nature pet kitten kitty
🐈 cat animal meow pet cats cat2 domestic feline housecat
🦁 lion animal nature face leo zodiac
🐯 tiger face animal cat danger wild nature roar cute
🐅 tiger animal nature roar bengal tiger2
🐆 leopard animal nature african jaguar
🐴 horse face animal brown nature head
🐎 horse animal gamble luck equestrian galloping racehorse racing speed
🦄 unicorn animal nature mystical face
🦓 zebra animal nature stripes safari face stripe
🦌 deer animal nature horns venison buck reindeer stag
🐮 cow face beef ox animal nature moo milk happy
🐂 ox animal cow beef bull bullock oxen steer taurus zodiac
🐃 water buffalo animal nature ox cow domestic
🐄 cow beef ox animal nature moo milk cow2 dairy
🐷 pig face animal oink nature head
🐖 pig animal nature hog pig2 sow
🐗 boar animal nature pig warthog wild
🐽 pig nose animal oink face snout
🐏 ram animal sheep nature aries male zodiac
🐑 ewe animal nature wool shipit female lamb sheep
🐐 goat animal nature capricorn zodiac
🐪 camel animal hot desert hump arabian bump dromedary one
🐫 two hump camel animal nature hot desert hump asian bactrian bump
🦙 llama animal nature alpaca guanaco vicuña wool
🦒 giraffe animal nature spots safari face
🐘 elephant animal nature nose th circus
🦏 rhinoceros animal nature horn rhino
🦛 hippopotamus animal nature hippo
🐭 mouse face animal nature cheese wedge rodent
🐁 mouse animal nature rodent dormouse mice mouse2
🐀 rat animal mouse rodent
🐹 hamster animal nature face pet
🐰 rabbit face animal nature pet spring magic bunny easter
🐇 rabbit animal nature pet magic spring bunny rabbit2
🐿️ chipmunk animal nature rodent squirrel
🦔 hedgehog animal nature spiny face
🦇 bat animal nature blind vampire batman
🐻 bear animal nature wild face teddy
🐨 koala animal nature bear face marsupial
🐼 panda animal nature face
🦥 sloth animal lazy slow
🦦 otter animal fishing playful
🦨 skunk animal smelly stink
🦘 kangaroo animal nature australia joey hop marsupial jump roo
🦡 badger animal nature honey pester
🐾 paw prints animal tracking footprints dog cat pet feet kitten print puppy
🦃 turkey animal bird thanksgiving wild
🐔 chicken animal cluck nature bird hen
🐓 rooster animal nature chicken bird cock cockerel
🐣 hatching chick animal chicken egg born baby bird
🐤 baby chick animal chicken bird yellow
🐥 front facing baby chick animal chicken baby bird hatched standing
🐦 bird animal nature fly tweet spring
🐧 penguin animal nature bird
🕊️ dove animal bird fly peace
🦅 eagle animal nature bird bald
🦆 duck animal nature bird mallard
🦢 swan animal nature bird cygnet duckling ugly
🦉 owl animal nature bird hoot wise
🦩 flamingo animal flamboyant tropical
🦚 peacock animal nature peahen bird ostentatious proud
🦜 parrot animal nature bird pirate talk
🐸 frog animal nature croak toad face
🐊 crocodile animal nature reptile lizard alligator croc
🐢 turtle animal slow nature tortoise terrapin
🦎 lizard animal nature reptile gecko
🐍 snake animal evil nature hiss python bearer ophiuchus serpent zodiac
🐲 dragon face animal myth nature chinese green fairy head tale
🐉 dragon animal myth nature chinese green fairy tale
🦕 sauropod animal nature dinosaur brachiosaurus brontosaurus diplodocus extinct
🦖 t rex animal nature dinosaur tyrannosaurus extinct trex
🐳 spouting whale animal nature sea ocean cute face
🐋 whale animal nature sea ocean whale2
🐬 dolphin animal nature fish sea ocean flipper fins beach
🐟 fish animal food nature freshwater pisces zodiac
🐠 tropical fish animal swim ocean beach nemo blue yellow
🐡 blowfish animal nature food sea ocean fish fugu pufferfish
🦈 shark animal nature fish sea ocean jaws fins beach great white
🐙 octopus animal creature ocean sea nature beach
🐚 spiral shell nature sea beach seashell
🐌 snail slow animal shell garden slug
🦋 butterfly animal insect nature caterpillar pretty
🐛 bug animal insect nature worm caterpillar
🐜 ant animal insect nature bug
🐝 honeybee animal insect nature bug spring honey bee bumblebee
🐞 lady beetle animal insect nature ladybug bug ladybird
🦗 cricket animal chirp grasshopper insect orthoptera
🕷️ spider animal arachnid insect
🕸️ spider web animal insect arachnid silk cobweb spiderweb
🦂 scorpion animal arachnid scorpio scorpius zodiac
🦟 mosquito animal nature insect malaria disease fever pest virus
🦠 microbe amoeba bacteria germs virus covid cell coronavirus germ microorganism
💐 bouquet flowers nature spring flower plant romance
🌸 cherry blossom nature plant spring flower pink sakura
💮 white flower japanese spring blossom cherry doily done paper stamp well
🏵️ rosette flower decoration military plant
🌹 rose flowers valentines love spring flower plant red
🥀 wilted flower plant nature flower rose dead drooping
🌺 hibiscus plant vegetable flowers beach flower
🌻 sunflower nature plant fall flower sun yellow
🌼 blossom nature flowers yellow blossoming flower daisy flower plant
🌷 tulip flowers plant nature summer spring flower
🌱 seedling plant nature grass lawn spring sprout sprouting young
🌲 evergreen tree plant nature fir pine wood
🌳 deciduous tree plant nature rounded shedding wood
🌴 palm tree plant vegetable nature summer beach mojito tropical coconut
🌵 cactus vegetable plant nature desert
🌾 sheaf of rice nature plant crop ear farming grain wheat
🌿 herb vegetable plant medicine weed grass lawn crop leaf
☘️ shamrock vegetable plant nature irish clover trefoil
🍀 four leaf clover vegetable plant nature lucky irish ireland luck
🍁 maple leaf nature plant vegetable ca fall canada canadian falling
🍂 fallen leaf nature plant vegetable leaves autumn brown fall falling
🍃 leaf fluttering in wind nature plant tree vegetable grass lawn spring blow flutter green leaves
🍇 grapes fruit food wine grape plant
🍈 melon fruit nature food cantaloupe honeydew muskmelon plant
🍉 watermelon fruit food picnic summer plant
🍊 tangerine food fruit nature orange mandarin plant
🍋 lemon fruit nature citrus lemonade plant
🍌 banana fruit food monkey plant plantain
🍍 pineapple fruit nature food plant
🥭 mango fruit food tropical
🍎 red apple fruit mac school delicious plant
🍏 green apple fruit nature delicious golden granny plant smith
🍐 pear fruit nature food plant
🍑 peach fruit nature food bottom butt plant
🍒 cherries food fruit berries cherry plant red wild
🍓 strawberry fruit food nature berry plant
🥝 kiwi fruit fruit food chinese gooseberry kiwifruit
🍅 tomato fruit vegetable nature food plant
🥥 coconut fruit nature food palm cocoanut colada piña
🥑 avocado fruit food
🍆 eggplant vegetable nature food aubergine phallic plant purple
🥔 potato food tuber vegatable starch baked idaho vegetable
🥕 carrot vegetable food orange
🌽 ear of corn food vegetable plant cob maize maze
🌶️ hot pepper food spicy chilli chili plant
🥒 cucumber fruit food pickle gherkin vegetable
🥬 leafy green food vegetable plant bok choy cabbage kale lettuce chinese cos greens romaine
🥦 broccoli fruit food vegetable cabbage wild
🧄 garlic food spice cook flavoring plant vegetable
🧅 onion cook food spice flavoring plant vegetable
🍄 mushroom plant vegetable fungus shroom toadstool
🥜 peanuts food nut nuts peanut vegetable
🌰 chestnut food squirrel acorn nut plant
🍞 bread food wheat breakfast toast loaf
🥐 croissant food bread french breakfast crescent roll
🥖 baguette bread food bread french france bakery
🥨 pretzel food bread twisted germany bakery soft twist
🥯 bagel food bread bakery schmear jewish bakery breakfast cheese cream
🥞 pancakes food breakfast flapjacks hotcakes brunch crêpe crêpes hotcake pancake
🧇 waffle food breakfast brunch indecisive iron
🧀 cheese wedge food chadder swiss
🍖 meat on bone good food drumstick barbecue bbq manga
🍗 poultry leg food meat drumstick bird chicken turkey bone
🥩 cut of meat food cow meat cut chop lambchop porkchop steak
🥓 bacon food breakfast pork pig meat brunch rashers
🍔 hamburger meat fast food beef cheeseburger mcdonalds burger king
🍟 french fries chips snack fast food potato mcdonald's
🍕 pizza food party italy cheese pepperoni slice
🌭 hot dog food frankfurter america hotdog redhot sausage wiener
🥪 sandwich food lunch bread toast bakery cheese deli meat vegetables
🌮 taco food mexican
🌯 burrito food mexican wrap
🥙 stuffed flatbread food flatbread stuffed gyro mediterranean doner falafel kebab pita sandwich shawarma
🧆 falafel food mediterranean chickpea falfel meatball
🥚 egg food chicken breakfast
🍳 cooking food breakfast kitchen egg skillet fried frying pan
🥘 shallow pan of food food cooking casserole paella skillet curry
🍲 pot of food food meat soup hot pot bowl stew
🥣 bowl with spoon food breakfast cereal oatmeal porridge congee tableware
🥗 green salad food healthy lettuce vegetable
🍿 popcorn food movie theater films snack drama corn popping
🧈 butter food cook dairy
🧂 salt condiment shaker
🥫 canned food food soup tomatoes can preserve tin tinned
🍱 bento box food japanese box lunch
🍘 rice cracker food japanese snack senbei
🍙 rice ball food japanese onigiri omusubi
🍚 cooked rice food asian boiled bowl steamed
🍛 curry rice food spicy hot indian
🍜 steaming bowl food japanese noodle chopsticks ramen noodles soup
🍝 spaghetti food italian pasta noodle
🍠 roasted sweet potato food nature plant goguma yam
🍢 oden skewer food japanese kebab seafood stick
🍣 sushi food fish japanese rice sashimi seafood
🍤 fried shrimp food animal appetizer summer prawn tempura
🍥 fish cake with swirl food japan sea beach narutomaki pink swirl kamaboko surimi ramen design fishcake pastry
🥮 moon cake food autumn dessert festival mooncake yuèbǐng
🍡 dango food dessert sweet japanese barbecue meat balls green pink skewer stick white
🥟 dumpling food empanada pierogi potsticker gyoza gyōza jiaozi
🥠 fortune cookie food prophecy dessert
🥡 takeout box food leftovers chinese container out oyster pail take
🦀 crab animal crustacean cancer zodiac
🦞 lobster animal nature bisque claws seafood
🦐 shrimp animal ocean nature seafood food prawn shellfish small
🦑 squid animal nature ocean sea food molusc
🦪 oyster food diving pearl
🍦 soft ice cream food hot dessert summer icecream mr. serve sweet whippy
🍧 shaved ice hot dessert summer cone snow sweet
🍨 ice cream food hot dessert bowl sweet
🍩 doughnut food dessert snack sweet donut breakfast
🍪 cookie food snack oreo chocolate sweet dessert biscuit chip
🎂 birthday cake food dessert cake candles celebration party pastry sweet
🍰 shortcake food dessert cake pastry piece slice strawberry sweet
🧁 cupcake food dessert bakery sweet cake fairy pastry
🥧 pie food dessert pastry filling sweet
🍫 chocolate bar food snack dessert sweet candy
🍬 candy snack dessert sweet lolly
🍭 lollipop food snack candy sweet dessert lollypop sucker
🍮 custard dessert food pudding flan caramel creme sweet
🍯 honey pot bees sweet kitchen honeypot
🍼 baby bottle food container milk drink feeding
🥛 glass of milk beverage drink cow
☕ hot beverage beverage caffeine latte espresso coffee mug cafe chocolate drink steaming tea
🍵 teacup without handle drink bowl breakfast green british beverage cup matcha tea
🍶 sake wine drink drunk beverage japanese alcohol booze bar bottle cup rice
🍾 bottle with popping cork drink wine bottle celebration bar bubbly champagne party sparkling
🍷 wine glass drink beverage drunk alcohol booze bar red
🍸 cocktail glass drink drunk alcohol beverage booze mojito bar martini
🍹 tropical drink beverage cocktail summer beach alcohol booze mojito bar fruit punch tiki vacation
🍺 beer mug relax beverage drink drunk party pub summer alcohol booze bar stein
🍻 clinking beer mugs relax beverage drink drunk party pub summer alcohol booze bar beers cheers clink drinks mug
🥂 clinking glasses beverage drink party alcohol celebrate cheers wine champagne toast celebration clink glass
🥃 tumbler glass drink beverage drunk alcohol liquor booze bourbon scotch whisky glass shot rum whiskey
🥤 cup with straw drink soda go juice malt milkshake pop smoothie soft tableware water
🧃 beverage box drink juice straw sweet
🧉 mate drink tea beverage bombilla chimarrão cimarrón maté yerba
🧊 ice water cold cube iceberg
🥢 chopsticks food hashi jeotgarak kuaizi
🍽️ fork and knife with plate food eat meal lunch dinner restaurant cooking cutlery dining tableware
🍴 fork and knife cutlery kitchen cooking silverware tableware
🥄 spoon cutlery kitchen tableware
🔪 kitchen knife knife blade cutlery kitchen weapon butchers chop cooking cut hocho tool
🏺 amphora vase jar aquarius cooking drink jug tool zodiac
🌍 globe showing europe africa globe world earth international planet
🌎 globe showing americas globe world USA earth international planet
🌏 globe showing asia australia globe world east earth international planet
🌐 globe with meridians earth international world internet interweb i18n global web wide www
🗺️ world map location direction travel
🗾 map of japan nation country japanese asia silhouette
🧭 compass magnetic navigation orienteering
🏔️ snow capped mountain photo nature environment winter cold
⛰️ mountain photo nature environment
🌋 volcano photo nature disaster eruption mountain weather
🗻 mount fuji photo mountain nature japanese capped san snow
🏕️ camping photo outdoors tent campsite
🏖️ beach with umbrella weather summer sunny sand mojito
🏜️ desert photo warm saharah
🏝️ desert island photo tropical mojito
🏞️ national park photo environment nature
🏟️ stadium photo place sports concert venue grandstand sport
🏛️ classical building art culture history
🏗️ building construction wip working progress crane
🧱 brick bricks clay construction mortar wall
🏘️ houses buildings photo building group house
🏚️ derelict house abandon evict broken building abandoned haunted old
🏠 house building home
🏡 house with garden home plant nature building tree
🏢 office building building bureau work city high rise
🏣 japanese post office building envelope communication japan mark postal
🏤 post office building email european
🏥 hospital building health surgery doctor cross emergency medical medicine red room
🏦 bank building money sales cash business enterprise bakkureru bk branch
🏨 hotel building accomodation checkin accommodation h
🏩 love hotel like affection dating building heart hospital
🏪 convenience store building shopping groceries corner e eleven® hour kwik mart shop
🏫 school building student education learn teach clock elementary high middle tower
🏬 department store building shopping mall center shops
🏭 factory building industry pollution smoke industrial smog
🏯 japanese castle photo building fortress
🏰 castle building royalty history european turrets
💒 wedding love like affection couple marriage bride groom activity chapel church heart romance
🗼 tokyo tower photo japanese eiffel red
🗽 statue of liberty american newyork new york
⛪ church building religion christ christian cross
🕌 mosque islam worship minaret domed muslim religion roof
🛕 hindu temple religion
🕍 synagogue judaism worship temple jewish jew religion synagog
⛩️ shinto shrine temple japan kyoto kami michi no religion
🕋 kaaba mecca mosque islam muslim religion
⛲ fountain photo summer water fresh feature park
⛺ tent photo camping outdoors
🌁 foggy photo mountain bridge city fog fog bridge karl under weather
🌃 night with stars evening city downtown star starry weather
🏙️ cityscape photo night life urban building city skyline
🌄 sunrise over mountains view vacation photo morning mountain sun weather
🌅 sunrise morning view vacation photo sun sunset weather
🌆 cityscape at dusk photo evening sky buildings building city landscape orange sun sunset weather
🌇 sunset photo good morning dawn building buildings city dusk over sun sunrise weather
🌉 bridge at night photo sanfrancisco gate golden weather
♨️ hot springs bath warm relax hotsprings onsen steam steaming
🎠 carousel horse photo carnival activity entertainment fairground go merry round
🎡 ferris wheel photo carnival londoneye activity amusement big entertainment fairground observation park
🎢 roller coaster carnival playground photo fun activity amusement entertainment park rollercoaster theme
💈 barber pole hair salon style barber's haircut hairdresser shop stripes
🎪 circus tent festival carnival party activity big entertainment top
🚂 locomotive transportation vehicle train engine railway steam
🚃 railway car transportation vehicle carriage electric railcar railroad train tram trolleybus wagon
🚄 high speed train transportation vehicle bullettrain railway shinkansen side
🚅 bullet train transportation vehicle speed fast public travel bullettrain front high nose railway shinkansen
🚆 train transportation vehicle diesel electric passenger railway regular train2
🚇 metro transportation blue-square mrt underground tube subway train vehicle
🚈 light rail transportation vehicle railway
🚉 station transportation vehicle public platform railway train
🚊 tram transportation vehicle trolleybus
🚝 monorail transportation vehicle
🚞 mountain railway transportation vehicle car funicular train
🚋 tram car transportation vehicle carriage public travel train trolleybus
🚌 bus car vehicle transportation school
🚍 oncoming bus vehicle transportation front
🚎 trolleybus bart transportation vehicle bus electric bus tram trolley
🚐 minibus vehicle car transportation bus minivan mover people
🚑 ambulance health 911 hospital vehicle
🚒 fire engine transportation cars vehicle department truck
🚓 police car vehicle cars transportation law legal enforcement cop patrol side
🚔 oncoming police car vehicle law legal enforcement 911 front of 🚓 cop
🚕 taxi uber vehicle cars transportation new side taxicab york
🚖 oncoming taxi vehicle cars uber front taxicab
🚗 automobile red transportation vehicle car side
🚘 oncoming automobile car vehicle transportation front
🚙 sport utility vehicle transportation vehicle blue campervan car motorhome recreational rv
🚚 delivery truck cars transportation vehicle
🚛 articulated lorry vehicle cars transportation express green semi truck
🚜 tractor vehicle car farming agriculture farm
🏎️ racing car sports race fast formula f1 one
🏍️ motorcycle race sports fast motorbike racing
🛵 motor scooter vehicle vespa sasha bike cycle
🦽 manual wheelchair accessibility
🦼 motorized wheelchair accessibility
🛺 auto rickshaw move transportation tuk
🚲 bicycle bike sports exercise hipster push vehicle
🛴 kick scooter vehicle kick razor
🛹 skateboard board skate
🚏 bus stop transportation wait busstop
🛣️ motorway road cupertino interstate highway
🛤️ railway track train transportation
🛢️ oil drum barrell
⛽ fuel pump gas station petroleum diesel fuelpump petrol
🚨 police car light police ambulance 911 emergency alert error pinged law legal beacon cars car’s emergency light flashing revolving rotating siren vehicle
🚥 horizontal traffic light transportation signal
🚦 vertical traffic light transportation driving semaphore signal
🛑 stop sign stop octagonal
🚧 construction wip progress caution warning barrier black roadwork sign striped yellow
⚓ anchor ship ferry sea boat admiralty fisherman pattern tool
⛵ sailboat ship summer transportation water sailing boat dinghy resort sea vehicle yacht
🛶 canoe boat paddle water ship
🚤 speedboat ship transportation vehicle summer boat motorboat powerboat
🛳️ passenger ship yacht cruise ferry vehicle
⛴️ ferry boat ship yacht passenger
🛥️ motor boat ship motorboat vehicle
🚢 ship transportation titanic deploy boat cruise passenger vehicle
✈️ airplane vehicle transportation flight fly aeroplane plane
🛩️ small airplane flight transportation fly vehicle aeroplane plane
🛫 airplane departure airport flight landing aeroplane departures off plane taking vehicle
🛬 airplane arrival airport flight boarding aeroplane arrivals arriving landing plane vehicle
🪂 parachute fly glide hang parasail skydive
💺 seat sit airplane transport bus flight fly aeroplane chair train
🚁 helicopter transportation vehicle fly
🚟 suspension railway vehicle transportation
🚠 mountain cableway transportation vehicle ski cable gondola
🚡 aerial tramway transportation vehicle ski cable car gondola ropeway
🛰️ satellite communication gps orbit spaceflight NASA ISS artificial space vehicle
🚀 rocket launch ship staffmode NASA outer space outer space fly shuttle vehicle
🛸 flying saucer transportation vehicle ufo alien extraterrestrial fantasy space
🛎️ bellhop bell service hotel
🧳 luggage packing travel suitcase
⌛ hourglass done time clock oldschool limit exam quiz test sand timer
⏳ hourglass not done oldschool time countdown flowing sand timer
⌚ watch time accessories apple clock timepiece wrist wristwatch
⏰ alarm clock time wake morning
⏱️ stopwatch time deadline clock
⏲️ timer clock alarm
🕰️ mantelpiece clock time
🕛 twelve o clock 12 00:00 0000 12:00 1200 time noon midnight midday late early schedule clock12 face oclock o’clock
🕧 twelve thirty 00:30 0030 12:30 1230 time late early schedule clock clock1230 face
🕐 one o clock 1 1:00 100 13:00 1300 time late early schedule clock1 face oclock o’clock
🕜 one thirty 1:30 130 13:30 1330 time late early schedule clock clock130 face
🕑 two o clock 2 2:00 200 14:00 1400 time late early schedule clock2 face oclock o’clock
🕝 two thirty 2:30 230 14:30 1430 time late early schedule clock clock230 face
🕒 three o clock 3 3:00 300 15:00 1500 time late early schedule clock3 face oclock o’clock
🕞 three thirty 3:30 330 15:30 1530 time late early schedule clock clock330 face
🕓 four o clock 4 4:00 400 16:00 1600 time late early schedule clock4 face oclock o’clock
🕟 four thirty 4:30 430 16:30 1630 time late early schedule clock clock430 face
🕔 five o clock 5 5:00 500 17:00 1700 time late early schedule clock5 face oclock o’clock
🕠 five thirty 5:30 530 17:30 1730 time late early schedule clock clock530 face
🕕 six o clock 6 6:00 600 18:00 1800 time late early schedule dawn dusk clock6 face oclock o’clock
🕡 six thirty 6:30 630 18:30 1830 time late early schedule clock clock630 face
🕖 seven o clock 7 7:00 700 19:00 1900 time late early schedule clock7 face oclock o’clock
🕢 seven thirty 7:30 730 19:30 1930 time late early schedule clock clock730 face
🕗 eight o clock 8 8:00 800 20:00 2000 time late early schedule clock8 face oclock o’clock
🕣 eight thirty 8:30 830 20:30 2030 time late early schedule clock clock830 face
🕘 nine o clock 9 9:00 900 21:00 2100 time late early schedule clock9 face oclock o’clock
🕤 nine thirty 9:30 930 21:30 2130 time late early schedule clock clock930 face
🕙 ten o clock 10 10:00 1000 22:00 2200 time late early schedule clock10 face oclock o’clock
🕥 ten thirty 10:30 1030 22:30 2230 time late early schedule clock clock1030 face
🕚 eleven o clock 11 11:00 1100 23:00 2300 time late early schedule clock11 face oclock o’clock
🕦 eleven thirty 11:30 1130 23:30 2330 time late early schedule clock clock1130 face
🌑 new moon nature twilight planet space night evening sleep dark eclipse shadow moon solar symbol weather
🌒 waxing crescent moon nature twilight planet space night evening sleep symbol weather
🌓 first quarter moon nature twilight planet space night evening sleep symbol weather
🌔 waxing gibbous moon nature night sky gray twilight planet space evening sleep symbol weather
🌕 full moon nature yellow twilight planet space night evening sleep symbol weather
🌖 waning gibbous moon nature twilight planet space night evening sleep waxing gibbous moon symbol weather
🌗 last quarter moon nature twilight planet space night evening sleep symbol weather
🌘 waning crescent moon nature twilight planet space night evening sleep symbol weather
🌙 crescent moon night sleep sky evening magic space weather
🌚 new moon face nature twilight planet space night evening sleep creepy dark molester weather
🌛 first quarter moon face nature twilight planet space night evening sleep weather
🌜 last quarter moon face nature twilight planet space night evening sleep weather
🌡️ thermometer weather temperature hot cold
☀️ sun weather nature brightness summer beach spring black bright rays space sunny sunshine
🌝 full moon face nature twilight planet space night evening sleep bright moonface smiley smiling weather
🌞 sun with face nature morning sky bright smiley smiling space summer sunface weather
🪐 ringed planet outerspace planets saturn saturnine space
⭐ star night yellow gold medium white
🌟 glowing star night sparkle awesome good magic glittery glow shining star2
🌠 shooting star night photo activity falling meteoroid space stars upon when wish you
🌌 milky way photo space stars galaxy night sky universe weather
☁️ cloud weather sky cloudy overcast
⛅ sun behind cloud weather nature cloudy morning fall spring partly sunny
⛈️ clo
