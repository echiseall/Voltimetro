library IEEE;
use IEEE.std_logic_1164.all;

entity ffd is
	port(
			reset_i: in std_logic;
			enable_i: in std_logic;
			clock_i: in std_logic;
			data_i: in std_logic;
			q_o: out std_logic
	);
end;

architecture ffd_arq of ffd is

begin
	process (clock_i)
	begin
		if rising_edge (clock_i) then
			if reset_i = '1' then
				q_o <= '0';
			elsif enable_i = '1' then
				q_o <= data_i;
			end if;
		end if;
	end process;
end;