//Please use mob or src (not usr) in these procs. This way they can be called in the same fashion as procs.
/client/verb/wiki()
	set name = "wiki"
	set desc = "Visit the wiki."
	set hidden = 1
	if( config.wikiurl )
		if(alert("This will open the wiki in your browser. Are you sure?",,"Yes","No")=="No")
			return
		src << link(config.wikiurl)
	else
		src << "\red The wiki URL is not set in the server configuration."
	return

/client/verb/github()//�� ������ ��� ��������
	set name = "github"
	set desc = "Visit the our github repository."
	set hidden = 1
	if( config.githuburl )
		if(alert("This will open the github in your browser. Are you sure?",,"Yes","No")=="Yes")
			src << link(config.githuburl)
	else
		src << "\red The github URL is not set in the server configuration."
	return

var/list/bagreports = list()

/client/verb/fast_bag_report()//�� ������ ��� ��������
	set name = "fast_bag_report"
	set desc = "You can read and write here about actual errors."
	set hidden = 1
	var/dat = "<html><body>"
	for(var/message in bagreports)
		if(message)
			dat += sanitize_simple(message)
			//dat += "<a href=?bagreport_remove> Remove</a>"
			dat += "<br><br>"
	dat += "<a href=?bagreport_add><b>\[Add Report\]</a></b><br>"
	dat += "</body></html>"
	usr << browse(dat, "window=bagreport;size=300x400")

/world/New()
	..()
	var/file = file2text("data/bagreport.txt")
	bagreports = splittext(file, "\n")
	for(var/mes in bagreports)
		mes = sanitize_simple(mes)


/world/Del()
	fdel("data/bagreport.txt")
	for(var/message in bagreports)
		if(message)	text2file("[message]\n","data/bagreport.txt")
	..()


/client/Topic(href)
	if(href == "bagreport_add")
		var/message = input("������� �������� ������.","���������")
		if(message)
			bagreports += "<b>[usr.key]:</b> [message]"
		fast_bag_report()

	else ..()

/client/verb/forum()
	set name = "forum"
	set desc = "Visit the forum ingame."
	set hidden = 1
	if(mob.Selected_Forum)	mob.Display_HTML_Forum()
	else	mob.Display_HTML_SubForum()

#define BACKSTORY_FILE "config/backstory.html"
/client/verb/backstory()
	set name = "backstory"
	set desc = "Show our backstories."
	set hidden = 1

	src << browse(file(BACKSTORY_FILE), "window=backstory;size=480x320")
	return
#undef BACKSTORY_FILE


#define RULES_FILE "config/rules.html"
/client/verb/rules()
	set name = "Rules"
	set desc = "Show Server Rules."
	set hidden = 1
	src << browse(file(RULES_FILE), "window=rules;size=480x320")
#undef RULES_FILE

/client/verb/hotkeys_help()
	set name = "hotkeys-help"
	set category = "OOC"

	var/hotkey_mode = {"<font color='purple'>
Hotkey-Mode: (hotkey-mode must be on)
\tTAB = toggle hotkey-mode
\ta = left
\ts = down
\td = right
\tw = up
\tq = drop
\te = equip
\tr = throw
\tt = say
\t5 = emote
\tx = swap-hand
\tz = activate held object (or y)
\tj = toggle-aiming-mode
\tf = cycle-intents-left
\tg = cycle-intents-right
\t1 = help-intent
\t2 = disarm-intent
\t3 = grab-intent
\t4 = harm-intent
</font>"}

	var/other = {"<font color='purple'>
Any-Mode: (hotkey doesn't need to be on)
\tCtrl+a = left
\tCtrl+s = down
\tCtrl+d = right
\tCtrl+w = up
\tCtrl+q = drop
\tCtrl+e = equip
\tCtrl+r = throw
\tCtrl+x = swap-hand
\tCtrl+z = activate held object (or Ctrl+y)
\tCtrl+f = cycle-intents-left
\tCtrl+g = cycle-intents-right
\tCtrl+1 = help-intent
\tCtrl+2 = disarm-intent
\tCtrl+3 = grab-intent
\tCtrl+4 = harm-intent
\tF1 = adminhelp
\tF2 = ooc
\tF3 = say
\tF4 = emote
\tDEL = pull
\tINS = cycle-intents-right
\tHOME = drop
\tPGUP = swap-hand
\tPGDN = activate held object
\tEND = throw
</font>"}

	var/admin = {"<font color='purple'>
Admin:
\tF5 = Aghost (admin-ghost)
\tF6 = player-panel-new
\tF7 = admin-pm
\tF8 = Invisimin
</font>"}

	src << hotkey_mode
	src << other
	if(holder)
		src << admin
