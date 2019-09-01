library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;          

entity mux_RAM_ULA is
  port ( sel    :  in std_logic;
		 a	    :  in unsigned (15 downto 0);  
		 b	    :  in unsigned (15 downto 0);
		 saida	: out unsigned (15 downto 0)
  );
end entity ;

architecture a_mux_RAM_ULA of mux_RAM_ULA is
begin
	saida <= a when sel = '0' else
			 b when sel = '1' else
			 "0000000000000000";			 
end architecture ;