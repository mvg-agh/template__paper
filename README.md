# Szablon manuskryptu publikacji do czasopisma anglojęzycznego

Niniejszy projekt ma ułatwić autorom przygotowywanie manuskryptów publikacji do czasopism anglojęzycznych akceptujących dokumenty złożone z użyciem systemu LaTeX (bądź wręcz wymagających użycia tego systemu). Zawiera również pomocnicze skrypty napisane w MATLAB-ie, które umożliwiają wygodne portowanie wykresów z MATLAB-a do LaTeX-a (z użyciem biblioteki TikZ).

Autor:  **Paweł Kłeczek**   (**[pkleczek@agh.edu.pl](pkleczek@agh.edu.pl)**), AGH (Kraków), WEAIiIB, KAiR

----

## Edytor LaTeX-a

Składu manuskryptu warto dokonywać w edytorze dedykowanym dla projektów LaTeX-a, np. [TeXstudio](https://www.texstudio.org/).

W TeXstudio istnieje możliwość stosowania w komentarzu standardowych znaczników ``TODO`` i ``FIXME`` do oznaczania miejsc wymagających dopracowania, przykładowo:

    % TODO: opisać wyniki

    % FIXME: poprawić ten wzór
    $x = 1$

Komentarze te są podświetlane w tekście oraz widoczne w drzewie struktury projektu po rozwinięciu sekcji *TODO*.
Istnieje możliwość definiowania własnych znaczników: z menu wybrać *Options > Configure TeXstudio...*, wybrać *Adv. Editor* i w sekcji *Structure Panel* w polu *Regular expression for TODO comment* dodać odpowiednie etykiety.

TeXstudio posiada też opcję do szybkiego odnajdywania w dokumencie PDF miejsca odpowiadającego danemu miejscu w kodzie LaTeX-a (i *vice versa*) – **po skompilowaniu i pokazaniu podglądu dokumentu** (*Tools > Build & View*) kliknij PPM w tekście i wybierz *Go to PDF* bądź analogicznie kliknij PPM w wybranym miejscu w podglądzie dokumentu PDF i wybierz *Go to Source*.

## matlab2tikz

Aby wygenerować szkielet wykresu w TikZ na podstawie wykresu w MATLAB-ie możesz użyć funkcji ``matlab2tikz()`` – do pobrania ze strony [https://github.com/matlab2tikz/matlab2tikz](https://github.com/matlab2tikz/matlab2tikz).

Ponieważ domyślne formatowanie wykresów wygenerowanych za pomocą ``matlab2tikz()`` nie zawsze jest estetyczne, pewnie zmiany należy wprowadzić ręcznie. W związku z tym, aby mieć na bieżąco podgląd wykresu z dobrym formatowaniem **oraz** z aktualnymi danymi, wygenerowany plik TikZ warto poddać procesowi parametryzacji (m.in. zakresy wartości na osiach, dane).
W ten sposób po dopracowaniu warstwy wizualnej możemy ponownie generować jedynie pliki konfiguracyjne wykresów i nadpisywać w katalogu z plikami manuskryptu stare wersje nowymi.

Wygenerowane dokumenty można dołączać w plikach ``.tex`` za pomocą polecenia ``\input``.

## Tworzenie ilustracji w postaci wektorowej

Do tworzenia ilustracji w postaci wektorowej można użyć np. darmowego programu [Inkscape](https://inkscape.org/).
