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
			  clk : in STD_LOGIC;
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
type state_type is (Fetch, Decode, Execute, Memory, WriteBack);
signal cur_state, next_state : state_type;
signal opcode : STD_LOGIC_VECTOR(5 downto 0);

begin
process(Instr, ALU_zero, opcode, clk, rst, cur_state, next_state)
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
		cur_state <= WriteBack;
   elsif rising_edge(clk) then
      cur_state <= next_state;
   end if;
						
		case cur_state is
			when Fetch => --pc_sel
				case opcode is
					when "111111" => --B
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
						next_state <= Decode;
					when "010000" => --beq
						ALU_func <= "1111";
						ALU_Bin_sel <= '0';
						PC_sel <= '0';
						PC_LdEn <= '0';
						RF_WrEn <= '0';
						RF_WrData_sel <= '0';
						RF_B_sel <= '1';
						MEM_WrEn <= '0';
						byteOp <= '0';
						immed_sel <= "01";
						next_state <= Decode;
					when "010001" => --bne
						ALU_func <= "1111";
						ALU_Bin_sel <= '0';
						PC_LdEn <= '0';
						RF_WrEn <= '0';
						RF_WrData_sel <= '0';
						RF_B_sel <= '1';
						MEM_WrEn <= '0';
						byteOp <= '0';
						immed_sel <= "01";
						next_state <= Decode;
					when "111000" => --li
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
						next_state <= Decode;
					when "011111" => --sw
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
						next_state <= Decode;
					when others =>
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
						next_state <= Decode;
				end case;
			when Decode => -- rf_b_sel , immed_sel
				case opcode is
					when "100000" => --R-type
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
						next_state <= Execute;
					when "111111" => --B
						ALU_func <= "1111";
						PC_sel <= '0';
						PC_LdEn <= '1';
						RF_WrEn <= '0';
						RF_WrData_sel <= '0';
						RF_B_sel <= '1';
						ALU_Bin_sel <= '0';
						MEM_WrEn <= '0';
						byteOp <= '0';
						immed_sel <= "01";
						next_state <= Execute;
					when "010000" => --beq
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
						RF_B_sel <= '0';
						MEM_WrEn <= '0';
						byteOp <= '0';
						immed_sel <= "00";
						next_state <= Execute;
					when "010001" => --bne
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
						RF_B_sel <= '0';
						MEM_WrEn <= '0';
						byteOp <= '0';
						immed_sel <= "00";
						next_state <= Execute;
					when "011111" => --sw
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
						next_state <= Execute;
					when "000011" => --lb
						ALU_func <= "1111";
						PC_sel <= '0';
						PC_LdEn <= '0';
						RF_WrEn <= '0';
						RF_WrData_sel <= '0';
						RF_B_sel <= '1';
						ALU_Bin_sel <= '0';
						MEM_WrEn <= '0';
						byteOp <= '0';
						immed_sel <= "00";
						next_state <= Execute;
					when "001111" => --lw
						ALU_func <= "1111";
						PC_sel <= '0';
						PC_LdEn <= '0';
						RF_WrEn <= '0';
						RF_WrData_sel <= '0';
						RF_B_sel <= '1';
						ALU_Bin_sel <= '0';
						MEM_WrEn <= '0';
						byteOp <= '0';
						immed_sel <= "00";
						next_state <= Execute;
					when "111000" => --li
						ALU_func <= "1111";
						PC_sel <= '0';
						PC_LdEn <= '0';
						RF_WrEn <= '0';
						RF_WrData_sel <= '0';
						RF_B_sel <= '1';
						ALU_Bin_sel <= '0';
						MEM_WrEn <= '0';
						byteOp <= '0';
						immed_sel <= "00";
						next_state <= Execute;
					when "111001" => --lui
						ALU_func <= "1111";
						PC_sel <= '0';
						PC_LdEn <= '0';
						RF_WrEn <= '0';
						RF_WrData_sel <= '0';
						RF_B_sel <= '1';
						ALU_Bin_sel <= '0';
						MEM_WrEn <= '0';
						byteOp <= '0';
						immed_sel <= "11";
						next_state <= Execute;
					when "110000" => --addi
						ALU_func <= "1111";
						PC_sel <= '0';
						PC_LdEn <= '0';
						RF_WrEn <= '0';
						RF_WrData_sel <= '0';
						RF_B_sel <= '1';
						ALU_Bin_sel <= '0';
						MEM_WrEn <= '0';
						byteOp <= '0';
						immed_sel <= "00";
						next_state <= Execute;
					when "110010" => --andi
						ALU_func <= "1111";
						PC_sel <= '0';
						PC_LdEn <= '0';
						RF_WrEn <= '0';
						RF_WrData_sel <= '0';
						RF_B_sel <= '1';
						ALU_Bin_sel <= '0';
						MEM_WrEn <= '0';
						byteOp <= '0';
						immed_sel <= "10";
						next_state <= Execute;
					when "110011" => --ori
						ALU_func <= "1111";
						PC_sel <= '0';
						PC_LdEn <= '0';
						RF_WrEn <= '0';
						RF_WrData_sel <= '0';
						RF_B_sel <= '1';
						ALU_Bin_sel <= '0';
						MEM_WrEn <= '0';
						byteOp <= '0';
						immed_sel <= "10";
						next_state <= Execute;
					when others =>
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
						next_state <= Fetch;
				end case;
			when Execute => --alu_func, alu_bin_sel 
				case opcode is
					when "100000" => --r type
						ALU_func <= Instr(3 downto 0);
						PC_sel <= '0';
						PC_LdEn <= '1';
						RF_WrEn <= '0';
						RF_WrData_sel <= '0';
						RF_B_sel <= '0';
						ALU_Bin_sel <= '0';
						MEM_WrEn <= '0';
						byteOp <= '0';
						immed_sel <= "00";
						next_state <= WriteBack;
					when "111111" => --B
						ALU_func <= "1111";
						PC_sel <= '1';
						PC_LdEn <= '0';
						RF_WrEn <= '0';
						RF_WrData_sel <= '0';
						RF_B_sel <= '0';
						ALU_Bin_sel <= '0';
						MEM_WrEn <= '0';
						byteOp <= '0';
						immed_sel <= "00";
						next_state <= Fetch;
					when "010000" => --beq
						ALU_func <= "1111";
						ALU_Bin_sel <= '0';
						PC_LdEn <= '0';
						RF_WrEn <= '0';
						RF_WrData_sel <= '0';
						RF_B_sel <= '0';
						MEM_WrEn <= '0';
						byteOp <= '0';
						immed_sel <= "00";
						next_state <= Fetch;
					when "010001" => --bne
						ALU_func <= "1111";
						ALU_Bin_sel <= '0';
						PC_LdEn <= '0';
						RF_WrEn <= '0';
						RF_WrData_sel <= '0';
						RF_B_sel <= '0';
						MEM_WrEn <= '0';
						byteOp <= '0';
						immed_sel <= "00";
						next_state <= Fetch;
					when "111000" => --li
						ALU_func <= "0000";
						PC_sel <= '0';
						PC_LdEn <= '1';
						RF_WrEn <= '0';
						RF_WrData_sel <= '0';
						RF_B_sel <= '0';
						ALU_Bin_sel <= '1';
						MEM_WrEn <= '0';
						byteOp <= '0';
						immed_sel <= "00";
						next_state <= WriteBack;
					when "111001" => --lui
						ALU_func <= "0000";
						PC_sel <= '0';
						PC_LdEn <= '1';
						RF_WrEn <= '0';
						RF_WrData_sel <= '0';
						RF_B_sel <= '0';
						ALU_Bin_sel <= '1';
						MEM_WrEn <= '0';
						byteOp <= '0';
						immed_sel <= "00";
						next_state <= WriteBack;
					when "110000" => --addi
						ALU_func <= "0000";
						PC_sel <= '0';
						PC_LdEn <= '1';
						RF_WrEn <= '0';
						RF_WrData_sel <= '0';
						RF_B_sel <= '0';
						ALU_Bin_sel <= '1';
						MEM_WrEn <= '0';
						byteOp <= '0';
						immed_sel <= "00";
						next_state <= WriteBack;
					when "110010" => --andi
						ALU_func <= "0010";
						PC_sel <= '0';
						PC_LdEn <= '1';
						RF_WrEn <= '0';
						RF_WrData_sel <= '0';
						RF_B_sel <= '0';
						ALU_Bin_sel <= '1';
						MEM_WrEn <= '0';
						byteOp <= '0';
						immed_sel <= "00";
						next_state <= WriteBack;
					when "110011" => --ori
						ALU_func <= "0011";
						PC_sel <= '0';
						PC_LdEn <= '1';
						RF_WrEn <= '0';
						RF_WrData_sel <= '0';
						RF_B_sel <= '0';
						ALU_Bin_sel <= '1';
						MEM_WrEn <= '0';
						byteOp <= '0';
						immed_sel <= "00";
						next_state <= WriteBack;
					when "000011" => --lb
						ALU_func <= "0000";
						PC_sel <= '0';
						PC_LdEn <= '0';
						RF_WrEn <= '0';
						RF_WrData_sel <= '0';
						RF_B_sel <= '0';
						ALU_Bin_sel <= '1';
						MEM_WrEn <= '0';
						byteOp <= '0';
						immed_sel <= "00";
						next_state <= Memory;
					when "001111" => --lw
						ALU_func <= "0000";
						PC_sel <= '0';
						PC_LdEn <= '0';
						RF_WrEn <= '0';
						RF_WrData_sel <= '0';
						RF_B_sel <= '0';
						ALU_Bin_sel <= '1';
						MEM_WrEn <= '0';
						byteOp <= '0';
						immed_sel <= "00";
						next_state <= Memory;
					when "011111" => --sw
						ALU_func <= "0000";
						PC_sel <= '0';
						PC_LdEn <= '1';
						RF_WrEn <= '0';
						RF_WrData_sel <= '0';
						RF_B_sel <= '1';
						ALU_Bin_sel <= '1';
						MEM_WrEn <= '0';
						byteOp <= '0';
						immed_sel <= "00";
						next_state <= Memory;
					when others =>
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
						next_state <= Fetch;
				end case;
			when Memory => --MemWrEn, byteOp, rf_wrdatasel
				case opcode is
					when "011111" => --sw
						ALU_func <= "1111";
						PC_sel <= '0';
						PC_LdEn <= '0';
						RF_WrEn <= '0';
						RF_WrData_sel <= '0';
						RF_B_sel <= '0';
						ALU_Bin_sel <= '0';
						MEM_WrEn <= '1';
						byteOp <= '0';
						immed_sel <= "00";
						next_state <= Fetch;
					when "000011" => --lb
						ALU_func <= "1111";
						PC_sel <= '0';
						PC_LdEn <= '1';
						RF_WrEn <= '0';
						RF_WrData_sel <= '0';
						RF_B_sel <= '0';
						ALU_Bin_sel <= '0';
						MEM_WrEn <= '0';
						byteOp <= '1';
						immed_sel <= "00";
						next_state <= WriteBack;
					when "001111" => --lw
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
						next_state <= WriteBack;
					when others => 
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
						next_state <= Fetch;
				end case;
			when WriteBack => --rf_wren
				case opcode is
					when "100000" => -- r type
						ALU_func <= "1111";
						PC_sel <= '0';
						PC_LdEn <= '0';
						RF_WrEn <= '1';
						RF_WrData_sel <= '0';
						RF_B_sel <= '0';
						ALU_Bin_sel <= '0';
						MEM_WrEn <= '0';
						byteOp <= '0';
						immed_sel <= "00";
						next_state <= Fetch;
					when "111000" => --li
						ALU_func <= "1111";
						PC_sel <= '0';
						PC_LdEn <= '0';
						RF_WrEn <= '1';
						RF_WrData_sel <= '0';
						RF_B_sel <= '0';
						ALU_Bin_sel <= '0';
						MEM_WrEn <= '0';
						byteOp <= '0';
						immed_sel <= "00";
						next_state <= Fetch;
					when "111001" => --lui
						ALU_func <= "1111";
						PC_sel <= '0';
						PC_LdEn <= '0';
						RF_WrEn <= '1';
						RF_WrData_sel <= '0';
						RF_B_sel <= '0';
						ALU_Bin_sel <= '0';
						MEM_WrEn <= '0';
						byteOp <= '0';
						immed_sel <= "00";
						next_state <= Fetch;
					when "110000" => --addi
						ALU_func <= "1111";
						PC_sel <= '0';
						PC_LdEn <= '0';
						RF_WrEn <= '1';
						RF_WrData_sel <= '0';
						RF_B_sel <= '0';
						ALU_Bin_sel <= '0';
						MEM_WrEn <= '0';
						byteOp <= '0';
						immed_sel <= "00";
						next_state <= Fetch;
					when "110010" => --andi 
						ALU_func <= "1111";
						PC_sel <= '0';
						PC_LdEn <= '0';
						RF_WrEn <= '1';
						RF_WrData_sel <= '0';
						RF_B_sel <= '0';
						ALU_Bin_sel <= '0';
						MEM_WrEn <= '0';
						byteOp <= '0';
						immed_sel <= "00";
						next_state <= Fetch;
					when "110011" => --ori
						ALU_func <= "1111";
						PC_sel <= '0';
						PC_LdEn <= '0';
						RF_WrEn <= '1';
						RF_WrData_sel <= '0';
						RF_B_sel <= '0';
						ALU_Bin_sel <= '0';
						MEM_WrEn <= '0';
						byteOp <= '0';
						immed_sel <= "00";
						next_state <= Fetch;
					when "000011" => --lb
						ALU_func <= "1111";
						PC_sel <= '0';
						PC_LdEn <= '0';
						RF_WrEn <= '1';
						RF_WrData_sel <= '1';
						RF_B_sel <= '0';
						ALU_Bin_sel <= '0';
						MEM_WrEn <= '0';
						byteOp <= '0';
						immed_sel <= "00";
						next_state <= Fetch;
					when "001111" => --lw
						ALU_func <= "1111";
						PC_sel <= '0';
						PC_LdEn <= '0';
						RF_WrEn <= '1';
						RF_WrData_sel <= '1';
						RF_B_sel <= '0';
						ALU_Bin_sel <= '0';
						MEM_WrEn <= '0';
						byteOp <= '0';
						immed_sel <= "00";
						next_state <= Fetch;
					when others => 
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
						next_state <= Fetch;
				end case;
			end case;
end process;
end Behavioral;

