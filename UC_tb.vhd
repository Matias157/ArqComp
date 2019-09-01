library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity UC_tb is
end entity;

architecture a_UC_tb of UC_tb is
	component UC is
		port (
				inst 	    : in unsigned(15 downto 0);
  				jump_en		: out std_logic;
  				erro	   	: out std_logic
  			);
	end component;

	signal jump_en, erro: std_logic;
	signal inst: unsigned(15 downto 0);

	begin

	 uut: UC port map( inst => inst,
					   jump_en => jump_en,
					   erro => erro
			 );

	 process
	 begin
		 inst <= "0000000000000000";
		 wait for 100 ns;
		 inst <= "0000001100000000";
		 wait for 100 ns;
		 inst <= "1000000000000000";
		 wait for 100 ns;
		 wait;
	end process;

end architecture;
