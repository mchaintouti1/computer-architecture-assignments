--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   15:50:41 04/28/2024
-- Design Name:   
-- Module Name:   /home/ise/askisi1/Control_tb.vhd
-- Project Name:  askisi1
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: Control
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
 
ENTITY Control_tb IS
END Control_tb;
 
ARCHITECTURE behavior OF Control_tb IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT Control
    PORT(
         clk : IN  std_logic;
         rst : IN  std_logic;
         Instr : IN  std_logic_vector(31 downto 0);
			ALU_zero : IN std_logic;
         PC_sel : OUT  std_logic;
         PC_Lden : OUT  std_logic;
         RF_WrData_sel : OUT  std_logic;
         RF_B_sel : OUT  std_logic;
         ALU_Bin_sel : OUT  std_logic;
         MEM_WrEn : OUT  std_logic;
         immed_sel : OUT  std_logic_vector(1 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal clk : std_logic := '0';
   signal rst : std_logic := '0';
   signal Instr : std_logic_vector(31 downto 0) := (others => '0');
	signal ALU_zero : std_logic := '0';

 	--Outputs
   signal PC_sel : std_logic;
   signal PC_Lden : std_logic;
   signal RF_WrData_sel : std_logic;
   signal RF_B_sel : std_logic;
   signal ALU_Bin_sel : std_logic;
   signal MEM_WrEn : std_logic;
   signal immed_sel : std_logic_vector(1 downto 0);

BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: Control PORT MAP (
          clk => clk,
          rst => rst,
          Instr => Instr,
			 ALU_zero => ALU_zero,
          PC_sel => PC_sel,
          PC_Lden => PC_Lden,
          RF_WrData_sel => RF_WrData_sel,
          RF_B_sel => RF_B_sel,
          ALU_Bin_sel => ALU_Bin_sel,
          MEM_WrEn => MEM_WrEn,
          immed_sel => immed_sel
        );

   -- Clock process definitions
   clk_process :process
   begin
		clk <= '0';
		wait for 10 ns;
		clk <= '1';
		wait for 10 ns;
   end process;
 

   -- Stimulus process
   stim_proc: process
   begin		
      
		rst <= '1';
      -- hold reset state for 100 ns.
      wait for 100 ns;
		rst <= '0';
		
		-- Test instructions
        -- li
        Instr <= "11100000000000011000000000000000"; 
        wait for 20 ns;

        -- lui
       -- Instr <= "11100100000100001000000000000000"; 
        --wait for 20 ns;
		  
		  --        -- addi
--        Instr <= "11000000001000110000000000000001"; 
--        wait for 20 ns;
--		  
--		  -- andi
--        Instr <= "11001000010001001000000000000000"; 
--        wait for 20 ns;
--		  
--		  -- ori
--        Instr <= "11001100100001011000000000000000"; 
--        wait for 20 ns;

--		  -- B
--        Instr <= "11111100011001101000000000000000"; 
--        wait for 20 ns;
--		  
--		  -- beq
--        Instr <= "01000000000001111000000000000000"; 
--        wait for 20 ns;
--		  
--		  -- bne
--        Instr <= "01000100000010001000000000000000"; 
--        wait for 20 ns;
				

      wait;
   end process;
END;
