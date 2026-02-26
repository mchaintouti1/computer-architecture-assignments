----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    12:42:34 04/09/2024 
-- Design Name: 
-- Module Name:    RegisterFile - Structural 
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

entity RegisterFile is
    Port ( ard1 : in  STD_LOGIC_VECTOR (4 downto 0);
           ard2 : in  STD_LOGIC_VECTOR (4 downto 0);
           awr : in  STD_LOGIC_VECTOR (4 downto 0);
           dout1 : out  STD_LOGIC_VECTOR (31 downto 0);
           dout2 : out  STD_LOGIC_VECTOR (31 downto 0);
           din : in  STD_LOGIC_VECTOR (31 downto 0);
           regfile_we : in  STD_LOGIC;
           clk : in  STD_LOGIC;
			  rst : in STD_LOGIC);
end RegisterFile;

architecture Structural of RegisterFile is

type RegisterArray is array (0 to 31) of STD_LOGIC_VECTOR(31 downto 0);
signal register_out:RegisterArray;
signal dec_out : STD_LOGIC_VECTOR(31 downto 0);
signal mux32_output1 : STD_LOGIC_VECTOR(31 downto 0);
signal mux32_output2 : STD_LOGIC_VECTOR(31 downto 0);
signal comp_mod_output1 : STD_LOGIC;
signal comp_mod_output2 : STD_LOGIC;
signal RegWrEn : STD_LOGIC_VECTOR(31 downto 0) := (others => '0');


component RegisterEx is 
	  Port(
			  clk : in STD_LOGIC;
			  rst : in STD_LOGIC;
			  din : in STD_LOGIC_VECTOR(31 downto 0);
			  we : in STD_LOGIC;
			  dout : out STD_LOGIC_VECTOR(31 downto 0)
			  );
end component;


component Decoder5to32 is
		Port(dec_input : in  STD_LOGIC_VECTOR (4 downto 0);
           dec_output : out  STD_LOGIC_VECTOR (31 downto 0)
			  );
end component;

component mux32to1 is
		Port(sel : in  STD_LOGIC_VECTOR (4 downto 0);
           IN0 : in  STD_LOGIC_VECTOR (31 downto 0);
			  IN1 : in  STD_LOGIC_VECTOR (31 downto 0);
			  IN2 : in  STD_LOGIC_VECTOR (31 downto 0);
			  IN3 : in  STD_LOGIC_VECTOR (31 downto 0);
			  IN4 : in  STD_LOGIC_VECTOR (31 downto 0);
			  IN5 : in  STD_LOGIC_VECTOR (31 downto 0);
			  IN6 : in  STD_LOGIC_VECTOR (31 downto 0);
			  IN7 : in  STD_LOGIC_VECTOR (31 downto 0);
			  IN8 : in  STD_LOGIC_VECTOR (31 downto 0);
			  IN9 : in  STD_LOGIC_VECTOR (31 downto 0);
			  IN10 : in  STD_LOGIC_VECTOR (31 downto 0);
			  IN11 : in  STD_LOGIC_VECTOR (31 downto 0);
			  IN12 : in  STD_LOGIC_VECTOR (31 downto 0);
			  IN13 : in  STD_LOGIC_VECTOR (31 downto 0);
			  IN14 : in  STD_LOGIC_VECTOR (31 downto 0);
			  IN15 : in  STD_LOGIC_VECTOR (31 downto 0);
			  IN16 : in  STD_LOGIC_VECTOR (31 downto 0);
			  IN17 : in  STD_LOGIC_VECTOR (31 downto 0);
			  IN18 : in  STD_LOGIC_VECTOR (31 downto 0);
			  IN19 : in  STD_LOGIC_VECTOR (31 downto 0);
			  IN20 : in  STD_LOGIC_VECTOR (31 downto 0);
			  IN21 : in  STD_LOGIC_VECTOR (31 downto 0);
			  IN22 : in  STD_LOGIC_VECTOR (31 downto 0);
			  IN23 : in  STD_LOGIC_VECTOR (31 downto 0);
			  IN24 : in  STD_LOGIC_VECTOR (31 downto 0);
			  IN25 : in  STD_LOGIC_VECTOR (31 downto 0);
			  IN26 : in  STD_LOGIC_VECTOR (31 downto 0);
			  IN27 : in  STD_LOGIC_VECTOR (31 downto 0);
			  IN28 : in  STD_LOGIC_VECTOR (31 downto 0);
			  IN29 : in  STD_LOGIC_VECTOR (31 downto 0);
			  IN30 : in  STD_LOGIC_VECTOR (31 downto 0);
			  IN31 : in  STD_LOGIC_VECTOR (31 downto 0);
           mux32_output : out  STD_LOGIC_VECTOR(31 downto 0)
			  );
