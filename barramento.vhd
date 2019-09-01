library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity barramento is
	port ( inst     : in unsigned(15 downto 0);
		   opcode   : out unsigned(5 downto 0);
		   functR   : out unsigned(3 downto 0);
		   functJ   : out unsigned(2 downto 0);
		   rd       : out unsigned(2 downto 0);
		   rs       : out unsigned(2 downto 0);
		   end_jump : out unsigned(6 downto 0);
		   imm      : out unsigned(6 downto 0)
	);
end entity barramento;

architecture a_barramento of barramento is

begin

	opcode <= inst(15 downto 10);
	functR <= inst(6 downto 3);
	functJ <= inst(9 downto 7);
	rd <= inst(9 downto 7);
	rs <= inst(2 downto 0);
	end_jump <= inst(6 downto 0);
	imm <= inst(6 downto 0);
	
end architecture a_barramento;
