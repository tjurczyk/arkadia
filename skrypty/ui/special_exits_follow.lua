function trigger_func_skrypty_ui_special_exits_follow_furtka_otwiera()
    if matches[2] then
        scripts.utils.bind_functional_team_follow(matches[2], "furtka", 15)
    else
        scripts.utils.bind_functional_team_follow(nil, "furtka", 15)
    end
end

function trigger_func_skrypty_ui_special_exits_follow_przeciska_sie_przez_krzaki()
    scripts.utils.bind_functional_team_follow(matches[2], "przecisnij sie przez krzaki", 15)
end

function trigger_func_skrypty_ui_special_exits_follow_wejdz_po_linine()
    scripts.utils.bind_functional_team_follow(matches[2], "wejdz po linie", 15)
end

function trigger_func_skrypty_ui_special_exits_follow_zejdz_po_linie()
    scripts.utils.bind_functional_team_follow(matches[2], "zejdz po linie", 15)
end

function trigger_func_skrypty_ui_special_exits_follow_wspina_na_drzewo()
    scripts.utils.bind_functional_team_follow(matches[2], "wespnij sie na drzewo", 15)
end

function trigger_func_skrypty_ui_special_exits_follow_przedrzyj_przez_bluszcz()
    scripts.utils.bind_functional_team_follow(matches[2], "przedrzyj sie przez bluszcz", 15)
end

function trigger_func_skrypty_ui_special_exits_follow_za_najwiekszy_krzak()
    scripts.utils.bind_functional_team_follow(matches[2], "wejdz za najwiekszy krzak", 15)
end

function trigger_func_skrypty_ui_special_exits_follow_przejdz_furtke()
    scripts.utils.bind_functional_team_follow(matches[2], "przejdz przez furtke", 15)
end

function trigger_func_skrypty_ui_special_exits_follow_zejdz_na_dol()
    scripts.utils.bind_functional_team_follow(matches[2], "zejdz na dol", 15)
end

function trigger_func_skrypty_ui_special_exits_follow_wespnij_na_mur()
    scripts.utils.bind_functional_team_follow(matches[2], "wespnij sie na mur", 15)
end

function trigger_func_skrypty_ui_special_exits_follow_wejdz_po_schodkach()
    scripts.utils.bind_functional_team_follow(matches[2], "wejdz po schodkach", 15)
end

function trigger_func_skrypty_ui_special_exits_follow_zejdz_po_schodkach()
    scripts.utils.bind_functional_team_follow(matches[2], "zejdz po schodkach", 15)
end

function trigger_func_skrypty_ui_special_exits_follow_wejdz_na_luk()
    scripts.utils.bind_functional_team_follow(matches[2], "wejdz na luk", 15)
end

function trigger_func_skrypty_ui_special_exits_follow_zejdz_placyk()
    scripts.utils.bind_functional_team_follow(matches[2], "zejdz na placyk", 15)
end

function trigger_func_skrypty_ui_special_exits_follow_wejdz_do_studni_przecisnij_sie_przez_otwor()
    scripts.utils.bind_functional_team_follow(matches[2], "wejdz do studni;przecisnij sie przez otwor", 15)
end

function trigger_func_skrypty_ui_special_exits_follow_przecisnij_przez_otwor()
    if amap and amap.curr.id == 6134 then
        scripts.utils.bind_functional_team_follow(matches[2], "wejdz do dziupli", 15)
        return
    end
    scripts.utils.bind_functional_team_follow(matches[2], "przecisnij sie przez otwor", 15)
end

function trigger_func_skrypty_ui_special_exits_follow_przecisnij_sie_przez_szczeline()
    scripts.utils.bind_functional_team_follow(matches[2], "przecisnij sie przez szczeline", 15)
end

function trigger_func_skrypty_ui_special_exits_follow_przekrec_czaszke()
    scripts.utils.bind_functional_team_follow(matches[2], "przekrec czaszke", 15)
end

function trigger_func_skrypty_ui_special_exits_follow_poklon_sie_statui()
    scripts.utils.bind_functional_team_follow(matches[2], "poklon sie statui", 15)
