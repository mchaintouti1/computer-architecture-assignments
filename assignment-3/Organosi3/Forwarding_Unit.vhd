----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    10:07:30 06/21/2024 
-- Design Name: 
-- Module Name:    Forwarding_Unit - Behavioral 
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

entity Forwarding_Unit is
    Port ( 
			  EX_MEM_RegRd : in  STD_LOGIC_VECTOR (4 downto 0);
           MEM_WB_RegRd : in  STD_LOGIC_VECTOR (4 downto 0);
           ID_EX_RegRs : in  STD_LOGIC_VECTOR (4 downto 0);
           ID_EX_RegRt : in  STD_LOGIC_VECTOR (4 downto 0);
           EX_MEM_RegWrite : in  STD_LOGIC;
			  MEM_WB_RegWrite : in  STD_LOGIC;
           forwardA : out  STD_LOGIC_VECTOR (1 downto 0);
           forwardB : out  STD_LOGIC_VECTOR (1 downto 0));
end Forwarding_Unit;

architecture Behavioral of Forwarding_Unit is

begin
	process(EX_MEM_RegRd, MEM_WB_RegRd, ID_EX_RegRs, ID_EX_RegRt, EX_MEM_RegWrite, MEM_WB_RegWrite)
	begin
	
	forwardA <= "00";
	forwardB <= "00";
	
		--EX danger(Forward from EX_MEM)
		if(EX_MEM_RegWrite = '1' and 
			EX_MEM_RegRd/= "00000" and 
			EX_MEM_RegRd = ID_EX_RegRs) then
				forwardA <= "10"; 
		elsif(MEM_WB_RegWrite = '1' and 
			MEM_WB_RegRd/= "00000" and 
			MEM_WB_RegRd = ID_EX_RegRs) then
				forwardA <= "01";
		else	
				forwardA <= "00";
		end if;


		--MEM danger(Forward from MEM_WB)
		if(EX_MEM_RegWrite = '1' and 
				EX_MEM_RegRd /= "00000" and 
				EX_MEM_RegRd = ID_EX_RegRt) then				
					forwardB <= "10";
		elsif(MEM_WB_RegWrite = '1' and
				MEM_WB_RegRd /= "00000" and 
				MEM_WB_RegRd = ID_EX_RegRt) then
					forwardB <= "01";
		else	
					forwardB <= "00";
		end if;
		
	end process;

end Behavioral;
		

