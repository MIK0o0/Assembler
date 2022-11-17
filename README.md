# Assembler
#Task 1
Zaimplementuj program, który będzie obliczał wartość wyrażenia arytmetycznego wskazanego przez użytkownika. Po uruchomieniu program drukuje (wyświetla) dostępne wyrażenia, wczytuje wybór użytkownika, prosi o podanie wartości zmiennych, drukuje (wyświetla) wynik obliczeń i pyta czy kontynuować obliczenia.

Należy przyjąć, że program oblicza wartości wyrażeń postaci:

1.     a=(b+c)*d  
2.     a=(b-c)/d
3.     a=(b-c)+d
Na wyjściu program powinien podawać wynik działania oraz pytać czy wykonać kolejne działanie, należy przyjąć, że:

·         0: nie

·         1: tak

Jeśli odpowiedź jest pozytywna, to program powinien ponownie przedstawić wyrażenia, których wartości można obliczyć, wczytać wybór użytkownika oraz wartości zmiennych.

 Przykładowe wywołanie:

1.       Numer wyrażenia, którego wartość należy obliczyć: 3

2.       Podaj wartości zmiennych:

3.      b = 48

4.      c = 31

5.      d = 26

6.       Wartość wyrażenia wynosi: 43

7.       Czy kontynuować?: 0 (nie)

#Task 2
Szyfr podstawieniowy Cezara, jest przykładem szyfru opartego na alfabetach przesuniętych. Każdą literę tekstu jawnego zastępuje się literą alfabetu szyfru otrzymaną w wyniku przesunięcia litery źródłowej o k pozycji alfabetu, przy czym alfabet tworzy cykl zamknięty, tzn. po Z następuje A. Kluczem szyfru jest liczba naturalna k. Literę, którą należy podstawić w miejsce szyfrowanego znaku wyznacza się z następującej zależności:

f(a) = (a+k) mod n, 
gdzie:
a – numer pozycji szyfrowanego znaku w alfabecie (numeracja od 0 ze względu na operację modulo),
k – przesunięcie (klucz przekształcenia), 
n – rozmiar alfabetu (liczba jego liter) 

#Task 3
Proszę zaimplementować prosty parser (analizator syntaktyczny) języka asembler. Program ma pobrać od użytkownika (wczytać z wejścia) od 1 do maksymalnie 5 instrukcji ze zbioru podanego poniżej. Dla każdej instrukcji należy sprawdzić jej poprawność oraz typ i zgodność podanych parametrów. Jeśli instrukcja jest poprawna, to odłożyć ją (wraz z parametrami) na stos. Jeśli instrukcja nie jest poprawna program prosi o jej ponowne podanie (do skutku). Na każdy obiekt proszę użyć jednego słowa, np. instrukcja ADD $8, $9, $10 będzie wymagała użycia 4 słów.


Program ma odkładać na stosie instrukcje w następujący sposób (OST = 1, 2, 3, 4 lub 5):

INSTRUKCJAOST

PARAMETR1 INSTRUKCJIOST

PARAMETR2 INSTRUKCJIOST

----------

    ....

----------

INSTRUKCJA2

PARAMETR1 INSTRUKCJI2

PARAMETR2 INSTRUKCJI2

----------

INSTRUKCJA1

PARAMETR1 INSTRUKCJI1

PARAMETR2 INSTRUKCJI1

PARAMETR3 INSTRUKCJI1

---------- (stack bottom)

Po ostatniej instrukcji program drukuje instrukcje na wyjściu w odwrotnej kolejności (ściągając je kolejno ze stosu i przy okazji zmieniając wartość wskaźnika stosu - SP). 

Uwaga: PROGRAM NIE WYKONUJE PODANEGO KODU, tylko weryfikuje instrukcje i jej parametry, a następnie odkłada je na stos.

Dane wejściowe:

liczba instrukcji do do sprawdzenia (od 1 do 5)
kolejno instrukcje w pełnej postaci, :np. "ADD $8, $9, $10" - rejestry podawane są tylko w postaci numerów; aplikacja weryfikuje czy takie rejestry istnieją (p. slajdy z wykładu); UWAGA: liczba parametrów może być różna dla różnych instrukcji
Dane wyjściowe: instrukcje, które zostały wcześniej wprowadzone, wydrukowane w odwrotnej kolejności
Zbiór obsługiwanych instrukcji:

 ADD $r1, $r2, $r3,

 ADDI $r1, $r2, wartosc

 J label

 NOOP

 MULT $s, $t

 JR $r1

 JAL label
 
 #Task 4
 Proszę zaimplementować kalkulator, który będzie operował na liczbach zmiennoprzecinkowych (floating point) podwójnej precyzji. 

Program na wejściu pyta, jaką operację ma wykonać: 

dodawanie, 
odejmowanie, 
mnożenie, 
dzielenie
a następnie prosi o podanie argumentów. 

Na wyjściu program drukuje wynik działania i pyta czy kontynuować obliczenia. 

Proszę zwrócić uwagę na dzielenie przez zero. Program powinien również sygnalizować brak lub nieprawidłowość podanych przez użytkownika argumentów (np. litera zamiast cyfry, kropka czy przecinek do oddzielenia części rzeczywistej i ułamkowej, liczba cyfr po przecinku większa niż dopuszczalna itp.).

#Task 5

Zaimplementuj grę w kółko i krzyżyk, w której jednym z graczy jest użytkownik, drugim - komputer.

Dane wejściowe:

- zawsze użytkownik inicjuje grę i wybiera swój znak (kółko - o, lub krzyżyk - x), drugi znak będzie wtedy znakiem przeciwnika

- użytkownik określa ile rund będzie trwała rozgrywka (1, 2, 3, 4 lub 5)

- dla każdej rundy:

użytkownik podaje numer pola, które zapełnia swoim znakiem (człowiek ma zawsze pierwszy ruch),
komputer stawia swój znak zgodnie z przyjętą strategią (nie może to być strategia losowa)
  kroki 1 i 2 powtarzane są dopóki:
użytkownik lub komputer będą mieli 3 swoje znaki w jednej linii (wiersz, kolumna lub przekątna planszy) lub
nie będzie możliwości wykonania ruchu (wszystkie pola zajęte)
Kolejne ruchy gracza należy definiować podając numer pola, na którym program ma wstawić odpowiedni znak według schematu poniżej:

 1	2	3
 4	5	6
 7	8	9


Dane wyjściowe:
wyniki każdej rundy są zapamiętywane (program zapisuje kto wygrał rundę)
na zakończenie program wyświetla wyniki rywalizacji
Na każdym etapie należy zadbać o kontrolę poprawności wprowadzanych danych, np. tylko ze zbioru o lub x, tylko ze zbioru cyfr 1 do 5 (dla liczby rund) lub 1 do 9 dla numerów pół, na których stawiamy znak. Oczywiste jest, że nie można wstawić znaku na pole, na którym stoi znak przeciwnika.
