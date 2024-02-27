library IEEE;
use IEEE.std_logic_1164.all;

entity VGA_tb is 	
end;

architecture VGA_tb_arq of VGA_tb is

	component VGA is
			generic(
				N: natural := 10 
			);
		port(
			reset_i: in std_logic;
			clock_i: in std_logic;
			rojo_i,verde_i,azul_i: in std_logic;
		
			cord_x_o,cord_y_o: out std_logic_vector(9 downto 0);
			hsync_o,vsync_o: out std_logic;
			rojo_o,verde_o,azul_o: out std_logic
		);
	end component;

signal reset: std_logic:= '0';
signal clock: std_logic:=	'1';
signal rojoI,verdeI,azulI: std_logic:= '1';

signal cord_x, cord_y: std_logic_vector(9 downto 0);
signal hsync, vsync: std_logic;
signal rojoO,verdeO, azulO: std_logic;


begin 
	reset <= '1' after 5 ns , '0' after 15 ns;
	clock <= not clock after 5 ns;
	rojoI <= '0' after 500 ns;
	verdeI<= '0' after 500 ns;
	azulI <= '0' after 300 ns;
	
	DUT: VGA
		port map(
			reset_i=>reset,
			clock_i=>clock,
			rojo_i=>rojoI, verde_i=>verdeI, azul_i=>azulI,
			
			cord_x_o=>cord_x, cord_y_o=>cord_y,
			hsync_o=>hsync, vsync_o=>vsync,
			rojo_o=>rojoO, verde_o=>verdeO, azul_o=>azulO
			);
end;