library IEEE;
use IEEE.std_logic_1164.all;

entity Lab1_FPGA_RTL is
    port (
        -- Gloabals
        fpga_clk_50   : in  std_logic;        

        -- I/Os
        fpga_led_pio  : out std_logic_vector(9 downto 0);
		  
		  -- Buttons
		  fpga_buttons_pio : in std_logic_vector(3 downto 0);
		  
		  --Switch
		  fpga_switch_pio : in std_logic_vector(5 downto 0)
  );
end entity Lab1_FPGA_RTL;

architecture rtl of Lab1_FPGA_RTL is

-- signal
signal blink, pwm : std_logic := '0';

begin

  process(fpga_clk_50) 
      variable counter : integer range 0 to 25000000 := 0;
		variable cutoff : integer := 10000000;
		variable binary : integer;
		
      begin
			
			binary := 0;
			for i in 0 to 5 loop
				if (fpga_switch_pio(i) = '1') then
					binary := binary + 2 ** i;
				end if;
			end loop;
			
        if (rising_edge(fpga_clk_50)) then
                  if (counter < cutoff + binary * 200000) then
                      counter := counter + 1;
                  else
                      blink <= not blink;
                      counter := 0;
                  end if;
        end if;
  end process;
  
 process(fpga_clk_50)
  variable counter : integer range 0 to 25000000 := 0;
  
  begin
   if (rising_edge(fpga_clk_50)) then
		if (counter < 25000000) then
			counter := counter + 1;
			pwm <= '0';
		else
			counter := 0;
			pwm <= '1';
		end if;
	end if;
	
end process;

  fpga_led_pio(0) <= blink and pwm;
  fpga_led_pio(1) <= blink and pwm;
  fpga_led_pio(2) <= blink and pwm;
  fpga_led_pio(3) <= blink and pwm;
  fpga_led_pio(4) <= blink and pwm;
  fpga_led_pio(5) <= blink and pwm;

  fpga_led_pio(9 downto 6) <= fpga_buttons_pio;
  
end rtl;
