library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity contador330_tb is
end contador330_tb;

architecture contador330_tb_arq of contador330_tb is

component contador330 is 
	 generic(
          N: natural := 20 
      );
      port(
          reset_i: in std_logic;      
          enable_i: in std_logic;       
          clock_i: in std_logic;      
          q_out:  out std_logic_vector(N-1 downto 0) 

      );
end component;

signal reset: std_logic := '0';
signal enable: std_logic := '1';
signal clock: std_logic := '1';
signal q: std_logic_vector (19 downto 0);

begin
	reset<= '1' after 50 ns, '0' after 300 ns;
	clock<= not clock after 5 ns;
	enable<= '0' after 250 ns, '1' after 400 ns;   
	
	DUT: contador330
	port map(
		reset_i=>reset,
		enable_i=>enable,
		clock_i=>clock,
		q_out=>q
	);
end;
