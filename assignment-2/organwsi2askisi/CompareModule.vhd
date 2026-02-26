----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    21:52:58 04/19/2024 
-- Design Name: 
-- Module Name:    CompareModule - Behavioral 
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

entity CompareModule is
    Port ( awr : in  STD_LOGIC_VECTOR (4 downto 0);
           ard : in  STD_LOGIC_VECTOR (4 downto 0);
			  we : in STD_LOGIC;
			  comp_mod_out : out STD_LOGIC
			  );
end CompareModule;

architecture Behavioral of CompareModule is

begin
process(awr, ard, we)
    begin
		if(we = '1') then
        if (awr = ard) then
            comp_mod_out <= '1';
        else
            comp_mod_out <= '0';
        end if;
		end if;
    end process;


end Behavioral;

