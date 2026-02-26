----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    09:32:22 04/26/2024 
-- Design Name: 
-- Module Name:    Datapath - Behavioral 
-- Project Name: 
-- Target Devices: 
-- Tool versions: 
-- Description: 
--
-- Dependencies: 
--
-- Revision: 
-- Revision 0.01 - File Created
-- Additional Comments: 
--
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity Datapath is
	 Port( clk : in  STD_LOGIC;
			 rst : in  STD_LOGIC;
			 PC_sel : in  STD_LOGIC;
			 PC_LdEn : in  STD_LOGIC;
			 RF_WrEn : in  STD_LOGIC;
			 RF_WrData_sel : in  STD_LOGIC;
			 RF_B_sel : in  STD_LOGIC;
			 immed_sel : in  STD_LOGIC_VECTOR (1 downto 0);
			 ALU_func : in STD_LOGIC_VECTOR(3 downto 0);
			 ALU_Bin_sel : in  STD_LOGIC;
			 ALU_ovf : out STD_LOGIC;
			 ALU_zero_out : out STD_LOGIC;
			 ALU_cout : out STD_LOGIC;
			 MEM_WrEn : in  STD_LOGIC;
			 byteOp : in  STD_LOGIC;
			 Instruction : out STD_LOGIC_VECTOR(31 downto 0)
			 );	 
end Datapath;

architecture Behavioral of Datapath is
signal Instr : STD_LOGIC_VECTOR(31 downto 0);
signal RF_A_mem : STD_LOGIC_VECTOR(31 downto 0);
signal RF_B_mem : STD_LOGIC_VECTOR(31 downto 0);
signal Immed : STD_LOGIC_VECTOR(31 downto 0);
signal sig_ALU_out : STD_LOGIC_VECTOR (31 downto 0);
signal DEC_MEM_out : STD_LOGIC_VECTOR (31 downto 0);

--Multi-cycle signals
signal If_Dec_Instr : STD_LOGIC_VECTOR(31 downto 0);
signal Dec_Exec_RF_A : STD_LOGIC_VECTOR(31 downto 0);
signal Dec_Exec_RF_B : STD_LOGIC_VECTOR(31 downto 0);
signal Dec_Exec_Immed : STD_LOGIC_VECTOR(31 downto 0);
signal Exec_Mem_Alu_out : STD_LOGIC_VECTOR(31 downto 0);
signal Mem_Wb_Mem_out : STD_LOGIC_VECTOR(31 downto 0);

--pipeline signals
signal ex_mem_wb_alu_out : STD_LOGIC_VECTOR (31 downto 0);
signal forwarding_sigA : STD_LOGIC_VECTOR(1 downto 0); 
signal forwarding_sigB : STD_LOGIC_VECTOR(1 downto 0); 
signal alu_mem_out : STD_LOGIC_VECTOR(31 downto 0);
signal alu_mux_a : STD_LOGIC_VECTOR(31 downto 0);
signal alu_mux_b : STD_LOGIC_VECTOR(31 downto 0);
signal holding_mem_in : STD_LOGIC_VECTOR(31 downto 0);

signal dec_ex_rf_wren : STD_LOGIC;
signal dec_ex_rf_wrdatasel : STD_LOGIC;
signal dec_ex_alubinsel : STD_LOGIC;
signal dec_ex_alufunc : STD_LOGIC_VECTOR(3 downto 0);
signal dec_ex_mem_wren : STD_LOGIC;
signal dec_ex_byteop : STD_LOGIC;
signal ex_mem_rfwren : STD_LOGIC;
signal ex_mem_rfwrdatasel : STD_LOGIC;
signal ex_mem_memwren : STD_LOGIC;
signal ex_mem_byteop : STD_LOGIC;
signal mem_wb_rfwren : STD_LOGIC;
signal mem_wb_rfwrdatasel : STD_LOGIC;

signal if_dec_rd_rs_rt_sig : STD_LOGIC_VECTOR(14 downto 0);
signal dec_rd_rs_rt_sig : STD_LOGIC_VECTOR(14 downto 0);
signal ex_rd_rs_rt_sig : STD_LOGIC_VECTOR(14 downto 0);
signal mem_rd_rs_rt_sig : STD_LOGIC_VECTOR(14 downto 0);

