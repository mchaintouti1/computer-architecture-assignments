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
			 Instruction : out STD_LOGIC_VECTOR(31 downto 0)
			 );	 
end Datapath;

architecture Behavioral of Datapath is
signal Instr : STD_LOGIC_VECTOR(31 downto 0);
signal RF_A_mem : STD_LOGIC_VECTOR(31 downto 0);
signal RF_B_mem : STD_LOGIC_VECTOR(31 downto 0);
signal Immed : STD_LOGIC_VECTOR(31 downto 0);
signal ALU_out : STD_LOGIC_VECTOR (31 downto 0);
signal DEC_MEM_out : STD_LOGIC_VECTOR (31 downto 0);


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
			  immed_sel : in STD_LOGIC_VECTOR(1 downto 0);
           Immed : out  STD_LOGIC_VECTOR (31 downto 0);
			  RF_A : out  STD_LOGIC_VECTOR (31 downto 0);
           RF_B : out  STD_LOGIC_VECTOR (31 downto 0)
			  );
end component;

component MEMSTAGE is
				Port ( clk : in  STD_LOGIC;
           Mem_WrEn : in  STD_LOGIC;
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

begin

IF_STAGE : IFSTAGE Port Map(clk => clk,
									 PC_Immed => Immed,
									 PC_sel => PC_sel,
									 PC_LdEn => PC_LdEn,
									 Reset => rst,
									 Instr => Instr
									 );
									 
DEC_STAGE : DECSTAGE Port Map(Instr => Instr,
										RF_WrEn => RF_WrEn,
										ALU_out => ALU_out,
										MEM_out => DEC_MEM_out,
										RF_WrData_sel => RF_WrData_sel,
										RF_B_sel => RF_B_sel,
										clk => clk,
										rst => rst,
										immed_sel => immed_sel,
										Immed => Immed,
										RF_A => RF_A_mem,
										RF_B => RF_B_mem
										);
										
MEM_STAGE : MEMSTAGE Port Map(clk => clk,
										Mem_WrEn => Mem_WrEn,
										ALU_MEM_Addr => ALU_out,
										MEM_DataIn => RF_B_mem,
										MEM_DataOut => DEC_MEM_out
										);
									 
ALU_STAGE : ALUSTAGE Port Map(RF_A => RF_A_mem,
										RF_B => RF_B_mem,
										Immed => Immed,
										ALU_Bin_sel => ALU_Bin_sel,
										ALU_func => ALU_func,
										ALU_out => ALU_out,
										ALU_cout => ALU_cout,
										ALU_zero_out => ALU_zero_out,
										ALU_ovf => ALU_ovf
										);
										
process(Instr)
begin 
		
		Instruction <= Instr;
		
		end process;


end Behavioral;

