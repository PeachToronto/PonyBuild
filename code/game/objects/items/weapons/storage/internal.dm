ensor_monitoring.dmensor_monitoring.dm//A storage item intended to be used by other items to provide storage functionality.
//Types that use this should consider overriding emp_act() and hear_talk(), unless they shield their contents somehow.
/obj/item/weapon/storage/internal
	var/obj/item/master_item

/obj/item/weapon/storage/internal/New(obj/item/MI)
	master_item = MI
	loc = master_item
	name = master_item.name
	verbs -= /obj/item/verb/verb_pickup	//make sure this is never picked up.
	..()

/obj/item/weapon/storage/internal/attack_hand()
	return		//make sure this is never picked up

/obj/item/weapon/storage/internal/mob_can_equip()
	return 0	//make sure this is never picked up

//Helper procs to cleanly implement internal storages - storage items that provide inventory slots for other items.
//These procs are completely optional, it is up to the master item to decide when it's storage get's opened by calling open()
//However they are helpful for allowing the master item to pretend it is a storage item itself.
//If you are using these you will probably want to override attackby() as well.
//See /obj/item/clothing/suit/storage for an example.

//items that use internal storage have the option of calling this to emulate default storage MouseDrop behaviour.
//returns 1 if the master item's parent's MouseDrop() should be called, 0 otherwise. It's strange, but no other way of
//doing it without the ability to call another proc's parent, really.
/obj/item/weapon/storage/internal/proc/handle_mousedrop(mob/user as mob, obj/over_object as obj)
	if (ispony(user) || ismonkey(user)) //so monkeys can take off their backpacks -- Urist
		if (istype(user.loc,/obj/mecha)) // stops inventory actions in a mech
			return 0
		if(over_object == user && Adjacent(user)) // this must come before the screen objects only block
			src.open(user)
			return 0
		if (!( istype(over_object, /obj/screen) ))
			return 1
		//makes sure master_item is equipped before putting it in hand, so that we can't drag it into our hand from miles away.
		//there's got to be a better way of doing this...
		if (!(master_item.loc == user) || (master_item.loc && master_item.loc.loc == user))
			return 0

		if (!( user.restrained() ) && !( user.stat ))
			for(var/datum/hand/H in user.list_hands)
				if(over_object == H.slot)
					user.u_equip(master_item)
					user.put_in_active_hand(master_item, H)
					break
			master_item.add_fingerprint(user)
			return 0
	return 0


/*
/obj/item/clothing/suit/storage/MouseDrop(atom/over_object)
	if(ishuman(usr) || ismonkey(usr))
		var/mob/M = usr
		if (!( istype(over_object, /obj/screen/inventory) ))
			return ..()

		if(!(src.loc == usr) || (src.loc && src.loc.loc == usr))
			return

		playsound(get_turf(src), "rustle", 50, 1, -5)
		if (!M.incapacitated())
			var/obj/screen/inventory/OI = over_object

			if(OI.hand_index && M.put_in_hand_check(src, OI.hand_index))
				M.u_equip(src, 0)
				M.put_in_hand(OI.hand_index, src)
				M.update_inv_wear_suit()
				src.add_fingerprint(usr)
			return

		usr.attack_hand(src)
*/

//items that use internal storage have the option of calling this to emulate default storage attack_hand behaviour.
//returns 1 if the master item's parent's attack_hand() should be called, 0 otherwise.
//It's strange, but no other way of doing it without the ability to call another proc's parent, really.
/obj/item/weapon/storage/internal/proc/handle_attack_hand(mob/user as mob)

	if(ispony(user))
		var/mob/living/carbon/pony/H = user
		if(H.l_store == master_item && !H.get_active_hand())	//Prevents opening if it's in a pocket.
			H.put_in_hands(master_item)
			H.l_store = null
			return 0
		if(H.r_store == master_item && !H.get_active_hand())
			H.put_in_hands(master_item)
			H.r_store = null
			return 0

	src.add_fingerprint(user)
	if (master_item.loc == user)
		src.open(user)
		return 0

	for(var/mob/M in range(1, master_item.loc))
		if (M.s_active == src)
			src.close(M)
	return 1

/obj/item/weapon/storage/internal/Adjacent(var/atom/neighbor)
	return master_item.Adjacent(neighbor)