end

function trigger_func_skrypty_ui_special_exits_follow_przejdz_wodospad()
    scripts.utils.bind_functional_team_follow(matches[2], "wejdz do wody;przejdz przez wodospad", 15)
end

function trigger_func_skrypty_ui_special_exits_follow_wejdz_w_krzaki()
    if amap and amap.curr and amap.curr.id == 7372 then
        scripts.utils.bind_functional_team_follow(matches[2], "przecisnij sie przez krzaki", 15)
        return
    end

    scripts.utils.bind_functional_team_follow(matches[2], "wejdz w krzaki", 15)
end

function trigger_func_skrypty_ui_special_exits_follow_wejdz_do_kurhanu()
    scripts.utils.bind_functional_team_follow(matches[2], "wejdz do kurhanu", 15)
end

function trigger_func_skrypty_ui_special_exits_follow_wejdz_na_gore()
    if amap and amap.curr and amap.curr.id == 17944 then
        return
    end
    scripts.utils.bind_functional_team_follow(matches[2], "wejdz na gore", 15)
end

function trigger_func_skrypty_ui_special_exits_follow_wejdz_w_otwor()
    scripts.utils.bind_functional_team_follow(matches[2], "wejdz w otwor", 15)
end

function trigger_func_skrypty_ui_special_exits_follow_wejdz_na_plyte()
    scripts.utils.bind_functional_team_follow(matches[2], "wejdz na plyte", 15)
end

function trigger_func_skrypty_ui_special_exits_follow_przeslizgnij_sie_miedzy_beczkami()
    scripts.utils.bind_functional_team_follow(matches[2], "przeslizgnij sie miedzy beczkami", 15)
end

function trigger_func_skrypty_ui_special_exits_follow_wejdz_na_drzewo()
    scripts.utils.bind_functional_team_follow(matches[2], "wejdz na drzewo", 15)
end

function trigger_func_skrypty_ui_special_exits_follow_przejdz_przez_wodospad()
    scripts.utils.bind_functional_team_follow(matches[2], "przejdz przez wodospad", 15)
end

function trigger_func_skrypty_ui_special_exits_follow_wejdz_do_pieczary()
    scripts.utils.bind_functional_team_follow(matches[2], "wejdz do pieczary", 15)
end

function trigger_func_skrypty_ui_special_exits_follow_przeczolgaj_na_poludnie()
    scripts.utils.bind_functional_team_follow(matches[2], "przeczolgaj sie na poludnie", 15)
end

function trigger_func_skrypty_ui_special_exits_follow_przeczolgaj_na_polnoc()
    scripts.utils.bind_functional_team_follow(matches[2], "przeczolgaj sie na polnoc", 15)
end

function trigger_func_skrypty_ui_special_exits_follow_zsun_sie_na_dol()
    scripts.utils.bind_functional_team_follow(matches[2], "zsun sie na dol", 15)
end

function trigger_func_skrypty_ui_special_exits_follow_podwaz_czarny_glaz()
    scripts.utils.bind_functional_team_follow(matches[2], "podwaz czarny glaz", 15)
end

function trigger_func_skrypty_ui_special_exits_follow_wespnij_sie_po_linach()
    scripts.utils.bind_functional_team_follow(matches[2], "wespnij sie po linach", 15)
end

function trigger_func_skrypty_ui_special_exits_follow_zsun_sie_po_linie()
    scripts.utils.bind_functional_team_follow(matches[2], "zsun sie po linie", 15)
end

function trigger_func_skrypty_ui_special_exits_follow_wdrap_na_sciezke()
    scripts.utils.bind_functional_team_follow(matches[2], "wdrap sie na sciezke", 15)
end

function trigger_func_skrypty_ui_special_exits_follow_zapukaj_w_skale()
    scripts.utils.bind_functional_team_follow(matches[2], "zapukaj w skale", 15)
end

function trigger_func_skrypty_ui_special_exits_follow_wespnij_sie_po_scianie()
    scripts.utils.bind_functional_team_follow(matches[2], "wespnij sie po scianie", 15)
