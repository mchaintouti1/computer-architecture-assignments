--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   09:33:24 04/24/2024
-- Design Name:   
-- Module Name:   /home/ise/askisi1/MEMSTAGE_tb.vhd
-- Project Name:  askisi1
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: MEMSTAGE
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
 
ENTITY MEMSTAGE_tb IS
END MEMSTAGE_tb;
 
ARCHITECTURE behavior OF MEMSTAGE_tb IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT MEMSTAGE
    PORT(
         clk : IN  std_logic;
         Mem_WrEn : IN  std_logic;
         ALU_MEM_Addr : IN  std_logic_vector(31 downto 0);
         MEM_DataIn : IN  std_logic_vector(31 downto 0);
         MEM_DataOut : OUT  std_logic_vector(31 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal clk : std_logic := '0';
   signal Mem_WrEn : std_logic := '0';
   signal ALU_MEM_Addr : std_logic_vector(31 downto 0) := (others => '0');
   signal MEM_DataIn : std_logic_vector(31 downto 0) := (others => '0');

 	--Outputs
   signal MEM_DataOut : std_logic_vector(31 downto 0);


 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: MEMSTAGE PORT MAP (
          clk => clk,
          Mem_WrEn => Mem_WrEn,
          ALU_MEM_Addr => ALU_MEM_Addr,
          MEM_DataIn => MEM_DataIn,
          MEM_DataOut => MEM_DataOut
        );
		  
		  clk_process : process
			begin
				clk <= '0';
				wait for 10 ns;
				clk <= '1';
				wait for 10 ns;
			end process;

   -- Stimulus process
   stim_proc: process
   begin		
      -- hold reset state for 100 ns.
      wait for 100 ns;	

		 -- Test scenario
		  MEM_WrEn <= '0';
		  ALU_MEM_Addr <= "00000000000000000000000000000001";
		  MEM_DataIn <= "11111111000000001111111100000000";
        wait for 20 ns;
		  
		  MEM_WrEn <= '1';
		  ALU_MEM_Addr <= "00000000000000000000000000000110";
		  MEM_DataIn <= "00000000000000001111111100000000";
        wait for 20 ns;
		 
		  MEM_WrEn <= '0';
		  ALU_MEM_Addr <= "00000000000000000000000000000010";
        MEM_DataIn <= "11110000111100001111000011110000";
        wait for 20 ns;
		  
		  MEM_WrEn <= '1';
		  ALU_MEM_Addr <= "00000000000000000000100000000010";
        MEM_DataIn <= "00000000111100001111000011110000";
        wait for 20 ns;
		  
		  --MEM_WrEn <= "0";

      wait;
   end process;

END;
