library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity ULA is
	port( x			 : in unsigned(15 downto 0);
		  y			 : in unsigned(15 downto 0);
		  sel		 : in unsigned(1 downto 0);
		  resultado  : out unsigned(15 downto 0)
	);
end entity;

architecture a_ULA of ULA is
	signal soma,subtrai,multiplica,maior : unsigned(15 downto 0);
begin
	soma <= x+y;
	subtrai <= x-y;
	multiplica <= x(7 downto 0)*y(7 downto 0);
	maior <= "0000000000000001" when x>y else
			 "0000000000000000" when x<=y else
			 "0000000000000000";
	resultado <= soma when sel="00" else
				 subtrai when sel="01" else
				 multiplica when sel="10" else
				 maior when sel="11" else
				 "0000000000000000";
end architecture;