end

function trigger_func_skrypty_ui_special_exits_follow_wdrap_sie_po_korzeniu()
    scripts.utils.bind_functional_team_follow(matches[2], "wdrap sie po korzeniu", 15)
end

function trigger_func_skrypty_ui_special_exits_follow_wejdz_po_schodach()
    scripts.utils.bind_functional_team_follow(matches[2], "wejdz po schodach", 15)
end

function trigger_func_skrypty_ui_special_exits_follow_skocz_do_stawu()
    scripts.utils.bind_functional_team_follow(matches[2], "skocz do stawu", 15)
end

function trigger_func_skrypty_ui_special_exits_follow_wejdz_na_most()
    scripts.utils.bind_functional_team_follow(matches[2], "wejdz na most", 15)
end

function trigger_func_skrypty_ui_special_exits_follow_przeplyn_na_polnoc()
    scripts.utils.bind_functional_team_follow(matches[2], "przeplyn na polnoc", 15)
end

function trigger_func_skrypty_ui_special_exits_follow_przeplyn_na_poludnie()
    scripts.utils.bind_functional_team_follow(matches[2], "przeplyn na poludnie", 15)
end

function trigger_func_skrypty_ui_special_exits_follow_wespnij_na_barak()
    scripts.utils.bind_functional_team_follow(matches[2], "wespnij sie na barak", 15)
end

function trigger_func_skrypty_ui_special_exits_follow_przeskocz_palisade()
    scripts.utils.bind_functional_team_follow(matches[2], "przeskocz palisade", 15)
end

function trigger_func_skrypty_ui_special_exits_follow_otworz_klape()
    scripts.utils.bind_functional_team_follow(matches[2], "otworz klape", 15)
end

function trigger_func_skrypty_ui_special_exits_follow_przesun_pien()
    scripts.utils.bind_functional_team_follow(matches[2], "przesun pien", 15)
end

function trigger_func_skrypty_ui_special_exits_follow_wskocz_do_jamy()
    scripts.utils.bind_functional_team_follow(matches[2], "wskocz do jamy", 15)
end

function trigger_func_skrypty_ui_special_exits_follow_wdrap_sie_na_gore()
    scripts.utils.bind_functional_team_follow(matches[2], "wdrap sie na gore", 15)
end

function trigger_func_skrypty_ui_special_exits_follow_nacisnij_kamien()
    scripts.utils.bind_functional_team_follow(matches[2], "nacisnij kamien", 15)
end

function trigger_func_skrypty_ui_special_exits_follow_zejdz_pod_most()
    scripts.utils.bind_functional_team_follow(matches[2], "zejdz pod most", 15)
end

function trigger_func_skrypty_ui_special_exits_follow_wespnij_sie_na_most()
    scripts.utils.bind_functional_team_follow(matches[2], "wespnij sie na most", 15)
end

function trigger_func_skrypty_ui_special_exits_follow_przecisnij_obok_drzewa()
    scripts.utils.bind_functional_team_follow(matches[2], "przecisnij sie obok drzewa", 15)
end

function trigger_func_skrypty_ui_special_exits_follow_wejdz_do_komina()
    scripts.utils.bind_functional_team_follow(matches[2], "wejdz do komina", 15)
end

function trigger_func_skrypty_ui_special_exits_follow_zejdz_na_dol_po_drabinie()
    scripts.utils.bind_functional_team_follow(matches[2], "zejdz na dol po drabinie", 15)
end

function trigger_func_skrypty_ui_special_exits_follow_przeskocz_wyrwe()
    scripts.utils.bind_functional_team_follow(matches[2], "przeskocz wyrwe", 15)
end

function trigger_func_skrypty_ui_special_exits_follow_wejdz_do_krypty()
    scripts.utils.bind_functional_team_follow(matches[2], "wejdz do krypty", 15)
end

function trigger_func_skrypty_ui_special_exits_follow_przejdz_przez_strumien()
    scripts.utils.bind_functional_team_follow(matches[2], "przejdz przez strumien", 15)
end

