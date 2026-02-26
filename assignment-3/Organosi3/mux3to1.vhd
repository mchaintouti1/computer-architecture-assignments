----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    19:54:09 06/21/2024 
-- Design Name: 
-- Module Name:    mux3to1 - Behavioral 
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

entity mux3to1 is
		Port (mux_input1 : in  STD_LOGIC_VECTOR (31 downto 0);
            mux_input2 : in  STD_LOGIC_VECTOR (31 downto 0);
            mux_input3 : in  STD_LOGIC_VECTOR (31 downto 0);
            sel : in  STD_LOGIC_VECTOR(1 downto 0);
            mux_output : out  STD_LOGIC_VECTOR (31 downto 0));
end mux3to1;

architecture Behavioral of mux3to1 is
begin

mux_output <= mux_input3 when sel = "00" else
						mux_input2 when sel = "10" else
						mux_input1 when sel = "01";


end Behavioral;

