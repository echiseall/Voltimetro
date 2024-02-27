library IEEE;
use IEEE.STD_LOGIC_1164.ALL;


entity adc_tb is 
end adc_tb;

architecture adc_tb_arq of adc_tb is

component adc is 
	port(
		reset_i, enable_i, clock_i: in std_logic;
		input_i: in std_logic;
		realimentacion_o: out std_logic;
		register_a, register_b, register_c: out std_logic_vector(3 downto 0)
	);
end component;

signal reset: std_logic:='0';
signal enable,clock,input: std_logic:='1';
signal realimentacion: std_logic;
signal regA, regB, regC: std_logic_vector(3 downto 0);

begin
	reset<= '1' after 150 ns, '0' after 300 ns;
	enable<= '0' after 50 ns, '1' after 100 ns;
	clock <= not clock after 1 ns;
	input<= not input after 10 ns;
	
	DUT: adc
	port map(
		reset_i=>reset,
		enable_i=>enable,
		clock_i=>clock,
		input_i=>input,
		realimentacion_o=>realimentacion,
		register_a=>regA,
		register_b=>regB,
		register_c=>regC
	);
end;
