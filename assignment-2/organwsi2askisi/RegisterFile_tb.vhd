-- TestBench Template 

  LIBRARY ieee;
  USE ieee.std_logic_1164.ALL;
  USE ieee.numeric_std.ALL;

  ENTITY RegisterFile_tb IS
  END RegisterFile_tb;

  ARCHITECTURE behavior OF RegisterFile_tb IS 
  
  -- Component Declaration
          COMPONENT RegisterFile
          PORT(
               ard1 : in  STD_LOGIC_VECTOR (4 downto 0);
					ard2 : in  STD_LOGIC_VECTOR (4 downto 0);
					awr : in  STD_LOGIC_VECTOR (4 downto 0);
					dout1 : out  STD_LOGIC_VECTOR (31 downto 0);
					dout2 : out  STD_LOGIC_VECTOR (31 downto 0);
					din : in  STD_LOGIC_VECTOR (31 downto 0);
					regfile_we : in  STD_LOGIC;
					rst : in STD_LOGIC;
					clk : in  STD_LOGIC
               );
          END COMPONENT;
			 
  --Input signals
			 signal regfile_we : STD_LOGIC := '0';
			 signal clk : STD_LOGIC := '0';
			 signal rst : STD_LOGIC := '0';
			 signal ard1 : STD_LOGIC_VECTOR(4 downto 0) := (others => '0');
			 signal ard2 : STD_LOGIC_VECTOR(4 downto 0) := (others => '0');
			 signal awr : STD_LOGIC_VECTOR(4 downto 0) := (others => '0');
			 signal din : STD_LOGIC_VECTOR(31 downto 0) := (others => '0');
			 
			 

  --Output signals
			 signal dout1 : STD_LOGIC_VECTOR (31 downto 0);
			 signal dout2 : STD_LOGIC_VECTOR (31 downto 0);  

  BEGIN
  
   -- Component Instantiation
          uut: RegisterFile PORT MAP(
                  ard1 => ard1,
						ard2 => ard2,
						awr => awr,
						dout1 => dout1,
						dout2 => dout2,
						din => din,
						regfile_we => regfile_we,
						rst => rst,
						clk => clk
						);
						
	-- Clock process
    clk_process: process
    begin
        wait for 40 ns;
        clk <= not clk;
    end process;

  --  Test Bench Statements
     tb : PROCESS
     BEGIN
	  
	   -- hold reset state for 100 ns.
		  rst <= '1';
		  
        wait for 80 ns;	
		rst <= '0';
      ard1 <= "00011";
		ard2 <= "10000";
		awr <= "00100";
		din <= "00000000000000000000000000100000";
		regfile_we <= '1';
		
		wait for 80 ns;
		
		-- writing
		ard1 <= "00011";
		ard2 <= "10000";
		awr <= "00101";
		din <= "00010000000000000000000000100010";
		regfile_we <= '1';
		
		wait for 80 ns;
		
		-- reading from reg4 and 
		ard1 <= "00101";
		ard2 <= "00100";
		regfile_we <= '0';
		awr <= "00000";
		din <= "00010000000000000000000001111010";
		
		wait for 80 ns;
		
		-- checking the compare for Dout1
		--Ard1 <= "00100";
		--Ard2 <= "00101";
		--WrEn <= '0';
		awr <= "00100";
		
		wait for 80 ns;
		
		awr <= "00101";
		wait for 80 ns;
		
		-- 
		ard1 <= "00100";
		ard2 <= "11100";
		regfile_we <= '1';
		awr <= "00100";
		din <= "00010000000000000000110001111010";
		
		wait for 80 ns;
		
		ard1 <= "00101";
		awr <= "00000";
		regfile_we <= '0';
		wait for 80 ns;
		
		
        wait; -- will wait forever
     END PROCESS tb;
  --  End Test Bench 

  END;
