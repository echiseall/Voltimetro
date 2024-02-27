library IEEE;
use IEEE.std_logic_1164.all;

entity comparador is
	generic(
		N: natural := 10
	);
	port(
		a_i: in std_logic_vector(N-1 downto 0);	
		b_i: in std_logic_vector(N-1 downto 0);	
		q_o: out std_logic						
	);
end;

architecture comparador_arq of comparador is 

signal aux: std_logic_vector(N downto 0);

begin
	gen: for i in 0 to N-1 generate
		aux(i+1) <= not (a_i(i) xor b_i(i)) and aux(i);
	end generate;
	
	aux(0) <='1';
	q_o <= aux(N);

end;