-- conversor A/D sigma delta permite leer señales de baja freq.

library IEEE;
use IEEE.std_logic_1164.all;

entity sigmadeltaA_D is 
	port(
		reset_i: in std_logic;     
		enable_i: in std_logic;     
		clock_i: in std_logic;     
		data_i: in std_logic;     
		realimentacion_o: out std_logic;
		q_o: out std_logic
		);
end;

architecture sigmadeltaA_D_arq of sigmadeltaA_D is 

component ffd is
	port(
			reset_i: in std_logic;
			enable_i: in std_logic;
			clock_i: in std_logic;
			data_i: in std_logic;
			q_o: out std_logic
	);
end component;

signal aux: std_logic;

begin

ffd0: ffd
	port map(
		reset_i=>reset_i,
		enable_i=>enable_i,
		clock_i=>clock_i,
		data_i=>data_i,
		q_o=>aux
		);
		
		realimentacion_o<= not aux;
		q_o<= aux;
end;