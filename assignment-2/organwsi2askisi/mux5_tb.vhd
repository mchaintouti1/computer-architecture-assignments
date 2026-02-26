--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   08:44:48 04/23/2024
-- Design Name:   
-- Module Name:   /home/ise/askisi1/mux5_tb.vhd
-- Project Name:  askisi1
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: mux2_5bits
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
 
ENTITY mux5_tb IS
END mux5_tb;
 
ARCHITECTURE behavior OF mux5_tb IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT mux2_5bits
    PORT(
         mux2_5bits_input1 : IN  std_logic_vector(4 downto 0);
         mux2_5bits_input2 : IN  std_logic_vector(4 downto 0);
         sel : IN  std_logic;
         mux2_5bits_output : OUT  std_logic_vector(4 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal mux2_5bits_input1 : std_logic_vector(4 downto 0) := (others => '0');
   signal mux2_5bits_input2 : std_logic_vector(4 downto 0) := (others => '0');
   signal sel : std_logic := '0';

 	--Outputs
   signal mux2_5bits_output : std_logic_vector(4 downto 0);
	
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: mux2_5bits PORT MAP (
          mux2_5bits_input1 => mux2_5bits_input1,
          mux2_5bits_input2 => mux2_5bits_input2,
          sel => sel,
          mux2_5bits_output => mux2_5bits_output
        );
   -- Stimulus process
   stim_proc: process
   begin		
      -- hold reset state for 100 ns.
		mux2_5bits_input1 <= "00000";
		mux2_5bits_input2 <= "00000";
		sel <= '0';
      wait for 100 ns;	
		
		mux2_5bits_input1 <= "00100";
		mux2_5bits_input2 <= "00000";
		sel <= '0';
		wait for 20 ns;
		
		mux2_5bits_input1 <= "00100";
		mux2_5bits_input2 <= "11111";
		sel <= '1';
		wait for 20 ns;

      wait;
   end process;

END;
