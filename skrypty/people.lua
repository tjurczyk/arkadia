scripts["people"] = scripts["people"] or { db = {}, mail = {}, enemies = {} }

scripts.people.db = db:create("people", {
    people = {
        name = "",
        short = "",
        title = "",
        updated = "",
        note = "",
        enemy = 0,
        guild = 0,
        room_id = -1,
        changed = db:Timestamp("CURRENT_TIMESTAMP"),
        _index = { "name", "short" }
    }
})

scripts.people["showing_names"] = true
scripts.people["updating_names"] = false

scripts.people["name_color"] = "yellow"
scripts.people["guild_color"] = "dark_orange"

scripts.people["people_triggers"] = scripts.people["people_triggers"] or {}
scripts.people["people_triggers_objects"] = scripts.people["people_triggers_objects"] or {}

scripts.people.enemy_guilds = {}
scripts.people.enemy_people = {}
scripts.people.enemy_table = scripts.people.enemy_table or {}
scripts.people.enemy_suffix = {}

scripts.people.keep_binds_unchanged = false
scripts.people.show_binds_setting = 1

scripts.people.colored_guilds = {}
scripts.people.colored_people = {}
scripts.people.color_table = {}
scripts.people.color_suffix = {}
scripts.people.color_items = scripts.people.color_items or {}

scripts.people.trigger_guilds = {
    "CKN", "ES", "SC", "KS", "KM", "OS",
    "OHM", "SGW", "PE", "WKS", "LE", "KG",
    "KGKS", "MC", "OK", "RA", "GL", "ZT",
    "ZS", "ZH", "GP"
}
--scripts.people.trigger_guilds = {}
scripts.people.trigger_items = scripts.people.trigger_items or {}
scripts.people.trigger_suffix = {}

function trigger_func_skrypty_people_przedstawienie()
    scripts.people:process_someone(multimatches[1][3], multimatches[2][1])
end

function trigger_func_skrypty_people_przedstawianie_ra()
    scripts.people:process_someone(matches[3], matches[4])
end

function trigger_func_skrypty_people_przedstawianie_jakas_pochodzeniowka()
    scripts.people:process_someone(matches[3], matches[4])
end

function trigger_func_skrypty_people_przedstawianie_korki()
    scripts.people:process_someone(matches[3], matches[4])
end

function trigger_func_skrypty_people_poczta_tablica()
    scripts.people.mail:check_table(matches[2])
end

function trigger_func_skrypty_people_paczka()
    scripts.people.mail:check_package_person(matches[2])
end

function alias_func_skrypty_people_ktoto()
    scripts.people:search(matches[2])
end

function alias_func_skrypty_people_osoba()
    scripts.people:print_id_details(tonumber(matches[2]))
end

function alias_func_skrypty_people_przeszukaj()
    scripts.people:search_hard(matches[2])
end

function alias_func_skrypty_people_przypomnij()
    scripts.people:search_name(matches[2])
end

function alias_func_skrypty_people_pokaz_wrogow()
    scripts.people:show_enemies()
end

function alias_func_skrypty_people_dodaj_osobe()
    scripts.people:add_person_to_db(matches[2])
end

function alias_func_skrypty_people_usun_osobe()
    scripts.people:remove_person_from_db(tonumber(matches[2]))
end

function alias_func_skrypty_people_dodaj_gildie()
    scripts.people:add_person_to_guild(tonumber(matches[2]), matches[3])
end

function alias_func_skrypty_people_usun_gildie()
    scripts.people:add_person_to_guild(tonumber(matches[2]), 0)
end

function alias_func_skrypty_people_zgildiowani()
    scripts.people:print_guilded(string.upper(matches[2]))
end

function alias_func_skrypty_people_gildie()
    scripts.people:print_guilds()
end

function alias_func_skrypty_people_help()
    scripts.people:print_help()
end

function alias_func_skrypty_people_widziani()
    scripts.people:print_last_seen()
end

function alias_func_skrypty_people_aktualizuj_id()
    scripts.people:modify_person(tonumber(matches[2]), matches[3], matches[4])
end

function alias_func_skrypty_people_nabindach()
    show_attack_binds()
end

function alias_func_skrypty_people_nabindach_()
    attack_binds_reset()
end

