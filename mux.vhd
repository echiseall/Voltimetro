-- recibe datos del registro

library IEEE; 
use IEEE.std_logic_1164.all;

entity multiplexor is
    port(
        entero_i,punto_i,dec1_i,dec2_i,volt_i: in std_logic_vector (3 downto 0); 
		selector_i    : in std_logic_vector (2 downto 0); 
		q_o       : out std_logic_vector (3 downto 0) 
    );
end;

architecture multiplexor_arq of multiplexor is

signal S: std_logic_vector(4 downto 0);
signal e1,E,e2,P,e3,D1,e4,D2,e5,V: std_logic_vector(3 downto 0);

begin
	q_o <= e1 or e2 or e3 or e4 or e5;
	
	E<=entero_i; 
	P<=punto_i; 
	D1<=dec1_i;
	D2<=dec2_i;
	V<=volt_i; -- E.DD V -> 1.23V
	
	e1 <= (E(3) and S(0)) & (E(2) and S(0)) & (E(1) and S(0)) & (E(0) and S(0));
	e2 <= (P(3) and S(1)) & (P(2) and S(1)) & (P(1) and S(1)) & (P(0) and S(1));
	e3 <= (D1(3) and S(2)) & (D1(2) and S(2)) & (D1(1) and S(2)) & (D1(0) and S(2));
	e4 <= (D2(3) and S(3)) & (D2(2) and S(3)) & (D2(1) and S(3)) & (D2(0) and S(3));
	e5 <= (V(3) and S(4)) & (V(2) and S(4)) & (V(1) and S(4)) & (V(0) and S(4));
	
	S(3) <= not (selector_i(2) or selector_i(1) or selector_i(0));         -- 000 
	S(1) <= (not selector_i(2)) and (not selector_i(1)) and selector_i(0); -- 001 
	S(2) <= (not selector_i(2)) and selector_i(1) and (not selector_i(0)); -- 010 
	S(0) <= (not selector_i(2)) and selector_i(1) and selector_i(0);       -- 011 
	S(4) <= selector_i(2) and (not selector_i(1)) and (not selector_i(0)); -- 100
	
end;