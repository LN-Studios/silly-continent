extends Node

#open menu
signal open_country_menu(c: Country)
signal open_terr_menu(t: Territory)

#new turn, carried out in phases in alphabet order
signal turn_phase_a(turn)
signal turn_phase_m(turn)
signal turn_phase_z(turn)

#top hud
signal new_balance(new)
signal new_approval(new)
signal new_reputation(new)
signal new_army(new)

#menu signals
signal open_help()

#game signals
signal finish_loading()
signal entities_connected()
signal game_start(country)
signal pause()
signal unpause()

#scripted events
signal spawn_exodus(rate)
signal end_spawn_exodus()
