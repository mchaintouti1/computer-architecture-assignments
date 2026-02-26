----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    04:06:11 06/22/2024 
-- Design Name: 
-- Module Name:    mux_stalling - Behavioral 
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

entity mux_stalling is
		Port ( mux_stall_input1 : in  STD_LOGIC_VECTOR (13 downto 0);
           mux_stall_input2 : in  STD_LOGIC_VECTOR (13 downto 0);
           sel : in  STD_LOGIC;
           mux_stall_output : out  STD_LOGIC_VECTOR (13 downto 0));
end mux_stalling;

architecture Behavioral of mux_stalling is

begin
		
		mux_stall_output <= mux_stall_input2 when sel = '1' else
								  mux_stall_input1 when sel = '0';

end Behavioral;

