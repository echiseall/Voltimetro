library IEEE;
use IEEE.std_logic_1164.all;

entity bcd is
	port(
		reset_i: in std_logic;
		enable_i: in std_logic;
		clock_i: in std_logic;
		q_o: out std_logic_vector (3 downto 0);
		flag_o: out std_logic
	);
end;

architecture bcd_arq of bcd is
	component ffd is
		port(
			reset_i: in std_logic;
			enable_i: in std_logic;
			clock_i: in std_logic;
			data_i: in std_logic;
			q_o: out std_logic
			);
	end component;
	
	signal D: std_logic_vector (3 downto 0);
	signal Q: std_logic_vector (3 downto 0);
	
begin
	gen: for i in 0 to 3 generate
		cuenta_i: ffd
			port map(
				reset_i=>reset_i,
				enable_i=>enable_i,
				clock_i=>clock_i,
				data_i => D(i),
				q_o => Q(i)
				);		
		q_o(i) <= Q(i);
	end generate;
	
	D(0) 	<= not Q(0);
	D(1) 	<= ((not Q(3)) and (not Q(1)) and Q(0)) or (Q(1) and (not Q(0))); 
	D(2) 	<= ((not Q(2)) and Q(1) and Q(0)) or (Q(2) and (not Q(1))) or (Q(2) and (not Q(0)));
	D(3)	<= (Q(3) and (not Q(0))) or (Q(2) and Q(1) and Q(0)); 
	
	flag_o <= Q(3) and (not Q(2)) and (not Q(1)) and Q(0);
end;