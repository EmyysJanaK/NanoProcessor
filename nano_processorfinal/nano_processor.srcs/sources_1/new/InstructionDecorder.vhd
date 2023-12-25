----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 06/09/2023 10:21:32 AM
-- Design Name: 
-- Module Name: InstructionDecorder - Behavioral
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

entity InstructionDecoder is
    Port ( Instruction : in STD_LOGIC_VECTOR (11 downto 0); --Instruction
           RCJ : in STD_LOGIC_VECTOR (3 downto 0);          --Register check for jump
           RegEn : out STD_LOGIC_VECTOR (2 downto 0);       --Register Enable
           LS : out STD_LOGIC;                              --Load Select       
           Immediatevalue : out STD_LOGIC_VECTOR (3 downto 0);--Immediate Value
           Reg_1 : out STD_LOGIC_VECTOR (2 downto 0);         --Register Select 1
           Reg_2 : out STD_LOGIC_VECTOR (2 downto 0);         --Register Select 2
           Add_Sub_Select : out STD_LOGIC;                    --Add_Sub_Select
           JumpFlag : out STD_LOGIC;                          --Jump Flag
           ATJ : out STD_LOGIC_VECTOR (2 downto 0));          --Address to jump
end InstructionDecoder;

architecture Behavioral of InstructionDecoder is


SIGNAL regEn_temp : std_logic_vector(2 downto 0);
SIGNAL regChkForJump : std_logic_vector(3 downto 0);
SIGNAL reg_select_temp_1 : std_logic_vector(2 downto 0);
SIGNAL op : std_logic_vector(1 downto 0);
SIGNAL reg_1_temp : std_logic_vector(2 downto 0);
SIGNAL reg_2_temp : std_logic_vector(2 downto 0);
SIGNAL immediateValue_temp : std_logic_vector(3 downto 0);
SIGNAL jumpAddress : std_logic_vector(2 downto 0);
SIGNAL reg_select_temp_2 : std_logic_vector(2 downto 0);
SIGNAL LS_temp : std_logic;
SIGNAL addSub_temp : std_logic;
SIGNAL immVal_temp : std_logic_vector(3 downto 0);

SIGNAL jumpSel : std_logic := '0';
begin
    op <= Instruction(11 downto 10);
    reg_1_temp <= Instruction(9 downto 7);
    reg_2_temp <= Instruction(6 downto 4);
    immediateValue_temp <= Instruction(3 downto 0);   
    
    regChkForJump<= RCJ;
    process (op, reg_1_temp, reg_2_temp, immediateValue_temp) 
    
    begin
       jumpSel <= '0'; 
        if op = "00" then   
            reg_select_temp_1<=reg_1_temp;
            reg_select_temp_2<=reg_2_temp;
            addSub_temp<='0';
            LS_temp<='1';
            regEn_temp<=reg_1_temp; 
        elsif op = "01"then 
            reg_select_temp_1<=reg_1_temp;
            reg_select_temp_2<="000";

            addSub_temp<='1';
            LS_temp<='1';
            regEn_temp<=reg_1_temp;
        elsif op = "10" then 

            immVal_temp<=immediateValue_temp;
            LS_temp <='0';
            regEn_temp<=reg_1_temp;
        elsif op = "11" then
            reg_select_temp_1<=reg_1_temp;
            jumpAddress<=immediateValue_temp(2 downto 0);
            regEn_temp<="UUU";
            if regChkForJump= "0000" then
                jumpSel<='0';
            else   
                jumpSel<='1';
            end if;   
        end if;
    end process;
    
    JumpFlag <= jumpSel;
    regChkForJump <= RCJ;
    RegEn <= regEn_temp;
    LS <= LS_temp;
    Immediatevalue <= immVal_temp;
    Reg_1 <= reg_select_temp_1;
    Reg_2 <= reg_select_temp_2;
    Add_Sub_Select <= addSub_temp;
    ATJ <= jumpAddress;
end Behavioral;