end component;

component mux2to1 is
		Port(mux2_input1 : in  STD_LOGIC_VECTOR (31 downto 0);
           mux2_input2 : in  STD_LOGIC_VECTOR (31 downto 0);
           sel : in  STD_LOGIC;
           mux2_output : out  STD_LOGIC_VECTOR (31 downto 0)
			  );
end component;

component CompareModule is 
		Port(awr : in  STD_LOGIC_VECTOR (4 downto 0);
           ard : in  STD_LOGIC_VECTOR (4 downto 0);
			  comp_mod_out : out STD_LOGIC
			  );
end component;

begin

decoder : Decoder5to32 Port Map(dec_input => awr,
										  dec_output => dec_out
										  );

upper_mux2to1 : mux2to1 Port Map(mux2_input1 => mux32_output1,
											mux2_input2 => din,
											sel => comp_mod_output1,
											mux2_output => dout1
											);

down_mux2to1 : mux2to1 Port Map(mux2_input1 => mux32_output2,
										  mux2_input2 => din,
										  sel => comp_mod_output2,
										  mux2_output => dout2
										  );
										  
upper_CompareModule : CompareModule Port Map(awr => awr,
															ard => ard1,
															comp_mod_out => comp_mod_output1
															);
															
down_CompareModule : CompareModule Port Map(awr => awr,
														  ard => ard2,
														  comp_mod_out => comp_mod_output2
														  );
														  													  
register0 : RegisterEx Port Map(clk => clk,
										  rst => rst,
										  din => "00000000000000000000000000000000",
										  we => '0',
										  dout => register_out(0)
										  );
		
generating_registers : for i in 1 to 31 generate	
RegWrEn(i) <= (regfile_we AND dec_out(i));
			
registers1to31 : RegisterEx Port Map(clk => clk,
												 rst => rst,
												 din => din,
												 we => RegWrEn(i),
												 dout => register_out(i) 
												 );
end generate;

upper_mux32to1 : mux32to1 Port Map(sel => ard1,
											  IN0 => register_out(0),
											  IN1 => register_out(1),
											  IN2 => register_out(2),
											  IN3 => register_out(3),
											  IN4 => register_out(4),
											  IN5 => register_out(5),
											  IN6 => register_out(6),
											  IN7 => register_out(7),
											  IN8 => register_out(8),
											  IN9 => register_out(9),
											  IN10 => register_out(10),
											  IN11 => register_out(11),
											  IN12 => register_out(12),
											  IN13 => register_out(13),
											  IN14 => register_out(14),
											  IN15 => register_out(15),
											  IN16 => register_out(16),
											  IN17 => register_out(17),
											  IN18 => register_out(18),
											  IN19 => register_out(19),
											  IN20 => register_out(20),
											  IN21 => register_out(21),
											  IN22 => register_out(22),
											  IN23 => register_out(23),
											  IN24 => register_out(24),
											  IN25 => register_out(25),
											  IN26 => register_out(26),
											  IN27 => register_out(27),
											  IN28 => register_out(28),
											  IN29 => register_out(29),
											  IN30 => register_out(30),
											  IN31 => register_out(31),
											  mux32_output => mux32_output1
											  );
											  
down_mux32to1 : mux32to1 Port Map(sel => ard2,
											 IN0 => register_out(0),
											 IN1 => register_out(1),
											 IN2 => register_out(2),
											 IN3 => register_out(3),
											 IN4 => register_out(4),
											 IN5 => register_out(5),
											 IN6 => register_out(6),
											 IN7 => register_out(7),
											 IN8 => register_out(8),
											 IN9 => register_out(9),
											 IN10 => register_out(10),
											 IN11 => register_out(11),
											 IN12 => register_out(12),
											 IN13 => register_out(13),
											 IN14 => register_out(14),
											 IN15 => register_out(15),
											 IN16 => register_out(16),
											 IN17 => register_out(17),
											 IN18 => register_out(18),
											 IN19 => register_out(19),
											 IN20 => register_out(20),
											 IN21 => register_out(21),
											 IN22 => register_out(22),
											 IN23 => register_out(23),
											 IN24 => register_out(24),
											 IN25 => register_out(25),
											 IN26 => register_out(26),
											 IN27 => register_out(27),
											 IN28 => register_out(28),
											 IN29 => register_out(29),
											 IN30 => register_out(30),
											 IN31 => register_out(31),
											 mux32_output => mux32_output2
											 );



end Structural;

