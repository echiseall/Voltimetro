-- cuenta hasta 524 con 10 bits, igual al horizontal

library IEEE;
use IEEE.std_logic_1164.all;
 
entity contador_vertical is 
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
end;

architecture contador_vertical_arq of contador_vertical is 
component ffd is 
	port(
			reset_i: in std_logic;
			enable_i: in std_logic;
			clock_i: in std_logic;
			data_i: in std_logic;
			q_o: out std_logic
	);
end component;
 
component contador is 
	port(
			reset_i : in std_logic;
			enable_i : in std_logic;
			clock_i : in std_logic;
			data_i : in std_logic;
			carry_o : out std_logic;
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
 
signal D,Q,C: std_logic_vector(9 downto 0);
signal RET,RST: std_logic;

begin
	gen: for i in 1 to 9 generate
	contador_i: contador
		port map(
			reset_i=>RET,
			enable_i=>enable_i,
			clock_i=>clock_i,
			data_i=>D(i),
			carry_o=>C(i),
			q_o=>Q(i)
			);
		D(i)<=C(i-1);
	end generate;
	ffd0: ffd
		port map(
			reset_i=>reset_i,
			enable_i=>enable_i,
			clock_i=>clock_i,
			data_i=>D(0),
			q_o=>Q(0)
			);
		
	reg: registro
		generic map(
			N=>N
			)
		port map(
			reset_i=>RET,
			enable_i=>enable_i,
			clock_i=>clock_i,
			data_i=>Q,
			q_o=>valor_o
			);

 
max_o <=Q(9) and (not Q(8)) and (not Q(7)) and (not Q(6)) and (not Q(5)) and (not Q(4)) and Q(3) and Q(2) and (not Q(1)) and (not Q(0)); 
RST <= Q(9) and (not Q(8)) and (not Q(7)) and (not Q(6)) and (not Q(5)) and (not Q(4)) and Q(3) and Q(2) and (not Q(1)) and Q(0);

D(0)<= not Q(0);
C(0)<= Q(0);

RET <= reset_i or RST;

end;