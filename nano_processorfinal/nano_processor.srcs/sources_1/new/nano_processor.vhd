----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 06/09/2023 10:25:44 AM
-- Design Name: 
-- Module Name: nano_processor - Behavioral
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

entity nano_processor is
    Port ( pushButton : in STD_LOGIC;
           Imm_Value:out std_logic_vector(3 downto 0);
           Clk : in STD_LOGIC;
           nextInsVal : out std_logic_vector(2 downto 0);
           RegisterEnable:out std_logic_vector(2 downto 0);
           RegisterBank_DataIn: out std_logic_vector(3 downto 0);
           LED : out STD_LOGIC_VECTOR (3 downto 0);
           LED_R6 : out std_logic_vector(3 downto 0);
           LED_R5 : out std_logic_vector(3 downto 0);
           LED_OVERFLOW:out STD_LOGIC;
           LED_ZERO:out STD_LOGIC;
           Instruction_temp : out std_logic_vector(11 downto 0)
           
           
           );
end nano_processor;

architecture Behavioral of nano_processor is
COMPONENT Slow_Clk is
    Port ( Clk_in : in STD_LOGIC;
           Clk_out : out STD_LOGIC);
end COMPONENT;


--Instruction Decoder
COMPONENT InstructionDecoder is
    Port ( Instruction : in STD_LOGIC_VECTOR (11 downto 0);
           RCJ : in STD_LOGIC_VECTOR (3 downto 0); 
           RegEn : out STD_LOGIC_VECTOR (2 downto 0);
           LS : out STD_LOGIC;
           Immediatevalue : out STD_LOGIC_VECTOR (3 downto 0);
           Reg_1 : out STD_LOGIC_VECTOR (2 downto 0);
           Reg_2 : out STD_LOGIC_VECTOR (2 downto 0);
           Add_Sub_Select : out STD_LOGIC;
           JumpFlag : out STD_LOGIC; 
           ATJ : out STD_LOGIC_VECTOR (2 downto 0));
end COMPONENT;


--ROM
COMPONENT ROM is
    Port ( address : in STD_LOGIC_VECTOR (2 downto 0);
           data : out STD_LOGIC_VECTOR (11 downto 0));
end COMPONENT;

--Adder 3bit
COMPONENT Adder_3bit is
    Port ( A : in STD_LOGIC_VECTOR(2 DOWNTO 0);
           B : in STD_LOGIC_VECTOR(2 DOWNTO 0);
           S : out STD_LOGIC_VECTOR(2 DOWNTO 0);
           C_out : out STD_LOGIC);
END COMPONENT ;

--MUX 2 3bit
COMPONENT MUX_2_3bit is
    Port ( A : in STD_LOGIC_VECTOR (2 downto 0);
           B: in STD_LOGIC_VECTOR (2 downto 0);
           S : in STD_LOGIC;
           Q : out STD_LOGIC_VECTOR (2 downto 0));
end COMPONENT;

--Program Counter
COMPONENT ProgramCounter is
    Port ( Reset : in STD_LOGIC;
           Clk : in STD_LOGIC;
           A : in STD_LOGIC_VECTOR (2 downto 0);
           memory_select : out STD_LOGIC_VECTOR (2 downto 0));
end COMPONENT;

--Register Bank
COMPONENT Reg_Bank is
    Port ( Clk : in STD_LOGIC;
           Reg_EN : in STD_LOGIC_VECTOR (2 downto 0);
           Reset :in STD_LOGIC;
           Reg_Bank_In : in STD_LOGIC_VECTOR (3 downto 0);
           REG_0_OUT : out STD_LOGIC_VECTOR (3 downto 0);
           REG_1_OUT : out STD_LOGIC_VECTOR (3 downto 0);
           REG_2_OUT : out STD_LOGIC_VECTOR (3 downto 0);
           REG_3_OUT : out STD_LOGIC_VECTOR (3 downto 0);
           REG_4_OUT : out STD_LOGIC_VECTOR (3 downto 0);
           REG_5_OUT : out STD_LOGIC_VECTOR (3 downto 0);
           REG_6_OUT : out STD_LOGIC_VECTOR (3 downto 0);
           REG_7_OUT : out STD_LOGIC_VECTOR (3 downto 0));
end COMPONENT;

--MUX 8 4bit
COMPONENT MUX_8_4bit is  
    Port ( Reg_Sel : in STD_LOGIC_VECTOR (2 downto 0);
           R0 : in STD_LOGIC_VECTOR (3 downto 0);
           R1 : in STD_LOGIC_VECTOR (3 downto 0);
           R2 : in STD_LOGIC_VECTOR (3 downto 0);
           R3 : in STD_LOGIC_VECTOR (3 downto 0);
           R4 : in STD_LOGIC_VECTOR (3 downto 0);
           R5 : in STD_LOGIC_VECTOR (3 downto 0);
           R6 : in STD_LOGIC_VECTOR (3 downto 0);
           R7 : in STD_LOGIC_VECTOR (3 downto 0);
           Mux_Out  : out STD_LOGIC_VECTOR (3 downto 0));
end COMPONENT;

--MUX 2 4bit
COMPONENT MUX_2_4bit is
    Port (A : in STD_LOGIC_VECTOR (3 downto 0);
           B: in STD_LOGIC_VECTOR (3 downto 0);
           S : in STD_LOGIC;
           Q : out STD_LOGIC_VECTOR (3 downto 0));
end COMPONENT;



--Adder_Subtractor 4bit
COMPONENT Adder_Subtractor_4bit IS
    Port ( A : in STD_LOGIC_VECTOR (3 downto 0);
           B : in STD_LOGIC_VECTOR (3 downto 0);
           M : in STD_LOGIC;
           S : out STD_LOGIC_VECTOR (3 downto 0);
           C_OUT : out STD_LOGIC;
           OVERFLOW: out STD_LOGIC;
           ZERO: out STD_LOGIC );
