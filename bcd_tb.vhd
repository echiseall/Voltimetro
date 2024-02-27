library IEEE; 
use IEEE.std_logic_1164.all;

entity bcd_tb is
end;

architecture bcd_tb_arq of bcd_tb is
	component bcd is
		port(
			reset_i: in std_logic;
			enable_i: in std_logic;
			clock_i: in std_logic;
			q_o: out std_logic_vector (3 downto 0);
			flag_o: out std_logic
		);
	end component;
	
	signal reset : std_logic:= '0';
	signal enable : std_logic:= '1';
	signal clock : std_logic:= '0';
	signal q : std_logic_vector (3 downto 0);
	signal flag : std_logic;
	
begin
	enable <= not enable after 100 ns;
	reset <= not reset after 1000 ns;
	clock <= not clock after 10 ns;

	DUT : bcd
		port map (
			reset_i => reset,
			enable_i => enable,
			clock_i => clock,
			q_o => q,
			flag_o => flag
		);
end;