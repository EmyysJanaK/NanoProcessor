----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 06/09/2023 10:34:26 AM
-- Design Name: 
-- Module Name: TB_nano_processor - Behavioral
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

entity TB_nano_processor is
--  Port ( );
end TB_nano_processor;

architecture Behavioral of TB_nano_processor is
COMPONENT nano_processor is
    Port ( pushButton : in STD_LOGIC;
           Clk : in STD_LOGIC;
           LED : out STD_LOGIC_VECTOR (3 downto 0);
           LED_OVERFLOW:out STD_LOGIC;
           LED_ZERO:out STD_LOGIC;
           an:out STD_LOGIC_VECTOR (3 downto 0);
           seven_seg_out : out STD_LOGIC_VECTOR (6 downto 0)
           );
end COMPONENT;
SIGNAL PUSHBUTTON,LED_ZERO:STD_LOGIC:='0';
SIGNAL LED_OVERFLOW:STD_LOGIC:='0';
SIGNAL LED:STD_LOGIC_VECTOR(3 DOWNTO 0);
SIGNAL seven_seg_out_0:STD_LOGIC_VECTOR(6 DOWNTO 0);
SIGNAL an:STD_LOGIC_VECTOR(3 DOWNTO 0);

SIGNAL CLK: STD_LOGIC:='1';


begin
 UUT:nano_processor Port Map(
    pushButton=>PUSHBUTTON,
    Clk=>CLK,
    LED=>LED,
    LED_OVERFLOW=>LED_OVERFLOW,
    LED_ZERO=>LED_ZERO,
    an=>an,
    seven_seg_out=>seven_seg_out_0
 );
 PROCESS BEGIN
    WAIT FOR 30 NS;
    CLK <= NOT CLK;
 END PROCESS;
 
 PROCESS BEGIN
    wait for 45 ns;
    PUSHBUTTON<='1';
    wait for 30 ns;
    PUSHBUTTON<='0';
    WAIT;
 END PROCESS;
    
   end Behavioral;
