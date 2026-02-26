----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    10:33:37 05/27/2024 
-- Design Name: 
-- Module Name:    Byte_Operation - Behavioral 
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

entity Byte_Operation is
    Port ( byteOp : in  STD_LOGIC;
           ALU_MEM_Addr : in  STD_LOGIC_VECTOR (31 downto 0);
           temp_spo : in  STD_LOGIC_VECTOR (31 downto 0);
           MEM_DataOut : out  STD_LOGIC_VECTOR (31 downto 0));
end Byte_Operation;

architecture Behavioral of Byte_Operation is
signal addr_offset : STD_LOGIC_VECTOR(1 downto 0);

begin
process(byteOp, ALU_MEM_Addr, temp_spo, addr_offset)
    begin
        -- 32-bit operation
        if byteOp = '0' then
            MEM_DataOut <= temp_spo;
				 -- Single Byte operation
		  elsif byteOp = '1' then
            addr_offset <= ALU_MEM_Addr(1 downto 0);
            case addr_offset is
                when "00" =>
                    MEM_DataOut <= "000000000000000000000000" & temp_spo(7 downto 0);
                when "01" =>
                    MEM_DataOut <= "000000000000000000000000" & temp_spo(15 downto 8);
					 when "10" =>
						MEM_DataOut <= "000000000000000000000000" & temp_spo(23 downto 16);
                when "11" =>
                    MEM_DataOut <= "000000000000000000000000" & temp_spo(31 downto 24);
                when others =>
                    MEM_DataOut <= (others => '0');
            end case;
        end if;
    end process;

end Behavioral;

