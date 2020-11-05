library IEEE;
use IEEE.std_logic_1164.all;

entity Lab1_FPGA_RTL is
    port (
        -- Gloabals
        fpga_clk_50   : in  std_logic;
		  
		  fpga_button  : in  std_logic_vector(3 downto 0);
		  fpga_sw 		: in  std_logic_vector(9 downto 0);

        -- I/Os
        fpga_led_pio  : out std_logic_vector(9 downto 0)
  );
end entity Lab1_FPGA_RTL;

architecture rtl of Lab1_FPGA_RTL is

-- signal
signal blink: std_logic := '0';

begin

  process(fpga_clk_50) is 
      variable counter : integer range 0 to 25000000 := 0;
      variable freq: integer;

      begin
        if (fpga_sw(1 downto 0) = "00") then
          freq:= 0;
          elsif (fpga_sw(1 downto 0) = "01") then
            freq:= 20000000;
            elsif (fpga_sw(1 downto 0) = "10") then
              freq:= 15000000;
				  elsif (fpga_sw(1 downto 0) = "11") then
					freq:= 10000000;
					end if;

      	
        if (rising_edge(fpga_clk_50)) then
                  if (counter < freq) then
                      counter := counter + 1;
                  else
                      blink <= not blink;
                      counter := 0;
                  end if;
        end if;
  end process;
  

  fpga_led_pio(0) <= blink;
  fpga_led_pio(1) <= blink;
  fpga_led_pio(2) <= blink;
  fpga_led_pio(3) <= blink;
  fpga_led_pio(4) <= blink;
  fpga_led_pio(5) <= blink;
  
  -- fpga_led_pio(6) <= fpga_button(0);
  -- fpga_led_pio(7) <= fpga_button(1);
  -- fpga_led_pio(8) <= fpga_button(2);
  -- fpga_led_pio(9) <= fpga_button(3);
  fpga_led_pio(9 downto 6) <= not fpga_button;

end rtl;



