-- 3 BCD para hacer un contador de unos, uso mas bcds y uso solo los digitos que me sirven

library IEEE;
use IEEE.std_logic_1164.all;

entity contador_unos is
      port(
          reset_i    : in std_logic;
          enable_i    : in std_logic;
          clock_i   : in std_logic;
          bcd0_o,bcd1_o,bcd2_o,bcd3_o,bcd4_o,bcd5_o   : out std_logic_vector(3 downto 0)
      );
end;

architecture contador_unos of contador_unos is

component bcd is 
	port(
		reset_i: in std_logic;
		enable_i: in std_logic;
		clock_i: in std_logic;
		q_o: out std_logic_vector (3 downto 0);
		flag_o: out std_logic
	);
end component;

signal flag_o,aux: std_logic_vector(5 downto 0);

begin 
	bcd0: bcd
		port map(
			reset_i	=> reset_i,
			enable_i=> aux(0),
			clock_i=>clock_i,
			q_o=>bcd0_o,
			flag_o=>flag_o(0)
			);
	
	bcd1: bcd
		port map(
			reset_i	=> reset_i,
			enable_i=> aux(1),
			clock_i=>clock_i,
			q_o=>bcd1_o,
			flag_o=>flag_o(1)
			);
	
	bcd2: bcd
		port map(
			reset_i	=> reset_i,
			enable_i=> aux(2),
			clock_i=>clock_i,
			q_o=>bcd2_o,
			flag_o=>flag_o(2)
			);
			
	bcd3: bcd
		port map(
			reset_i	=> reset_i,
			enable_i=> aux(3),
			clock_i=>clock_i,
			q_o=>bcd3_o,
			flag_o=>flag_o(3)
			);
			
	bcd4: bcd
		port map(
			reset_i	=> reset_i,
			enable_i=> aux(4),
			clock_i=>clock_i,
			q_o=>bcd4_o,
			flag_o=>flag_o(4)
			);
			
	bcd5: bcd
		port map(
			reset_i	=> reset_i,
			enable_i=> aux(5),
			clock_i=>clock_i,
			q_o=>bcd5_o,
			flag_o=>flag_o(5)
			);
			
	aux(0)<=enable_i;
	gen: for i in 1 to 5 generate
		aux(i) <= aux(i-1) and flag_o(i-1);
	end generate;

end;