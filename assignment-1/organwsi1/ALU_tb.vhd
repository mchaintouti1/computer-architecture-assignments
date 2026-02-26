--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   14:51:55 04/18/2024
-- Design Name:   
-- Module Name:   /home/ise/askisi1/ALU_tb.vhd
-- Project Name:  askisi1
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: ALU
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
 
ENTITY ALU_tb IS
END ALU_tb;
 
ARCHITECTURE behavior OF ALU_tb IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT ALU
    PORT(
         A : IN  std_logic_vector(31 downto 0);
         B : IN  std_logic_vector(31 downto 0);
         op : IN  std_logic_vector(3 downto 0);
         output : OUT  std_logic_vector(31 downto 0);
         zero_out : OUT  std_logic;
         cout : OUT  std_logic;
         ovf : OUT  std_logic
        );
    END COMPONENT;
    

   --Inputs
   signal A : std_logic_vector(31 downto 0) := (others => '0');
   signal B : std_logic_vector(31 downto 0) := (others => '0');
   signal op : std_logic_vector(3 downto 0) := (others => '0');

 	--Outputs
   signal output : std_logic_vector(31 downto 0);
   signal zero_out : std_logic;
   signal cout : std_logic;
   signal ovf : std_logic;
   -- No clocks detected in port list. Replace <clock> below with 
   -- appropriate port name 
 
 --  constant <clock>_period : time := 10 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: ALU PORT MAP (
          A => A,
          B => B,
          op => op,
          output => output,
          zero_out => zero_out,
          cout => cout,
          ovf => ovf
        );

-- Clock process definitions
--  <clock>_process :process
--  begin
--		<clock> <= '0';
--		wait for <clock>_period/2;
--		<clock> <= '1';
--		wait for <clock>_period/2;
--  end process;
 

   -- Stimulus process
   stim_proc: process
   begin		
      -- hold reset state for 100 ns.
      wait for 100 ns;	
	
			--Test Addition
		A <= "01111111111111111111111111111111";
		B <= "00000000000000000000000000000001";
		op <= "0000";
		wait for 50ns;
		
		A <= "10111111111111111111111111111111";
		B <= "10000000000000000000000000000001";
		op <= "0000";
		wait for 50ns;
	
			--Test Substraction
		A  <= "00000000000000000000000111111111";
		B  <=	"00000000000000000000000111111111";
		Op <= "0001";
      wait for 50 ns;
		A  <= "11000000000000010000000000000000";
		B  <=	"01000000000000010000000000000000";
		Op <= "0001";
		wait for 50 ns;
	
			--Test Logical AND
		A  <= "11000000000000010000000000000000";
		B  <=	"01000000000000010000000000000000";
		Op <= "0010";
		wait for 50 ns;
	
			--Test Logical OR
		A  <= "11000000000000010000000000000000";
		B  <=	"01000000000000010000000000000000";
		Op <= "0011";
		wait for 50 ns;
		
		--Test Logical NOT
		A  <= "11000000000000010000000000000000";
		B  <=	"01000000000000010000000000000000";
		Op <= "0100";
		wait for 50 ns;
		
		--Test Arithmetic Shift Right
		A  <= "11000000000000010000001111100000";
		Op <= "1000";
		wait for 50 ns;
	
			--Test Shift Right Logical
		A  <= "11000000000000010000000001000001";
		Op <= "1001";
		wait for 50 ns;
		
		--Test Shift Left Logical
		A  <= "11000000000000010000000000100000";
		Op <= "1010";
		wait for 50 ns;
		
		--Test Rotate Right
		A  <= "11000011000000010000000000000001";
		Op <= "1100";
		wait for 50 ns;

		--Test Rotate Left
		A  <= "11000000000000010011000000000000";
		Op <= "1101";
		wait for 50 ns;


      wait;
   end process;

END;
