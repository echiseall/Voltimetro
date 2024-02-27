library IEEE;
use IEEE.STD_LOGIC_1164.ALL;


entity contador_unos_tb is
end contador_unos_tb;

architecture contador_unos_tb_arq of contador_unos_tb is

component contador_unos is
	      port(
          reset_i    : in std_logic;
          enable_i    : in std_logic;
          clock_i   : in std_logic;
          bcd0_o,bcd1_o,bcd2_o,bcd3_o,bcd4_o,bcd5_o   : out std_logic_vector(3 downto 0)
      );
end component;

signal reset,enable,clock : std_logic:='1';
signal bcd0,bcd1,bcd2,bcd3,bcd4,bcd5: std_logic_vector(3 downto 0);

begin
	reset<= '0' after 50 ns;
	enable<= '0' after 20 ns, '1' after 100 ns;
	clock<= not clock after 1 ns;
	
	DUT: contador_unos
		port map(
				reset_i=>reset,
				enable_i=>enable,
				clock_i=>clock,
				bcd0_o=>bcd0,
				bcd1_o=>bcd1,
				bcd2_o=>bcd2,
				bcd3_o=>bcd3,
				bcd4_o=>bcd4,
				bcd5_o=>bcd5
			);
end;