function trigger_func_skrypty_ui_special_exits_follow_przejdz_za_glaz()
    scripts.utils.bind_functional_team_follow(matches[2], "przejdz za glazy", 15)
end

function trigger_func_skrypty_ui_special_exits_follow_zejdz_nad_strumien()
    scripts.utils.bind_functional_team_follow(matches[2], "zejdz nad strumien", 15)
end

function trigger_func_skrypty_ui_special_exits_follow_wejdz_na_podest()
    scripts.utils.bind_functional_team_follow(matches[2], "wejdz na podest", 15)
end

function trigger_func_skrypty_ui_special_exits_follow_wejdz_do_grobowca()
    scripts.utils.bind_functional_team_follow(matches[2], "wejdz do grobowca", 15)
end

function trigger_func_skrypty_ui_special_exits_follow_wejdz_w_sciane()
    scripts.utils.bind_functional_team_follow(matches[2], "wejdz w sciane", 15)
end

function trigger_func_skrypty_ui_special_exits_follow_zeskocz_na_glaz()
    scripts.utils.bind_functional_team_follow(matches[2], "zeskocz na glaz;wskocz do wody;zanurkuj pod wode", 15)
end

function trigger_func_skrypty_ui_special_exits_follow_wskocz_do_wody()
    scripts.utils.bind_functional_team_follow(matches[2], "wskocz do wody", 15)
end

function trigger_func_skrypty_ui_special_exits_follow_zanurkuj_pod_wode()
    scripts.utils.bind_functional_team_follow(matches[2], "zanurkuj pod wode", 15)
end

function trigger_func_skrypty_ui_special_exits_follow_wespnij_sie_na_gore_wespnij_sie_do_gory()
    scripts.utils.bind_functional_team_follow(matches[2], "wespnij sie na gore;wespnij sie do gory", 15)
end

function trigger_func_skrypty_ui_special_exits_follow_obroc_rzezbe()
    scripts.utils.bind_functional_team_follow(multimatches[1][1], "obroc rzezbe", 15)
end

function trigger_func_skrypty_ui_special_exits_follow_zejdz_po_drabinie()
    scripts.utils.bind_functional_team_follow(matches[2], "opusc bronie;zejdz po drabinie;" .. scripts.inv.weapons.wield, 15)
end

function trigger_func_skrypty_ui_special_exits_follow_zejdz_po_drabinie_2()
    scripts.utils.bind_functional_team_follow(matches[2], "zejdz po drabinie", 15)
end

function trigger_func_skrypty_ui_special_exits_follow_wejdz_po_drabinie()
    if amap and amap.curr and amap.curr.id == 17944 then
        scripts.utils.bind_functional_team_follow(matches[2], "wespnij sie na gore", 15)
        return
    end
    scripts.utils.bind_functional_team_follow(matches[2], "opusc bronie;wejdz po drabinie;" .. scripts.inv.weapons.wield, 15)
end

function trigger_func_skrypty_ui_special_exits_follow_przejdz_przez_wneke()
    scripts.utils.bind_functional_team_follow(matches[2], "przejdz przez wneke", 15)
end

function trigger_func_skrypty_ui_special_exits_follow_wejdz_do_baszty()
    scripts.utils.bind_functional_team_follow(matches[2], "wejdz do baszty", 15)
end

function trigger_func_skrypty_ui_special_exits_follow_wejdz_do_czerwonego_wozu()
    scripts.utils.bind_functional_team_follow(matches[2], "wejdz do czerwonego wozu", 15)
end

function trigger_func_skrypty_ui_special_exits_follow_zejdz_po_drabince()
    scripts.utils.bind_functional_team_follow(matches[2], "opusc bronie;zejdz po drabince;" .. scripts.inv.weapons.wield, 15)
end

function trigger_func_skrypty_ui_special_exits_follow_wdrap_sie_na_glaz()
    scripts.utils.bind_functional_team_follow(matches[2], "wdrap sie na glaz", 15)
end

function trigger_func_skrypty_ui_special_exits_follow_wdrap_glaz_polke()
    scripts.utils.bind_functional_team_follow(matches[2], "wdrap sie na glaz;wespnij sie na polke", 15)
