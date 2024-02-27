library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity contador_horizontal_tb is
end contador_horizontal_tb;

architecture contador_horizontal_tb_arq of contador_horizontal_tb is 
component contador_horizontal is 
	    generic(
         N: natural :=10 -- los 10 bits
         );
    port(
         reset_i    : in std_logic; 
         enable_i    : in std_logic; 
         clock_i    : in std_logic; 
         valor_o : out std_logic_vector (N-1 downto 0); 
         max_o : out std_logic 
     );
end component;

signal reset,enable,clock: std_logic:='1';
signal valor: std_logic_vector (9 downto 0);
signal max: std_logic;

begin 
	
    reset  <= '0' after 200 ns;
	enable  <= not enable after 100 ns;
	clock 	<= not clock after 1 ns;
	
	DUT: contador_horizontal
		port map(
			reset_i=>reset,
			enable_i=>enable,
			clock_i=>clock,
			valor_o=>valor,
			max_o=>max
			);
end;