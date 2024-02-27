library IEEE;
  use IEEE.std_logic_1164.all;

entity contador330 is               
      generic(
          N: natural := 20 
      );
      port(
          reset_i: in std_logic;      
          enable_i: in std_logic;       
          clock_i: in std_logic;      
          q_out:  out std_logic_vector(N-1 downto 0) 
      );
end;

architecture contador330_arq of contador330 is

	component ffd is 
		port(
			reset_i: in std_logic;
			enable_i: in std_logic;
			clock_i: in std_logic;
			data_i: in std_logic;
			q_o: out std_logic
		);
	end component;

	signal D: std_logic_vector (N-1 downto 0);
	signal q1: std_logic_vector (N-1 downto 0);
	signal aux: std_logic_vector (N-2 downto 0);

begin	
		gen: for i in 0 to N-1 generate
			cuenta_i: ffd
				port map(
					reset_i=>reset_i,
					enable_i=>enable_i,
					clock_i=>clock_i,
					data_i=>D(i),
					q_o=>q1(i)
				);
			q_out(i)<=q1(i);
			end generate;
		and_gen: for j in 1 to N-2 generate
			aux(j) <= aux(j-1) and q1(j+1);
		end generate;
		
		xor_gen: for j in 3 to N-1 generate
			D(j)<=aux(j-2) xor q1(j);
		end generate;
		
		D(0) <= not q1(0);
		D(1) <= q1(0) xor q1(1);
		D(2) <= aux(0) xor q1(2);
		
		aux(0) <= q1(0) and q1(1); 

		
end;