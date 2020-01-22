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

procedure Test1 is
   begin
         nowaOsoba(Gora, 1, 4);
         nowaOsoba(Gora, 2, 4);
         nowaOsoba(Dol, 3, 2);
end Test1;

procedure Test2 is
   begin
         nowaOsoba(Dol, 9, 4);
         nowaOsoba(Dol, 8, 5);
         nowaOsoba(Gora, 3, 7);
         nowaOsoba(Dol, 3, 1);
         nowaOsoba(Gora, 4, 8);
end Test2;

procedure Test3 is
   begin
         nowaOsoba(Dol, 2, 9);
         nowaOsoba(Gora, 3, 5);
         nowaOsoba(Gora, 4, 6);
         nowaOsoba(Dol, 6, 2);
         nowaOsoba(Dol, 5, 4);
         nowaOsoba(Dol, 5, 3);
         nowaOsoba(Dol, 2, 1);
         nowaOsoba(Gora, 1, 3);
end Test3;

procedure Test4 is
   begin
         nowaOsoba(Dol, 9, 4);
         nowaOsoba(Gora, 1, 3);
         nowaOsoba(Dol, 7, 5);
         nowaOsoba(Gora, 2, 7);
         nowaOsoba(Dol, 5, 4);
end Test4;

procedure Test5 is
   begin
         nowaOsoba(Dol, 9, 4);
         nowaOsoba(Dol, 7, 2);
         nowaOsoba(Dol, 8, 4);
         nowaOsoba(Dol, 5, 3);
         nowaOsoba(Dol, 3, 1);
end Test5;

procedure Test6 is
   begin
         nowaOsoba(Gora, 7, 8);
         nowaOsoba(Gora, 1, 3);
         nowaOsoba(Gora, 2, 5);
         nowaOsoba(Gora, 5, 7);
         nowaOsoba(Gora, 3, 4);
end Test6;

-----------------
------Start------
-----------------
begin
    Put_Line("Testowanie symulatora ruchu windy");

    Put_Line("Test 1: 1 -> 2 -> 4 -> 3 -> 2");
    Test1;
    Winda1;
    Put_Line("");
    delay(5.0);
    
    Put_Line("Test 2: 1 -> 9 -> 8 -> 5 -> 4 -> 3 -> 1 -> 3 -> 4 -> 7 -> 8");
    Test2;
    Winda1;
    Put_Line("");
    delay(5.0);
    
    Put_Line("Test 3: 1 -> 2 -> 9 -> 3 -> 4 -> 5 -> 6 -> 5 -> 4 -> 3 -> 2 -> 1 -> 3");
    Test3;
    Winda1;
    Put_Line("");
    delay(5.0);
    
    Put_Line("Test 4: 1 -> 9 -> 7 -> 5 -> 4 -> 1 -> 2 -> 3 -> 7");
    Test4;
    Winda1;
    Put_Line("");
    delay(5.0);
    
    Put_Line("Test 5: 1 -> 9 -> 8 -> 7 -> 5 -> 4 -> 3 -> 2 -> 1");
    Test5;
    Winda1;
    Put_Line("");
    delay(5.0);
    
    Put_Line("Test 6: 1 -> 2 -> 3 -> 4 -> 5 -> 7 -> 8");
    Test6;
    Winda1;
    Put_Line("");
    delay(5.0);
end main;
