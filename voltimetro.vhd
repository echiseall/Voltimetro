library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity voltimetro is
	port(
		reset_i, clock_i, input_i: in std_logic;
		rojo_o,verde_o,azul_o,hsync_o,vsync_o,realimentacion_o: out std_logic
	);
end;

architecture voltimetro_arq of voltimetro is

component ROM is 
	port(
		cord_x    : in std_logic_vector (2 downto 0);
		cord_y    : in std_logic_vector (2 downto 0);
		digito: in std_logic_vector (3 downto 0);
		rom_out       : out std_logic
	);
end component;

component multiplexor is 
	port(
        entero_i,punto_i,dec1_i,dec2_i,volt_i: in std_logic_vector (3 downto 0); 
		selector_i    : in std_logic_vector (2 downto 0); 
		q_o       : out std_logic_vector (3 downto 0) 
    );
end component;

component adc is 
	port(
		reset_i, enable_i, clock_i: in std_logic;
		input_i: in std_logic;
		realimentacion_o: out std_logic;
		register_a, register_b, register_c: out std_logic_vector(3 downto 0)
	);
end component;

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

	signal enable_i: std_logic := '1' ;  
	signal M_R: std_logic_vector(3 downto 0); 
	signal R_V: std_logic; 
	signal VX_M,VY_M: std_logic_vector(9 downto 0); 
	signal RM1,RM2,RM3: std_logic_vector(3 downto 0); 	
	
begin 
	bloque_rom: ROM 
		port map(
			cord_x    => VY_M(6 downto 4),
			cord_y    => VX_M(6 downto 4),
     		digito    => M_R,
			rom_out   => R_V
		);
			
	mux: multiplexor 
		port map( 
			punto_i   => "1010",  
			volt_i    => "1011",  
			entero_i  => RM1,
			dec1_i    => RM2,
			dec2_i    => RM3,
			selector_i => VX_M(9 downto 7), -- 3 primeros bits
			q_o       => M_R
		); 			
	
	adc1: adc
		port map (
			reset_i    => reset_i,
			enable_i   => enable_i,
			clock_i    => clock_i,
			input_i  => input_i,
			realimentacion_o   => realimentacion_o,
			register_a => RM1,
			register_b => RM2,
			register_c => RM3
		);      
                 
	display: VGA 
		generic map(
			N => 10
		)
		port map( 
			reset_i    => reset_i,
			clock_i    => clock_i,
			rojo_i   => R_V,                              
			verde_i   => R_V,                                  
			azul_i  => '1',
			
			cord_x_o => VX_M,
			cord_y_o => VY_M,
			
			hsync_o   => hsync_o,
			vsync_o   => vsync_o,
			
			rojo_o   => rojo_o,
			verde_o  => verde_o,
			azul_o => azul_o          
		);         
end;
