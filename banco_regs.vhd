library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity banco_regs is
	port( clk        : in std_logic;                         
		  rst        : in std_logic;                        
		  wr_enable  : in std_logic;                   
		  wr_select  : in unsigned(2 downto 0);
		  reg_rd1    : in unsigned(2 downto 0) ;
		  reg_rd2    : in unsigned(2 downto 0) ;   
		  write_data : in unsigned(15 downto 0) ;   
		  data1      : out unsigned(15 downto 0);
  		  data2      : out unsigned(15 downto 0)
	);
end entity;

architecture a_banco_regs of banco_regs is
	component reg16bits is
		port (  clk      : in std_logic;
				rst      : in std_logic;
				wr_en    : in std_logic;
				data_in  : in unsigned(15 downto 0);
				data_out : out unsigned(15 downto 0)
		);
	end component;
		
	signal out0, out1, out2, out3, out4, out5, out6, out7 : unsigned(15 downto 0);
	signal en_1,en_2,en_3,en_4,en_5,en_6,en_7             : std_logic;
begin

	reg1: reg16bits port map (clk=>clk,rst=>rst,wr_en=>en_1,data_in=>write_data,data_out=>out1);
	reg2: reg16bits port map (clk=>clk,rst=>rst,wr_en=>en_2,data_in=>write_data,data_out=>out2);
	reg3: reg16bits port map (clk=>clk,rst=>rst,wr_en=>en_3,data_in=>write_data,data_out=>out3);
	reg4: reg16bits port map (clk=>clk,rst=>rst,wr_en=>en_4,data_in=>write_data,data_out=>out4);
	reg5: reg16bits port map (clk=>clk,rst=>rst,wr_en=>en_5,data_in=>write_data,data_out=>out5);
	reg6: reg16bits port map (clk=>clk,rst=>rst,wr_en=>en_6,data_in=>write_data,data_out=>out6);
	reg7: reg16bits port map (clk=>clk,rst=>rst,wr_en=>en_7,data_in=>write_data,data_out=>out7);
	
	
	data1 <= "0000000000000000" when reg_rd1="000" else
		     out1 when reg_rd1="001" else
		     out2 when reg_rd1="010" else
		     out3 when reg_rd1="011" else
		     out4 when reg_rd1="100" else
		     out5 when reg_rd1="101" else
		     out6 when reg_rd1="110" else
		     out7 when reg_rd1="111" else
		     "0000000000000000";

	data2 <= "0000000000000000" when reg_rd2="000" else
		     out1 when reg_rd2="001" else
		     out2 when reg_rd2="010" else
		     out3 when reg_rd2="011" else
		     out4 when reg_rd2="100" else
		     out5 when reg_rd2="101" else
		     out6 when reg_rd2="110" else
		     out7 when reg_rd2="111" else
		     "0000000000000000";

	en_1 <= '1' when wr_enable='1' and wr_select="001"else
			'0';
	en_2 <= '1' when wr_enable='1' and wr_select="010"else
			'0';
	en_3 <= '1' when wr_enable='1' and wr_select="011"else
			'0';
	en_4 <= '1' when wr_enable='1' and wr_select="100"else
			'0';
	en_5 <= '1' when wr_enable='1' and wr_select="101"else
			'0';
	en_6 <= '1' when wr_enable='1' and wr_select="110"else
			'0';
	en_7 <= '1' when wr_enable='1' and wr_select="111"else
			'0';
 	 
end architecture ;