end

function trigger_func_skrypty_ui_special_exits_follow_przeplyn_rzeke()
    scripts.utils.bind_functional_team_follow(matches[2], "przeplyn rzeke", 15)
end

function trigger_func_skrypty_ui_special_exits_follow_wejdz_w_szczeline()
    scripts.utils.bind_functional_team_follow(matches[2], "wejdz w szczeline", 15)
end

function trigger_func_skrypty_ui_special_exits_follow_wdrap_sie_na_polke()
    scripts.utils.bind_functional_team_follow(matches[2], "wdrap sie na polke", 15)
end

function trigger_func_skrypty_ui_special_exits_follow_zeskocz_na_dol()
    scripts.utils.bind_functional_team_follow(matches[2], "zeskocz na dol", 15)
end

function trigger_func_skrypty_ui_special_exits_follow_wejdz_do_krypty()
    scripts.utils.bind_functional_team_follow(matches[2], "wejdz do krypty", 15)
end

function trigger_func_skrypty_ui_special_exits_follow_wslizgnij_sie_do_otworu()
    scripts.utils.bind_functional_team_follow(matches[2], "wslizgnij sie do otworu", 15)
end

function trigger_func_skrypty_ui_special_exits_follow_zejdz_do_rozpadliny()
    scripts.utils.bind_functional_team_follow(matches[2], "zejdz do rozpadliny", 15)
end

function trigger_func_skrypty_ui_special_exits_follow_wejdz_do_chaty()
    scripts.utils.bind_functional_team_follow(matches[2], "wejdz do chaty", 15)
end

function trigger_func_skrypty_ui_special_exits_follow_wejdz_do_alkierza()
    scripts.utils.bind_functional_team_follow(matches[2], "wejdz do alkierza", 15)
end

function trigger_func_skrypty_ui_special_exits_follow_unies_krate()
    scripts.utils.bind_functional_team_follow(matches[2], "unies " .. matches[3], 15)
end

function trigger_func_skrypty_ui_special_exits_follow_wejdz_do_namiotu()
    scripts.utils.bind_functional_team_follow(matches[2], "wejdz do namiotu", 15)
end

function trigger_func_skrypty_ui_special_exits_follow_zejdz_po_pniu()
    scripts.utils.bind_functional_team_follow(matches[2], "zejdz po pniu", 15)
end

function trigger_func_skrypty_ui_special_exits_follow_wejdz_po_stopniach()
    scripts.utils.bind_functional_team_follow(matches[2], "wejdz po stopniach", 15)
end

function trigger_func_skrypty_ui_special_exits_follow_wespnij_sie_po_pniu()
    scripts.utils.bind_functional_team_follow(matches[2], "wespnij sie po pniu", 15)
end

function trigger_func_skrypty_ui_special_exits_follow_przecisnij_sie_na_polnoc()
    scripts.utils.bind_functional_team_follow(matches[2], "przecisnij sie na polnoc", 15)
end

function trigger_func_skrypty_ui_special_exits_follow_przecisnij_sie_na_poludnie()
    scripts.utils.bind_functional_team_follow(matches[2], "przecisnij sie na poludnie", 15)
end

function trigger_func_skrypty_ui_special_exits_follow_przeskocz_przepasc()
    scripts.utils.bind_functional_team_follow(matches[2], "przeskocz przepasc", 15)
end

function trigger_func_skrypty_ui_special_exits_follow_wspinac_po_scianie_jaru()
    scripts.utils.bind_functional_team_follow(matches[2], "wejdz na gore", 15)
end

function trigger_func_skrypty_ui_special_exits_follow_chwytajac_sie_skalnych_ostepow()
    scripts.utils.bind_functional_team_follow(matches[2], "zejdz po scianie", 15)
end

function trigger_func_skrypty_ui_special_exits_follow_chwyta_ukrytych_za_miniaturowym_wodospadem_wystepow()
    scripts.utils.bind_functional_team_follow(matches[2], "wespnij sie po scianie", 15)
end

