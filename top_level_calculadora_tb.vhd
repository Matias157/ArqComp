library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity top_level_calculadora_tb is
end entity;

architecture a_top_level_calculadora_tb of top_level_calculadora_tb is
	component top_level_calculadora is
		port( clk      : in std_logic;
			  rst      : in std_logic;
			  estado   : out unsigned(1 downto 0);
			  PC       : out unsigned(6 downto 0);
			  inst     : out unsigned(15 downto 0);
			  ULA_out  : out unsigned(15 downto 0)
	);
	end component;

	signal clk, rst: std_logic;
	signal estado: unsigned(1 downto 0);
	signal PC: unsigned(6 downto 0);
	signal inst, ULA_out: unsigned(15 downto 0);

	begin

	 uut: top_level_calculadora port map( clk => clk, 
										  rst => rst, 
										  estado => estado,
										  PC => PC,
										  inst => inst,
										  ULA_out => ULA_out
								);

	 process
	 begin
		 clk <= '0';
		 wait for 50 ns;
		 clk <= '1';
		 wait for 50 ns;
	 end process;

	 process
		 begin
		 rst <= '1';
		 wait for 100 ns;
		 rst <= '0';
		 wait;
	 end process;

end architecture;
