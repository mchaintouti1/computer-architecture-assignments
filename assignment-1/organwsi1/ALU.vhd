----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    11:08:36 04/09/2024 
-- Design Name: 
-- Module Name:    ALU - Behavioral 
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

entity ALU is
    Port ( 
			  A : in  STD_LOGIC_VECTOR(31 downto 0);
           B : in  STD_LOGIC_VECTOR(31 downto 0);
           op : in  STD_LOGIC_VECTOR(3 downto 0);
           output : out  STD_LOGIC_VECTOR(31 downto 0);
           zero_out : out  STD_LOGIC;
           cout : out  STD_LOGIC;
           ovf : out  STD_LOGIC
			  );
end ALU;

architecture Behavioral of ALU is
signal result : STD_LOGIC_VECTOR (31 downto 0):= (others => '0');
signal carry: STD_LOGIC := '0';
signal overflow: STD_LOGIC := '0';
signal zero: STD_LOGIC := '0';
signal temp_B : STD_LOGIC_VECTOR (31 downto 0) := (others => '0');
signal result_addition : STD_LOGIC_VECTOR (32 downto 0) ;

begin
process(op, A,B, result, carry, overflow, temp_B)
begin
--2's complement
temp_B <= not B + "00000000000000000000000000000001";
		
	--Addition
	if op = "0000" then
		result_addition <= ('0' & A)+('0' & B);
		overflow <= (A(31) and B(31) and (not result_addition(31))) or
						((not A(31)) and (not B(31)) and result_addition(31));
		carry <= result_addition(32);
		result <= result_addition(31 downto 0);
	--Substraction
	elsif op = "0001" then
		result_addition <= ('0' & A) + ('0' & (not B) + '1');
		carry <= result_addition(32);
		overflow <= (A(31) and not B(31) and not result_addition(31)) or
                (not A(31) and B(31) and result_addition(31)) or
                (not A(31) and not B(31) and result_addition(31));
		result <= result_addition(31 downto 0);
	--Logical AND
	elsif op = "0010" then 
		result <= A AND B;
		carry <= '0';
		overflow <= '0';
	--Logical OR
	elsif op = "0011" then
		result <= A OR B;
		carry <= '0';
		overflow <= '0';
	--Logical NOT
	elsif op = "0100" then
		result <= not A;
		carry <= '0';
		overflow <= '0';
	--Arithmetic Shift right
	elsif op = "1000" then
	-- The MSB of A is assigned to result(31)
		result(31) <= A(31); 
	--Shift the bits of A to the right by one position	
		for i in 30 downto 0 loop
			result(i) <= A(i+1);
		end loop;	
		carry <= '0';
		overflow <= '0';
	--Shift right logical
	elsif op = "1001" then
		result <= '0' & A(31 downto 1);
		carry <= '0';
		overflow <= '0';
	--Shift left logical
	elsif op = "1010" then
		--result <= A(30 downto 0) & (others => '0');
		result <= '0' & A(30 downto 0);
		carry <= '0';
		overflow <= '0';
	--Rotate left
	elsif op = "1100" then
		result <= A(30 downto 0) & A(31);
		carry <= '0';
		overflow <= '0';	
	--Rotate right
	elsif op = "1101" then
		result <= A(0) & A(31 downto 1);
		carry <= '0';
		overflow <= '0';
	elsif op = "1111" then
		result <= "00000000000000000000000000000000";
		carry <= '0';
		overflow <= '0';
	end if;
	
	
		if (result = "00000000000000000000000000000000") then
		zero <= '1';
	else
		zero <= '0';
	end if;
end process;

	output <= result;
	cout <= carry;
	ovf <= overflow;
	zero_out <= zero;

end Behavioral;