function trigger_func_skrypty_ui_special_exits_follow_podchodzi_do_szczeliny_we_wschodniej()
    scripts.utils.bind_functional_team_follow(matches[2], "przecisnij sie przez szczeline", 15)
end

function trigger_func_skrypty_ui_special_exits_follow_wejdz_do_jamy()
    scripts.utils.bind_functional_team_follow(matches[2], "wejdz do jamy", 15)
end

function trigger_func_skrypty_ui_special_exits_follow_wespnij_sie_po_lancuchu()
    scripts.utils.bind_functional_team_follow(matches[2], "wespnij sie po lancuchu", 15)
end

function trigger_func_skrypty_ui_special_exits_follow_zejdz_po_lancuchu()
    scripts.utils.bind_functional_team_follow(matches[2], "zejdz po lancuchu", 15)
end

function trigger_func_skrypty_ui_special_exits_follow_zejdz_na_polke()
    scripts.utils.bind_functional_team_follow(matches[2], "zejdz na polke", 15)
end

function trigger_func_skrypty_ui_special_exits_follow_wejdz_na_szczyt()
    scripts.utils.bind_functional_team_follow(matches[2], "wespnij sie na szczyt", 15)
end

function trigger_func_skrypty_ui_special_exits_follow_wespnij_sie_na_polke()
    scripts.utils.bind_functional_team_follow(matches[2], "wespnij sie na polke", 15)
end

function trigger_func_skrypty_ui_special_exits_follow_przeskocz_szczeline()
    scripts.utils.bind_functional_team_follow(matches[2], "przeskocz szczeline", 15)
end

function trigger_func_skrypty_ui_special_exits_follow_wskocz_na_most()
    scripts.utils.bind_functional_team_follow(matches[2], "wskocz na most", 15)
end

function trigger_func_skrypty_ui_special_exits_follow_wespnij_sie_po_glazach()
    scripts.utils.bind_functional_team_follow(matches[2], "wespnij sie po glazach", 15)
end

function trigger_func_skrypty_ui_special_exits_follow_wespnij_sie_po_linie()
    scripts.utils.bind_functional_team_follow(matches[2], "wespnij sie po linie", 15)
end

function trigger_func_skrypty_ui_special_exits_follow_wcisnij_plaskorzezbe()

    scripts.utils.bind_functional_team_follow(matches[2], "wcisnij plaskorzezbe", 15)
end

function trigger_func_skrypty_ui_special_exits_follow_otworz_sarkofag_wejdz_do_sarkofagu()
    scripts.utils.bind_functional_team_follow(matches[2], "otworz sarkofag;wejdz do sarkofagu", 15)
end

function trigger_func_skrypty_ui_special_exits_follow_wejdz_do_jaskini()
    scripts.utils.bind_functional_team_follow(matches[2], "wejdz do jaskini", 15)
end

function trigger_func_skrypty_ui_special_exits_follow_opusc_bron_wejdz_po_drabince_dobadz_broni()
    scripts.utils.bind_functional_team_follow(matches[2], "opusc bronie;wejdz po drabinie;" .. scripts.inv.weapons.wield, 15)
end

function trigger_func_skrypty_ui_special_exits_follow_wejdz_na_pien()
    scripts.utils.bind_functional_team_follow(matches[2], "wejdz na pien", 15)
end

function trigger_func_skrypty_ui_special_exits_follow_wejdz_do_wyrwy()
    scripts.utils.bind_functional_team_follow(matches[2], "wejdz do wyrwy", 15)
end

function trigger_func_skrypty_ui_special_exits_follow_wcisnij_zapadke()
    scripts.utils.bind_functional_team_follow(matches[2], "wcisnij zapadke", 15)
end

function trigger_func_skrypty_ui_special_exits_follow_wejdz_do_otworu()
    scripts.utils.bind_functional_team_follow(matches[2], "wejdz do otworu", 15)
end

function trigger_func_skrypty_ui_special_exits_follow_przeskocz_nad_zaglebieniem()
    scripts.utils.bind_functional_team_follow(matches[2], "przeskocz nad zaglebieniem", 15)
