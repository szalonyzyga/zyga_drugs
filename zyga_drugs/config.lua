Config = {}

Config.NazwaTwojegoEventu = "mythic_progbar:progress"     -- Tutaj dajecie nazwe eventu do progressbara (mythic_progbar)

Config.Zbiorki = {
    {
        name = 'Przyklad',
        interakcjapowiadomienie = 'Naciśnij ~INPUT_CONTEXT~ aby zebrać kokaine.',
        coords = vec3(3295.0940, 5012.8882, 23.7132),
        radius = 10.0,  -- Obszar w którym respią sie markery
        maxmarkerow = 10,
        czaszbierania = 7500,
        progresslabel = "Zbierasz kokaine...",
        powiadomienie = "Zebrałeś ~r~kokaine~s~.",
        powiadomienieanulowano = "Anulowano zbieranie ~r~kokainy~s~.",
        animdict = 'amb@world_human_gardener_plant@female@base', -- Przykładowa animacja
        animka = 'base_female',     -- Przykładowa animacja
        nazwaitemka = 'coke',
        ileitemkadodaje = 1
    },    
}

Config.Przerobki = {
    {
        name = 'Przyklad Przerobki',
        text = '\t[~r~E~s~]\nPrzeróbka kokainy',
        coords = vec3(3792.8757, 4450.8101, 4.9187),
        prop = 'bkr_prop_coke_table01a',
        headingpropa = 176.7083,
        dystans = 20.0,   -- Dystans od którego gracz widzi propa / text
        dystansdowcisniecia = 2.0, -- Dystans od którego gracz może wejść z interakcje ze stolikiem
        czaszbierania = 10000,
        progresslabel = 'Przerabiasz kokaine...',
        powiadomienie = "Przerobiłeś ~r~kokaine~s~.",
        animdict = 'amb@world_human_gardener_plant@female@base', -- Przykładowa animacja
        animka = 'base_female',     -- Przykładowa animacja
        jakiitemusuwa = 'coke',
        ileitemausuwa = 1,
        jakiitemdodaje = 'coke_pure',
        ileitemadodaje = 1,
        niemaitemapowiadomienie = "Nie masz wystarczającej ilości ~r~kokainy~s~."
    },
}

Config.MarkerOptions = {
    type = 2,
    scalex = 0.5,
    scaley = 0.5,
    scalez = 0.5,
    r = 255,
    g = 255,
    b = 255,
    a = 200,
    bobbing = true,
    dystanszebyzobaczyc = 20.0,
}