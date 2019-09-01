library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity ROM is
	port( clk      : in std_logic;
		  endereco : in unsigned(6 downto 0);
		  dado     : out unsigned(15 downto 0)
	);
end entity;

architecture a_ROM of ROM is
	type mem is array (0 to 127) of unsigned(15 downto 0);
	constant conteudo_ROM : mem := (
		0 => "1000000010000000", -- add %r1, 0
		1 => "1000000010000001", -- add %r1, 1
		2 => "1000000100000001", -- add %r2, 1
		3 => "1000001100011111", -- add %r6, 31
		4 => "1000001010100000", -- add %r5, 32
		5 => "1000000010000001", -- add %r1, 1
		6 => "1000000100000001", -- add %r2, 1
		7 => "0010010010010010", -- ld [%r2], %r1
		8 => "0010101110010001", -- ld %r7, %r1
		9 => "1000001111100000", -- add %r7, -32
		10 => "0000111001111011", -- jreq -5
		11 => "1000000110000001", -- add %r3, 1
		12 => "1000000110000001", -- add %r3, 1
		13 => "0010101000010011", -- ld %r4, %r3
		14 => "0011101001000011", -- add %r4, %r3
		15 => "0010010000010100", -- ld [%r4], %r0
		16 => "0010101110010110", -- ld %r7, %r6
		17 => "0011101111010100", -- sub %r7, %r4
		18 => "0000100001111100", -- jrlt -4
		19 => "0010101110010011", -- ld %r7, %r3
		20 => "0011101111010101", -- sub %r7, %r5
		21 => "0000111001110111", -- jreq -9
		22 => "0000000000000000", -- nop
		23 => "0000000000000000", -- nop
		24 => "0000000000000000", -- nop
	others => (others=>'0')
	);
begin
	process(clk)
	begin
		if(rising_edge(clk)) then
			dado <= conteudo_ROM(to_integer(endereco));
		end if;
	end process;
end architecture;
