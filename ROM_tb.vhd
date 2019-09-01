library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity ROM_tb is
end;

architecture a_ROM_tb of ROM_tb is
	component ROM 
		port( clk      : in std_logic;
		      endereco : in unsigned(6 downto 0);
		      dado     : out unsigned(15 downto 0)
		);
	end component;
	signal clk : std_logic;
	signal endereco : unsigned(6 downto 0);
	signal dado : unsigned(15 downto 0);
begin
	uut : ROM port map( clk      => clk,
						endereco => endereco,
						dado     => dado);
	process
	begin
		clk <= '0';
		wait for 50 ns;
		clk <= '1';
		wait for 50 ns;
	end process;
	
	process
	begin
		endereco <= "0000000";
		wait for 100 ns;
		endereco <= "0000001";
		wait for 100 ns;
		endereco <= "0000010";
		wait for 100 ns;
		endereco <= "0000011";
		wait for 100 ns;
		endereco <= "0000100";
		wait for 100 ns;
		endereco <= "0000101";
		wait for 100 ns;
		endereco <= "0000110";
		wait for 100 ns;
	end process;
end architecture;