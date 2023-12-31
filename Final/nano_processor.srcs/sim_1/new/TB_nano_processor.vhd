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
           Imm_Value:out std_logic_vector(3 downto 0);
           LED : out STD_LOGIC_VECTOR (3 downto 0);
           LED_R6 : out std_logic_vector(3 downto 0);
           LED_R5 : out std_logic_vector(3 downto 0);
           nextInsVal : out std_logic_vector(2 downto 0);
           LED_OVERFLOW:out STD_LOGIC;
           RegisterEnable:out std_logic_vector(2 downto 0);
           RegisterBank_DataIn: out std_logic_vector(3 downto 0);
           LED_ZERO:out STD_LOGIC;

           Instruction_temp : out std_logic_vector(11 downto 0));
end COMPONENT;
SIGNAL PUSHBUTTON,LED_OVERFLOW,LED_ZERO:STD_LOGIC;
SIGNAL LED:STD_LOGIC_VECTOR(3 DOWNTO 0);

signal LED_R6 ,ImmValue: std_logic_vector(3 downto 0);
signal LED_R5 : std_logic_vector(3 downto 0);
SIGNAL CLK: STD_LOGIC:='1';
signal nextInsVal : std_logic_vector(2 downto 0);
SIGNAL Register_Enable :std_logic_vector(2 downto 0);
Signal Register_Bank_Data_In:std_logic_vector(3 downto 0);
signal Instruction_temp : std_logic_vector(11 downto 0);


begin
 UUT:nano_processor Port Map(
    pushButton=>PUSHBUTTON,
    Clk=>CLK,
    RegisterEnable=>Register_Enable,
    RegisterBank_DataIn=>Register_Bank_Data_In,
    LED=>LED,
    LED_R6 => LED_R6,
    LED_R5 => LED_R5,
    nextInsVal => nextInsVal,
    LED_OVERFLOW=>LED_OVERFLOW,
    Imm_Value=>ImmValue,
    LED_ZERO=>LED_ZERO,
  
    
    Instruction_temp => Instruction_temp
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
