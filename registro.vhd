library IEEE; 
use IEEE.std_logic_1164.all;

entity registro is
	generic(
		N: natural := 4 -- Siendo N la cantidad de bits del registro
	); 
	port(
                reset_i: in std_logic;
                enable_i: in std_logic;
                clock_i: in std_logic;
                data_i: in std_logic_vector (N-1 downto 0);
                q_o: out std_logic_vector (N-1 downto 0)
	);
end;

architecture registro_arq of registro is

begin
	process(clock_i)
	begin
		if rising_edge (clock_i) then
			if reset_i = '1' then
				q_o <= (N-1 downto 0 => '0');
			elsif enable_i = '1' then
				q_o<= data_i;
			end if;
		end if;
	end process;
end;