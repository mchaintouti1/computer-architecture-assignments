----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    13:55:55 04/20/2024 
-- Design Name: 
-- Module Name:    DECSTAGE - Structural 
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

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;


entity DECSTAGE is
    Port ( Instr : in  STD_LOGIC_VECTOR (31 downto 0);
           RF_WrEn : in  STD_LOGIC;
           ALU_out : in  STD_LOGIC_VECTOR (31 downto 0);
			  MEM_out : in  STD_LOGIC_VECTOR (31 downto 0);
           RF_WrData_sel : in  STD_LOGIC;
           RF_B_sel : in  STD_LOGIC;
           clk : in  STD_LOGIC;
			  rst : in STD_LOGIC;
			  immed_sel : in STD_LOGIC_VECTOR(1 downto 0);
			  rd_vector : in STD_LOGIC_VECTOR(4 downto 0);
           Immed : out  STD_LOGIC_VECTOR (31 downto 0);
			  RF_A : out  STD_LOGIC_VECTOR (31 downto 0);
           RF_B : out  STD_LOGIC_VECTOR (31 downto 0)
			  );
end DECSTAGE;

architecture Structural of DECSTAGE is
signal mux2_write_out : STD_LOGIC_VECTOR(31 downto 0);
signal mux2_read_out : STD_LOGIC_VECTOR(4 downto 0); 

component RegisterFile 
		Port ( 
				 ard1 : in  STD_LOGIC_VECTOR (4 downto 0);
				 ard2 : in  STD_LOGIC_VECTOR (4 downto 0);
				 awr : in  STD_LOGIC_VECTOR (4 downto 0);
				 dout1 : out  STD_LOGIC_VECTOR (31 downto 0);
				 dout2 : out  STD_LOGIC_VECTOR (31 downto 0);
				 din : in  STD_LOGIC_VECTOR (31 downto 0);
				 regfile_we : in STD_LOGIC;
				 rst : in  STD_LOGIC;
				 clk : in  STD_LOGIC
			  );
end component;

component mux2to1
        Port (
            mux2_input1 : in  STD_LOGIC_VECTOR (31 downto 0);
            mux2_input2 : in  STD_LOGIC_VECTOR (31 downto 0);
            sel : in  STD_LOGIC;
            mux2_output : out  STD_LOGIC_VECTOR (31 downto 0)
        );
end component;

component mux2_5bits
        Port (
            mux2_5bits_input1 : in  STD_LOGIC_VECTOR (4 downto 0);
            mux2_5bits_input2 : in  STD_LOGIC_VECTOR (4 downto 0);
            sel : in  STD_LOGIC;
            mux2_5bits_output : out  STD_LOGIC_VECTOR (4 downto 0)
        );
end component;

component Converter
		Port(
			 immed_in : in  STD_LOGIC_VECTOR (15 downto 0);
          immed_sel : in STD_LOGIC_VECTOR(1 downto 0);
			 immed_out : out  STD_LOGIC_VECTOR (31 downto 0)
			 );
end component;

begin
	 
	-- Instantiate components
		RF : RegisterFile 
			Port Map(ard1 => Instr(25 downto 21),
						ard2 => mux2_read_out, 
						awr => rd_vector,
						dout1 => RF_A,
						dout2 => RF_B,
						din => mux2_write_out,
						regfile_we => RF_WrEn,
						clk => clk,
						rst => rst
						);
						
		upper_mux2to1 : mux2_5bits
			Port Map(
						mux2_5bits_input1 => Instr(15 downto 11),
						mux2_5bits_input2 => Instr(20 downto 16),
						sel => RF_B_sel,
						mux2_5bits_output => mux2_read_out
						);
						
						
		down_mux2to1 : mux2to1 
			Port Map(
						mux2_input1 => ALU_out,
						mux2_input2 => MEM_out,
						sel => RF_WrData_sel,
						mux2_output => mux2_write_out
						);
						
		converter_inst: Converter 
			Port Map(
						immed_in => Instr(15 downto 0),
						immed_sel => immed_sel,
						immed_out => Immed
						);



end Structural;




