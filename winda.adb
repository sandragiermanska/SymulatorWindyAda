-- winda.adb

-- wykorzystane pakiety 
with Ada.Text_IO;
use Ada.Text_IO;

with Ada.Containers.Doubly_Linked_Lists;
--use Ada.Containers.Doubly_Linked_Lists;

-- procedura główna
procedure Winda is

   --pietra windy
   type Pietra is array(1..11) of Integer;
   --kolejne pietra
   pietraWindy : Pietra := (0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10);
   
   --mozliwe kierunki ruchu windy
   --winda moze jechac w gore(Gora), dol(Dol) lub stac(Brak)
   type KierunekRuchu is (Gora, Dol, Brak);

   --przyciski "gora" na kolejnych pietrach
   type PrzyciskiGora is array(1..11) of Integer;
   --wcisniety przycisk "gora", gdy 1, w przeciwnym przypadku 0
   przyciskiGoraWcisniete : PrzyciskiGora := (0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0);

   --przyciski "dol" na kolejnych pietrach
   type PrzyciskiDol is array(1..11) of Integer;
   --wcisniety przyciski "dol", gdy 1, w przeciwnym przypadku 0
   przyciskiDolWcisniete : PrzyciskiDol := (0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0);


   package Int_List is new Ada.Containers.Doubly_Linked_Lists(Integer);
   --use Doubly_Linked_Lists;
   TrasaWindy1Pietra : Int_List.List;

   package Bool_List is new Ada.Containers.Doubly_Linked_Lists(Boolean);
   --use Bool_Fifo;
   TrasaWindy1Postoj : Bool_List.List;

   --type TrasaWindy1Pietra is array(1..33) of Integer;
   --type TrasaWindy1Postoj is array(1..33) of Boolean;
   indeksPoczatek : Integer := 1;
   indeksKoniec : Integer := 1;

   --czy drzwi windy sa otwarte
   otwarte : Boolean := False;

-----------------------------------------------------------

	task Winda1 is
	end Winda1;

	task body Winda1 is
	begin
	null;
	end Winda1;


-----------------------------------------------------------


	task SterownikWindy is
		entry dodajDoKolejki(kierunek : KierunekRuchu; pietro: Integer; pietroKoniec: Integer; nrWindy : Integer);
	end SterownikWindy;

	task body SterownikWindy is
		k : KierunekRuchu;
	begin
		accept dodajDoKolejki(kierunek : KierunekRuchu; pietro: Integer; pietroKoniec: Integer; nrWindy : Integer) do
			--i := TrasaWindy1Pietra.Length;
			for i in Ada.Containers.Count_Type range 1..TrasaWindy1Pietra.Length loop
null;
--			while (i > indeksPoczatek or i < indeksKoniec) i in range indeksPoczatek..indeksKoniec loop
--				if (i == indeksKoniec) then
--					
--				k := 
--				if (TrasaWindy1Pietra(i) == pietro) then
--					TrasaWindy1Postoj(i) := True;
			end loop;
		end dodajDoKolejki;
	null;
	end SterownikWindy;


-----------------------------------------------------------

	function wybierzWinde (kierunek : KierunekRuchu; pietroStart: Integer; pietroKoniec: Integer) return Integer is
		begin
		return 1;
	end wybierzWinde;

	task SterownikGlowny is
		entry nowaOsoba(kierunek : KierunekRuchu; pietroStart: Integer; pietroKoniec: Integer);
	end SterownikGlowny;

	task body SterownikGlowny is
	nrWindy : Integer;
	begin
		accept nowaOsoba(kierunek : KierunekRuchu; pietroStart: Integer; pietroKoniec: Integer) do
			nrWindy := wybierzWinde(kierunek, pietroStart, pietroKoniec);
			SterownikWindy.dodajDoKolejki(kierunek, pietroStart, pietroKoniec, nrWindy);
		end nowaOsoba;
	end SterownikGlowny;


-----------------------------------------------------------


	task Test is
		entry Test1;
	end Test;

	task body Test is
	begin
		accept Test1;
			SterownikGlowny.nowaOsoba(Gora,0,4);
	end Test;

begin

Test.Test1;

end Winda;
