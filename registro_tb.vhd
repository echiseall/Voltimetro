library IEEE; 
use IEEE.std_logic_1164.all;

entity registro_tb is
end registro_tb;

architecture registro_tb_arq of registro_tb is

component registro is
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
end component;
signal reset: std_logic := '0';
signal enable: std_logic := '1';
signal clock: std_logic := '1';
signal data: std_logic_vector (3 downto 0) := "1001";
signal q: std_logic_vector (3 downto 0);

begin
	reset<= '1' after 5 ns, '0' after 8 ns;
	clock<= not clock after 5 ns;
	enable<= '0' after 250 ns, '1' after 400 ns;   
	data<= "0101" after 10 ns, "1010" after 20 ns, "1011" after 30 ns, "1001" after 40 ns, "1000" after 50 ns;
	
	DUT: registro
	port map(
		reset_i=>reset,
		enable_i=>enable,
		clock_i=>clock,
		data_i=>data,
		q_o=>q
	);
end;
	