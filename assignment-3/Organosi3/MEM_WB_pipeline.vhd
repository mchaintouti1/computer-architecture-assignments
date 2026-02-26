----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    10:17:42 06/21/2024 
-- Design Name: 
-- Module Name:    MEM_WB_pipeline - Behavioral 
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

entity MEM_WB_pipeline is
    Port ( clk : in  STD_LOGIC;
           rst : in  STD_LOGIC;
			  RF_WrData_sel_in : in  STD_LOGIC;
           RF_WrData_sel_out : out  STD_LOGIC;
           RF_WrEn_in : in  STD_LOGIC;
           RF_WrEn_out : out  STD_LOGIC
			  );
end MEM_WB_pipeline;

architecture Behavioral of MEM_WB_pipeline is

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
										  
RF_WrData_sel_REG: Register1Bit Port Map( clk => clk,
													 rst => rst,
													 din => RF_WrData_sel_in,
													 we => '1',
													 dout => RF_WrData_sel_out
													);
													
RF_WrEn: Register1Bit Port Map( clk => clk,
										rst => rst,
										din => RF_WrEn_in,
										we => '1',
										dout => RF_WrEn_out
										);

end Behavioral;										

