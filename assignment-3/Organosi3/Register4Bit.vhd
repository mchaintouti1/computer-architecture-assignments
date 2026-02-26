----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    14:18:54 06/21/2024 
-- Design Name: 
-- Module Name:    Register4Bit - Behavioral 
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

entity Register4Bit is
    Port ( clk : in  STD_LOGIC;
			  rst : in STD_LOGIC;
           din : in  STD_LOGIC_VECTOR(3 downto 0);
           we : in  STD_LOGIC;
           dout : out  STD_LOGIC_VECTOR(3 downto 0)
			  );
end Register4Bit;

architecture Behavioral of Register4Bit is
signal temp : STD_LOGIC_VECTOR(3 downto 0);

begin
process(clk, rst, we, din)
begin
		if rst = '1' then
        dout <= "0000";
		  temp <= "0000";
      elsif rising_edge(clk) then
			if we = '1' then
				temp <= din;
				dout <= din;
			else 
				dout <= temp;
				temp <= temp;
			end if;
		end if;
end process;
end Behavioral;

