--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   12:45:50 04/19/2024
-- Design Name:   
-- Module Name:   /home/ise/askisi1/IFSTAGE_tb.vhd
-- Project Name:  askisi1
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: IFSTAGE
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
 
ENTITY IFSTAGE_tb IS
  END IFSTAGE_tb;

  ARCHITECTURE behavior OF IFSTAGE_tb IS 

  -- Component Declaration
          COMPONENT IFSTAGE
          PORT(
                  clk : in  STD_LOGIC;
						PC_Immed : in  STD_LOGIC_VECTOR (31 downto 0);
						PC_sel : in  STD_LOGIC;
						PC_LdEn : in  STD_LOGIC;
						Reset : in  STD_LOGIC;
						Instr : out  STD_LOGIC_VECTOR (31 downto 0)
                  );
          END COMPONENT;
    

   --Input signals 
			 signal clk : STD_LOGIC := '0';
			 signal Reset : STD_LOGIC := '0';
			 signal PC_sel : STD_LOGIC := '0';
			 signal PC_LdEn : STD_LOGIC := '0';
			 signal PC_Immed : STD_LOGIC_VECTOR(31 downto 0) := (others => '0');
			 
			 --Output signals
			 signal Instr : STD_LOGIC_VECTOR(31 downto 0) := (others => '0');

  BEGIN

 
	 -- Component Instantiation
          uut: IFSTAGE PORT MAP(
                  clk => clk,
						PC_Immed => PC_Immed,
						PC_sel => PC_sel,
						PC_LdEn => PC_LdEn,
						Reset => Reset,
						Instr => Instr
						);

   -- Clock process definitions
		clk_process :process
			begin
				clk <= '0';
			wait for 10 ns;
				clk <= '1';
			wait for 10 ns;
		end process;
 

   --  Test Bench Statements
     tb : PROCESS
     BEGIN
		  Reset <= '1';
        wait for 100 ns;

        -- Add user defined stimulus here
		  -- Testcase 1
        PC_Immed <= "00000000000000000000000000010000"; 
        PC_sel <= '0'; --PC + 4
        PC_LdEn <= '1';
		  Reset <= '0';
        wait for 20 ns;
		  
		  -- Testcase 2
        PC_Immed <= "00000000000000000000000000010000"; 
        PC_sel <= '0'; --PC + 4
        PC_LdEn <= '1';
		  Reset <= '0';
        wait for 20 ns;
		  
		  --Testcase 3
		  PC_Immed <= "00000000000000000000000000010000"; 
        PC_sel <= '1'; --PC + 4 + Immediate
        PC_LdEn <= '1';
		  Reset <= '0';
        wait for 20 ns;
		  
		   --Testcase 4
		  PC_Immed <= "00000000000000000000000000010000"; 
        PC_sel <= '0'; --PC + 4 
        PC_LdEn <= '1';
		  Reset <= '0';
        wait for 20 ns;
		  
		  --Testcase 5
		  PC_Immed <= "00000000000000000000000000010000"; 
        PC_sel <= '1'; --PC + 4 + Immediate
        PC_LdEn <= '1';
		  Reset <= '0';
        wait for 20 ns;
		  
		   --Testcase 6
		  PC_Immed <= "00000000000000000000000000010000"; 
        PC_sel <= '0'; --PC + 4
        PC_LdEn <= '1';
		  Reset <= '0';
        wait for 20 ns;
		  
		  --Testcase 5
		  PC_Immed <= "00000000000000000000000000010000"; 
        PC_sel <= '1'; --PC + 4 + Immediate
        PC_LdEn <= '1';
		  Reset <= '0';
        wait for 20 ns;
		  
		  --Testcase 5
		  PC_Immed <= "00000000000000000000000000010000"; 
        PC_sel <= '1'; --PC + 4 + Immediate
        PC_LdEn <= '1';
		  Reset <= '0';
        wait for 20 ns;

        wait; -- will wait forever
     END PROCESS tb;
  --  End Test Bench 

  END; 