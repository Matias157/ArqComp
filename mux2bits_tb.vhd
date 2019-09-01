library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all; 

entity mux2bits_tb is
end entity;
architecture a_mux2bits_tb of mux2bits_tb is
	component mux2bits is
		port ( a      : in unsigned(15 downto 0); 
			   b      : in unsigned(15 downto 0);
			   enable : in std_logic;
			   sel    : in unsigned (1 downto 0);
			   saida  : out unsigned(15 downto 0)
		);
	end component mux2bits;

	signal a, b, saida :unsigned(15 downto 0);
	signal sel:  unsigned (1 downto 0);
	signal enable: std_logic;

begin
	uut: mux2bits port map ( a      => a,
							 b      => b,
							 enable => enable,
							 sel    => sel, 
							 saida  => saida
				  );
    process
	begin

		enable <= '1';
		sel <= "00";
		a <= "0011110000000000";
		b <= "0000000001111100";
		wait for 50 ns;
		sel<="01";
		wait for 50 ns;
		sel<="10";
		wait for 50 ns;
		sel<="11";
		wait;
	end process ; 

end architecture ;