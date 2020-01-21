with Ada.Text_IO, Ada.Containers;
use Ada.Text_IO, Ada.Containers;

with Ada.Containers.Doubly_Linked_Lists;

procedure main is

   ----------------
   ----Kierunki----
   -----Ruchu------
   ----------------

   type KierunekRuchu is (Gora, Dol, Brak);

   ---------------
   ---Rekord------
   ---------------

   type Rekord is record
      pietro : Integer;
      postoj : Boolean;
      kierunek : KierunekRuchu;
   end record;

   ---------------
   ----Osoba------
   ---------------

   type Osoba is record
      id : integer;
      pietroStart : Integer;
      pietroKoniec : integer;
      kierunek : KierunekRuchu;
   end record;

   ---------------
   -------ID------
   ---------------

   idOsoby : Integer := 1;

   ----------------
   -----Pietra-----
   -------Do-------
   ---Odwiedzenia--
   ----------------

   package Rekord_List is new Ada.Containers.Doubly_Linked_Lists(Rekord);
   TrasaWindy1Pietra : Rekord_List.List;

   ---------------
   --Maksymalna---
   ---Liczba------
   ----Osob-------
   ---------------

   maksymalnaLiczbaOsob : Integer := 10;

   ---------------
   -----Osoby-----
   ---------------

   type Osoba_List is array(1..maksymalnaLiczbaOsob) of Osoba;

   ---------------
   -----Osoby-----
   -----Lista-----
   ---------------

   package Osoba_Lista is new Ada.Containers.Doubly_Linked_Lists(Osoba);
   osobyWWindzie : Osoba_Lista.List;

   ---------------
   ----Ilosc------
   ---Pieter------
   ---------------

   iloscPieter : Integer := 11;

   ---------------
   ----Pietra-----
   ---------------

   type Pietra is array(1..iloscPieter) of Osoba_List;
   pietraLudzie : Pietra;

   ---------------
   ----Pietra-----
   ----ID---------
   ---------------

   type PietraId is array(1..iloscPieter) of Integer;
   pietraLudzieId : PietraId := (1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1);

----------------
-----Winda1-----
----------------

procedure Winda1 is
    aktualnePietro : Integer;
    rek : Rekord;
    listaOsobNaPietrze : Osoba_List;
begin
      while True loop
         if (TrasaWindy1Pietra.Is_Empty) then
            delay(0.5);
            Put_Line("Winda czeka na pasazera");
            exit;
         else
            rek := TrasaWindy1Pietra.First_Element;
            if (rek.postoj = True) then
               delay(2.0);
               Put_Line("Winda dojechala na pietro: " & rek.pietro'Img & " i otwieraja sie drzwi");
               aktualnePietro := rek.pietro;
               for j in osobyWWindzie.Iterate loop
                  if (osobyWWindzie(j).pietroKoniec = aktualnePietro) then
                     Put_Line("Osoba " & osobyWWindzie(j).id'Img & " wysiada");
                     --osobyWWindzie.Delete(j);
                  end if;
               end loop;
               listaOsobNaPietrze := pietraLudzie(rek.pietro);
               for i in listaOsobNaPietrze'Range loop
                  if (not(listaOsobNaPietrze(i).id = 0)) then
                     Put_Line("Osoba " & listaOsobNaPietrze(i).id'Img & " wsiada i chce jechac na pietro: " & listaOsobNaPietrze(i).pietroKoniec'Img);
                     osobyWWindzie.Append(listaOsobNaPietrze(i));
                     listaOsobNaPietrze(i).id := 0;
                  end if;
               end loop;
               Put_Line("Zamykaja sie drzwi windy");
            else
               delay(1.0);
               Put_Line("Winda minela pietro: " & rek.pietro'Img);
            end if;
            TrasaWindy1Pietra.Delete_First;
         end if;
      end loop;
end Winda1;

----------------
---Sterownik----
------Windy-----
----------------

procedure dodajDoKolejki(kierunek : KierunekRuchu; pietroStart : Integer; pietroKoniec : Integer) is
      czyWysadzila : Boolean := False;
      czyWziela : Boolean := False;
      element : Rekord;
   begin
         if (TrasaWindy1Pietra.Is_Empty) then
             element.pietro := pietroStart;
             element.postoj := True;
             element.kierunek := kierunek;
             TrasaWindy1Pietra.Append(element);
         end if;
         for i in TrasaWindy1Pietra.Iterate loop
            if (not czyWziela) then
               if (TrasaWindy1Pietra(i).pietro = pietroStart) then
                  if (TrasaWindy1Pietra(i).kierunek = kierunek) then
                     TrasaWindy1Pietra(i).postoj := True;
                     czyWziela := True;
                  end if;
               end if;
            elsif (not czyWysadzila and TrasaWindy1Pietra(i).pietro = pietroKoniec) then
               TrasaWindy1Pietra(i).postoj := True;
               czyWysadzila := True;
         end if;
         end loop;
         if (not czyWziela) then
            if (TrasaWindy1Pietra.Last_Element.pietro > pietroStart) then
               for j in TrasaWindy1Pietra.Last_Element.pietro..pietroStart loop
                  element.pietro := j;
                  element.postoj := False;
                  element.kierunek := Dol;
                  TrasaWindy1Pietra.Append(element);
               end loop;
               TrasaWindy1Pietra(TrasaWindy1Pietra.Last).postoj := True;
               czyWziela := True;
            else
               for k in TrasaWindy1Pietra.Last_Element.pietro..pietroStart loop
                  element.pietro := k;
                  element.postoj := False;
                  element.kierunek := Gora;
                  TrasaWindy1Pietra.Append(element);
               end loop;
               TrasaWindy1Pietra(TrasaWindy1Pietra.Last).postoj := True;
               czyWziela := True;
            end if;
         end if;

         if (not czyWysadzila) then
            if (TrasaWindy1Pietra.Last_Element.pietro > pietroKoniec) then
               for j in TrasaWindy1Pietra.Last_Element.pietro..pietroKoniec loop
                  element.pietro := j;
                  element.postoj := False;
                  element.kierunek := Dol;
                  TrasaWindy1Pietra.Append(element);
               end loop;
               TrasaWindy1Pietra(TrasaWindy1Pietra.Last).postoj := True;
               czyWysadzila := True;
            else
               for k in TrasaWindy1Pietra.Last_Element.pietro..pietroKoniec loop
                  element.pietro := k;
                  element.postoj := False;
                  element.kierunek := Gora;
                  TrasaWindy1Pietra.Append(element);
               end loop;
               TrasaWindy1Pietra(TrasaWindy1Pietra.Last).postoj := True;
               czyWysadzila := True;
            end if;
         end if;
end dodajDoKolejki;

----------------
---Sterownik----
-----Glowny-----
----------------

procedure nowaOsoba(kierunek : KierunekRuchu; pietroStart : Integer; pietroKoniec : Integer) is
         os : Osoba;
   begin
         os.id := idOsoby;
         idOsoby := idOsoby + 1;
         os.pietroStart := pietroStart;
         os.pietroKoniec := pietroKoniec;
         os.kierunek := kierunek;
         pietraLudzie(pietroStart)(pietraLudzieId(pietroStart)) := os;
         pietraLudzieId(pietroStart) := (pietraLudzieId(pietroStart) + 1) mod 10 +1;
         dodajDoKolejki(kierunek, pietroStart, pietroKoniec);
end nowaOsoba;

-----------------
------Testy------
-----------------

procedure Test is
   begin
         nowaOsoba(Gora, 1, 4);
end Test;

-----------------
------Start------
-----------------
begin
   Test;
   Winda1;
end main;
