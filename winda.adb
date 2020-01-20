with Ada.Text_IO;
use Ada.Text_IO;

with Ada.Containers.Doubly_Linked_Lists;

procedure Winda is

   ----------------
   -----Pietra-----
   ----------------
  
   type Pietra is array(1..11) of Integer;
   pietraWindy : Pietra := (0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10);
   
   ----------------
   ----Kierunki----
   -----Ruchu------
   ----------------
   
   type KierunekRuchu is (Gora, Dol, Brak);

   ----------------
   ----Przyciski---
   -----Gora-------
   ----------------
   
   type PrzyciskiGora is array(1..11) of Integer;
   przyciskiGoraWcisniete : PrzyciskiGora := (0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0);

   ----------------
   ----Przyciski---
   ------Dol-------
   ----------------
   type PrzyciskiDol is array(1..11) of Integer;
   przyciskiDolWcisniete : PrzyciskiDol := (0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0);


   ----------------
   -----Pietra-----
   -------Do-------
   ---Odwiedzenia--
   ----------------
   
   package Int_List is new Ada.Containers.Doubly_Linked_Lists(Integer);
   TrasaWindy1Pietra : Int_List.List;

   ----------------
   ------Czy-------
   ------Sie-------
   ---Zatrzymac----
   ----------------
   
   package Bool_List is new Ada.Containers.Doubly_Linked_Lists(Boolean);
   TrasaWindy1Postoj : Bool_List.List;

   ----------------
   -----Indeksy----
   ----------------
   
   indeksPoczatek : Integer := 1;
   indeksKoniec : Integer := 1;
   
   ----------------
   ------Czy-------
   -----Drzwi------
   ----Otwarte-----
   ----------------
   
   otwarte : Boolean := False;

----------------
-----Winda1-----
----------------

task Winda1 is
end Winda1;

task body Winda1 is
begin
      null;
end Winda1;
   
----------------
-----Winda2-----
----------------

task Winda2 is
end Winda2;

task body Winda2 is
begin
      null;
end Winda2;

----------------
---Sterownik----
------Windy-----
----------------

task SterownikWindy is
      entry dodajDoKolejki(kierunek : KierunekRuchu; pietro : Integer; pietroKoniec : Integer; nrWindy : Integer);
end SterownikWindy;

task body SterownikWindy is
      kier : KierunekRuchu;
begin
      accept dodajDoKolejki(kierunek : KierunekRuchu; pietro : Integer; pietroKoniec : Integer; nrWindy : Integer) do
         for i in Ada.Containers.Count_Type range 1..TrasaWindy1Pietra.Length loop
            null;
            --while (i > indeksPoczatek or i < indeksKoniec) i in range indeksPoczatek..indeksKoniec loop
            --if (i == indeksKoniec) then
            --k := 
            --if (TrasaWindy1Pietra(i) == pietro) then
            --TrasaWindy1Postoj(i) := True;
         end loop;
      end dodajDoKolejki;
end SterownikWindy;

----------------
---Sterownik----
-----Glowny-----
----------------

function wybierzWinde (kierunek : KierunekRuchu; pietroStart : Integer; pietroKoniec : Integer) return Integer is
begin
      return 1;
end wybierzWinde;

task SterownikGlowny is
	entry nowaOsoba(kierunek : KierunekRuchu; pietroStart : Integer; pietroKoniec : Integer);
end SterownikGlowny;

task body SterownikGlowny is
      nrWindy : Integer;
begin
      accept nowaOsoba(kierunek : KierunekRuchu; pietroStart : Integer; pietroKoniec : Integer) do
         nrWindy := wybierzWinde(kierunek, pietroStart, pietroKoniec);
         SterownikWindy.dodajDoKolejki(kierunek, pietroStart, pietroKoniec, nrWindy);
      end nowaOsoba;
end SterownikGlowny;

-----------------
------Testy------  
-----------------

task Test is
      entry Test1;
end Test;

task body Test is
begin
      accept Test1 do
         SterownikGlowny.nowaOsoba(Gora, 0, 4);
      end Test1;
end Test;

-----------------
------Start------
-----------------
begin
   Test.Test1;
end Winda;
