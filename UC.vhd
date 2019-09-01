library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity UC is
	port ( opcode       : in unsigned(5 downto 0);
		   functR	    : in unsigned(3 downto 0);
		   functJ       : in unsigned(2 downto 0);
		   jump_en      : out std_logic;
		   branch_eq_en : out std_logic;
		   branch_le_en : out std_logic;
		   reg_wr_en    : out std_logic;
		   PC_update    : out std_logic;
		   reg_en       : out std_logic;
		   RAM_wr_en    : out std_logic;
		   imm_en       : out unsigned(1 downto 0);
		   estado	    : in unsigned(1 downto 0);
		   ULA_op	    : out unsigned(1 downto 0)
	);
end entity ;

architecture a_UC of UC is

begin

	PC_update <= '1' when estado = "10" else
				 '0';
	
	reg_en <= '1' when opcode = "001010" and functR = "0010" and estado = "00" else
				'0';

	imm_en <= "01" when opcode = "100000" and estado = "00" else
				"00";

	reg_wr_en <= '1' when estado = "00" 
				 and((opcode = "001010" and functR = "0010")
				 or (opcode = "001110" and functR = "1000")
				 or (opcode = "001110" and functR = "1010")
				 or (opcode = "100000")
				 or (opcode = "001000" and functR = "0010"))
				 else '0';
	
	jump_en <= '1' when opcode = "000000" and functJ = "110" and estado = "10" else
	 			 '0';

	branch_eq_en <= '1' when opcode = "000011" and functJ = "100" and estado = "10" else
	 			 '0';

	branch_le_en <= '1' when opcode = "000010" and functJ = "000" and estado = "10" else
	 			 '0';
	
	ULA_op <= "00" when (opcode = "001110" and functR = "1000") or (opcode = "100000") else
			  "01" when (opcode = "001110" and functR = "1010") else
	 	  	  "00";

	RAM_wr_en <= '1' when opcode = "001001" and functR = "0010" and estado = "00" else
				 '0';

end architecture;