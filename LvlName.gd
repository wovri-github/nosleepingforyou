extends GDScript
class_name LvlNames

const NAME = {
	"1": "Zbyt prosty",
	"1.2": "Całkiem łatwy",
	"1.4": "Łatwy",
	"1.6": "Normalny",
	"1.8": "Średni",
	"2": "Trudny",
	"2.2": "Bardzo trudny",
	"2.4": "Extremalnie trudny",
	"2.6": "Ło panie!",
	"2.8": "Niemożliwy",
	"3": "Spróbuj przeżyć 10 sekund",

}

static func get_lvl_name(num):
	if num < 3.1:
		return NAME[str(num)]
	else:
		return str("Wygrałeś! Możesz grać dalej. Twój poziom to: ", num)
