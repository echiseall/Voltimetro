library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity adc is 
	port(
		reset_i, enable_i, clock_i: in std_logic;
		input_i: in std_logic;
		realimentacion_o: out std_logic;
		register_a, register_b, register_c: out std_logic_vector(3 downto 0)
	);
end;

architecture adc_arq of adc is

component sigmadeltaA_D is
	port(
		reset_i: in std_logic;     
		enable_i: in std_logic;     
		clock_i: in std_logic;     
		data_i: in std_logic;     
		realimentacion_o: out std_logic;
		q_o: out std_logic
		);
end component;


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


component contador_unos is
	port(
        reset_i    : in std_logic;
        enable_i    : in std_logic;
        clock_i   : in std_logic;
        bcd0_o,bcd1_o,bcd2_o,bcd3_o,bcd4_o,bcd5_o   : out std_logic_vector(3 downto 0)
    );
end component;

component contador330 is 
	generic(
          N: natural := 20 
    );
    port(
        reset_i: in std_logic;      
        enable_i: in std_logic;       
        clock_i: in std_logic;      
        q_out:  out std_logic_vector(N-1 downto 0) 
	);
end component;

signal CONVERSOR, ENABLE_REG, RESET, RESET330: std_logic;
signal CONTADOR: std_logic_vector(19 downto 0);
signal REG_A,REG_B,REG_C:std_logic_vector(3 downto 0);

begin
	a_dsigma: sigmadeltaA_D
		port map(
			reset_i => reset_i,
			enable_i => '1',
			clock_i => clock_i,
			data_i=>input_i,
			realimentacion_o=>realimentacion_o,
			q_o=>CONVERSOR
		);

	regi_A: registro
		generic map(
			N => 4
		)
		port map(
			reset_i=> reset_i,
			enable_i=>ENABLE_REG,
			clock_i=>clock_i,
			data_i=>REG_A,
			q_o=>register_a
		);
	
	regi_B: registro
		generic map(
			N => 4
		)
		port map(
			reset_i=> reset_i,
			enable_i=>ENABLE_REG,
			clock_i=>clock_i,
			data_i=>REG_B,
			q_o=>register_b
		);
		
	regi_C: registro
		generic map(
			N => 4
		)
		port map(
			reset_i=> reset_i,
			enable_i=>ENABLE_REG,
			clock_i=>clock_i,
			data_i=>REG_C,
			q_o=>register_c
		);
		
	unos: contador_unos
         port map(
              reset_i  => RESET,  
              enable_i  => CONVERSOR,
              clock_i   => clock_i,
              bcd0_o => open,
              bcd1_o => open,
              bcd2_o => open,
              bcd3_o => REG_A,
              bcd4_o => REG_B,
              bcd5_o => REG_C
        );

	contbinario: contador330
		port map(
			reset_i =>RESET,
			enable_i => '1',
			clock_i =>clock_i,
			q_out => CONTADOR
		);
	
ENABLE_REG<= (not CONTADOR(19)) and (CONTADOR(18)) and (not CONTADOR(17)) and (CONTADOR(16)) and (not CONTADOR(15)) and (not CONTADOR(14)) and (not CONTADOR(13)) and (not CONTADOR(12)) and (CONTADOR(11)) and (CONTADOR(10)) and (not CONTADOR(9)) and (not CONTADOR(8)) and CONTADOR(7) and (CONTADOR(6)) and CONTADOR(5) and CONTADOR(4) and (not CONTADOR(3)) and ( CONTADOR(2)) and ( CONTADOR(1)) and ( CONTADOR(0));
RESET330<= (not CONTADOR(19)) and (CONTADOR(18)) and (not CONTADOR(17)) and (CONTADOR(16)) and (not CONTADOR(15)) and (not CONTADOR(14)) and (not CONTADOR(13)) and (not CONTADOR(12)) and (CONTADOR(11)) and (CONTADOR(10)) and (not CONTADOR(9)) and (not CONTADOR(8)) and CONTADOR(7) and (CONTADOR(6)) and CONTADOR(5) and CONTADOR(4) and ( CONTADOR(3)) and (not CONTADOR(2)) and (not CONTADOR(1)) and (not CONTADOR(0));

RESET <= reset_i or RESET330;

end;