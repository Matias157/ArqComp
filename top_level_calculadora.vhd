library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity top_level_calculadora is
	port( clk      : in std_logic;
		  rst      : in std_logic;
		  estado   : out unsigned(1 downto 0);
		  PC       : out unsigned(6 downto 0);
		  inst     : out unsigned(15 downto 0);
		  ULA_out  : out unsigned(15 downto 0)
	);
end entity;

architecture a_top_level_calculadora of top_level_calculadora is
	component proto_UC_jump is
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
	end component;

	component ROM is
		port( clk      : in std_logic;
			  endereco : in unsigned(6 downto 0);
			  dado     : out unsigned(15 downto 0)
		);
	end component;
	
	component maq_estados is
		port( clk    : in std_logic;
			  rst    : in std_logic;
			  estado : out unsigned(1 downto 0)
		);
	end component;
	
	component UC is
	  	port( opcode       : in unsigned(5 downto 0);
		      functR	   : in unsigned(3 downto 0);
		      functJ       : in unsigned(2 downto 0);
		      jump_en      : out std_logic;
		      branch_eq_en : out std_logic;
		      branch_le_en : out std_logic;
		      reg_wr_en    : out std_logic;
		      PC_update    : out std_logic;
		      reg_en       : out std_logic;
		      RAM_wr_en    : out std_logic;
		      imm_en       : out unsigned(1 downto 0);
		      estado	   : in unsigned(1 downto 0);
		      ULA_op	   : out unsigned(1 downto 0)
		);
	end component; 
	
	component banco_regs is
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
	end component;
	
	component ULA is
		port (x			: in unsigned(15 downto 0);
			  y			: in unsigned(15 downto 0);
			  sel		: in unsigned(1 downto 0);
			  resultado : out unsigned(15 downto 0)
		);
	end component;
	
	component mux2bits is
		port (a      : in unsigned(15 downto 0);
			  b      : in unsigned(15 downto 0);
			  enable : in std_logic;
			  sel    : in unsigned (1 downto 0);
			  saida  : out unsigned(15 downto 0)
		);
	end component;
	
	component mux_copia is
		port( a       : in unsigned(2 downto 0);
			  b       : in unsigned(2 downto 0);
			  enable  : in std_logic;
			  sel     : in std_logic;
			  saida   : out unsigned(2 downto 0)
		);
	end component;
		
	component barramento is
		port ( inst     : in unsigned(15 downto 0);
			   opcode   : out unsigned(5 downto 0);
			   functR   : out unsigned(3 downto 0);
			   functJ   : out unsigned(2 downto 0);
			   rd       : out unsigned(2 downto 0);
			   rs       : out unsigned(2 downto 0);
			   end_jump : out unsigned(6 downto 0);
			   imm      : out unsigned(6 downto 0)
		);
	end component;

	component flipflopzero is 
		port( clk      : in std_logic;
		      rst      : in std_logic;
		  	  wr_en    : in std_logic;
		  	  data_in  : in std_logic;
		  	  data_out : out std_logic
		);
	end component;

	component flipflopneg is 
		port( clk      : in std_logic;
		      rst      : in std_logic;
		  	  wr_en    : in std_logic;
		  	  data_in  : in std_logic;
		  	  data_out : out std_logic
		);
	end component;

	component RAM is
		port( clk      : in std_logic;
			  endereco : in unsigned(6 downto 0);
			  wr_en    : in std_logic;
			  dado_in  : in unsigned(15 downto 0);
	 		  dado_out : out unsigned(15 downto 0)
	 	);
	 end component;

	component mux_RAM_ULA is
	    port ( sel   :  in std_logic;
			   a	 :  in unsigned (15 downto 0);  
			   b	 :  in unsigned (15 downto 0);
			   saida : out unsigned (15 downto 0)
	    );
	end component;
	
	signal endereco_s, endereco_jump: unsigned(6 downto 0);
	signal inst_s, ULA_out_s, ULA_in1, ULA_in2, data_rs, signal_ext, RAM_in, RAM_out, RAM_ULA_out: unsigned(15 downto 0);
	signal pc_wr_en, jump_en, branch_eq_en, branch_le_en, zeroin, zeroout, negin, negout, erro, enable_mux, reg_wr_en, reg_en, wr_en_branch_eq, wr_en_branch_le, RAM_wr_en, sel_RAM_ULA: std_logic;
	signal functR: unsigned(3 downto 0);
	signal opcode: unsigned(5 downto 0);
	signal imm, end_RAM: unsigned(6 downto 0);
	signal functJ, end_rd, end_rs, end_reg_2, zeroimm: unsigned(2 downto 0);
	signal ULA_op, estado_s, imm_en: unsigned(1 downto 0);

