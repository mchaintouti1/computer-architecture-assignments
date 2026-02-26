--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   10:43:47 04/26/2024
-- Design Name:   
-- Module Name:   /home/ise/askisi1/ALUSTAGE_tb.vhd
-- Project Name:  askisi1
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: ALUSTAGE
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
 
ENTITY ALUSTAGE_tb IS
END ALUSTAGE_tb;
 
ARCHITECTURE behavior OF ALUSTAGE_tb IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT ALUSTAGE
    PORT(
         RF_A : IN  std_logic_vector(31 downto 0);
         RF_B : IN  std_logic_vector(31 downto 0);
         Immed : IN  std_logic_vector(31 downto 0);
         ALU_Bin_sel : IN  std_logic;
         ALU_func : IN  std_logic_vector(3 downto 0);
         ALU_out : OUT  std_logic_vector(31 downto 0);
         ALU_ovf : OUT  std_logic;
         ALU_zero_out : OUT  std_logic;
         ALU_cout : OUT  std_logic
        );
    END COMPONENT;
    

   --Inputs
   signal RF_A : std_logic_vector(31 downto 0) := (others => '0');
   signal RF_B : std_logic_vector(31 downto 0) := (others => '0');
   signal Immed : std_logic_vector(31 downto 0) := (others => '0');
   signal ALU_Bin_sel : std_logic := '0';
   signal ALU_func : std_logic_vector(3 downto 0) := (others => '0');

 	--Outputs
   signal ALU_out : std_logic_vector(31 downto 0);
   signal ALU_ovf : std_logic;
   signal ALU_zero_out : std_logic;
   signal ALU_cout : std_logic;
   
 
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: ALUSTAGE PORT MAP (
          RF_A => RF_A,
          RF_B => RF_B,
          Immed => Immed,
          ALU_Bin_sel => ALU_Bin_sel,
          ALU_func => ALU_func,
          ALU_out => ALU_out,
          ALU_ovf => ALU_ovf,
          ALU_zero_out => ALU_zero_out,
          ALU_cout => ALU_cout
        );

   -- Stimulus process
   stim_proc: process
   begin		
      -- hold reset state for 100 ns.
      wait for 100 ns;	
		
		-- Test 1: Addition
        RF_A <= "00000000000000000000000000000001";
        RF_B <= "00000000000000000000000000000010";
        Immed <= "00000000000000000000000000000011";
        ALU_Bin_sel <= '0';
        ALU_func <= "0000";
        wait for 20 ns;

       -- Test 2: Substraction
        RF_A <= "00000000000000000000000111111111";
        RF_B <= "00000000000000000000000000000001";
        Immed <= "00000000000000000000000000011111";
        ALU_Bin_sel <= '0';
        ALU_func <= "0001";
        wait for 20 ns;

      -- Test 3: Logical AND
        RF_A <= "01000000000000010000000000000001";
        RF_B <= "01000000000000010000000000000001";
        Immed <= "00000000000000010000000000000000";
        ALU_Bin_sel <= '0';
        ALU_func <= "0010";
        wait for 20 ns;
		  

      wait;
   end process;

END;
