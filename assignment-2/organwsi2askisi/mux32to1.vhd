----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    11:45:23 04/16/2024 
-- Design Name: 
-- Module Name:    mux32to1 - Behavioral 
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
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity mux32to1 is
    Port ( sel : in  STD_LOGIC_VECTOR (4 downto 0);
           IN0 : in  STD_LOGIC_VECTOR (31 downto 0);
			  IN1 : in  STD_LOGIC_VECTOR (31 downto 0);
			  IN2 : in  STD_LOGIC_VECTOR (31 downto 0);
			  IN3 : in  STD_LOGIC_VECTOR (31 downto 0);
			  IN4 : in  STD_LOGIC_VECTOR (31 downto 0);
			  IN5 : in  STD_LOGIC_VECTOR (31 downto 0);
			  IN6 : in  STD_LOGIC_VECTOR (31 downto 0);
			  IN7 : in  STD_LOGIC_VECTOR (31 downto 0);
			  IN8 : in  STD_LOGIC_VECTOR (31 downto 0);
			  IN9 : in  STD_LOGIC_VECTOR (31 downto 0);
			  IN10 : in  STD_LOGIC_VECTOR (31 downto 0);
			  IN11 : in  STD_LOGIC_VECTOR (31 downto 0);
			  IN12 : in  STD_LOGIC_VECTOR (31 downto 0);
			  IN13 : in  STD_LOGIC_VECTOR (31 downto 0);
			  IN14 : in  STD_LOGIC_VECTOR (31 downto 0);
			  IN15 : in  STD_LOGIC_VECTOR (31 downto 0);
			  IN16 : in  STD_LOGIC_VECTOR (31 downto 0);
			  IN17 : in  STD_LOGIC_VECTOR (31 downto 0);
			  IN18 : in  STD_LOGIC_VECTOR (31 downto 0);
			  IN19 : in  STD_LOGIC_VECTOR (31 downto 0);
			  IN20 : in  STD_LOGIC_VECTOR (31 downto 0);
			  IN21 : in  STD_LOGIC_VECTOR (31 downto 0);
			  IN22 : in  STD_LOGIC_VECTOR (31 downto 0);
			  IN23 : in  STD_LOGIC_VECTOR (31 downto 0);
			  IN24 : in  STD_LOGIC_VECTOR (31 downto 0);
			  IN25 : in  STD_LOGIC_VECTOR (31 downto 0);
			  IN26 : in  STD_LOGIC_VECTOR (31 downto 0);
			  IN27 : in  STD_LOGIC_VECTOR (31 downto 0);
			  IN28 : in  STD_LOGIC_VECTOR (31 downto 0);
			  IN29 : in  STD_LOGIC_VECTOR (31 downto 0);
			  IN30 : in  STD_LOGIC_VECTOR (31 downto 0);
			  IN31 : in  STD_LOGIC_VECTOR (31 downto 0);
           mux32_output : out  STD_LOGIC_VECTOR(31 downto 0)
			  );
end mux32to1;

architecture Behavioral of mux32to1 is
signal mux32_out : STD_LOGIC_VECTOR(31 downto 0);
begin
process(sel,IN0,IN1,IN2,IN3,IN4,IN5,IN6,IN7,IN8,IN9,IN10,IN11,IN12,IN13,IN14,IN15,IN16,IN17,IN18,IN19,IN20,IN21,IN22,IN23,IN24,IN25,IN26,IN27,IN28,IN29,IN30,IN31)
begin
		case(sel) is
			when"00000"=>
			  mux32_out<=IN0;
			when"00001"=>
			  mux32_out<=IN1;
			when"00010"=>
			  mux32_out<=IN2;
			when"00011"=>
			  mux32_out<=IN3;
			when"00100"=>
			  mux32_out<=IN4;
			when"00101"=>
			  mux32_out<=IN5;
			when"00110"=>
			  mux32_out<=IN6;
			when"00111"=>
			  mux32_out<=IN7;
			when"01000"=>
			  mux32_out<=IN8;
			when"01001"=>
			  mux32_out<=IN9;
			when"01010"=>
			  mux32_out<=IN10;
			when"01011"=>
			  mux32_out<=IN11;
			when"01100"=>
			  mux32_out<=IN12;
			when"01101"=>
			  mux32_out<=IN13;
			when"01110"=>
			  mux32_out<=IN14;
			when"01111"=>
			  mux32_out<=IN15;
			when"10000"=>
			  mux32_out<=IN16;
			when"10001"=>
			  mux32_out<=IN17;
			when"10010"=>
			  mux32_out<=IN18;
			when"10011"=>
			  mux32_out<=IN19;
			when"10100"=>
			  mux32_out<=IN20;
			when"10101"=>
			  mux32_out<=IN21;
			when"10110"=>
			  mux32_out<=IN22;
			when"10111"=>
			  mux32_out<=IN23;
			when"11000"=>
			  mux32_out<=IN24;
			when"11001"=>
			  mux32_out<=IN25;
			when"11010"=>
			  mux32_out<=IN26;
			when"11011"=>
			  mux32_out<=IN27;
			when"11100"=>
			  mux32_out<=IN28;
			when"11101"=>
			  mux32_out<=IN29;
			when"11110"=>
			  mux32_out<=IN30;
			when"11111"=>
			  mux32_out<=IN31;
			when others =>
			  null;
			  
		end case;
	end process;
	
	mux32_output <= mux32_out;

end Behavioral;

