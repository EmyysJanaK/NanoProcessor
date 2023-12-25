----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 06/09/2023 10:24:58 AM
-- Design Name: 
-- Module Name: ProgramCounter - Behavioral
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

entity ProgramCounter is
    Port ( Reset : in STD_LOGIC;                    --Reset Button
           Clk : in STD_LOGIC;                      --Clock
           A : in STD_LOGIC_VECTOR (2 downto 0);    --ProgramCounter_in
           memory_select : out STD_LOGIC_VECTOR (2 downto 0)); ----ProgramCounter select Address
end ProgramCounter;

architecture Behavioral of ProgramCounter is
begin
    process(Clk)
    begin
    if(rising_edge(Clk)) then
        if(Reset='1') then
          memory_select<="000";
        else
          memory_select<=A;
        end if;
    end if;
end process;


end Behavioral;
