library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity contador_tb is
end contador_tb;

architecture contador_tb_arq of contador_tb is
component contador is
	port(
			reset_i : in std_logic;
			enable_i : in std_logic;
			clock_i : in std_logic;
			data_i : in std_logic;
			carry_o : out std_logic;
			q_o: out std_logic
		);
end component;

signal reset : std_logic:='0'; 
signal enable : std_logic:='1'; 
signal clock : std_logic:='1';       
signal data : std_logic:='1'; 
signal carry : std_logic;
signal q : std_logic;

begin
	reset <= not reset after 500 ns;
	enable <= not enable after 50 ns;
	clock <= not clock after 10 ns;
	data <= not data after 20 ns;
	
	DUT: contador
		port map (
			reset_i=>reset,
			enable_i=>enable,
			clock_i=>clock,
			data_i=>data,
			carry_o=>carry,
			q_o=>q
		);
end;