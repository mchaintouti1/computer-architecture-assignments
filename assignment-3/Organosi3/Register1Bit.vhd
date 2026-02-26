----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    10:40:51 06/21/2024 
-- Design Name: 
-- Module Name:    Register1Bit - Behavioral 
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

entity Register1Bit is
    Port ( clk : in  STD_LOGIC;
           rst : in  STD_LOGIC;
           we : in  STD_LOGIC;
           din : in  STD_LOGIC;
           dout : out  STD_LOGIC);
end Register1Bit;

architecture Behavioral of Register1Bit is
signal reg : STD_LOGIC;

begin
process(clk, rst, din, we)
    begin
        if rst = '1' then
				dout <= '0';
            reg <= '0';
        elsif rising_edge(clk) then
            if we = '1' then
					 dout <= din;
                reg <= din;
				else
					 dout <= din;
                reg <= din;
            end if;
        end if;
    end process;
end Behavioral;