signal stall_we : STD_LOGIC;
signal haz_out : STD_LOGIC;
signal haz_pclden : STD_LOGIC;
signal stalled_mux : STD_LOGIC_VECTOR(13 downto 0);
signal not_stalled_mux : STD_LOGIC_VECTOR(13 downto 0);
signal output_14bit : STD_LOGIC_VECTOR(13 downto 0);

component mux_stalling
		  Port ( mux_stall_input1 : in  STD_LOGIC_VECTOR (13 downto 0);
           mux_stall_input2 : in  STD_LOGIC_VECTOR (13 downto 0);
           sel : in  STD_LOGIC;
           mux_stall_output : out  STD_LOGIC_VECTOR (13 downto 0)
			  );
end component;

component mux2to1
        Port (
            mux2_input1 : in  STD_LOGIC_VECTOR (31 downto 0);
            mux2_input2 : in  STD_LOGIC_VECTOR (31 downto 0);
            sel : in  STD_LOGIC;
            mux2_output : out  STD_LOGIC_VECTOR (31 downto 0)
        );
end component;

component mux3to1
			Port (mux_input1 : in  STD_LOGIC_VECTOR (31 downto 0);
            mux_input2 : in  STD_LOGIC_VECTOR (31 downto 0);
            mux_input3 : in  STD_LOGIC_VECTOR (31 downto 0);
            sel : in  STD_LOGIC_VECTOR(1 downto 0);
            mux_output : out  STD_LOGIC_VECTOR (31 downto 0)
				);
end component;

component IFSTAGE is
	 Port ( clk : in  STD_LOGIC;
           PC_Immed : in  STD_LOGIC_VECTOR (31 downto 0);
           PC_sel : in  STD_LOGIC;
           PC_LdEn : in  STD_LOGIC;
           Reset : in  STD_LOGIC;
           Instr : out  STD_LOGIC_VECTOR (31 downto 0)
			  );
end component;


component DECSTAGE is
		Port(Instr : in  STD_LOGIC_VECTOR (31 downto 0);
           RF_WrEn : in  STD_LOGIC;
           ALU_out : in  STD_LOGIC_VECTOR (31 downto 0);
			  MEM_out : in  STD_LOGIC_VECTOR (31 downto 0);
           RF_WrData_sel : in  STD_LOGIC;
           RF_B_sel : in  STD_LOGIC;
           clk : in  STD_LOGIC;
			  rst : in STD_LOGIC;
			  rd_vector : in STD_LOGIC_VECTOR(4 downto 0);
			  immed_sel : in STD_LOGIC_VECTOR(1 downto 0);
           Immed : out  STD_LOGIC_VECTOR (31 downto 0);
			  RF_A : out  STD_LOGIC_VECTOR (31 downto 0);
           RF_B : out  STD_LOGIC_VECTOR (31 downto 0)
			  );
end component;

component MEMSTAGE is
	 Port ( clk : in  STD_LOGIC;
           Mem_WrEn : in  STD_LOGIC;
			  byteOp : in  STD_LOGIC;
           ALU_MEM_Addr : in  STD_LOGIC_VECTOR (31 downto 0);
           MEM_DataIn : in  STD_LOGIC_VECTOR (31 downto 0);
           MEM_DataOut : out  STD_LOGIC_VECTOR (31 downto 0)
			  );
end component;

component ALUSTAGE is 
	 Port ( RF_A : in  STD_LOGIC_VECTOR (31 downto 0);
           RF_B : in  STD_LOGIC_VECTOR (31 downto 0);
           Immed : in  STD_LOGIC_VECTOR (31 downto 0);
           ALU_Bin_sel  : in  STD_LOGIC;
           ALU_func : in  STD_LOGIC_VECTOR (3 downto 0);
           ALU_out : out  STD_LOGIC_VECTOR (31 downto 0);
			  ALU_ovf : out STD_LOGIC;
			  ALU_zero_out : out STD_LOGIC;
			  ALU_cout : out STD_LOGIC
			  );
end component;

component RegisterEx is 
	 Port(
		  clk : in STD_LOGIC;
		  din : in STD_LOGIC_VECTOR(31 downto 0);
		  we : in STD_LOGIC;
		  rst : in STD_LOGIC;
		  dout : out STD_LOGIC_VECTOR(31 downto 0)
		  );
end component;

component Register15Bit is 
	 Port(
		  clk : in STD_LOGIC;
		  din : in STD_LOGIC_VECTOR(14 downto 0);
		  we : in STD_LOGIC;
		  rst : in STD_LOGIC;
		  dout : out STD_LOGIC_VECTOR(14 downto 0)
		  );
