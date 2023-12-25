----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 06/11/2023 12:34:15 PM
-- Design Name: 
-- Module Name: TB_MUX_2_4bit - Behavioral
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

entity TB_MUX_2_4bit is
--  Port ( );
end TB_MUX_2_4bit;

architecture Behavioral of TB_MUX_2_4bit is
    -- Component declaration for the unit under test (UUT)
component MUX_2_4bit is
    Port (
        A : in  STD_LOGIC_VECTOR(3 DOWNTO 0);
        B : in  STD_LOGIC_VECTOR(3 DOWNTO 0);
        Q : out STD_LOGIC_VECTOR(3 DOWNTO 0);
        S : in  STD_LOGIC
    );
end component;

-- Inputs
signal A : STD_LOGIC_VECTOR(3 DOWNTO 0);
signal B : STD_LOGIC_VECTOR(3 DOWNTO 0);
signal S : STD_LOGIC;

-- Outputs
signal Q : STD_LOGIC_VECTOR(3 DOWNTO 0);

begin
-- Instantiate the unit under test (UUT)
uut: MUX_2_4bit port map (
    A => A,
    B => B,
    Q => Q,
    S => S
);

-- Stimulus process
stim_proc: process
begin


    A <= "0000";
    B <= "1111";
    S <= '0';
    wait for 10 ns;


    A <= "0101";
    B <= "0011";
    S <= '1';
    wait for 10 ns;


    wait;
end process;

end Behavioral;