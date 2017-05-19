var/list/stone_text_list = list("(������� �������� ��� �������� �������)",
"����� ����� ������� ���������, ����� ������� �� ������� � ����� ������������ �� ������������.",
"����� ��������� ������ ���� � ������ ������� ���� ������ �����.",
"����� ����� ���� �������, ������ ��������.",
"��������� ����� '������ �����'- ���������� ��������",
"��������� ����� �������, �� �� '���� �������', �� �� '����': ���� ��� � ��������� ������� �������� ��� �������... ��������, ���� ���� �� �����������.",
"����� �������: ��� ���� ������������� �����.",
"����� �����: ����� ������� ����� ���������. �� ��������� �� � ����� � �� ��� ������.",
"���� ������. ��������� ����.",
"������ �������: ���������� �� ��������� �������� ������.",
"����� ��������. ����� �������� �������. ������� ������.",
"���� ������. ��� �� ���-�� �����. ��� �� ����� ������, � �� ������������, ����� ���.",
"������ �������. �����. ������������. ���.",
"������ ����������� 2. ���� ������� ������� ��� ���-��, �� �� ���������: '� ���� ������ ����������.'",
"����� ����� ����� ������. ������� �� ������. �� ��� �����.",
"����� �����: ���� ��� ������� ���������� � �������� ����������.",
"�. �. ���������: ����� �������� ������� �����, ������� ��������� ������� ������-�����. ���� � ���!",
"����� ����� ������ ���, � ��� �������� ���, � ������ - ����� ��������� ������.",
"���� ��������: �� �� ��� ����������, ��� � � ����� ���� ��������� �� ���.",
"����� ����� ����, � ������� ��� ������. ����� ��� ������: �������, ��� � ����.",
"������ �����, 25. ���� �� ����� ���, �� ��� ������ ������ � ����� �������� ������.",
"����� �������� ����� ��������, ������� � �������. � ����������� �����, ����� ����������� ��� ����������� ������.",
"�������� �����. �� ����������� ���.",
"���� �������: ������� ����� �����������.",
"������� �� � ����� ����� ���-������ ��������?",
"������ �� ��� �� ��������� � ����� � �� �������� ����-�� �� ������ ������?",
"���� ������: �� �� ��� ��� ������ ��� �����.",
"����� ����� ������ ���. ��������, ��� �� �����.",
"����� ����� ������ �������� ����, �� ����� ������ ������, � ����� �� ���.",
"����� ����� ����, �� ������ �������, �� �������� ����� ��������.",
"��� ���� �������. ���� � ���� ��� �����-�� ������� �������, �� ��� �������.",
"� ��� ���-��. ��� - �� ���� ����.",
"� ������� ���, ��� �����!",
"� �������, ���� � �������� ����� ����-�� - ������ ����� �����, ������� 4 ����.",
"��� ������ ��������, ��� ���� �� ��������, �� ����� �� �� �����.",
"� ���� ������ ����� ��������� �������� �������, ��������� ��������.",
"���� �� ��� ���� ���, � ������ �� ���-���.",
"� ������ � ������ ����� �����. ����� ��� ����, ������� � ����, ���� � �����, ��� ��������. ���� ������� ���� ������� ����, ������ - ������� ��������.",
"��� �������� ����� � ����������� ����� ���� ����������� ����� ������. ��� ����� ���, ����� ���� ���� �������: ����� �� � ��� -- �������, ��������.",
"����� ��: ����� ����, ��� �������� ��������� ����������� �������, ������� ������� �� ���.",
"���� �����: ������, �����, ���������, De Amicitia.",
"��� �����: \"� �� ������� �������� ���������, ����� ������ �����������o\".",
""
)


/obj/structure/tombstone
	icon = 'icons/obj/cemetery.dmi'
	icon_state = "tombstone1"
	density = 1
	anchored = 1
	opacity = 0
	desc = "It's tombstone."
	var/stone_text

	New()
		icon_state = "tombstone[rand(1,8)]"
		stone_text = pick(stone_text_list)
		if(stone_text!="")	stone_text_list -= stone_text

	Click()
		..()
		usr << browse_rsc(new/icon(icon, icon_state), "tombstone.png")
		var/html = {"
<html>
<head><style>
	body {
	background-image: url(tombstone.png);
	background-size: 100%;
	}
</style></head>
<body>
[stone_text]
</body>
</html>
"}
		usr << browse(html, "window=tombstone; size=50x75")
