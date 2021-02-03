# Instalacja skryptów pod rozwój

## Wymagania
* Konto na GitHub (https://github.com/)
* GIT (https://git-scm.com/book/pl/v2/Pierwsze-kroki-Instalacja-Git)

## Rekomendowane
* IDE (np. VS Code, od biedy Sublime wystarczy)

## Pobranie kodu
Bez podstaw GITa się niestety nie obędzie, z dobrych wiadomości, to podstawy wystarczą.
Z podstawami można się np. zapoznać tutaj: https://git-scm.com/book/pl/v2/Pierwsze-kroki-Podstawy-Git

Po zalogowaniu na GitHubie, przechodzimy na [stronę repozytorium skryptów](https://github.com/tjurczyk/arkadia) i robimy `fork`.
W ten sposób utworzymy kopię repozytorium na swoim koncie. Zostaniemy przeniesieni do utworzonego repozytorium.

Z naszego profilu należy usunąć regularną paczkę skryptów, po czym klonujemy nasze repozytorium w katalogu profilu:

Przykład polecenia dla forka `Delwing/arkadia`

```
git clone https://github.com/Delwing/arkadia.git
```

Następnie warto przygotować sobię również "połączenie" z głównym repozytorium.
```
git remote add upstream https://github.com/tjurczyk/arkadia.git
```

Otwieramy Mudlet i następnie zamiast z Package Manager, klikamy Module Manager (strzałka obok Package Managera) i wybieramy `Install Module`, wskazujemy ścieżkę kodu (`[katalog_profilu]/arkadia`).

Ważne, żeby zaznaczyć opcję `sync` wtedy zmiany w triggerach i aliasach będą zapisywane do `Arkadia.xml`.

## Przygotowanie zmiany

Przed każdą zmianą warto przełączyć się na branch `master` i upewnić się, że nasz branch jest on aktualny.

Wpisujemy 
```
git checkout master
git fetch upstream
git merge upstream/main
```

Nasz kod jest aktualny.

Tworzymy nowy `branch`, nazwijmy go jakoś adekwatnie do szykowanej zmiany.

```
git checkout -b nazwa_brancha
```

Wprowadzamy zmianę w kodzie i/lub w xmlu.

Dodajemy pliki do commita.

```
git add .
git commit -m "opis zmian"
git push
```

Po czym przechodzimy na strone naszego repozytorium, zakładka `Pull requests -> New pull request`

Po lewej stronie powinniśmy widzieć

```
base repository: tjuryczk/arkadia base: master
```
Po prawej nasze repozytorium i branch.

Klikamy `Create Pull request`.

Czekamy na review i release. Sprawliśmy, że świat jest lepszy.

# Uwagi do kodu

Zerknijcie na kod przed wykonaniem zmian. Wskazówki jak pisać kod nie są spisane jeszcze.
Na razie istotne jest, żeby trzymać się tej samej konwencji nazweniczej (`snake_case`)

Jak tworzymy alias i triggery to mogą zawierać maksymalnie jedną linię kodu - wywołanie funkcji z pliku `.lua`, najelpiej nazwanej zgodnie z konwencją tj. `trigger_nazwa` lub `alias_nazwa`.

W razie pytań łapcie nas na Discord

*@dzordzyk* i *@Wilk*