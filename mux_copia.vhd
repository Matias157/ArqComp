library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;       

entity mux_copia is
  port ( a       : in unsigned(2 downto 0);
		 b       : in unsigned(2 downto 0);
		 enable  : in std_logic;
		 sel     : in std_logic;
		 saida   : out unsigned(2 downto 0)
  );
end entity;

architecture a_mux_copia of mux_copia is

begin
	saida <= a when enable='1' and sel='0' else
			 b when enable='1' and sel='1' else
			"000";			 
end architecture;