end component;

component Forwarding_Unit is
		Port ( 
			  EX_MEM_RegRd : in  STD_LOGIC_VECTOR (4 downto 0);
           MEM_WB_RegRd : in  STD_LOGIC_VECTOR (4 downto 0);
           ID_EX_RegRs : in  STD_LOGIC_VECTOR (4 downto 0);
           ID_EX_RegRt : in  STD_LOGIC_VECTOR (4 downto 0);
           EX_MEM_RegWrite : in  STD_LOGIC;
			  MEM_WB_RegWrite : in  STD_LOGIC;
           forwardA : out  STD_LOGIC_VECTOR (1 downto 0);
           forwardB : out  STD_LOGIC_VECTOR (1 downto 0)
			  );
end component;			  

component Hazard_Detection_Unit is 
			Port ( 
			  forA : in STD_LOGIC_VECTOR(1 downto 0);
			  forB : in STD_LOGIC_VECTOR(1 downto 0);
			  ID_EX_MemWrite : in  STD_LOGIC;
			  WrEn_last_wb : in STD_LOGIC;
           ID_EX_RegRt : in  STD_LOGIC_VECTOR (4 downto 0);
           IF_ID_RegRs : in  STD_LOGIC_VECTOR (4 downto 0);
           IF_ID_RegRt : in  STD_LOGIC_VECTOR (4 downto 0);
           PC_LdEn : out  STD_LOGIC;
           IF_ID_Write : out  STD_LOGIC;
           control_signal : out  STD_LOGIC
			  );
end component;

component DEC_EX_pipeline is 
	Port ( clk : in STD_LOGIC;
           rst : in  STD_LOGIC;
			  RF_WrEn_in : in  STD_LOGIC;
			  RF_WrEn_out : out  STD_LOGIC;
           RF_WrData_sel_in : in  STD_LOGIC;
           RF_WrData_sel_out : out  STD_LOGIC;
           ALU_Bin_sel_in : in  STD_LOGIC;
           ALU_Bin_sel_out : out  STD_LOGIC;
			  ALU_func_in : in STD_LOGIC_VECTOR(3 downto 0);
			  ALU_func_out : out STD_LOGIC_VECTOR(3 downto 0);
           MEM_WrEn_in : in STD_LOGIC;
           MEM_WrEn_out : out STD_LOGIC;
			  byteOp_in : in  STD_LOGIC;
			  byteOp_out : out STD_LOGIC
			  );
end component;

component EX_MEM_pipeline is
		Port ( clk : in  STD_LOGIC;
           rst : in  STD_LOGIC;
           RF_WrEn_in : in  STD_LOGIC;
           RF_WrEn_out : out  STD_LOGIC;
           RF_WrData_sel_in : in  STD_LOGIC;
           RF_WrData_sel_out : out  STD_LOGIC;
           Mem_WrEn_in : in  STD_LOGIC;
           Mem_WrEn_out : out  STD_LOGIC;
			  byteOp_in : in STD_LOGIC;
			  byteOp_out : out STD_LOGIC
			  );
end component;

component MEM_WB_pipeline is
		 Port ( clk : in  STD_LOGIC;
           rst : in  STD_LOGIC;
			  RF_WrData_sel_in : in  STD_LOGIC;
           RF_WrData_sel_out : out  STD_LOGIC;
           RF_WrEn_in : in  STD_LOGIC;
           RF_WrEn_out : out  STD_LOGIC
			  );
end component;

begin

--IF_STAGE : IFSTAGE Port Map(clk => clk,
--									 PC_Immed => Dec_Exec_Immed,
--									 PC_sel => PC_sel, --ouput_14bit(0)
--									 PC_LdEn => PC_LdEn, --haz_pclden
--									 Reset => rst,
--									 Instr => Instr
--									 );
--								
--If_Dec_reg : RegisterEx Port Map(clk => clk,
--											rst => rst,
--											we => '1',
--											din => Instr,
--											dout => If_Dec_Instr
--											);


IF_STAGE : IFSTAGE Port Map(clk => clk,
									 PC_Immed => Dec_Exec_Immed,
									 PC_sel => PC_sel, 
									 PC_LdEn => haz_pclden,
									 Reset => rst,
									 Instr => Instr
									 );
											
