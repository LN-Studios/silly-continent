extends Node

#open menu
signal open_country_menu(c: Country)
signal open_terr_menu(t: Territory)

#new turn, carried out in phases in alphabet order
signal turn_phase_a(turn) #update country/territ vars
signal turn_phase_m(turn) #tick down modifier duration, erase expired mods, activate new events
signal turn_phase_t(turn) #recompile incoming changes for next turn
signal turn_phase_z(turn) #display new data

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
signal all_nodes_loaded()
signal game_start(country)

#scripted events
signal spawn_exodus(rate)
signal end_spawn_exodus()