begin

	Topproto_UC_jump: proto_UC_jump port map ( data_out     => endereco_s,
											   clk 	        => clk,
											   rst 	        => rst,
											   wr_en        => pc_wr_en,
											   jump_en      => jump_en,
											   branch_eq_en => branch_eq_en,
											   branch_le_en => branch_le_en,
											   zero         => zeroout,
											   neg          => negout,
											   data_in      => endereco_jump
									);

	TopROM: ROM port map ( clk 	    => clk,
			 	     	   endereco => endereco_s,
						   dado	    => inst_s
				);

	Topmaq_estados:	maq_estados port map ( clk 	  => clk,
										   rst 	  => rst,
										   estado => estado_s
									);

	TopUC: UC port map ( opcode       => opcode,
						 functR       => functR,
						 functJ       => functJ,
						 jump_en      => jump_en,
						 branch_eq_en => branch_eq_en,
						 branch_le_en => branch_le_en,
						 reg_wr_en    => reg_wr_en,
						 PC_update    => pc_wr_en,
						 reg_en       => reg_en,
						 RAM_wr_en    => RAM_wr_en,
						 imm_en       => imm_en,
						 estado       => estado_s,
						 ULA_op       => ULA_op
			  );

	TopBarramento: barramento port map ( inst     => inst_s,
										 opcode   => opcode,
										 functR   => functR,
										 functJ   => functJ,
										 rd       => end_rd,
										 rs       => end_rs,
										 end_jump => endereco_jump,
										 imm      => imm
							  );

	Topmux_copia: mux_copia port map (  a      => end_rd,
										b      => zeroimm,
										enable => enable_mux,
										sel    => reg_en,
										saida  => end_reg_2
							 );

	Topmux2bits: mux2bits port map ( a      => data_rs,
									 b      => signal_ext,
									 enable => enable_mux,
									 sel    => imm_en,
									 saida  => ULA_in1
						  );

	TopULA: ULA port map ( sel       => ULA_op,
						   x         => ULA_in2,
						   y         => ULA_in1,
						   resultado => ULA_out_s
				);

	Topbanco_regs: banco_regs port map ( clk        => clk,
										 rst        => rst,
										 write_data => RAM_ULA_out,
										 data1      => data_rs,
										 data2      => ULA_in2,
										 reg_rd1    => end_rs,
										 reg_rd2    => end_reg_2,
										 wr_select  => end_rd,
										 wr_enable  => reg_wr_en
							  );

	Topfliflopzero: flipflopzero port map ( clk      => clk,
									   	    rst      => rst,
									   	    wr_en    => wr_en_branch_eq,
									   	    data_in  => zeroin,
									   	    data_out => zeroout
							     );

	Topfliflopneg: flipflopneg port map ( clk      => clk,
									   	  rst      => rst,
									   	  wr_en    => wr_en_branch_le,
									   	  data_in  => negin,
									   	  data_out => negout
							   );

	TopRAM: RAM port map( clk      => clk,
		  				  endereco => end_RAM,
		  				  wr_en    => RAM_wr_en,
		  				  dado_in  => RAM_in,
 		 				  dado_out => RAM_out
 				);

	Topmux_RAM_ULA: mux_RAM_ULA port map( sel   => sel_RAM_ULA,
										  a	    => ULA_out_s,
										  b	    => RAM_out,
										  saida	=> RAM_ULA_out
  								);


	signal_ext <= "111111111" & imm when imm(6)='1' else
					 "000000000" & imm;

	ULA_out <= ULA_out_s;

	inst <= inst_s;
	
	estado <= estado_s;
	
	PC <= endereco_s;

	enable_mux <= '1';
	
	zeroimm <= "000";

	wr_en_branch_eq <= '1' when opcode = "001110" or opcode = "100000" else
		            '0';

	wr_en_branch_le <= '1' when opcode = "001110" or opcode = "100000" else
		            '0';

	zeroin <= '1' when ULA_out_s = "0000000000000000" else
	          '0';

	negin <= '1' when ULA_out_s(15) = '1'  else
	          '0';

	end_RAM <= data_rs(6 downto 0);

	RAM_in <= ULA_in2;

	sel_RAM_ULA <= '1' when opcode = "001000" else
		   		   '0';

end architecture;
