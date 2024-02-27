library IEEE;
use IEEE.std_logic_1164.all;

entity ffd_tb is 
end; 

architecture ffd_tb_arq of ffd_tb is 
component ffd is 
	port(
			reset_i: in std_logic;
			enable_i: in std_logic;
			clock_i: in std_logic;
			data_i: in std_logic;
			q_o: out std_logic
	);
end component;

signal reset: std_logic:='0';
signal enable: std_logic:='1';
signal clock: std_logic:='0';
signal data: std_logic:='0';
signal q: std_logic:='0';

begin
	reset <= not reset after 1000 ns;
	enable <= not enable after 500 ns;
	clock <=  not clock after 100 ns;
	data <= not data after 200 ns;
	
	DUT: ffd
		port map (
			reset_i=>reset,
			enable_i=>enable,
			clock_i=>clock,
			data_i=>data,
			q_o=>q
		);
end;