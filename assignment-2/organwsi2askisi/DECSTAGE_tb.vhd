-- TestBench Template 

  LIBRARY ieee;
  USE ieee.std_logic_1164.ALL;
  USE ieee.numeric_std.ALL;

  ENTITY DECSTAGE_tb IS
  END DECSTAGE_tb;
  
  ARCHITECTURE behavior OF DECSTAGE_tb IS 

  -- Component Declaration
          COMPONENT DECSTAGE
          PORT( Instr : in  STD_LOGIC_VECTOR (31 downto 0);
					 RF_WrEn : in  STD_LOGIC;
					 ALU_out : in  STD_LOGIC_VECTOR (31 downto 0);
					 MEM_out : in  STD_LOGIC_VECTOR (31 downto 0);
					 RF_WrData_sel : in  STD_LOGIC;
					 RF_B_sel : in  STD_LOGIC;
					 clk : in  STD_LOGIC;
					 rst : in STD_LOGIC;
					 immed_sel : in STD_LOGIC_VECTOR(1 downto 0);
					 Immed : out  STD_LOGIC_VECTOR (31 downto 0);
					 RF_A : out  STD_LOGIC_VECTOR (31 downto 0);
					 RF_B : out  STD_LOGIC_VECTOR (31 downto 0)
					 );
          END COMPONENT;
			 
			 --Input signals
			 signal clk : STD_LOGIC := '0';
			 signal rst : STD_LOGIC := '0';
			 signal Instr : STD_LOGIC_VECTOR (31 downto 0);
			 signal RF_WrEn : STD_LOGIC := '0';
			 signal ALU_out : STD_LOGIC_VECTOR (31 downto 0);
			 signal MEM_out : STD_LOGIC_VECTOR (31 downto 0);
			 signal RF_WrData_sel : STD_LOGIC := '0';
			 signal RF_B_sel : STD_LOGIC := '0';
			 signal immed_sel : STD_LOGIC_VECTOR(1 downto 0);
			 
			 			 
			  --Output signals
			 signal Immed : STD_LOGIC_VECTOR (31 downto 0);
			 signal RF_A : STD_LOGIC_VECTOR (31 downto 0);
			 signal RF_B : STD_LOGIC_VECTOR (31 downto 0);

  BEGIN
			 
			 
			 -- Component Instantiation
          uut:  DECSTAGE
    port map (
        Instr => Instr,
        RF_WrEn => RF_WrEn,
        ALU_out => ALU_out,
        MEM_out => MEM_out,
        RF_WrData_sel => RF_WrData_sel,
        RF_B_sel => RF_B_sel,
        clk => clk,
        rst => rst,
        Immed => Immed,
		  immed_sel => immed_sel,
        RF_A => RF_A,
        RF_B => RF_B
		  );
		  
		  
		   -- Clock Process
    clk_process: process
    begin
        clk <= '0';
        wait for 10 ns;
        clk <= '1';
        wait for 10 ns;
    end process;
	 
	 
	 --  Test Bench Statements
     tb : PROCESS
     BEGIN
		  -- Reset
        rst <= '1';
        RF_WrEn <= '0';
        RF_WrData_sel <= '0';
        RF_B_sel <= '0';
		  immed_sel <= "00";
        Instr <= (others => '0');
        ALU_out <= (others => '0');
        MEM_out <= (others => '0');

        wait for 100 ns;

		    -- Testcases
		  rst <= '0';
			 		  
		  
		  -- li
		  Instr <= "11100000000000011000000000000000";
		  RF_WrEn <= '1';
		  RF_WrData_sel <= '1'; --MEM_OUT
		  RF_B_sel <= '1';     
		  ALU_out <= "00000011000000001111111111111111";
        MEM_out <= "11000011000000001110000000001100";
		  immed_sel <= "00";
		  wait for 20 ns;
		  
		  -- lui
		  Instr <= "11100100000000101000000000000000";
	     RF_WrEn <= '1';
		  RF_WrData_sel <= '0';
		  RF_B_sel <= '1';
		  ALU_out <= "00000011000010000010000100001100";
        MEM_out <= "00100011000000001110000000001100";
		  immed_sel <= "11";
		  wait for 20 ns;
		  
		  -- li
		  Instr <= "11100000000000011000000000000000";
		  RF_WrEn <= '0'; --only read
		  RF_WrData_sel <= '1'; --MEM_OUT
		  RF_B_sel <= '1';     
		  ALU_out <= "00000011000000001111111111111111";
        MEM_out <= "11000011000000001110000000001100";
		  immed_sel <= "00";
		  wait for 20 ns;
		  
		   -- lui
		  Instr <= "11100100000000101000000000000000";
	     RF_WrEn <= '0';
		  RF_WrData_sel <= '0';
		  RF_B_sel <= '1';
		  ALU_out <= "00000011000010000010000100001100";
        MEM_out <= "00100011000000001110000000001100";
		  immed_sel <= "11";
		  wait for 50 ns;
		  
