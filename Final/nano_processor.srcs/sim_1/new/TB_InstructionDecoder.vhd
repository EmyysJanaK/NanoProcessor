----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 06/11/2023 12:37:43 PM
-- Design Name: 
-- Module Name: TB_InstructionDecoder - Behavioral
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

entity TB_InstructionDecoder is
--  Port ( );
end TB_InstructionDecoder;

architecture Behavioral of TB_InstructionDecoder is
    -- Component declaration for the unit under test (UUT)
component InstructionDecoder is
    Port (
        Instruction    : in  STD_LOGIC_VECTOR(11 DOWNTO 0);
        RCJ            : in  STD_LOGIC_VECTOR(3 DOWNTO 0);
        RegEn          : out STD_LOGIC_VECTOR(2 DOWNTO 0);
        LS             : out STD_LOGIC;
        Immediatevalue : out STD_LOGIC_VECTOR(3 DOWNTO 0);
        Reg_1          : out STD_LOGIC_VECTOR(2 DOWNTO 0);
        Reg_2          : out STD_LOGIC_VECTOR(2 DOWNTO 0);
        Add_Sub_Select : out STD_LOGIC;
        JumpFlag       : out STD_LOGIC;
        ATJ            : out STD_LOGIC_VECTOR(2 DOWNTO 0)
    );
end component;

-- Inputs
signal Instruction    : STD_LOGIC_VECTOR(11 DOWNTO 0);
signal RCJ            : STD_LOGIC_VECTOR(3 DOWNTO 0);

-- Outputs
signal RegEn          : STD_LOGIC_VECTOR(2 DOWNTO 0);
signal LS             : STD_LOGIC;
signal Immediatevalue : STD_LOGIC_VECTOR(3 DOWNTO 0);
signal Reg_1          : STD_LOGIC_VECTOR(2 DOWNTO 0);
signal Reg_2          : STD_LOGIC_VECTOR(2 DOWNTO 0);
signal Add_Sub_Select : STD_LOGIC;
signal JumpFlag       : STD_LOGIC;
signal ATJ            : STD_LOGIC_VECTOR(2 DOWNTO 0);

begin
-- Instantiate the unit under test (UUT)
uut: InstructionDecoder port map (
    Instruction    => Instruction,
    RCJ            => RCJ,
    RegEn          => RegEn,
    LS             => LS,
    Immediatevalue => Immediatevalue,
    Reg_1          => Reg_1,
    Reg_2          => Reg_2,
    Add_Sub_Select => Add_Sub_Select,
    JumpFlag       => JumpFlag,
    ATJ            => ATJ
);

-- Stimulus process
stim_proc: process
begin
    -- Test case 1
    Instruction    <= "100010000101";
    RCJ            <= "0000";

    wait for 100 ns;
    
    -- Test case 2
    Instruction    <= "100100000010";
    RCJ            <= "0001";

    wait for 100 ns;
    
    -- Test case 3
    Instruction    <= "101010000001";
    RCJ            <= "0000";

    wait for 100 ns;

    -- Add more test cases as needed

    wait;
end process;
end Behavioral;
