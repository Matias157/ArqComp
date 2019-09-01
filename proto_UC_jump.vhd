library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity proto_UC_jump is
	port( clk          : in std_logic;
		  rst          : in std_logic;
		  wr_en        : in std_logic;
		  jump_en      : in std_logic;
		  branch_eq_en : in std_logic;
		  branch_le_en : in std_logic;
		  zero         : in std_logic;
		  neg          : in std_logic;
		  data_in      : in unsigned(6 downto 0);
		  data_out     : out unsigned(6 downto 0)
	);
end entity;

architecture a_proto_UC_jump of proto_UC_jump is
	component PC is
		port( clk      : in std_logic;
			  rst      : in std_logic;
			  wr_en    : in std_logic;
			  data_in  : in unsigned(6 downto 0);
			  data_out : out unsigned(6 downto 0)
		);
	end component;
	
	signal data_in_s, data_out_s: unsigned(6 downto 0);
	
begin

	TopReg: PC port map ( 		 clk => clk,
								 rst => rst,
								 wr_en => wr_en,
								 data_in => data_in_s,
								 data_out => data_out_s
					  );

	data_in_s <= data_out_s + "0000001" when (jump_en = '0' and branch_eq_en = '0' and branch_le_en = '0') or (branch_eq_en = '1' and zero = '1') or (branch_le_en = '1' and neg = '1') else 
				 data_out_s + data_in when branch_eq_en = '1' and zero = '0' else
				 data_out_s + data_in when branch_le_en = '1' and neg = '0' else
				 data_in;
	data_out <= data_out_s;
					  
end architecture;