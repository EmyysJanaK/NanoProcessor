----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 06/11/2023 12:25:47 PM
-- Design Name: 
-- Module Name: TB_Adder_3bit - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
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
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity TB_Adder_3bit is
--  Port ( );
end TB_Adder_3bit;

architecture Behavioral of TB_Adder_3bit is
    -- Component declaration for the unit under test (UUT)
component Adder_3bit is
    Port (
        A    : in  STD_LOGIC_VECTOR(2 DOWNTO 0);
        B    : in  STD_LOGIC_VECTOR(2 DOWNTO 0);
        S    : out STD_LOGIC_VECTOR(2 DOWNTO 0);
        C_out: out STD_LOGIC
    );
end component;

-- Inputs
signal A    : STD_LOGIC_VECTOR(2 DOWNTO 0) := (others => '0');
signal B    : STD_LOGIC_VECTOR(2 DOWNTO 0) := (others => '0');

-- Outputs
signal S    : STD_LOGIC_VECTOR(2 DOWNTO 0);
signal C_out: STD_LOGIC;

begin
-- Instantiate the unit under test (UUT)
uut: Adder_3bit port map (
    A     => A,
    B     => B,
    S     => S,
    C_out => C_out
);

-- Stimulus process
stim_proc: process
begin
    -- Test case 1
    A <= "001";
    B <= "010";
    wait for 10 ns;

    -- Test case 2
    A <= "011";
    B <= "101";
    wait for 10 ns;

    -- Add more test cases here

    wait;
end process;

end Behavioral;