----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    11:29:39 04/16/2024 
-- Design Name: 
-- Module Name:    Decoder5to32 - Behavioral 
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

entity Decoder5to32 is
    Port ( dec_input : in  STD_LOGIC_VECTOR (4 downto 0);
           dec_output : out  STD_LOGIC_VECTOR (31 downto 0));
end Decoder5to32;

architecture Behavioral of Decoder5to32 is

begin
process(dec_input)
begin

		case dec_input is
					when "00000" =>
						dec_output <= "00000000000000000000000000000001";
					when "00001" =>
						dec_output <= "00000000000000000000000000000010";
					when "00010" =>
						dec_output <= "00000000000000000000000000000100";
					when "00011" =>
						dec_output <= "00000000000000000000000000001000";
					when "00100" =>
						dec_output <= "00000000000000000000000000010000";
					when "00101" =>
						dec_output <= "00000000000000000000000000100000";
					when "00110" =>
						dec_output <= "00000000000000000000000001000000";
					when "00111" =>
						dec_output <= "00000000000000000000000010000000";
					when "01000" =>
						dec_output <= "00000000000000000000000100000000";
					when "01001" =>
						dec_output <= "00000000000000000000001000000000";
					when "01010" =>
						dec_output <= "00000000000000000000010000000000";
					when "01011" =>
						dec_output <= "00000000000000000000100000000000";
					when "01100" =>
						dec_output <= "00000000000000000001000000000000";
					when "01101" =>
						dec_output <= "00000000000000000010000000000000";
					when "01110" =>
						dec_output <= "00000000000000000100000000000000";
					when "01111" =>
						dec_output <= "00000000000000001000000000000000";
					when "10000" =>
						dec_output <= "00000000000000010000000000000000";
					when "10001" =>
						dec_output <= "00000000000000100000000000000000";
					when "10010" =>
						dec_output <= "00000000000001000000000000000000";
					when "10011" =>
						dec_output <= "00000000000010000000000000000000";
					when "10100" =>
						dec_output <= "00000000000100000000000000000000";
					when "10101" =>
						dec_output <= "00000000001000000000000000000000";
					when "10110" =>
						dec_output <= "00000000010000000000000000000000";
					when "10111" =>
						dec_output <= "00000000100000000000000000000000";
					when "11000" =>
						dec_output <= "00000001000000000000000000000000";
					when "11001" =>
						dec_output <= "00000010000000000000000000000000";
					when "11010" =>
						dec_output <= "00000100000000000000000000000000";
					when "11011" =>
						dec_output <= "00001000000000000000000000000000";
					when "11100" =>
						dec_output <= "00010000000000000000000000000000";
					when "11101" =>
						dec_output <= "00100000000000000000000000000000";
					when "11110" =>
						dec_output <= "01000000000000000000000000000000";
					when "11111" =>
						dec_output <= "10000000000000000000000000000000";
					when others =>
						dec_output <= "00000000000000000000000000000000";
					
			end case;
		
		end process;

end Behavioral;

