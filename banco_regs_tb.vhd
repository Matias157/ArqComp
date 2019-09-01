library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;              

entity banco_regs_tb is
end entity;

architecture a_banco_regs_tb of banco_regs_tb is
	component banco_regs is
		port (clk        : in std_logic;                         
			  rst        : in std_logic;                        
			  wr_enable  : in std_logic;                   
			  wr_select  : in unsigned(2 downto 0);
			  reg_rd1    : in unsigned(2 downto 0) ;
			  reg_rd2    : in unsigned(2 downto 0) ;   
			  write_data : in unsigned(15 downto 0) ;   
			  data1      : out unsigned(15 downto 0);
			  data2      : out unsigned(15 downto 0)   
		);
	end component banco_regs;

	signal clk,rst,wr_enable         : std_logic;
	signal wr_select,reg_rd1,reg_rd2 : unsigned(2 downto 0);
	signal write_data,data1,data2    : unsigned(15 downto 0);

begin
	uut: banco_regs port map ( clk        => clk,
							   rst        => rst,
							   wr_enable  => wr_enable,
							   wr_select  => wr_select,
							   reg_rd1    => reg_rd1,
							   reg_rd2    => reg_rd2,
							   write_data => write_data,
							   data1      => data1,
							   data2      => data2
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
	
	process
	begin
		wait for 1000 ns;
		wr_enable<='1';
		reg_rd1<="001";
		reg_rd2<="001";
		write_data<="1011000011010010";
		wr_select<="001";
		wait for 150 ns;
		wr_select<="010";
		wait for 150 ns;
		wr_select<="011";
		wait for 150 ns;
		wr_select<="100";
		wait for 150 ns;
		wr_select<="101";
		wait for 150 ns;
		wr_select<="110";
		wait for 150 ns;
		wr_select<="111";
		wait for 150 ns;
		wr_select<="000";
		wait for 150 ns;
		reg_rd2<="001";
		write_data<="1101001010110010";
		
		wait for 50 ns;
		reg_rd1<="000";
		reg_rd2<="000";

		wait;
	end process;
end architecture;