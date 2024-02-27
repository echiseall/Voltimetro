library IEEE;
use IEEE.std_logic_1164.all;

entity VGA is 
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
end;

architecture VGA_arq of VGA is

	component ffd is
		port(
			reset_i: in std_logic;
			enable_i: in std_logic;
			clock_i: in std_logic;
			data_i: in std_logic;
			q_o: out std_logic
		);
	end component;

	component comparador is 
		generic(
			N: natural := 10
		);
		port(
			a_i: in std_logic_vector(N-1 downto 0);	
			b_i: in std_logic_vector(N-1 downto 0);	
			q_o: out std_logic						
		);
	end component;
		
	component contador_horizontal is
		generic(
			N: natural :=10 -- los 10 bits
        );
		port(
			reset_i    : in std_logic; 
			enable_i    : in std_logic; 
			clock_i    : in std_logic; 
			valor_o : out std_logic_vector (N-1 downto 0); 
			max_o : out std_logic 
		);
	end component;
	
	component contador_vertical is
		generic(
			N: natural :=10 -- los 10 bits
		);
		port(
			reset_i    : in std_logic; 
			enable_i    : in std_logic; 
			clock_i    : in std_logic; 
			valor_o : out std_logic_vector (N-1 downto 0); 
			max_o : out std_logic 
		);
	end component;
	
signal cuentaHorizontal, cuentaVertical: std_logic_vector(N-1 downto 0);
signal enableVertical, resetHorizontal, resetVertical: std_logic;

signal enaH,enaV,rstH,rstV: std_logic;

signal Hvidon, Vvidon, vidon: std_logic;

begin
	ffdH:ffd
		port map(
			reset_i=>resetHorizontal,
			enable_i=>enaH,
			clock_i=>clock_i,
			data_i=>'1',
			q_o=>hsync_o
		);
	
	ffdV:ffd
		port map(
			reset_i=>resetVertical,
			enable_i=>enaV,
			clock_i=>clock_i,
			data_i=>'1',
			q_o=>vsync_o
		);
	
	C656: comparador
		generic map(
			N=>N
		)
		port map(
			a_i=>cuentaHorizontal,
			b_i=>"1010010000", -- 656
			q_o=>enaH
		);
	
	C751: comparador
		generic map(
			N=>N
		)
		port map(
			a_i=>cuentaHorizontal,
			b_i=>"1011101111", -- 751
			q_o=>rstH
		);
	
	C490: comparador
		generic map(
			N=>N
		)
		port map(
			a_i=>cuentaVertical,
			b_i=>"0111101010", -- 490
			q_o=>enaV
		);
		
	C491: comparador
		generic map(
			N=>N
		)
		port map(
			a_i=>cuentaVertical,
			b_i=>"0111101011", -- 491
			q_o=>rstV
		);
	
	contadorH: contador_horizontal
        generic map(
            N => N
            )
        port map(
            clock_i    => clock_i,
            reset_i    => reset_i,
            enable_i    => '1',
            valor_o => cuentaHorizontal,  -- cuenta horizontal
            max_o => enableVertical
        );
	
		
	contadorV: contador_vertical
            generic map(
                N => N
                )
            port map(
                clock_i    => clock_i,
                reset_i    => reset_i,
                enable_i    => enableVertical,
                valor_o => cuentaVertical,  
                max_o => open
            );
            
	
	
	
	resetHorizontal<= reset_i or rstH;
	resetVertical<= reset_i or rstV;
	
	vidon <= Hvidon and Vvidon;
	Hvidon<= (not cuentaHorizontal(7) and not cuentaHorizontal(8)) or not cuentaHorizontal(9);
	Vvidon<= cuentaVertical(7) and not cuentaVertical(8);
	
	cord_x_o		<= cuentaHorizontal;   
    cord_y_o    <= cuentaVertical;  
        
	rojo_o<= rojo_i and vidon;
	azul_o<= azul_i and vidon;
	verde_o<= verde_i and vidon;

end;