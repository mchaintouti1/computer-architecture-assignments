--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   08:54:09 04/23/2024
-- Design Name:   
-- Module Name:   /home/ise/askisi1/converter_tb.vhd
-- Project Name:  askisi1
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: converter16to32
-- 
-- Dependencies:
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
--
-- Notes: 
-- This testbench has been automatically generated using types std_logic and
-- std_logic_vector for the ports of the unit under test.  Xilinx recommends
-- that these types always be used for the top-level I/O of a design in order
-- to guarantee that the testbench will bind correctly to the post-implementation 
-- simulation model.
--------------------------------------------------------------------------------
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
 
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--USE ieee.numeric_std.ALL;
 
ENTITY Converter_tb IS
END Converter_tb;
 
ARCHITECTURE behavior OF Converter_tb IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT Converter
    PORT(
         immed_in : IN  std_logic_vector(15 downto 0);
			immed_sel : IN std_logic_vector(1 downto 0);
         immed_out : OUT  std_logic_vector(31 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal immed_in : std_logic_vector(15 downto 0) := (others => '0');
	signal shift : INTEGER range 0 to 31;
	signal immed_sel : STD_LOGIC_VECTOR(1 downto 0) := (others => '0');

 	--Outputs
   signal immed_out : std_logic_vector(31 downto 0);
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: Converter PORT MAP (
          immed_in => immed_in,
			 immed_sel => immed_sel,
          immed_out => immed_out
        );

 

   -- Stimulus process
   stim_proc: process
   begin		
      -- hold reset state for 100 ns.
      wait for 100 ns;	
		
		immed_in <= "0000001111000001";
		immed_sel <= "00";
		shift <= 0;
		wait for 20 ns;
		
		immed_in <= "1000111001100110";
		immed_sel <= "00";
		shift <= 0;
		wait for 20 ns;
		
		immed_in <= "0000001111000001";
		immed_sel <= "01";
		shift <= 0;
		wait for 20 ns;
		
		immed_in <= "1000111001100110";
		immed_sel <= "01";
		shift <= 0;
		wait for 20 ns;
		
		immed_in <= "0000001111000001";
		immed_sel <= "10";
		shift <= 0;
		wait for 20 ns;
		
		immed_in <= "1000111001100110";
		immed_sel <= "10";
		shift <= 0;
		wait for 20 ns;
		
		immed_in <= "0000001111000001";
		immed_sel <= "11";
		shift <= 0;
		wait for 20 ns;
		
		immed_in <= "1000111001100110";
		immed_sel <= "11";
		shift <= 0;
		wait for 20 ns;

      wait;
   end process;

END;
