----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 08/09/2019 10:47:12 AM
-- Design Name: 
-- Module Name: led_thingy_top - Behavioral
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

entity led_thingy_top is
  Port (
    btn :       in  STD_LOGIC_VECTOR( 1 downto 0);
   -- sw :        in  STD_LOGIC_VECTOR(3 downto 0);
    led :       out  STD_LOGIC_VECTOR (3 downto 0);
    led4_r :    out STD_LOGIC;
    led4_g :    out STD_LOGIC;
    led4_b :    out STD_LOGIC
 --   led5_r :    out STD_LOGIC;
   -- led5_g :    out STD_LOGIC;
    --led5_b :    out STD_LOGIC
  );
end led_thingy_top;

architecture Behavioral of led_thingy_top is
   
    -- group of RGB led signals
    signal RGB_Led_4: std_logic_vector(0 to 3);
    -- group of RGB led signals
   -- signal RGB_Led_5: std_logic_vector(0 to 3);


begin

    -- buttons directly mapped to red leds
   -- led <= btn;
    
 
    -- Some "housekeeping" first
    -- map signal "RGB_Led_4" to actual output ports
    led4_r <= RGB_Led_4(2);
    led4_g <= RGB_Led_4(1);
    led4_b <= RGB_Led_4(0);
    
    -- map signal "RGB_Led_5" to actual output ports
   -- led5_r <= RGB_Led_5(2);
    --led5_g <= RGB_Led_5(1);
    --led5_b <= RGB_Led_5(0);
            
            
                
    -- Control of RGB LED 4
    with btn(1 downto 0) select
        RGB_Led_4 <=    "0001" when "00", --off
                        "0010" when "01", --red 
                        "0100" when "10", --green
                        "1000" when "11"; --blue     
                        
    with btn( 1 downto 0) select 
            led <=      "0001" when "00", 
                        "0010" when "01",  
                        "0100" when "10", 
                        "1000" when "11";     
          
                
               
end Behavioral;