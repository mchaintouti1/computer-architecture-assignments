----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    10:09:25 06/21/2024 
-- Design Name: 
-- Module Name:    Hazard_detection_Unit - Behavioral 
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

entity Hazard_Detection_Unit is
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
end Hazard_Detection_Unit;


architecture Behavioral of Hazard_Detection_Unit is

begin
	process(ID_EX_MemWrite, ID_EX_RegRt, IF_ID_RegRs, IF_ID_RegRt, WrEn_last_wb, forA, forB)
	begin
		if((ID_EX_MemWrite = '0' and WrEn_last_wb = '1') and (ID_EX_RegRt = IF_ID_RegRs or ID_EX_RegRt = IF_ID_RegRt) and (IF_ID_RegRs /= "00000" and IF_ID_RegRt /= "00000") and (forA= "00" and forB="00")) then
			--Stall pipeline
			PC_LdEn <= '0';
			IF_ID_Write <= '0';
			control_signal <= '0';
		else
		--No stall
			PC_LdEn <= '1';
			IF_ID_Write <= '1';
			control_signal <= '1';
		end if;
	
	end process;


end Behavioral;