end COMPONENT;


SIGNAL clk_temp:STD_LOGIC;
SIGNAL clk_temp2:STD_LOGIC;

---Program counter
SIGNAL Next_Instruction:STD_LOGIC_VECTOR(2 DOWNTO 0);

--Adder 3 bit
SIGNAL THREE_BIT_ADDER_OUT:STD_LOGIC_VECTOR(2 DOWNTO 0);
SIGNAL C_OUTT:STD_LOGIC;

--Adder_Subtractor
SIGNAL M,OVERFLOW,ZERO,C_OUT:STD_LOGIC;

--Register Bank
SIGNAL R0,R1,R2,R3,R4,R5,R6,R7,Reg_Bank_In:STD_LOGIC_VECTOR(3 DOWNTO 0);
signal pushButton_temp : std_logic;

--instruction decoder
SIGNAL Reg_1,Reg_2,Reg_EN:STD_LOGIC_VECTOR(2 DOWNTO 0);
SIGNAL LS_temp:STD_LOGIC;
SIGNAL ASU_temp:STD_LOGIC_VECTOR(3 DOWNTO 0);
SIGNAL Immediatevalue_temp:STD_LOGIC_VECTOR(3 DOWNTO 0);

------Decoder
SIGNAL Instruction: STD_LOGIC_VECTOR(11 DOWNTO 0);
SIGNAL JumpFlag:STD_LOGIC;
SIGNAL ATJ:STD_LOGIC_VECTOR(2 DOWNTO 0);

---ROM
SIGNAL memory_select:STD_LOGIC_VECTOR(2 DOWNTO 0);

-----MUX 8 4 bit
SIGNAL MUX_8_OUT0,MUX_8_OUT1:STD_LOGIC_VECTOR(3 DOWNTO 0);

begin

Program_Counter:ProgramCounter
    Port map(
    Reset=>pushButton_temp,
    Clk=>clk_temp,
--    Clk=>clk_temp2,
    A=>Next_Instruction,
    memory_select=>memory_select
    );
    
    
Reg_Bank_0 :Reg_Bank
    port map(
    Clk=>clk_temp,
    Reg_EN=>Reg_EN,
    Reset=>pushButton_temp,
    Reg_Bank_In=>Reg_Bank_In,
    REG_0_OUT=>R0,
    REG_1_OUT=>R1,
    REG_2_OUT=>R2,
    REG_3_OUT=>R3,
    REG_4_OUT=>R4,
    REG_5_OUT=>R5,
    REG_6_OUT=>R6,
    REG_7_OUT=>R7
    );
    
MUX_2_3bit_0:MUX_2_3bit
        port map(
        A=>ATJ,
        B=>THREE_BIT_ADDER_OUT,
        S=>JumpFlag,
        Q=>Next_Instruction
        );
        
Instruction_Decoder:InstructionDecoder
    Port map(
    Instruction=>Instruction,
    RCJ =>MUX_8_OUT0,
    RegEn =>Reg_EN,
    LS =>LS_temp,
    Immediatevalue=>Immediatevalue_temp,
    Reg_1=>Reg_1,
    Reg_2 =>Reg_2,
    Add_Sub_Select =>M,
    JumpFlag=>JumpFlag,
    ATJ=>ATJ
    );
    
Adder_3bit_0:Adder_3bit
        Port map(
        A=>memory_select,
        B => "001",
        S=>THREE_BIT_ADDER_OUT,
        C_out=>C_OUTT
        );
            
MUX_8_4bit_0:MUX_8_4bit
    port map(
     Reg_Sel =>Reg_1,
     R0 =>R0,
     R1 =>R1,
     R2 =>R2,
     R3 =>R3,
     R4 =>R4,
     R5 =>R5,
     R6 =>R6,
     R7 =>R7,
     Mux_Out =>MUX_8_OUT0
     );
MUX_8_4bit_1:MUX_8_4bit
     port map(
     Reg_Sel =>Reg_2,
     R0 =>R0,
     R1 =>R1,
     R2 =>R2,
     R3 =>R3,
     R4 =>R4,
     R5 =>R5,
     R6 =>R6,
     R7 =>R7,
     Mux_Out =>MUX_8_OUT1
     );
MUX_2_4bit_0: MUX_2_4bit
    port map(
    A=>Immediatevalue_temp,
    B=>ASU_temp,
    Q=>Reg_Bank_In,
    S=>LS_temp
    );

Adder_Subtractor: Adder_Subtractor_4bit
    Port map (
    A =>MUX_8_OUT0,
    B =>MUX_8_OUT1,
    M  =>M,
    S =>ASU_temp,
    C_OUT =>C_OUT,
    ZERO =>ZERO,
    OVERFLOW => OVERFLOW
    );


ROM_0 :ROM
    Port map(
    address=>memory_select,
    data=>Instruction
    );
    
Slow_Clk_0 :Slow_Clk
        Port map(
        Clk_in=>Clk,
        Clk_out=>clk_temp2
        );

    clk_temp <= Clk;
    nextInsVal <= Next_Instruction;
    pushButton_temp <= pushButton;
    LED<=R7;
    LED_R6 <= R6;
    LED_R5 <= R5;
    LED_OVERFLOW<=OVERFLOW;
    LED_ZERO<=ZERO;
    RegisterEnable<=Reg_EN;
    RegisterBank_DataIn<=Reg_Bank_In;
    Imm_Value<=Immediatevalue_temp;
    Instruction_temp <= Instruction;

end Behavioral;

