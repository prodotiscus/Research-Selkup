#!/usr/bin/perl6
# my $s = 'нӓқэлешпугу /об. Ч, вас., тым./ отгл. гл., пер./непер., конкрпроц., НС - 1) тянуть; 2) натягивать; 3) курить; см. нӓқлешпугу'
# my $s = 'нӓдэ́бэ́гу /об. С/ отгл. гл., непер., пас., НС - быть женатым; см. нӓдэббэ́гу'
# my $s = 'нӓдэ́бэ́л /тым./ 1. прич. от гл. нӓдэ́бэ́гу; 2. отгл. прил. - женатый: ~ қуп «женатый человек»'
# my $s = 'нӓлдёлгу /об. Ш/ гл., пер., однокр., С - 1) затоптать: таб нежбо нӓлдённыт /об. Ш/ «он наступил (букв. затоптал) на шиповник»; см. нӓльдёлгу; няльдёлгу'
# my $s = 'нӓқыттықо /тур./ отгл. гл., непер., характ., НС - курить обычно: тэп мелко кансазэ нӓқытта «он всегда трубку (букв. трубкой)курит
# my $s = 'нӓл ~ нӓль /об. Ш, вас., тым./ сущ. нӓ, ф. опред. - женский'
# my $s = 'явол /тур./ сущ. - 1) дьявол; 2) чёрт (< русск.): яволыт қыйты «чёртов дух»'
# my $s = 'я /об. Ч/ отриц. част. - не: ~ шыдедуқут «не врём»; ӣл най шындэ ~ қостэла «сын-твой опять тебя не узнает»; см. а'
# my $s = 'эҗ ~ эҗэ /об., кет., вас., тым./ ~ эҗо ~ эҗи /кет./ сущ. - 1) голос: қун эҗап ӧнтэльдяп /об. Ш/ «голос человека услышал-я»; қун эҗэм ӱндыдисав /кет./ «голос человека услышал-я»; табэ қыгыс парқугу, эҗэдэ нету];а /об. Ч/ «он хотел кричать, голоса-его не было»; окэр челҗоқот пыкан аңмут эҗэ чаннэнҗа /об. Ч/ «однажды изо рта быка голос вышел» (из ск.); 2) слово: онэндэ эҗэм оралбэгу /кет./ «своё слово сдержать»; қудэ ташшэндэ огхолалҗешпа қоштэл эҗэп чэнчугу? /об. Ч/ «кто тебя учит плохое слово говорить?»; 3) язык (речь): қулэй эҗэ /кет./ «человеческий язык»; қульдиң нимдйкваттэ тэ эҗан? /кет./ «как называется на вашем языке?»; 4) речь: ме ӱндыдет тэбын эҗэм соң /кет./ «мы слушали его речь внимательно»; 5) разговор; 6) легенда; 7) сказание; 8) предание: таб эҗэлгук: “Қаиль на эҗ? Ман ныльҗи эҗэ тӓнундак, шэнҗэ а кадэшпал” /об. Ч/ «она говорит: “Разве это предание? Я такое предание знаю, (что) языком не расскажешь”»; см. эҗ'
# my $s = 'эннэт /об. Ч/ нареч., м.-вр. п. - наверху: хэр ~ коимба «снег наверху кружится»'
# my $s = 'аттэкочэ́гу /тым./ отгл. гл., непер., возвр., НС - прятаться; см. ӓггу 1дфужэ́гу'
my $s = 'атымбыгу /кет./ отгл. гл., непер., результ. сост. ~ пас., С/НС - 1) появиться; 2) быть на виду, торчать';
grammar article {
	rule TOP {
		<title_wrap> <meaning_wrap> .*# <meaning_group> <see_group>
	}
	token title_wrap {
		<title_pair>+ % [ [ \h* \~ \h* ] * ] \h+ <prop_wrap>
	}
	token title_pair {
		<title> <geo_marking>*
	}
	token title {
		<symbol_strict>+
	}
	# symbol abstracts
	token symbol_strict {
		<alpha>
	}
	token symbol_med {
		[
			|| \w
			|| "'"
			|| "-"
			|| \d
			|| ";"
		]
	}
	# meaning
	token meaning_wrap {
		\h* "-" \h* <meaning_arr>
	}
	token meaning_arr {
		[
			|| <par_numbered_ma>
		]
	}
	token meaning {
		[
			|| <alpha>
			|| <?after <alpha>> [ <digit> || <punct> ] + <?before <alpha>>
		] + % [ \s * ]

	}
	# # parenthesis numbered meaning arr
	token par_numbered_ma {
		<pm_meaning_group>+ % [ [ \h* \; \h* ] * ]
	}
	token pm_meaning_group {
		\d+ ")" \h* <meaning>+ %% [ \h* [";" || ","] \h* ]
	}
	# properties
	token prop_wrap {
		<property> + % [ [ \h*\,\h* || \h*\~\h* ] + ]
	}
	token property {
		[
			|| [ <[а..я]>\.* ] + % [ [ \s+ || "/" || "-" ] * ]
			|| [ <[А..Я]> ] + % [ "/" * ]
		]
	}
	# geo marking
	token geo_marking {
		\s+ "/" <geo_marks> "/"
	}
	token geo_marks {
		<geo_mark>+ % [ ", "* ]
	}
	token geo_mark {
		[ <geo_obsk> || <geo_default> ]
	}
	token geo_obsk {
		"об. "
		["С" || "Ч" || "Ш"]+ % [ ", "* ]
		\.*
	}
	token geo_default {
		\w+ \.
	}
};
say article.parse($s);