If_Dec_reg : RegisterEx Port Map(clk => clk,
											rst => rst,
											we => stall_we,
											din => Instr,
											dout => If_Dec_Instr
											);											

 stalled_mux <= "00000000000000";
 not_stalled_mux <= byteOp & Mem_WrEn & ALU_bin_sel & ALU_func & immed_sel & RF_B_sel & RF_WrData_sel & RF_WrEn & PC_LdEn & PC_sel;
-- bits:              13        12          11          10-7        6-5          4            3            2         1         0        

haz_mux_stall : mux_stalling Port Map( mux_stall_input1 => stalled_mux,
													mux_stall_input2 => not_stalled_mux,
													sel => haz_out,
													mux_stall_output => output_14bit
													);
-- ---------------------------------------------------------------------------------

DEC_STAGE : DECSTAGE Port Map(Instr => If_Dec_Instr,
										RF_WrEn => mem_wb_rfwren,
										ALU_out => ex_mem_wb_alu_out,
										MEM_out => Mem_Wb_Mem_out,
										RF_WrData_sel => mem_wb_rfwrdatasel,
										RF_B_sel => output_14bit(4),
										clk => clk,
										rst => rst,
										rd_vector => mem_rd_rs_rt_sig(14 downto 10),
										immed_sel => output_14bit(6 downto 5),
										Immed => Immed,
										RF_A => RF_A_mem,
										RF_B => RF_B_mem
										);

if_dec_rd_rs_rt_sig <= If_Dec_Instr(20 downto 16) & If_Dec_Instr(25 downto 21) & If_Dec_Instr(15 downto 11);

Dec_rd_rs_rt_reg : Register15Bit Port Map(clk => clk,
														rst => rst,
													   we => '1',
													   din => if_dec_rd_rs_rt_sig,
													   dout => dec_rd_rs_rt_sig
													   );

Dec_Exec_reg_RF_A : RegisterEx Port Map(clk => clk,
													 rst => rst,
													 we => '1',
													 din => RF_A_mem,
													 dout => Dec_Exec_RF_A
													 );	

Dec_Exec_reg_RF_B : RegisterEx Port Map(clk => clk,
													 rst => rst,
													 we => '1',
													 din => RF_B_mem,
													 dout => Dec_Exec_RF_B
													 );

Dec_Exec_reg_RF_Immed : RegisterEx Port Map(clk => clk,
														  rst => rst,
														  we => '1',
														  din => Immed,
														  dout => Dec_Exec_Immed
														  );											  									


Dec_Ex_pipeline_reg : DEC_EX_pipeline Port Map(clk => clk,
															  rst => rst,
															  RF_WrEn_in => output_14bit(2),
															  RF_WrEn_out => dec_ex_rf_wren,
															  RF_WrData_sel_in => output_14bit(3),
															  RF_WrData_sel_out => dec_ex_rf_wrdatasel,
															  ALU_Bin_sel_in => output_14bit(11),
															  ALU_Bin_sel_out => dec_ex_alubinsel,
															  ALU_func_in => output_14bit(10 downto 7),
															  ALU_func_out => dec_ex_alufunc,
															  MEM_WrEn_in => output_14bit(12),
															  MEM_WrEn_out => dec_ex_mem_wren,
															  byteOp_in => output_14bit(13),
															  byteOp_out => dec_ex_byteop
															  );

-- ---------------------------------------------------------------------------------

ALU_STAGE : ALUSTAGE Port Map(RF_A => alu_mux_a,
										RF_B => alu_mux_b,
										Immed => Dec_Exec_Immed,
										ALU_Bin_sel => dec_ex_alubinsel,
										ALU_func => dec_ex_alufunc,
										ALU_out => sig_ALU_out,
										ALU_cout => ALU_cout,
										ALU_zero_out => ALU_zero_out,
										ALU_ovf => ALU_ovf
										);

Exec_rd_rs_rt_reg : Register15Bit Port Map(clk => clk,
														rst => rst,
													   we => '1',
													   din => dec_rd_rs_rt_sig,
													   dout => ex_rd_rs_rt_sig
													   );
										
Exec_Mem_reg : RegisterEx Port Map(clk => clk,
											  rst => rst,
											  we => '1',
											  din => sig_ALU_out,
											  dout => Exec_Mem_Alu_out
											  );	

Exec_Mem_datain_reg : RegisterEx Port Map(clk => clk,
											  rst => rst,
											  we => '1',
											  din => alu_mux_b,
											  dout => holding_mem_in
											  );	