end

function trigger_func_skrypty_ui_special_exits_follow_zjedz_na_dol()
    scripts.utils.bind_functional_team_follow(matches[2], "zjedz na dol", 15)
end

function trigger_func_skrypty_ui_special_exits_follow_wyjscie()
    scripts.utils.bind_functional_team_follow(matches[2], "wyjscie", 15)
end

function trigger_func_skrypty_ui_special_exits_follow_przeskocz_przez_przepasc()
    scripts.utils.bind_functional_team_follow(matches[2], "przeskocz przez przepasc", 15)
end

function trigger_func_skrypty_ui_special_exits_follow_wejdz_do_tunelu()
    scripts.utils.bind_functional_team_follow(matches[2], "wejdz do tunelu", 15)
end

function trigger_func_skrypty_ui_special_exits_follow_wespnij_sie_po_skale()
    scripts.utils.bind_functional_team_follow(matches[2], "wespnij sie po skale", 15)
end

function trigger_func_skrypty_ui_special_exits_follow_przeskocz_na_most()
    scripts.utils.bind_functional_team_follow(matches[2], "przeskocz na most", 15)
end

function trigger_func_skrypty_ui_special_exits_follow_przeskocz_na_polke()
    scripts.utils.bind_functional_team_follow(matches[2], "przeskocz na polke", 15)
end

function trigger_func_skrypty_ui_special_exits_follow_przepraw_sie_przez_rzeke()
    scripts.utils.bind_functional_team_follow(matches[2], "przepraw sie przez rzeke", 15)
end

function trigger_func_skrypty_ui_special_exits_follow_zanurkuj()
    scripts.utils.bind_functional_team_follow(matches[2], "zanurkuj", 15)
end

function trigger_func_skrypty_ui_special_exits_follow_przesun_plyte()
    scripts.utils.bind_functional_team_follow(matches[2], "przesun plyte", 15)
end

function trigger_func_skrypty_ui_special_exits_follow_wskocz_do_studni()
    scripts.utils.bind_functional_team_follow(matches[2], "wskocz do studni", 15)
end

function trigger_func_skrypty_ui_special_exits_follow_dotknij_slupa()
    scripts.utils.bind_functional_team_follow(matches[2], "dotknij slupa", 15)
end

function trigger_func_skrypty_ui_special_exits_follow_przejdz_przez_zachodnia_sciane()
    scripts.utils.bind_functional_team_follow(matches[2], "przejdz przez zachodnia sciane", 15)
end

function trigger_func_skrypty_ui_special_exits_follow_obejdz_budynek()
    scripts.utils.bind_functional_team_follow(matches[2], "obejdz budynek", 15)
end

function trigger_func_skrypty_ui_special_exits_follow_wdrap_sie_po_sznurze()
    scripts.utils.bind_functional_team_follow(matches[2], "wdrap sie po sznurze", 15)
end

function trigger_func_skrypty_ui_special_exits_follow_wejdz_po_korzeniu()
    scripts.utils.bind_functional_team_follow(matches[2], "wejdz po korzeniu", 15)
end

function trigger_func_skrypty_ui_special_exits_follow_zeskocz_na_placyk()
    scripts.utils.bind_functional_team_follow(matches[2], "zeskocz na placyk", 15)
end

function trigger_func_skrypty_ui_special_exits_follow_wejdz_do_latarni()
    scripts.utils.bind_functional_team_follow(matches[2], "wejdz do latarni", 15)
end

function trigger_func_skrypty_ui_special_exits_follow_wespnij_sie_na_skarpe()
    scripts.utils.bind_functional_team_follow(matches[2], "wespnij sie na skarpe", 15)
end

function trigger_func_skrypty_ui_special_exits_follow_wcisnij_sie_do_wneki()
    scripts.utils.bind_functional_team_follow(matches[2], "wcisnij sie do wneki", 15)
end

function trigger_func_skrypty_ui_special_exits_follow_wyjdz_na_zewnatrz()
    scripts.utils.bind_functional_team_follow(matches[2], "wyjdz na zewnatrz", 15)
