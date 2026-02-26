----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    18:52:48 04/20/2024 
-- Design Name: 
-- Module Name:    ALUSTAGE - Behavioral 
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

entity ALUSTAGE is
    Port ( RF_A : in  STD_LOGIC_VECTOR (31 downto 0);
           RF_B : in  STD_LOGIC_VECTOR (31 downto 0);
           Immed : in  STD_LOGIC_VECTOR (31 downto 0);
           ALU_Bin_sel  : in  STD_LOGIC;
           ALU_func : in  STD_LOGIC_VECTOR (3 downto 0);
           ALU_out : out  STD_LOGIC_VECTOR (31 downto 0);
			  ALU_ovf : out STD_LOGIC;
			  ALU_zero_out : out STD_LOGIC;
			  ALU_cout : out STD_LOGIC
			  );
end ALUSTAGE;

architecture Behavioral of ALUSTAGE is
signal mux2_out : STD_LOGIC_VECTOR(31 downto 0);

component ALU is 
			Port(A : in  STD_LOGIC_VECTOR(31 downto 0);
           B : in  STD_LOGIC_VECTOR(31 downto 0);
           op : in  STD_LOGIC_VECTOR(3 downto 0);
           output : out  STD_LOGIC_VECTOR(31 downto 0);
           zero_out : out  STD_LOGIC;
           cout : out  STD_LOGIC;
           ovf : out  STD_LOGIC
			  );
end component;

component mux2to1 is
			Port(mux2_input1 : in  STD_LOGIC_VECTOR (31 downto 0);
           mux2_input2 : in  STD_LOGIC_VECTOR (31 downto 0);
           sel : in  STD_LOGIC;
           mux2_output : out  STD_LOGIC_VECTOR (31 downto 0)
			  );
end component;

begin


 mux2to1_inst : mux2to1 Port Map
							(mux2_input1 => RF_B,
							 mux2_input2 => Immed,
							 sel => ALU_Bin_sel,
							 mux2_output => mux2_out
							 );
							 
							 
 ALU_inst : ALU Port Map
						(A => RF_A,
						 B => mux2_out,
						 op => ALU_func,
						 output => ALU_out,
						 zero_out => ALU_zero_out,
						 cout => ALU_cout,
						 ovf => ALU_ovf
						 );

end Behavioral;

