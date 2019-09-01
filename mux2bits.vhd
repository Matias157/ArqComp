library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;          

entity mux2bits is
  port ( enable	:  in std_logic;
		 sel    :  in unsigned (1 downto 0) ;
		 a	    :  in unsigned (15 downto 0) ;  
		 b	    :  in unsigned (15 downto 0) ;
		 saida	: out unsigned (15 downto 0)
  );
end entity ;

architecture a_mux2bits of mux2bits is
begin
	saida <= a when enable='1' and sel="00" else
			 b when enable='1' and sel="01" else
			 "0000000000000000";			 
end architecture ;