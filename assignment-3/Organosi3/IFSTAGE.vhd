----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    10:01:37 04/19/2024 
-- Design Name: 
-- Module Name:    IFSTAGE - Behavioral 
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

entity IFSTAGE is
    Port ( clk : in  STD_LOGIC;
           PC_Immed : in  STD_LOGIC_VECTOR (31 downto 0);
           PC_sel : in  STD_LOGIC;
           PC_LdEn : in  STD_LOGIC;
           Reset : in  STD_LOGIC;
           Instr : out  STD_LOGIC_VECTOR (31 downto 0)
			  );
end IFSTAGE;

architecture Behavioral of IFSTAGE is

signal mux_out : STD_LOGIC_VECTOR(31 downto 0); --Mux's output
signal PC_out : STD_LOGIC_VECTOR(31 downto 0); --Register's urrent state 
signal Incrementer_out : STD_LOGIC_VECTOR(31 downto 0); --Incremented by 4 register's value
signal Adder_out : STD_LOGIC_VECTOR(31 downto 0);

--Components declarations
component Adder
	Port( 
			input: in STD_LOGIC_VECTOR (31 downto 0);
			PC_Immed: in STD_LOGIC_VECTOR (31 downto 0);
			output: out STD_LOGIC_VECTOR (31 downto 0));
end component;

component Incrementer4
	Port( 
			input: in STD_LOGIC_VECTOR (31 downto 0);
			output: out STD_LOGIC_VECTOR (31 downto 0));
end component;

component mux2to1
        Port (
            mux2_input1 : in  STD_LOGIC_VECTOR (31 downto 0);
            mux2_input2 : in  STD_LOGIC_VECTOR (31 downto 0);
            sel : in  STD_LOGIC;
            mux2_output : out  STD_LOGIC_VECTOR (31 downto 0)
        );
end component;

component PC_Register
        Port (
           clk : in  STD_LOGIC;
           rst : in  STD_LOGIC;
			  input_LdEn : in  STD_LOGIC;
           input_pc : in  STD_LOGIC_VECTOR (31 downto 0);
           output : out  STD_LOGIC_VECTOR (31 downto 0)
        );
end component;

component Rom_mem
		  PORT (
			 a : IN STD_LOGIC_VECTOR(9 DOWNTO 0);
			 spo : OUT STD_LOGIC_VECTOR(31 DOWNTO 0)
		    );
end component;

begin

-- Instantiate components
	PC_Register_inst: PC_Register
		port map(clk =>clk,
					rst =>Reset,
					input_LdEn => PC_LdEn,
					input_pc => mux_out,
					output => PC_out
					);
					
	Adder_inst: Adder
    port map(
        input => Incrementer_out,
        PC_Immed => PC_Immed,
        output => Adder_out
    );
	 
	 Incrementer4_inst: Incrementer4
	  port map(
			input => PC_out,
			output => Incrementer_out
			);
			
			
	mux2to1_inst: mux2to1
	 port map(
		  mux2_input1 => Incrementer_out,
        mux2_input2 => Adder_out,
        sel => PC_sel,
        mux2_output => mux_out
    );
	 
	IMEM : Rom_mem
	 port map(
			a => PC_out(11 downto 2),
			spo => Instr
			);



end Behavioral;

