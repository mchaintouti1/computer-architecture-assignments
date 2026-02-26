----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    18:22:08 04/23/2024 
-- Design Name: 
-- Module Name:    Converter - Behavioral 
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
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_SIGNED.ALL;
use IEEE.NUMERIC_STD.ALL;


-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity Converter is
    Port ( immed_in : in  STD_LOGIC_VECTOR (15 downto 0);
           immed_sel : in  STD_LOGIC_VECTOR (1 downto 0);
           immed_out : out  STD_LOGIC_VECTOR (31 downto 0));
end Converter;

architecture Behavioral of Converter is

begin
process(immed_in, immed_sel)
begin 
		

		case immed_sel is
				when "00" => -- Sign extend no shift
					immed_out(31 downto 16) <= (others => immed_in(15));
					immed_out(15 downto 0) <= immed_in;
				when "01" => -- Sign extend shift
					immed_out(31 downto 18) <= (others => immed_in(15));
					immed_out(17 downto 2) <= immed_in;
					immed_out(1 downto 0) <= "00";
				when "10" => -- Zero-fill no shift
					immed_out(31 downto 16) <= (others => '0');
					immed_out(15 downto 0) <= immed_in;
				when "11" => -- Zero-fill shift
					immed_out(31 downto 16) <= immed_in;
					immed_out(15 downto 0) <= (others => '0');
				when others =>
					null;			
										
end case;
end process;	


end Behavioral;

