/datum/job/roguetown/guardsman
	title = "City Guard"
	flag = GUARDSMAN
	department_flag = GARRISON
	faction = "Station"
	total_positions = 4
	spawn_positions = 4
	selection_color = JCOLOR_SOLDIER
	allowed_sexes = list(MALE, FEMALE)
	allowed_races = ACCEPTED_RACES
	allowed_ages = list(AGE_ADULT, AGE_MIDDLEAGED)
	job_traits = list(TRAIT_GUARDSMAN, TRAIT_STEELHEARTED)
	tutorial = "Responsible for the safety of the city and the enforcement of the law, \
	you patrol the city streets, on the look out for crime and disorder. \
	Armed with chains and a trusty beating stick, you are charged with catching \
	thieves, vagrants and troublemakers, confiscating stolen times, and administering swift and orderly justice"
	display_order = JDO_TOWNGUARD
	whitelist_req = TRUE

	outfit = /datum/outfit/job/roguetown/guardsman
	advclass_cat_rolls = list(CTAG_WATCH = 20)

	give_bank_account = 20
	min_pq = 2
	max_pq = null
	round_contrib_points = 2
	social_rank = SOCIAL_RANK_YEOMAN

	cmode_music = 'sound/music/combat_ManAtArms.ogg'

/datum/outfit/job/roguetown/guardsman
	job_bitflag = BITFLAG_GARRISON

/datum/job/roguetown/guardsman/after_spawn(mob/living/L, mob/M, latejoin = TRUE)
	. = ..()
	if(ishuman(L))
		var/mob/living/carbon/human/H = L
		if(istype(H.cloak, /obj/item/clothing/cloak/citywatch))
			var/obj/item/clothing/S = H.cloak
			var/index = findtext(H.real_name, " ")
			if(index)
				index = copytext(H.real_name, 1,index)
			if(!index)
				index = H.real_name
			S.name = "watchman halfcloak ([index])"

/datum/outfit/job/roguetown/guardsman
	neck = /obj/item/clothing/neck/roguetown/gorget
	pants = /obj/item/clothing/under/roguetown/chainlegs
	cloak = /obj/item/clothing/cloak/citywatch
	armor = /obj/item/clothing/suit/roguetown/armor/plate/citywatch
	head = /obj/item/clothing/head/roguetown/helmet/citywatch
	shirt = /obj/item/clothing/suit/roguetown/armor/gambeson
	gloves = /obj/item/clothing/gloves/roguetown/chain
	shoes = /obj/item/clothing/shoes/roguetown/boots/leather/reinforced
	belt = /obj/item/storage/belt/rogue/leather/black
	wrists = /obj/item/clothing/wrists/roguetown/bracers/citywatch

	beltr = /obj/item/rogueweapon/mace/cudgel
	belt = /obj/item/storage/belt/rogue/leather
	backr = /obj/item/storage/backpack/rogue/satchel
	id = /obj/item/scomstone/bad/garrison

	backpack_contents = list(
		/obj/item/rogueweapon/huntingknife/idagger/steel = 1,
		/obj/item/rope/chain = 1,
		/obj/item/storage/keyring/guardcastle = 1,
		/obj/item/rogueweapon/scabbard/sheath = 1,
		)

/datum/advclass/guardsman/cityguard
	name = "City Guard"
	tutorial = "Responsible for the safety of the city and the enforcement of the law, \
	you patrol the city streets, on the look out for crime and disorder. \
	Armed with chains and a trusty beating stick, you are charged with catching \
	thieves, vagrants and troublemakers, confiscating stolen times, and administering swift and orderly justice"
	outfit = /datum/outfit/job/roguetown/guardsman/cityguard

	category_tags = list(CTAG_WATCH)
	traits_applied = list(TRAIT_MEDIUMARMOR)
	subclass_stats = list(
		STATKEY_STR = 2,
		STATKEY_CON = 1,
		STATKEY_WIL = 1,
		STATKEY_PER = 1,//on the lookout for perps
	)
	subclass_skills = list(
		/datum/skill/combat/maces = SKILL_LEVEL_JOURNEYMAN,
		/datum/skill/combat/wrestling = SKILL_LEVEL_EXPERT,
		/datum/skill/combat/unarmed = SKILL_LEVEL_EXPERT,
		/datum/skill/combat/knives = SKILL_LEVEL_JOURNEYMAN,
		/datum/skill/combat/shields = SKILL_LEVEL_JOURNEYMAN,
		/datum/skill/combat/whipsflails = SKILL_LEVEL_APPRENTICE,
		/datum/skill/combat/crossbows = SKILL_LEVEL_APPRENTICE,
		/datum/skill/combat/bows = SKILL_LEVEL_APPRENTICE,
		/datum/skill/combat/slings = SKILL_LEVEL_APPRENTICE,
		/datum/skill/misc/climbing = SKILL_LEVEL_JOURNEYMAN,
		/datum/skill/misc/sneaking = SKILL_LEVEL_APPRENTICE,
		/datum/skill/misc/reading = SKILL_LEVEL_NOVICE,
		/datum/skill/misc/athletics = SKILL_LEVEL_EXPERT,
		/datum/skill/misc/tracking = SKILL_LEVEL_APPRENTICE,
	)

