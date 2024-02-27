library IEEE;
use IEEE.std_logic_1164.all;

entity contador is 
	port(
			reset_i : in std_logic;
			enable_i : in std_logic;
			clock_i : in std_logic;
			data_i : in std_logic;
			carry_o : out std_logic;
			q_o: out std_logic
		);
	end;

architecture contador_arq of contador is 
	component ffd is
		port(
			reset_i: in std_logic;
			enable_i: in std_logic;
			clock_i: in std_logic;
			data_i: in std_logic;
			q_o: out std_logic
		);
	end component;
	
	signal AUX,D,Q: std_logic;
	
begin
	ffd0: ffd
		port map(
			reset_i=>reset_i,
			enable_i=>enable_i,
			clock_i => clock_i,
			data_i=>AUX,
			q_o=>Q
		);
		
		AUX<= D xor Q;
		D<=data_i;
		carry_o<=D and Q;
		q_o<=Q;

end;