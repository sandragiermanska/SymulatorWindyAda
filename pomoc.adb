with Ada.Text_IO, Ada.Numerics.Discrete_Random;
use Ada.Text_IO;

procedure Elevatorsimulation is
   
   --------------------------------------------------------------------------------
   
   --do losowania pieter
   subtype Zakres is Integer range 0..10;
   package R is new Ada.Numerics.Discrete_Random(Zakres);
   use R;
   Gen: Generator;
   
   --------------------------------------------------------------------------------
   
   --------------------------------------------------------------------------------

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

   --czy drzwi windy sa otwarte
   otwarte : Boolean := False;
   --czy drzwi sa zamkniete
   zamkniete : Boolean := True;

  --na jakim pietrze jest teraz winda
  aktualnePietro : Integer := 0;

  --aktualny kierunek ruchu windy
  aktualnyKierunek : KierunekRuchu := Brak;

   --------------------------------------------------------------------------------
   
   --------------------------------------------------------------------------------
   --to do: obsluga zakonczenia pracy watku
   --procedura obslugujaca czekanie na winde
   procedure czekajNaWinde is
      
   begin
      null;
   end czekajNaWinde;
   --------------------------------------------------------------------------------
   
   --------------------------------------------------------------------------------
   --to do: obsluga powiadomienia watkow
   --procedura obslugujaca powiadamianie watkow
   procedure powiadom is
      
   begin
      null;
   end powiadom;
   --------------------------------------------------------------------------------
   
   --------------------------------------------------------------------------------

   --procedura obslugujaca przycisniecie na x pietrze przycisku "gora/dol"
   procedure przywolajWinde(pietro : Integer; kierunek : KierunekRuchu) is

   begin
      --gdy wcisnieto na pietrze pietro przycisk "gora"
      if (kierunek = Gora) then
         przyciskiGoraWcisniete(pietro) := 1;
         Put_Line("Na pietrze " & pietro'Img & ". wcisnieto przycisk " & kierunek'Img);
      --gdy wcisnieto na pietrze pietro przycisk "dol"
      elsif (kierunek = Dol) then
         przyciskiDolWcisniete(pietro) := 1;
         Put_Line("Na pietrze " & pietro'Img & ". wcisnieto przycisk " & kierunek'Img);
      end if;
     
      --gdy winda nie znajduje sie na pietrze, na ktorym jest uzytkownik
      --gdy winda porusza sie w przeciwnym kierunku
      --nalezy zaczekac na winde
      --while (not (aktualnePietro = pietro and aktualnyKierunek = kierunek)) loop
         --czekajNaWinde;
      --end loop;
      
      Put_Line("Winda przyjechala na pietro " & pietro'Img & ".");
       
      
      Put_Line("Drzwi sie otwieraja"); 
      --drzwi sie otwieraja
      otwarte := True;
      zamkniete := False;
      
      Put_Line("Drzwi sie zamykaja");  
      --nastepnie drzwi sa zamykane
      otwarte := False;
      zamkniete := True;
      
      --powiadomienie watkow
      powiadom;

   end przywolajWinde;
   
   --------------------------------------------------------------------------------
   
   --------------------------------------------------------------------------------

   --procedura obslugujaca wybranie pietra, na ktore ktos chce jechac,
   --gdy dana osoba dostanie sie juz do windy
   procedure wybierzPietro(pietro : Integer) is

   begin
      Put_Line("Ktos wybiera numer pietra: " & pietro'Img);
      --gdy winda jedzie w gore i chcemy dostac sie na wyzsze pietro
      if (aktualnyKierunek = Gora and aktualnePietro <= pietro) then
          --z najwyzszego pietra bedzie mozna jechac tylko w dol
          if (pietro = 9) then
             przyciskiDolWcisniete(pietro) := 1;
          else
             przyciskiGoraWcisniete(pietro) := 1;
         end if;
      --gdy winda jedzie w gore, a chcemy zjechac na nizsze pietro niz aktualne
      elsif (aktualnyKierunek = Gora and aktualnePietro > pietro) then
         przyciskiDolWcisniete(pietro) := 1;
      --gdy winda jedzie w dol, a chcemy jechac na nizsze pietro niz aktualne
      elsif (aktualnyKierunek = Dol and aktualnePietro >= pietro) then
         --z pietra najnizszego mozna jechac tylko w gore
          if (pietro = 1)  then
             przyciskiGoraWcisniete(pietro) := 1;
          else
             przyciskiDolWcisniete(pietro) := 1;
         end if;
      --gdy winda jedzie w dol, a chcemy jechac na pietro wyzsze niz aktualne
      elsif (aktualnyKierunek = Dol and aktualnePietro < pietro) then
           przyciskiGoraWcisniete(pietro) := 1;
      end if;
      
      --Put_Line("Drzwi windy sie zamykaja");
      --po wyborze pietra drzwi sie zamykaja
      otwarte := False;
      zamkniete := True;

      powiadom;

      --dopoki winda nie dotrze na wlasciwe pietro
      --czekaj
      --while (not (aktualnePietro = pietro)) loop
          --czekajNaWinde;
      --end loop;

      --drzwi sie zamykaja
      otwarte := False;
      zamkniete := True;

      powiadom;

   end wybierzPietro;
   
   --funkcja obslugujaca dotarcie windy do pietra i dezaktywacje przyciskow
   function windaDotarlaNaPietro(pietro : Integer; kierunek : KierunekRuchu) return Boolean is
      
   begin
      --zmieniaja sie aktualne pietro i kierunek ruchu
      aktualnePietro := pietro;
      aktualnyKierunek := kierunek;
      
      --gdy kierunek to gora
      if (kierunek = Gora) then
         --jesli guzik na pietrze jest wcisniety w gore
         if (przyciskiGoraWcisniete(pietro) = 1) then
            przyciskiGoraWcisniete(pietro) := 0;
            return True;
         else
            return False;
         end if;
      --gdy kierunek to dol
      elsif (kierunek = Dol) then
         --jesli guzik na pietrze jest wcisniety w dol
         if (przyciskiDolWcisniete(pietro) = 1) then
            przyciskiDolWcisniete(pietro) := 0;
            return True;
         else
            return False;
         end if;
      end if;
      
      return False;   
         
   end windaDotarlaNaPietro;
   
   --------------------------------------------------------------------------------
   





begin
   Reset(Gen);
   przywolajWinde(2, Dol);
   wybierzPietro(3);
end Elevatorsimulation;

