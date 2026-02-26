----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    10:15:01 06/21/2024 
-- Design Name: 
-- Module Name:    EX_MEM_pipeline - Behavioral 
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

entity EX_MEM_pipeline is
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
end EX_MEM_pipeline;

architecture Behavioral of EX_MEM_pipeline is

component Register1Bit is 
	 Port(
		  clk : in STD_LOGIC;
		  din : in STD_LOGIC;
		  we : in STD_LOGIC;
		  rst : in STD_LOGIC;
		  dout : out STD_LOGIC
		  );
end component;

begin

RF_WrEn_REG: Register1Bit Port Map( clk => clk,
											 rst => rst,
											 we => '1',
											 din => RF_WrEn_in,
											 dout => RF_WrEn_out
											);	
											

RF_WrData_sel_REG: Register1Bit Port Map( clk => clk,
													 rst => rst,
													 we => '1',
													 din => RF_WrData_sel_in,
													 dout => RF_WrData_sel_out
												  );
													 
Mem_WrEn_REG: Register1Bit Port Map( clk => clk,
											  rst => rst,
										 	  we => '1',
											  din => Mem_WrEn_in,
											  dout => Mem_WrEn_out
											);		


byteOp_REG: Register1Bit Port Map( clk => clk,
											  rst => rst,
										 	  we => '1',
											  din => byteOp_in,
											  dout => byteOp_out
											);													

end Behavioral;										  