Ex_mem_wb_alu_reg : RegisterEx Port Map(clk => clk,
											   rst => rst,
											   we => '1',
											   din => Exec_Mem_Alu_out,
											   dout => ex_mem_wb_alu_out
											   );	
											  
EX_Mem_pipeline_reg : EX_MEM_pipeline Port Map(clk => clk,											  
															  rst => rst,
															  RF_WrEn_in => dec_ex_rf_wren,
															  RF_WrEn_out => ex_mem_rfwren,
															  RF_WrData_sel_in => dec_ex_rf_wrdatasel,
															  RF_WrData_sel_out => ex_mem_rfwrdatasel,
															  Mem_WrEn_in => dec_ex_mem_wren,
															  Mem_WrEn_out => ex_mem_memwren,
															  byteOp_in => dec_ex_byteop,
															  byteOp_out => ex_mem_byteop
															  );
															  
-- ---------------------------------------------------------------------------------
															  
MEM_STAGE : MEMSTAGE Port Map(clk => clk,
										Mem_WrEn => ex_mem_memwren,
										byteOp => ex_mem_byteop,
										ALU_MEM_Addr => Exec_Mem_Alu_out,
										MEM_DataIn => holding_mem_in,
										MEM_DataOut => DEC_MEM_out
										);
										

Mem_rd_rs_rt_reg : Register15Bit Port Map(clk => clk,
														rst => rst,
													   we => '1',
													   din => ex_rd_rs_rt_sig,
													   dout => mem_rd_rs_rt_sig
													   );
										
Mem_wb_pipeline_reg : MEM_WB_pipeline Port Map(clk => clk,
															  rst => rst,
															  RF_WrData_sel_in => ex_mem_rfwrdatasel,
															  RF_WrData_sel_out => mem_wb_rfwrdatasel,
															  RF_WrEn_in => ex_mem_rfwren,
															  RF_WrEn_out => mem_wb_rfwren
															  );
										
Mem_Wb_reg : RegisterEx Port Map(clk => clk,
			 							   rst => rst,
											we => '1',
											din => DEC_MEM_out,
											dout => Mem_Wb_Mem_out
											);	
											

Alu_mem_mux : mux2to1 
			Port Map(
						mux2_input1 => ex_mem_wb_alu_out,
						mux2_input2 => Mem_Wb_Mem_out,
						sel => RF_WrData_sel,
						mux2_output => alu_mem_out
						);

Mux_upper_pipeline : mux3to1 Port Map(mux_input1 => alu_mem_out,
												  mux_input2 => Exec_Mem_Alu_out,
												  mux_input3 => Dec_Exec_RF_A,
												  sel => forwarding_sigA,
												  mux_output => alu_mux_a
												  );

Mux_down_pipeline : mux3to1 Port Map(mux_input1 => alu_mem_out,
												 mux_input2 => Exec_Mem_Alu_out,
												 mux_input3 => Dec_Exec_RF_B,
												 sel => forwarding_sigB,
												 mux_output => alu_mux_b
												 );
											
ForwardingUnit : Forwarding_Unit Port Map(
														EX_MEM_RegRd => ex_rd_rs_rt_sig(14 downto 10),
														MEM_WB_RegRd => mem_rd_rs_rt_sig(14 downto 10),
														ID_EX_RegRs => dec_rd_rs_rt_sig(9 downto 5),
														ID_EX_RegRt => dec_rd_rs_rt_sig(4 downto 0),
														EX_MEM_RegWrite => ex_mem_rfwren,
														MEM_WB_RegWrite => mem_wb_rfwren,
														forwardA => forwarding_sigA,
														forwardB => forwarding_sigB
														);	

Hazard_Detection : Hazard_Detection_Unit Port Map( 
																	ID_EX_MemWrite => dec_ex_mem_wren,
																	WrEn_last_wb => mem_wb_rfwren,	
																	forA => forwarding_sigA,
																	forB => forwarding_sigB,
																	ID_EX_RegRt => dec_rd_rs_rt_sig(14 downto 10),
																	IF_ID_RegRs => If_Dec_Instr(25 downto 21),
																	IF_ID_RegRt => If_Dec_Instr(15 downto 11),
																	PC_LdEn => haz_pclden,
																	IF_ID_Write => stall_we,
																	control_signal => haz_out
																	);													

	Instruction <= If_Dec_Instr;

end Behavioral;									