/datum/outfit/job/roguetown/guardsman/cityguard/pre_equip(mob/living/carbon/human/H)
	..()
	H.adjust_blindness(-3)
	if(H.mind)
		var/weapons = list("Stunmace & Shield","Maul - 14STR Minimum", "Stunmace & Crossbow")
		var/weapon_choice = input(H, "Choose your weapon.", "TAKE UP ARMS") as anything in weapons
		H.set_blindness(0)
		switch(weapon_choice)
			if("Stunmace & Shield")
				r_hand = /obj/item/rogueweapon/mace/stunmace
				backl = /obj/item/rogueweapon/shield/iron
				H.adjust_skillrank_up_to(/datum/skill/combat/maces, SKILL_LEVEL_EXPERT, TRUE)
			if("Maul - 14STR Minimum")
				r_hand = /obj/item/rogueweapon/mace/maul
				backl = /obj/item/rogueweapon/scabbard/gwstrap
				H.adjust_skillrank_up_to(/datum/skill/combat/maces, SKILL_LEVEL_EXPERT, TRUE)
			if("Stunmace & Crossbow")
				r_hand = /obj/item/gun/ballistic/revolver/grenadelauncher/crossbow
				backl = /obj/item/quiver/bolts
				H.adjust_skillrank_up_to(/datum/skill/combat/crossbows, SKILL_LEVEL_MASTER, TRUE)
				H.adjust_skillrank_up_to(/datum/skill/combat/bows, SKILL_LEVEL_MASTER, TRUE)

	H.verbs |= /mob/proc/haltyell

// /datum/advclass/watchman/archer
// 	name = "Watch Archer"
// 	tutorial = "You are an archer of the Town Watch. Once a hunter, now a man-hunter for your lord. Rooftops, bows, and daggers are your best friend."
// 	outfit = /datum/outfit/job/roguetown/guardsman/archer

// 	category_tags = list(CTAG_WATCH)
// 	traits_applied = list(TRAIT_DODGEEXPERT)
// 	subclass_stats = list(
// 		STATKEY_SPD = 2,
// 		STATKEY_PER = 2,
// 		STATKEY_STR = 1,
// 		STATKEY_INT = 1,
// 		STATKEY_CON = 1
// 	)
// 	subclass_skills = list(
// 		/datum/skill/combat/bows = SKILL_LEVEL_EXPERT,
// 		/datum/skill/combat/crossbows = SKILL_LEVEL_MASTER,		//Why master? Because all it does is effect draw time, which is strength x skill / 1.2. (Bow is just skill / 1.0). You get poor bonus strength, so you get skill to offset.
// 		/datum/skill/combat/wrestling = SKILL_LEVEL_JOURNEYMAN,
// 		/datum/skill/combat/unarmed = SKILL_LEVEL_JOURNEYMAN,
// 		/datum/skill/combat/knives = SKILL_LEVEL_EXPERT,
// 		/datum/skill/combat/maces = SKILL_LEVEL_APPRENTICE,
// 		/datum/skill/combat/shields = SKILL_LEVEL_NOVICE,		//Maybe take away? Leaving for now just as a fall-back for non-lethal ability.
// 		/datum/skill/combat/swords = SKILL_LEVEL_NOVICE,
// 		/datum/skill/misc/climbing = SKILL_LEVEL_EXPERT,
// 		/datum/skill/misc/athletics = SKILL_LEVEL_JOURNEYMAN,
// 		/datum/skill/misc/sneaking = SKILL_LEVEL_JOURNEYMAN,
// 		/datum/skill/misc/swimming = SKILL_LEVEL_APPRENTICE,
// 		/datum/skill/misc/reading = SKILL_LEVEL_NOVICE,
// 		/datum/skill/misc/medicine = SKILL_LEVEL_NOVICE,
// 		/datum/skill/craft/crafting = SKILL_LEVEL_NOVICE,	//For basic crafting; you'll need it due to relegated support role.
// 		/datum/skill/craft/tanning = SKILL_LEVEL_NOVICE,	//Likely hunter background; very crappy basic skill.
// 		/datum/skill/misc/tracking = SKILL_LEVEL_NOVICE, 
// 	)

// /datum/outfit/job/roguetown/guardsman/archer/pre_equip(mob/living/carbon/human/H)
// 	..()
// 	head = /obj/item/clothing/head/roguetown/roguehood/red		/
// 	armor = /obj/item/clothing/suit/roguetown/armor/leather		
// 	beltr = /obj/item/quiver/bolts
// 	backl = /obj/item/gun/ballistic/revolver/grenadelauncher/crossbow
// 	backr = /obj/item/storage/backpack/rogue/satchel/black
// 	beltl = /obj/item/storage/keyring/guardcastle
// 	belt = /obj/item/storage/belt/rogue/leather/black
// 	gloves = /obj/item/clothing/gloves/roguetown/leather
// 	backpack_contents = list(
// 		/obj/item/rogueweapon/huntingknife/idagger/steel = 1,
// 		/obj/item/rope/chain = 1,
// 		)
// 	H.verbs |= /mob/proc/haltyell

// Added to baliff under assumption townguard.dm will not be enabled.
// /mob/proc/haltyell()
//	set name = "HALT!"
//	set category = "Noises"
//	emote("haltyell")
