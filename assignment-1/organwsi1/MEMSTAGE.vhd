----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    12:34:36 04/22/2024 
-- Design Name: 
-- Module Name:    MEMSTAGE - Behavioral 
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

entity MEMSTAGE is
    Port ( clk : in  STD_LOGIC;
           Mem_WrEn : in  STD_LOGIC;
           ALU_MEM_Addr : in  STD_LOGIC_VECTOR (31 downto 0);
           MEM_DataIn : in  STD_LOGIC_VECTOR (31 downto 0);
           MEM_DataOut : out  STD_LOGIC_VECTOR (31 downto 0));
end MEMSTAGE;

architecture Behavioral of MEMSTAGE is

component RAM_MEMORY is 
				Port(a : IN STD_LOGIC_VECTOR(9 DOWNTO 0);
					  d : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
					  clk : IN STD_LOGIC;
					  we : IN STD_LOGIC;
					  spo : OUT STD_LOGIC_VECTOR(31 DOWNTO 0)
					  );
end component;

begin

ram_mem_inst : RAM_MEMORY port map(clk => clk,
											  a => ALU_MEM_Addr(11 downto 2),
											  d => MEM_DataIn,
											  we => Mem_WrEn,
											  spo => MEM_DataOut
											  );
						 
	
	
	
end Behavioral;