--		  -- addi
--		  Instr <= "11000000001000110000000000000001";
--	     RF_WrEn <= '1';
--		  RF_WrData_sel <= '1';
--		  RF_B_sel <= '0';
--		  ALU_out <= "00000000000000000000000000000011";
--        MEM_out <= "00000011110000111110000000001100";
--		  immed_sel <= "00";
--		  wait for 20 ns;
--		  
--		  -- andi
--		  Instr <= "11001000010001001000000000000000";
--	     RF_WrEn <= '1';
--		  RF_WrData_sel <= '1';
--		  RF_B_sel <= '1';
--		  ALU_out <= "11100011000100001110000010001100";
--        MEM_out <= "10101011000010001110000000001100";
--		  immed_sel <= "01";
--		  wait for 20 ns;
--		  
--		  -- ori
--		  Instr <= "11001100100001011000000000000000";
--	     RF_WrEn <= '1';
--		  RF_WrData_sel <= '1';
--		  RF_B_sel <= '0';
--		  ALU_out <= "00000011010110001110010010001100";
--        MEM_out <= "00000011000000001110000000001111";
--		  immed_sel <= "01";
--		  wait for 20 ns;
--		  
--		  -- B
--		  Instr <= "11111100011001101000000000000000";
--		  RF_WrEn <= '0';
--		  RF_WrData_sel <= '0';
--		  RF_B_sel <= '1';
--		  ALU_out <= "11111111000000001110000000001100";
--        MEM_out <= "00000000000000000000000000000011";
--		  immed_sel <= "10";
--		  wait for 20 ns;
--		  
--		  -- beq
--		  Instr <= "01000000000001111000000000000000";
--		  RF_WrEn <= '0';
--		  RF_WrData_sel <= '0';
--		  RF_B_sel <= '1';
--		  ALU_out <= "00000000000000000000000000000001";
--        MEM_out <= "00000000000000000000000000111111";
--		  immed_sel <= "10";
--		  wait for 20 ns;
--		  
--		  -- bne
--		  Instr <= "01000100000010001000000000000000";
--		  RF_WrEn <= '0';
--		  RF_WrData_sel <= '0';
--		  RF_B_sel <= '1';
--		  ALU_out <= "00000011010010001110001110001100";
--        MEM_out <= "00101000001000001000110000001100";
--		  immed_sel <= "10";
--		  wait for 20 ns;
--		  			 		   
--		   -- Lb
--		  Instr <= "00001100000010011000000000000000";
--		  RF_WrEn <= '1';
--		  RF_WrData_sel <= '1';
--		  RF_B_sel <= '1';
--		  ALU_out <= "00011000000010010010000000001100";
--        MEM_out <= "00000011000000001110000000000101";
--		  immed_sel <= "00";
--		  wait for 20 ns;
--		  
--		  -- Lw
--		  Instr <= "00111100000010101000000000000000";
--		  RF_WrEn <= '1';
--		  RF_WrData_sel <= '1';
--		  RF_B_sel <= '0';
--		  ALU_out <= "00000000000000000001001001001000";
--        MEM_out <= "00000010000000001000000000001000";
--		  immed_sel <= "00";
--		  wait for 20 ns;
--		  
--		  -- Sw
--		  Instr <= "01111100000010111000000000000000";
--		  RF_WrEn <= '0';
--		  RF_WrData_sel <= '0';
--		  RF_B_sel <= '1';
--		  ALU_out <= "00000111000000001000000000001100";
--        MEM_out <= "11000000001000001000001100000000";
--		  immed_sel <= "00";
--		  wait for 20 ns;
		  
		  wait; -- will wait forever
     END PROCESS tb;
  --  End Test Bench 

  END;