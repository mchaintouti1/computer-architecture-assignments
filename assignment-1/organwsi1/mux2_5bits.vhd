----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    16:36:28 04/22/2024 
-- Design Name: 
-- Module Name:    mux2_5bits - Behavioral 
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

entity mux2_5bits is
    Port ( mux2_5bits_input1 : in  STD_LOGIC_VECTOR (4 downto 0);
           mux2_5bits_input2 : in  STD_LOGIC_VECTOR (4 downto 0);
           sel : in  STD_LOGIC;
           mux2_5bits_output : out  STD_LOGIC_VECTOR (4 downto 0));
end mux2_5bits;

architecture Behavioral of mux2_5bits is

begin

mux2_5bits_output <= mux2_5bits_input2 when sel = '1' else
							mux2_5bits_input1 when sel = '0';


end Behavioral;

