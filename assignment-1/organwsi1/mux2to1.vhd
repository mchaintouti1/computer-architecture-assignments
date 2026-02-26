----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    15:36:24 04/09/2024 
-- Design Name: 
-- Module Name:    mux2to1 - Behavioral 
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

entity mux2to1 is
    Port ( mux2_input1 : in  STD_LOGIC_VECTOR (31 downto 0);
           mux2_input2 : in  STD_LOGIC_VECTOR (31 downto 0);
           sel : in  STD_LOGIC;
           mux2_output : out  STD_LOGIC_VECTOR (31 downto 0));
end mux2to1;

architecture Behavioral of mux2to1 is
signal output : STD_LOGIC_VECTOR(31 downto 0);

begin		
	
	mux2_output <= mux2_input2 when sel = '1' else
						mux2_input1 when sel = '0';

end Behavioral;

