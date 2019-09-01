library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity ULA_tb is
end;

architecture a_ULA_tb of ULA_tb is
	component ULA
		port( x			 : in unsigned(15 downto 0);
		   	  y			 : in unsigned(15 downto 0);
			  sel		 : in unsigned(1 downto 0);
			  resultado  : out unsigned(15 downto 0)
		);
	end component;
	
	signal x,y,resultado : unsigned(15 downto 0);
	signal sel : unsigned(1 downto 0);
	begin
		uut : ULA port map( x         => x,
							y         => y,
							sel       => sel,
							resultado => resultado
				  );
	process
	begin
		x <= "0000000000000110";
		y <= "1111111111111111";
		sel <= "00";
		wait for 50 ns;
		sel <= "01";
		wait for 50 ns;
		sel <= "10";
		wait for 50 ns;
		sel <= "11";
		wait for 50 ns;
		wait;
	end process;
end architecture;