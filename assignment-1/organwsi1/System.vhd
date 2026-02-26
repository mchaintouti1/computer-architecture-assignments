----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    11:24:19 04/29/2024 
-- Design Name: 
-- Module Name:    System - Behavioral 
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

entity System is
    Port ( clk : in  STD_LOGIC;
           rst : in  STD_LOGIC);
end System;

architecture Behavioral of System is
signal PC_sel : STD_LOGIC;
signal PC_LdEn : STD_LOGIC;
signal RF_WrEn : STD_LOGIC;
signal RF_WrData_sel : STD_LOGIC;
signal RF_B_sel : STD_LOGIC;
signal immed_sel : STD_LOGIC_VECTOR (1 downto 0);
signal ALU_func : STD_LOGIC_VECTOR(3 downto 0);
signal ALU_Bin_sel : STD_LOGIC;
signal ALU_ovf : STD_LOGIC;
signal ALU_zero_out : STD_LOGIC;
signal ALU_cout : STD_LOGIC;
signal MEM_WrEn : STD_LOGIC;
signal Instr : STD_LOGIC_VECTOR(31 downto 0);

component Datapath is 
				Port(clk : in  STD_LOGIC;
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
end component;

component Control is 
				Port(clk : in  STD_LOGIC;
           rst : in  STD_LOGIC;
           Instr : in  STD_LOGIC_VECTOR (31 downto 0);
			  ALU_zero : in STD_LOGIC;
           PC_sel : out  STD_LOGIC;
           PC_Lden : out  STD_LOGIC;
			  RF_WrEn : out  STD_LOGIC;
           RF_WrData_sel : out  STD_LOGIC;
           RF_B_sel : out  STD_LOGIC;
           ALU_Bin_sel : out  STD_LOGIC;
			  ALU_func : out STD_LOGIC_VECTOR(3 downto 0);
           MEM_WrEn : out STD_LOGIC;
           immed_sel : out STD_LOGIC_VECTOR (1 downto 0)
			  );
end component;

begin

datapath_inst : Datapath port map(clk => clk,
											 rst => rst,
											 PC_sel => PC_sel,
											 PC_LdEn => PC_LdEn,
											 RF_WrEn => RF_WrEn,
											 RF_WrData_sel => RF_WrData_sel,
											 RF_B_sel => RF_B_sel,
											 immed_sel => immed_sel,
											 ALU_Bin_sel => ALU_Bin_sel,
											 ALU_func => ALU_func,
											 ALU_ovf => ALU_ovf,
											 ALU_zero_out => ALU_zero_out,
											 ALU_cout => ALU_cout,
											 MEM_WrEn => MEM_WrEn,
											 Instruction => Instr
											 );
											 
control_inst : Control port map(clk => clk,
										  rst => rst,
										  Instr => Instr,
										  ALU_zero => ALU_zero_out,
										  PC_sel => PC_sel,
										  PC_Lden => PC_Lden,
										  RF_WrEn => RF_WrEn,
										  RF_WrData_sel => RF_WrData_sel,
										  RF_B_sel => RF_B_sel,
										  ALU_Bin_sel => ALU_Bin_sel,
										  MEM_WrEn => MEM_WrEn,
										  immed_sel => immed_sel,
										  ALU_func => ALU_func
										  );


end Behavioral;

