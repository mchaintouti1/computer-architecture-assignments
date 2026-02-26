----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    15:44:23 04/28/2024 
-- Design Name: 
-- Module Name:    Control - Behavioral 
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

entity Control is
	 Port (
           rst : in  STD_LOGIC;
           Instr : in  STD_LOGIC_VECTOR (31 downto 0);
			  ALU_zero : in STD_LOGIC;
           PC_sel : out  STD_LOGIC;
           PC_Lden : out  STD_LOGIC;
			  RF_WrEn : out  STD_LOGIC;
           RF_WrData_sel : out  STD_LOGIC;
           RF_B_sel : out  STD_LOGIC;
           ALU_Bin_sel : out  STD_LOGIC;
			  ALU_func : out STD_LOGIC_VECTOR(3 downto 0);
           MEM_WrEn : out STD_LOGIC;
			  byteOp : out  STD_LOGIC;
           immed_sel : out STD_LOGIC_VECTOR (1 downto 0)
			  );
end Control;

architecture Behavioral of Control is
signal opcode : STD_LOGIC_VECTOR(5 downto 0);

begin
process(Instr, ALU_zero, rst, opcode)
begin

	opcode <= Instr(31 downto 26);
	
	if (rst = '1') then
		ALU_func <= "1111";
		PC_sel <= '0';
		PC_LdEn <= '0';
		RF_WrEn <= '0';
		RF_WrData_sel <= '0';
		RF_B_sel <= '0';
		ALU_Bin_sel <= '0';
		MEM_WrEn <= '0';
		byteOp <= '0';
		immed_sel <= "00";
	else			
			if (Instr(31 downto 0) = "00000000000000000000000000000000") then 
					ALU_func <= "1111";
					PC_sel <= '0';
					PC_LdEn <= '1';
					RF_WrEn <= '0';
					RF_WrData_sel <= '0';
					RF_B_sel <= '0';
					ALU_Bin_sel <= '0';
					MEM_WrEn <= '0';
					byteOp <= '0';
					immed_sel <= "00";			
			  else
			if(opcode = "100000") then
								ALU_func <= Instr(3 downto 0);
								PC_sel <= '0';
								PC_LdEn <= '1';
								RF_WrEn <= '1';
								RF_WrData_sel <= '0';
								RF_B_sel <= '0';
								ALU_Bin_sel <= '0';
								MEM_WrEn <= '0';
								byteOp <= '0';
								immed_sel <= "00";
			else
						if(opcode = "111000") then  --li
								ALU_func <= "0000";
								PC_sel <= '0';
								PC_LdEn <= '1';
								RF_WrEn <= '1';
								RF_WrData_sel <= '0';
								RF_B_sel <= '1';
								ALU_Bin_sel <= '1';
								MEM_WrEn <= '0';
								byteOp <= '0';
								immed_sel <= "00";
						elsif(opcode = "111001") then  --lui
								ALU_func <= "0000";
								PC_sel <= '0';
								PC_LdEn <= '1';
								RF_WrEn <= '1';
								RF_WrData_sel <= '0';
								RF_B_sel <= '1';
								ALU_Bin_sel <= '1';
								MEM_WrEn <= '0';
								byteOp <= '0';
								immed_sel <= "11";
						elsif(opcode = "110000") then   --addi
								ALU_func <= "0000";
								PC_sel <= '0';
								PC_LdEn <= '1';
								RF_WrEn <= '1';
								RF_WrData_sel <= '0';
								RF_B_sel <= '1';
								ALU_Bin_sel <= '1';
								MEM_WrEn <= '0';
								byteOp <= '0';
								immed_sel <= "00";
						elsif(opcode = "110010") then   --andi
								ALU_func <= "0010";
								PC_sel <= '0';
								PC_LdEn <= '1';
								RF_WrEn <= '1';
								RF_WrData_sel <= '0';
								RF_B_sel <= '1';
								ALU_Bin_sel <= '1';
								MEM_WrEn <= '0';
								byteOp <= '0';
								immed_sel <= "10";
						elsif(opcode = "110011") then  --ori
								ALU_func <= "0011";
								PC_sel <= '0';
								PC_LdEn <= '1';
								RF_WrEn <= '1';
								RF_WrData_sel <= '0';
								RF_B_sel <= '0';
								ALU_Bin_sel <= '1';
								MEM_WrEn <= '0';
								byteOp <= '0';
								immed_sel <= "10";
						elsif(opcode = "111111") then   --B
								ALU_func <= "1111";
								PC_sel <= '1';
								PC_LdEn <= '1';
								RF_WrEn <= '0';
								RF_WrData_sel <= '0';
								RF_B_sel <= '1';
								ALU_Bin_sel <= '0';
								MEM_WrEn <= '0';
								byteOp <= '0';
								immed_sel <= "01";
						elsif(opcode = "010000") then  --beq
								ALU_func <= "0001";
								ALU_Bin_sel <= '0';
								if(ALU_zero = '1') then
									PC_sel <= '1';
								elsif (ALU_zero = '0') then
									PC_sel <= '0';
								else 
									PC_sel <= '0';
								end if;
								PC_LdEn <= '1';
								RF_WrEn <= '0';
								RF_WrData_sel <= '0';
								RF_B_sel <= '1';
								--ALU_Bin_sel <= '0';
								MEM_WrEn <= '0';
								byteOp <= '0';
								immed_sel <= "01";
						elsif(opcode = "010001") then  --bne
								ALU_func <= "0001";
								ALU_Bin_sel <= '0';
								if(ALU_zero = '1') then
									PC_sel <= '0';
								elsif (ALU_zero = '0') then
									PC_sel <= '1';
								else 
									PC_sel <= '1';
								end if;
								PC_LdEn <= '1';
								RF_WrEn <= '0';
								RF_WrData_sel <= '0';
								RF_B_sel <= '1';
								--ALU_Bin_sel <= '0';
								MEM_WrEn <= '0';
								byteOp <= '0';
								immed_sel <= "01";
						elsif(opcode = "000011") then  --lb
								ALU_func <= "0000";
								PC_sel <= '0';
								PC_LdEn <= '1';
								RF_WrEn <= '1';
								RF_WrData_sel <= '1';
								RF_B_sel <= '1';
								ALU_Bin_sel <= '1';
								MEM_WrEn <= '0';
								byteOp <= '1';
								immed_sel <= "00";
						elsif(opcode = "001111") then  --lw
								ALU_func <= "0000";
								PC_sel <= '0';
								PC_LdEn <= '1';
								RF_WrEn <= '1';
								RF_WrData_sel <= '1';
								RF_B_sel <= '1';
								ALU_Bin_sel <= '1';
								MEM_WrEn <= '0';
								byteOp <= '0';
								immed_sel <= "00";
						elsif(opcode = "011111") then  --sw
								ALU_func <= "0000";
								PC_sel <= '0';
								PC_LdEn <= '1';
								RF_WrEn <= '0';
								RF_WrData_sel <= '0';
								RF_B_sel <= '1';
								ALU_Bin_sel <= '1';
								MEM_WrEn <= '1';
								byteOp <= '0';
								immed_sel <= "00";
						end if;	
					end if;
				end if;
			end if;	
end process;
end Behavioral;