end

function trigger_func_skrypty_ui_special_exits_follow_wejdz_po_drabince_na_gore()
    scripts.utils.bind_functional_team_follow(matches[2], "wejdz po drabince na gore", 15)
end

function trigger_func_skrypty_ui_special_exits_follow_wejdz_do_dziury()
    scripts.utils.bind_functional_team_follow(matches[2], "wejdz do dziury", 15)
end

function trigger_func_skrypty_ui_special_exits_follow_przeczolgaj_sie_pod_pniem()
    scripts.utils.bind_functional_team_follow(matches[2], "przeczolgaj sie pod pniem", 15)
end

function trigger_func_skrypty_ui_special_exits_follow_zejdz_po_drabince_na_dol()
    scripts.utils.bind_functional_team_follow(matches[2], "zejdz po drabince na dol", 15)
end

function trigger_func_skrypty_ui_special_exits_follow_zeskocz_na_polke()
    scripts.utils.bind_functional_team_follow(matches[2], "zeskocz na polke", 15)
end

function trigger_func_skrypty_ui_special_exits_follow_przeskocz_rozpadline()
    scripts.utils.bind_functional_team_follow(matches[2], "przeskocz rozpadline", 15)
end

function trigger_func_skrypty_ui_special_exits_follow_zejdz_po_drabinie()
    scripts.utils.bind_functional_team_follow(matches[2], "zejdz po drabinie", 15)
end

function trigger_func_skrypty_ui_special_exits_follow_przeslizgnij_sie_przez_szczeline()
    scripts.utils.bind_functional_team_follow(matches[2], "przeslizgnij sie przez szczeline", 15)
end


function trigger_func_skrypty_ui_special_exits_follow_wejdz_na_statek(ship)
    scripts.utils.bind_functional_team_follow(matches[1], "wejdz na " .. ship, 15)
end

function trigger_func_skrypty_ui_special_exits_follow_przecisnij_sie_do_baszty()
    scripts.utils.bind_functional_team_follow(matches[2], "przecisnij sie do baszty", 15)
end

function trigger_func_skrypty_ui_special_exits_follow_przecisnij_sie_miedzy_skalami()
    scripts.utils.bind_functional_team_follow(matches[2], "przecisnij sie miedzy skalami", 15)
end

function trigger_func_skrypty_ui_special_exits_follow_przecisnij_sie_przez_gaszcz()
    scripts.utils.bind_functional_team_follow(matches[2], "przecisnij sie przez gaszcz", 15)
end

function trigger_func_skrypty_ui_special_exits_follow_przesun_glaz()
    scripts.utils.bind_functional_team_follow(matches[2], "przesun glaz", 15)
end

function trigger_func_skrypty_ui_special_exits_follow_wejdz_do_szafy()
    scripts.utils.bind_functional_team_follow(matches[2], "wejdz do szafy", 15)
end

function trigger_func_skrypty_ui_special_exits_follow_pchnij_sciane()
    scripts.utils.bind_functional_team_follow(matches[2], "pchnij sciane", 15)
end

function trigger_func_skrypty_ui_special_exits_follow_wespnij_sie_do_kraty()
    scripts.utils.bind_functional_team_follow(matches[2], "wespnij sie do kraty", 15)
end

function trigger_func_skrypty_ui_special_exits_follow_wejdz_do_okienka()
    scripts.utils.bind_functional_team_follow(matches[2], "wejdz do okienka", 15)
end

function trigger_func_skrypty_ui_special_exits_follow_przecisnij_sie_przez_lukarne()
    scripts.utils.bind_functional_team_follow(matches[2], "przecisnij sie przez lukarne", 15)
end

function trigger_func_skrypty_ui_special_exits_follow_wejdz_do_sarkofagu()
    scripts.utils.bind_functional_team_follow(matches[2], "wejdz do sarkofagu", 15)
end

function trigger_func_skrypty_ui_special_exits_follow_zejdz_po_zboczu()
    scripts.utils.bind_functional_team_follow(matches[2], "zejdz po zboczu", 15)
end
