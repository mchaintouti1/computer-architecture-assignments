----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    10:06:50 04/19/2024 
-- Design Name: 
-- Module Name:    PC_Register - Behavioral 
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

entity PC_Register is
    Port ( clk : in  STD_LOGIC;
           rst : in  STD_LOGIC;
			  input_LdEn : in  STD_LOGIC;
           input_pc : in  STD_LOGIC_VECTOR (31 downto 0);
           output : out  STD_LOGIC_VECTOR (31 downto 0));
end PC_Register;

architecture Behavioral of PC_Register is
begin
process
begin
	wait until clk'event and clk='1';
	if rst = '1' then
		output <= "00000000000000000000000000000000";
	elsif (input_LdEn = '1') then
			output <= input_pc;
		end if;
		
	end process;

end Behavioral;
