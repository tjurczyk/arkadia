local sampleLines = {
    enc("\27[22;38;5;247m\27[22;38;5;247mWojownicy,\n"),
    enc("\27[22;38;5;247m\27[22;38;5;247m\n"),
    enc("\27[22;38;5;247m\27[22;38;5;247mKazdy niewierny zasluguje na unicestwienie, jednak szczegolna uwage Mrocznych Poteg, zwroci smierc tychze:\n"),
    enc("\27[22;38;5;247m\27[22;38;5;247m - czerwononosy wasaty krasnolud\n"),
    enc("\27[22;38;5;247m\27[22;38;5;247m - ogorzaly siwy mezczyzna\n"),
    enc("\27[22;38;5;247m\27[22;38;5;247m - jednooki siwobrody krasnolud\n"),
    enc("\27[22;38;5;247m\27[22;38;5;247m - porywczy jednooki krasnolud\n"),
    enc("\27[22;38;5;247m\27[22;38;5;247m - barczysty siwobrody krasnolud znany jako Jabhorn\n"),
    enc("\27[22;38;5;247m\27[22;38;5;247m - barczysty nerwowy krasnolud/mutant znany jako Zandar\n"),
    enc("\27[22;38;5;247m\27[22;38;5;247m - zgrzybialy smierdzacy gnom\n"),
    enc("\27[22;38;5;247m\27[22;38;5;247m - spokojny ponury gnom\n"),
    enc("\27[22;38;5;247m\27[22;38;5;247m - kruczowlosa czarnooka elfka\n"),
    enc("\27[22;38;5;247m\27[22;38;5;247m - wysoki krwistooki ogr\n"),
    enc("\27[22;38;5;247m\27[22;38;5;247m - rudowlosy gruby krasnolud\n"),
    enc("\27[22;38;5;247m\27[22;38;5;247m - zawadiacki fiolkowooki elf\n"),
    enc("\27[22;38;5;247m\27[22;38;5;247m - wyniosly wiotki elf\n"),
    enc("\27[22;38;5;247m\27[22;38;5;247m - okazaly krostowaty ogr\n"),
    enc("\27[22;38;5;247m\27[22;38;5;247m - mlody wylenialy ogr znany jako Haes\n"),
    enc("\27[22;38;5;247m\27[22;38;5;247m - malomowny umiesniony mezczyzna\n"),
    enc("\27[22;38;5;247m\27[22;38;5;247m - wielki energiczny polelf\n"),
    enc("\27[22;38;5;247m\27[22;38;5;247m - wasaty czujny gnom\n"),
    enc("\27[22;38;5;247m\27[22;38;5;247m - brodaty zlosliwy krasnolud znany jako Zetu\n"),
    enc("\27[22;38;5;247m\27[22;38;5;247m - krotkonogi rudobrody krasnolud\n"),
    enc("\27[22;38;5;247m\27[22;38;5;247m - wielkonosy plomiennobrody krasnolud\n"),
    enc("\27[22;38;5;247m\27[22;38;5;247m - kulawy pajakowaty gnom\n"),
    enc("\27[22;38;5;247m\27[22;38;5;247m - kasztanowowlosy szczawikowaty niziolek\n"),
    enc("\27[22;38;5;247m\27[22;38;5;247m - ciemnoskory zielonooki krasnolud\n"),
    enc("\27[22;38;5;247m\27[22;38;5;247m - rudobrody grozny krasnolud\n"),
    enc("\27[22;38;5;247m\27[22;38;5;247m - rumiana dorodna krasnoludka\n"),
    enc("\27[22;38;5;247m\27[22;38;5;247m - modrooka malomowna elfka\n"),
    enc("\27[22;38;5;247m\27[22;38;5;247m - podstarzaly przysadzisty krasnolud\n"),
    enc("\27[22;38;5;247m\27[22;38;5;247m - kudlaty masywny krasnolud\n"),
    enc("\27[22;38;5;247m\27[22;38;5;247m - zaglodzony maly gnom\n"),
    enc("\27[22;38;5;247m\27[22;38;5;247m - czarnoskory bezwzgledny mezczyzna\n"),
    enc("\27[22;38;5;247m\27[22;38;5;247m - krzaczasty zarosniety krasnolud\n"),
    enc("\27[22;38;5;247m\27[22;38;5;247m - smierdzacy laciaty ogr\n"),
}


local startTest = os.clock()

for i = 1, #sampleLines, 1 do
    gmcp = {
        gmcp_msgs = {
            text = sampleLines[i],
            type = "comm"
        }
    }
    raiseEvent("gmcp.gmcp_msgs", gmcp)
end


local endTest = os.clock()

display((endTest - startTest))
